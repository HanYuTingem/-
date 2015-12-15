//
//  LSYHomePageViewController.m
//  MarketManage
//
//  Created by 许文波 on 15/7/29.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYHomePageViewController.h"
#import "MarketAPI.h"

/** 首页的自定义CEll 与自定义段头断尾 */
#import "HomeCellAndHeadView.h"
/** 首页的所有模型 与首页的所有cell 的样式， */
#import "homeAllModel.h"

/** 网络请求*/
#import "GCRequest.h"
/** 轮播 */
#import "ImagePlayerView.h"
/** 充值u */
#import "RechargeViewController.h"
#import "JSBadgeView.h"
/** 购物车 */
#import "shoppingCarViewController.h"

/** 搜索跳转的列表 */
#import "ZXYClassifierListViewController.h"
/** 跳转订单详情 */
#import "LSYGoodsInfoViewController.h"
/** 跳转分类2级 */
#import "ZXYClassifierListViewController.h"
/** 跳转 秒杀 */
#import "LSYSeckillingListViewController.h"
/** 蒙版 */
#import "ZXYSearchHistroyView.h"
/**  专题 */
#import "DHSubjectViewController.h"

#import "AppDelegate.h"

#import "LoginViewController.h"


@interface LSYHomePageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ImagePlayerViewDelegate,UITextFieldDelegate,SelectHistroyDelegate,MBProgressHUDDelegate>
{
    BOOL isCancelSearch;//是否取消搜索
    ZXYSearchHistroyView *searchView;

    UICollectionView *collectView;
    
    MBProgressHUD *HUD;
}
@property (nonatomic,strong)GCRequest * lsyMainRequest;
/** 轮播 */
@property (nonatomic, strong) NSMutableArray *imageURLs;
/** 分类数组*/
@property (nonatomic,strong) NSMutableArray * menus;
/** 域名＊*/
@property (nonatomic,copy)   NSString * host;

@property (nonatomic,strong) ImagePlayerView *bannerImageView;

/** 搜索 */
@property (nonatomic,strong) UITextField  * search;
/** 购物车*/
@property (retain,nonatomic) UIButton *mShoppingButton;
/** 购物车数量显示*/
@property (nonatomic,strong) JSBadgeView * badgeView;

/** 商城 首页 模块  */
@property(nonatomic,strong)NSMutableArray  *modularArray;

@property(nonatomic,strong)NSMutableArray  *RecommendArray;

/** 活动秒杀 */
@property(nonatomic,strong)NSMutableArray *activityArray;

/** 遮罩 */
@property(nonatomic,strong)UIView  *maskView;

@end

@implementation LSYHomePageViewController


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.search.text = @"";
    [self.rightButton removeFromSuperview];


}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushURLOrCateOrShopInfo:) name:@"PushURLOrCategoryOrShopInfo" object:nil];
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(moreButtonDown) name:@"moreButtonDown" object:nil];
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(loadData) name:@"FreshTime" object:nil];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    
    [self initData];
    [self makeUI];
    [self buyCar];

    //搜索栏
    [self addNavbarSearch];
    [self makeMaskView];
    self.self.view.backgroundColor = [UIColor lightGrayColor];
    self.imageVL.hidden = YES;
}
/** 实例化我们的数组们
 */
-(void)initData{
    self.menus = [NSMutableArray arrayWithCapacity:0];
    self.imageURLs = [NSMutableArray arrayWithCapacity:0];
    self.modularArray = [NSMutableArray arrayWithCapacity:0];
    self.RecommendArray  = [NSMutableArray arrayWithCapacity:0];
    self.activityArray = [NSMutableArray arrayWithCapacity:0];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [HUD hide:YES];
    [self.appDelegate.homeTabBarController showTabBarAnimated:YES];
    
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
        return;
    }

    
    [self loadData];
    searchView = [ZXYSearchHistroyView shanreInstance];
    searchView.histroyAry = [NSMutableArray arrayWithArray:[MarketAPI loadsearchHistroy]];
    searchView.histroydelegate = self;
    [searchView setFrame:CGRectMake(0, 0, SCREENWIDTH, 44 * 6)];

    [searchView setLayout];
    self.mShoppingButton.hidden = NO;
    [self.maskView addSubview:searchView];
    DHHeadSecondsKill *kill = [[DHHeadSecondsKill alloc] init];
    kill.single = NO;
    
}
/** 购物车 */
-(void)buyCar{
    _mShoppingButton                    = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.barCenterView addSubview:_mShoppingButton];

    [_mShoppingButton setFrame:CGRectMake(SCREENWIDTH-64, 13, 64, 64)];
    _mShoppingButton.imageEdgeInsets    = UIEdgeInsetsMake(0, 24, 20, 0);
    _mShoppingButton.titleEdgeInsets    = UIEdgeInsetsMake(15, 1, 0, 0);
    _mShoppingButton.titleLabel.font    = [UIFont systemFontOfSize:9];
    [_mShoppingButton setImage:[UIImage imageNamed:@"lyq_goodsinfo_shoppingcart_image"] forState:UIControlStateNormal];
    [_mShoppingButton setTitle:@"购物车" forState:UIControlStateNormal];
    [_mShoppingButton setTitleColor:C8 forState:UIControlStateNormal];
    _mShoppingButton.contentHorizontalAlignment = NSTextAlignmentCenter;
    [_mShoppingButton addTarget:self action:@selector(rightBackCliked:)
               forControlEvents:UIControlEventTouchUpInside];
    
    //购物车的小红点
    _badgeView = [[JSBadgeView alloc] initWithParentView:self.mShoppingButton alignment:JSBadgeViewAlignmentCenterRight];
    _badgeView.badgeTextFont = [UIFont systemFontOfSize:9];
    _badgeView.userInteractionEnabled = NO;

    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, SCREENWIDTH, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
    [self.barCenterView addSubview:line];
    
}
-(void)makeMaskView{
   
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    self.maskView.backgroundColor = [UIColor whiteColor];
    self.maskView.hidden = YES;
    [self.view addSubview:self.maskView];
}
-(void)rightBackCliked:(UIButton *)button{

    isCancelSearch = YES;
    self.maskView.hidden = YES;

    if (![button.currentTitle isEqualToString:@"购物车"]) {
        return;
    }
    if (kkNickDicPHP == nil || [HUserId isEqualToString:@""]) {
        
        [MarketAPI jumLoginControllerWithNavPush:self.navigationController];
        
    } else {
        shoppingCarViewController *shopBuyCar = [[shoppingCarViewController alloc] init];
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        [self.navigationController pushViewController:shopBuyCar animated:YES];
    }
}
/** 添加搜索栏 */
- (void)addNavbarSearch
{
    UIView * view                           = [[UIView alloc]initWithFrame:CGRectMake(56, 27, 200*SP_WIDTH, 30)];
    self.search                             = [[UITextField alloc]initWithFrame:CGRectMake(65,0, 140*SP_WIDTH, 30)];
    UIImageView  * searchViewImage          = [[UIImageView alloc]initWithFrame:CGRectMake(50,9, 12, 12)];
    searchViewImage.image                   = [UIImage imageNamed:@"zxy_shop_title_icon_search.png"];
    [view addSubview:searchViewImage];
    self.search.placeholder                 =   @"请输入关键词";
    [self.search setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.search.borderStyle                 = UITextBorderStyleNone;
    self.search.font                        = [UIFont systemFontOfSize:12];
    self.search.textColor                   = [UIColor blackColor];
    self.search.returnKeyType               = UIReturnKeySearch;
    self.search.contentVerticalAlignment    = UIControlContentVerticalAlignmentCenter;
    [view.layer setCornerRadius:4];
    [view.layer setMasksToBounds:YES];
    view.backgroundColor                    = [UIColor groupTableViewBackgroundColor];
    view.alpha                              = 0.6;
    self.search.clearButtonMode             = UITextFieldViewModeAlways;
    self.search.delegate                    = self;
    [view addSubview:self.search];
    [self.barCenterView addSubview:view];
    
}
#pragma mark - TextFiledDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqual:@"\n"]) {
        isCancelSearch = NO;
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.rightButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(cancelBttonActionCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.barCenterView addSubview:self.rightButton];
    self.mShoppingButton.hidden = YES;
    self.maskView.hidden = NO;
    searchView.histroyAry = [NSMutableArray arrayWithArray:[MarketAPI loadsearchHistroy]];
    [searchView reloadData];
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length > 0 ) {
        self.maskView.hidden = YES;
    }
    
    

    if (!isCancelSearch) {
        if (textField.text.length) {
            self.maskView.hidden = YES;

            ZXYClassifierListViewController *classifierVC = [[ZXYClassifierListViewController alloc] initWithNibName:@"ZXYClassifierListViewController" bundle:nil];
            classifierVC.leftRow = 0;
            classifierVC.cat_id = @"0";
            classifierVC.cat_name = @"全部";
            classifierVC.searchName = textField.text;
            [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
            [self.navigationController pushViewController:classifierVC animated:YES];
        } else {
            [self showMsg:@"请输入搜索内容"];
            return;
        }
    }
}
-(void)cancelBttonActionCliked:(id)sender
{
    self.mShoppingButton.hidden = NO;
    [self.rightButton removeFromSuperview];
    self.search.text = @"";
    isCancelSearch = YES;
    [self.search resignFirstResponder];
}
-(void)moreButtonDown{
 
    if (self.activityArray.count ) {
        ActivityModel *activityModel = self.activityArray[0];
        LSYSeckillingListViewController * seckillingListiVC = [[LSYSeckillingListViewController alloc] init];
        seckillingListiVC.miaoShaID=activityModel.id;
        seckillingListiVC.childMiaoShaID= ((ActitvityListModel *)activityModel.list[0]).id;
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        [self.navigationController pushViewController:seckillingListiVC animated:YES];
    }

}
-(void)makeUI{
    
    //1、设置collectionView的UICollectionViewFlowLayout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;//设置一行cell间的距离
    layout.minimumLineSpacing = 0;//设置不同行之间的距离
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置滚动为竖着滚
    
    //2、实例化collectionView，初始化的时候用布局来初始化他
    collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64 - self.appDelegate.homeTabBarController.tabBar.frame.size.height) collectionViewLayout:layout];
    collectView.dataSource = self;
    collectView.delegate = self;
    collectView.backgroundColor = [UIColor whiteColor];
    collectView.tag =6666;
    collectView.userInteractionEnabled = YES;

    [self.view addSubview:collectView];
    /*
     给collectionView 注册我们对应的cell
     */
    [collectView registerClass:[DHHomeAdvertCell class] forCellWithReuseIdentifier:@"advertCell"];//广告轮播的cell
    
    [collectView registerNib:[UINib nibWithNibName:@"DHCategoryCell" bundle:nil] forCellWithReuseIdentifier:@"categoryCell"];
    
    [collectView registerNib:[UINib nibWithNibName:@"DHSecondsKillCell" bundle:nil] forCellWithReuseIdentifier:@"secondsKillCell"];//限时秒杀
    
    [collectView registerClass:[DHBrandTJCell class] forCellWithReuseIdentifier:@"brandTJcell"];//品牌推荐
    
    [collectView registerNib:[UINib nibWithNibName:@"DHSelectMarketCell" bundle:nil] forCellWithReuseIdentifier:@"selectMarkCell"];//精选市场
    
//    [collectView registerNib:[UINib nibWithNibName:@"DHWondefulTJCell" bundle:nil] forCellWithReuseIdentifier:@"wondefulCell"];
    
        [collectView registerClass:[DHWondefulTJCell class] forCellWithReuseIdentifier:@"wondefulCell"];
    
    [collectView registerNib:[UINib nibWithNibName:@"DHhotMarketCell" bundle:nil] forCellWithReuseIdentifier:@"hotMarketCell"];//热门市场
    
    
    /** 9.21  修改  */
//    [collectView registerNib:[UINib nibWithNibName:@"DHhotMarketTwoCell" bundle:nil] forCellWithReuseIdentifier:@"hotMarketTwoCell"];//第二个热门市场
    
    
    [collectView registerClass:[DHhotMarketTwoCell class] forCellWithReuseIdentifier:@"hotMarketTwoCell"];
    
      [collectView registerClass:[DHLifeCell class] forCellWithReuseIdentifier:@"liftCell"];//品牌推荐
//    [collectView registerNib:[UINib nibWithNibName:@"DHLifeCell" bundle:nil] forCellWithReuseIdentifier:@"liftCell"];// 生活馆
    
    [collectView registerClass:[DHAllBuy class] forCellWithReuseIdentifier:@"allBuy"];//大家都在买

    
    
    /*
     给collectionView 注册我们对应的段头
     */
    
    [collectView registerClass:[DHHeadSecondsKill class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"secondsKill"];//限时秒杀
    
    [collectView registerClass:[DHHeadBrandsTJ class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadBrandsTJ"];//品牌推荐
    [collectView registerClass:[DHHeadSelectMark class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"selectMarkCell"];//精选市场
    
    [collectView registerClass:[DHHeadWonderfulTJ class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"wonderfulCell"];//精彩推荐
    
    [collectView registerClass:[DHHeadhotMarket class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"hotMarket"];//热门市场
   
    [collectView registerClass:[DHHeadAllBuy class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"allBuy"];//大家都在买
    /*
     段尾
     */
     [collectView registerClass:[DHHeadAdvert class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Advert"];//热门市场第二个
    [collectView registerClass:[advertEnd class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"advertEnd"];
}
#pragma  mark 我们的网络请求

-(void)loadData{
    DHHeadSecondsKill *kill = [[DHHeadSecondsKill alloc] init];
    kill.single = NO;
    
    [HUD show:YES];

//    [self startActivity];
    self.lsyMainRequest =[MarketAPI requestHomePost100WithController:self];
}

#pragma mark 获取购物车数量的接口
-(void)getCardNumData
{
//    [self startActivity];
    self.lsyMainRequest = [MarketAPI requestHomeCardNumPost113WithController:self];
    
}
#pragma mark 首页商品推荐的接口
/** 推荐商品 */
-(void)getRecommendGoodsInfo
{
//    [self startActivity];
    [HUD show:YES];
    self.lsyMainRequest = [MarketAPI requestRecommedPost109WithController:self];
}
-(void)GCRequest:(GCRequest*)aRequest Error:(NSString*)aError{
//    [self stopActivity];
    [HUD hide:YES];
    [self showMsg:@"网络连接失败" hideTime:2];
}
- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString{
    NSLog(@"%@",aString);
    
//    [self.activityArray removeAllObjects];

//    [self stopActivity];
    [HUD hide:YES];
    NSDictionary *dic = [aString JSONValue];
    if (!dic){
        NSLog(@"接口错误");
        return;
    }
    if ([dic[@"code"] integerValue] == 0 || dic[@"code"] != nil) {
        switch (aRequest.tag) {
                //首页数据
            case 100:  {
                /** 添加之前先 清空数据。 */

                [self.modularArray removeAllObjects];
                [self.menus removeAllObjects];
                self.host=[dic objectForKey:@"host"];

                NSArray *cateArr = dic[@"fenlei"];
                for(NSDictionary *cateDic in cateArr){
                    cateModel *model = [[cateModel alloc] initWithDictionary:cateDic error:nil];
                    [self.menus addObject:model];
                }
                
//                if ([[dic objectForKey:@"fenlei"]isKindOfClass:[NSArray class]]) {
//                    NSMutableArray * array= [dic objectForKey:@"fenlei"];
//                    [array insertObject:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"id",@"全部",@"name", nil] atIndex:0];
//                    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"All_Classification"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                                        
//                }
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:dic[@"server_time"] forKey:@"server_time"];
                [user synchronize];
                self.imageURLs=[dic objectForKey:@"lunbo"];
                
              
#pragma  mark  功能模块
                NSArray *modualArr = dic[@"module"];
                for (NSDictionary *mudualDic in modualArr) {
                    ModularModel *mudualModel = [[ModularModel alloc] initWithDictionary:mudualDic error:nil];
                    [self.modularArray addObject:mudualModel];
                }
                
                NSArray *activityArr = dic[@"activity"];
                for(NSDictionary *dic in activityArr){
                    /** 添加之前先 清空数据。 */
                    [self.activityArray removeAllObjects];
                    ActivityModel *activiity = [[ActivityModel alloc] initWithDictionary:dic error:nil];
                    [self.activityArray addObject:activiity];
                }
                     [self getRecommendGoodsInfo];
            }
                break;
                //推荐商品
            case 109:
            {
                [self.RecommendArray removeAllObjects];
                if ([dic[@"list"]isKindOfClass:[NSArray class]]) {
                    NSArray * tmpArray=dic[@"list"];
                    NSLog(@"%@",tmpArray);
                    for(NSDictionary *dic in tmpArray){
                        RecommendModel *model = [[RecommendModel alloc] initWithDictionary:dic error:nil];
                        [self.RecommendArray addObject:model];
                    }
                    [collectView reloadData];
                }
                [self getCardNumData];
            }
            case 113:
            {
                if([[dic objectForKey:@"goodscart_nums"] integerValue] > 0){
                    if([[dic objectForKey:@"goodscart_nums"] integerValue]>99){
                        _badgeView.badgeText =  @"99+";
                    }else{
                        _badgeView.badgeText =  IfNullToString([dic objectForKey:@"goodscart_nums"]);
                        
                        NSLog(@"%@",IfNullToString([dic objectForKey:@"goodscart_nums"]));
                    }
                }else{
                    _badgeView.badgeText=@"";
                }
            }
            break;
        }
    }
}

#pragma  mark 设置我们有几段

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.modularArray.count+4;
}

#pragma mark 设置我们自定义的cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     ModularModel *modularModel;
    if (self.modularArray.count) {
        if (indexPath.section >2&& indexPath.section < self.modularArray.count+3) {
             modularModel = self.modularArray[indexPath.section-3];
        }
    }    
    if (indexPath.section == 0) {
        //广告
        static NSString *advert = @"advertCell";
        DHHomeAdvertCell *advertCell = [collectionView dequeueReusableCellWithReuseIdentifier:advert forIndexPath:indexPath];
        NSLog(@"%@",self.imageURLs);

        self.bannerImageView = [[ImagePlayerView alloc] initWithFrame:advertCell.bounds];
        [self.bannerImageView initWithCount:self.imageURLs.count delegate:self];
        self.bannerImageView.pageControlPosition = ICPageControlPosition_BottomCenter;
        self.bannerImageView.hidePageControl = NO;
        [advertCell addSubview:self.bannerImageView];
        return advertCell;
    }
    
    else if(indexPath.section == 1)
    {
        // 分类
        static NSString *category = @"categoryCell";
        DHCategoryCell *categoryCell = [collectionView dequeueReusableCellWithReuseIdentifier:category forIndexPath:indexPath];
        if (self.host.length) {

            [categoryCell refreshCateGoryUI:self.menus[indexPath.row] andImagViewURL:self.host];
        }
        
    

        return categoryCell;
    }else if(indexPath.section == 2){
        //现实秒杀
        static NSString *secondsKill = @"secondsKillCell";
        DHSecondsKillCell *secondsKillCell = [collectionView dequeueReusableCellWithReuseIdentifier:secondsKill forIndexPath:indexPath];
        if (self.activityArray.count) {
            ActivityModel *model = self.activityArray[indexPath.row];
            ActitvityListModel *listModel = ((ActitvityListModel *)model.list[0]);
            [secondsKillCell refreshKillUI:listModel withUrl:self.host];
        }
        return secondsKillCell;
    }
    //模块 4-1
    else if([modularModel.template isEqualToString:TEMPLATEFOUREONE]){
        //品牌推荐
        static NSString *brandTJ = @"brandTJcell";
        DHBrandTJCell *brandTJcell = [collectionView dequeueReusableCellWithReuseIdentifier:brandTJ forIndexPath:indexPath];
        [brandTJcell refreshDHBrandTJUI:modularModel.list withUrl:self.host];
        return brandTJcell;
    }
    // 模块 3-1
    else if ([modularModel.template isEqualToString:TEMPLATETHREEONE]){
        //精选市场
        static NSString *selectMark = @"selectMarkCell";
        DHSelectMarketCell *selectMarkCell = [collectionView dequeueReusableCellWithReuseIdentifier:selectMark forIndexPath:indexPath];
        if (self.host.length > 0) {
            [selectMarkCell refreshThreeOneUI:modularModel.list andImagViewURL:self.host];

        }
        return selectMarkCell;
    }
    // 模块 6-1
    else if([modularModel.template isEqualToString:TEMPLATESIXONE]){
        //精彩推荐
        static NSString *wondeful = @"wondefulCell";
        DHWondefulTJCell *wondefulCell = [collectionView dequeueReusableCellWithReuseIdentifier:wondeful forIndexPath:indexPath];
        [wondefulCell refreshSixOneUI:(ModularListModel *)(modularModel.list)[indexPath.row] withUrl:self.host];
        
//        wondefulCell.layer.borderWidth = 0.3f;
//        wondefulCell.layer.borderColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f].CGColor;
        return wondefulCell;
    }
    // 模块 2-1
    else if ([modularModel.template isEqualToString:TEMPLATETHREETWO]){
        //热门市场
            static NSString *hotMarket = @"hotMarketCell";
            DHhotMarketCell *hotMarketCell = [collectionView dequeueReusableCellWithReuseIdentifier:hotMarket forIndexPath:indexPath];
        [hotMarketCell refreshThreeTwoUI:(ModularListModel *)(modularModel.list)[indexPath.row] withUrl:self.host];
            return hotMarketCell;
    }
    //  模块 10-2
    else if([modularModel.template isEqualToString:TEMPLATEELEVENONE]){
        //第二个热门市场下面的母婴，运动，等，，，，
        if (indexPath.row < 2) {
            static NSString *hotMarket = @"hotMarketCell";
            DHhotMarketCell *hotMarketCell = [collectionView dequeueReusableCellWithReuseIdentifier:hotMarket forIndexPath:indexPath];
            [hotMarketCell refreshThreeTwoUI:(ModularListModel *)(modularModel.list)[indexPath.row] withUrl:self.host];

            return hotMarketCell;
        }else{
            static NSString  *hotMarketTwo = @"hotMarketTwoCell";
            DHhotMarketTwoCell *hotMarkTwoCell = [collectionView dequeueReusableCellWithReuseIdentifier:hotMarketTwo forIndexPath:indexPath];
            [hotMarkTwoCell refreshElevenOneUI:(ModularListModel *)(modularModel.list)[indexPath.row] withUrl:self.host];
            return hotMarkTwoCell;
        }
        
    }
    // 模块 10-1
    else if ([modularModel.template isEqualToString:TEMPLATETENONE] ){
        // 生活馆
        static NSString *lift = @"liftCell";
        DHLifeCell *liftCell = [collectionView dequeueReusableCellWithReuseIdentifier:lift forIndexPath:indexPath];
        
        [liftCell refreshLifeUI:(ModularListModel *)(modularModel.list)[indexPath.row] withUrl:self.host];
        return liftCell;
    }

    //  下面推荐。
    else if (indexPath.section == self.modularArray.count+3){
        //大家都在买
        static NSString *allBuy = @"allBuy";
        DHAllBuy *allBuyCell =[collectionView dequeueReusableCellWithReuseIdentifier:allBuy forIndexPath:indexPath];
        [allBuyCell refreshBuyUI:self.RecommendArray[indexPath.row] withUrl:self.host];
        if (indexPath.row %2== 0) {
            allBuyCell.view.frame= CGRectMake(10, 0, 145*SP_WIDTH, 214 );

        }else{
            allBuyCell.view.frame = CGRectMake(5, 0, 145*SP_WIDTH, 214);
        }
        return allBuyCell;
    }
    
    else{
        return nil;
    }
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    ModularModel *modularModel;
    if (self.modularArray.count) {
        if (section > 2 && section < self.modularArray.count+3) {
            modularModel = self.modularArray[section-3];
        }
    }
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return self.menus.count;
    } else if(section ==2)
    {
        
        if (self.activityArray.count > 0) {
            return 1;
        }else{
            return 0;
        }
    }
    
    else if ([modularModel.template isEqualToString:TEMPLATETHREEONE]){
        return 1;
    }else if ([modularModel.template isEqualToString:TEMPLATEFOUREONE]){
        return 1;
    }
   else if ([modularModel.template isEqualToString:TEMPLATESIXONE]){
        return 6;
    }
    else if ([modularModel.template isEqualToString:TEMPLATETHREETWO]){
        return 2;
    }
    else if ([modularModel.template isEqualToString:TEMPLATEELEVENONE]){
        return 10;
    }else if ([modularModel.template isEqualToString:TEMPLATETENONE]){
        return 10;
    }else if (section == self.modularArray.count+3){

        return self.RecommendArray.count;
        
    }else{
        return 0;
    }
}
#pragma  mark 设置我们我们的段头高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    ModularModel *modularModel;
    if (self.modularArray.count) {
        if (section > 2 && section < self.modularArray.count+3) {
            modularModel = self.modularArray[section-3];
        }
    }
    if (section == 0) {
        return CGSizeMake(SCREENWIDTH, 0);
    }else if(section == 1){
        return CGSizeMake(SCREENWIDTH, 0);
    }else if(section == 2){
        
        if (self.activityArray.count> 0) {
            return CGSizeMake(SCREENWIDTH, 45);

        }else
        {
            return CGSizeMake(SCREENWIDTH, 0);

        }
    }else if ([modularModel.template isEqualToString:TEMPLATETHREEONE] || [modularModel.template isEqualToString:TEMPLATEFOUREONE] || [modularModel.template isEqualToString:TEMPLATESIXONE] || [modularModel.template isEqualToString:TEMPLATETHREETWO] || [modularModel.template isEqualToString:TEMPLATEELEVENONE] ||  [modularModel.template isEqualToString:TEMPLATEELEVENONE] || section == self.modularArray.count+3)
    {
        return CGSizeMake(SCREENWIDTH, 45);
    }
    else if([modularModel.template isEqualToString:TEMPLATETENONE]){
        return CGSizeMake(SCREENWIDTH, 10);
    }
    else{
        return CGSizeMake(SCREENWIDTH, 0);
    }
}
#pragma mark 设置我们的段尾高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    ModularModel *modularModel;
    if (self.modularArray.count) {
        if (section >2&& section < self.modularArray.count+3) {
            modularModel = self.modularArray[section-3];
        }
    }
    if ([modularModel.template isEqualToString:TEMPLATEONEONE]) {
        return CGSizeMake(SCREENWIDTH, 90);
    }
//    else if ([modularModel.template isEqualToString:TEMPLATEELEVENONE]){
//        return CGSizeMake(SCREENWIDTH, 120);
//    }
    
    else{
        return CGSizeMake(0, 0);
    }
}
#pragma  mark 设置我们的每个cell 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ModularModel *modularModel;
    if (self.modularArray.count) {
        if (indexPath.section >2&& indexPath.section < self.modularArray.count+3) {
            modularModel = self.modularArray[indexPath.section-3];
        }
    }
    if (indexPath.section == 0 ) {
        return CGSizeMake(SCREENWIDTH, 150*SP_HEIGHT);
    }else if(indexPath.section == 1){
        return CGSizeMake(SCREENWIDTH/4, 73*SP_HEIGHT);
    }
    else if(indexPath.section == 2){
#warning mark   如果 activityArray.count 数量为0 没有活动。activityArray.count 大于0 有活动
        if (self.activityArray.count > 0) {
            return CGSizeMake(SCREENWIDTH, 120*SP_HEIGHT);
        }else{
            return CGSizeMake(SCREENWIDTH, 0);
        }
    }
    else if([modularModel.template isEqualToString:TEMPLATETHREEONE]){
        return CGSizeMake(SCREENWIDTH, 184*SP_HEIGHT);
    } else if([modularModel.template isEqualToString:TEMPLATEFOUREONE]){
        return CGSizeMake(SCREENWIDTH, 155*SP_HEIGHT);
    }else if([modularModel.template isEqualToString:TEMPLATESIXONE]){
        return CGSizeMake(SCREENWIDTH/3, 130*SP_HEIGHT);
    }
    else if ([modularModel.template isEqualToString:TEMPLATEELEVENONE]){
        if (indexPath.row < 2) {
            return CGSizeMake(SCREENWIDTH/2, 130*SP_HEIGHT);
            
        }else {
            return CGSizeMake(SCREENWIDTH / 4, 92*SP_HEIGHT);
        }
    }
    else if ([modularModel.template isEqualToString:TEMPLATETHREETWO]){
        return CGSizeMake(SCREENWIDTH/2, 130*SP_HEIGHT);
    }
    else if([modularModel.template isEqualToString:TEMPLATETENONE]){
          return CGSizeMake(SCREENWIDTH/2, 65*SP_HEIGHT);
        
    }
    else if(indexPath.section == self.modularArray.count+3){
        return CGSizeMake(SCREENWIDTH/2, 225);
    }
    else{
        return CGSizeMake(0,0);
    }
}
#pragma  mark 设置我们每个段头的内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    ModularModel *modularModel;
    if (self.modularArray.count) {
        if (indexPath.section >2 && indexPath.section <self.modularArray.count+3) {
            modularModel = self.modularArray[indexPath.section - 3];
        }
    }
    
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 2) {
            DHHeadSecondsKill *secondsKill = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"secondsKill" forIndexPath:indexPath];

            if (self.activityArray.count) {
//                secondsKill.userInteractionEnabled = YES;
//                UIButton *button = (UIButton *)[self.view viewWithTag:7676];
//                [button addTarget:self action:@selector(secondsKillButtonDown) forControlEvents:UIControlEventTouchUpInside];
                ActivityModel *activityModel = self.activityArray[indexPath.row];

                

                [secondsKill RefreshActivityUI:activityModel];
                
            }
//            secondsKill.backgroundColor = [UIColor redColor];
            return secondsKill;
            
        }else if([modularModel.template isEqualToString:TEMPLATETHREEONE] || [modularModel.template isEqualToString:TEMPLATEFOUREONE] || [modularModel.template isEqualToString:TEMPLATESIXONE]  || [modularModel.template isEqualToString:TEMPLATEELEVENONE] || [modularModel.template isEqualToString:TEMPLATETHREETWO] ){
            
            DHHeadBrandsTJ *headBrandsTJ = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier: @"HeadBrandsTJ" forIndexPath:indexPath];

            [headBrandsTJ refreshBrandsTJ:modularModel.name];
            
            return headBrandsTJ;
        }
        else if([modularModel.template isEqualToString:TEMPLATETENONE]){
            
            DHHeadSelectMark *selectMark = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"selectMarkCell" forIndexPath:indexPath];
           selectMark.backgroundColor = [UIColor colorWithRed:0.95f green:0.96f blue:0.97f alpha:1.00f];
            return selectMark;
        }
        
        else if(indexPath.section == self.modularArray.count+3){
            DHHeadAllBuy *allBuy = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"allBuy" forIndexPath:indexPath];
            [allBuy refreshAllBuy:@"大家都再买"];
            return allBuy;
        }
        
        else{
#pragma  mark  此视图没用 只是做一个容器
            DHHeadAllBuy *allBuy = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"allBuy" forIndexPath:indexPath];
            return allBuy;
        }
    }
    else
    {
        /** 段尾 */

//        if ([modularModel.template isEqualToString:TEMPLATETHREETWO]) {
//            advertEnd *advertEnd = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"advertEnd" forIndexPath:indexPath];
//            advertEnd.backgroundColor = [UIColor yellowColor];
//            return advertEnd;
//        }else{
            DHHeadAdvert *advert = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Advert" forIndexPath:indexPath];
            ModularListModel *model = (ModularListModel *)modularModel.list[0];
            [advert refreshSelectMark: model];

        advert.backgroundColor = [UIColor colorWithRed:0.95f green:0.96f blue:0.97f alpha:1.00f];
            advert.tag = [model.type intValue];
            [advert.ImgButton addTarget:self action:@selector(pushTemplateOneOne:) forControlEvents:UIControlEventTouchUpInside];
            return advert;
//        }
    }
}

-(void)pushTemplateOneOne:(UIButton *)btnDown{

    
}

/** 模块 跳转 */
-(void)pushURLOrCateOrShopInfo:(NSNotification *)notification{
    
    NSDictionary *dict = [notification userInfo];
    ModularListModel *modularListModel = dict[@"ModularListModel"];
    NSLog(@"modularListModel=======  %@",modularListModel.type);
    switch ([modularListModel.type intValue]) {
        case 1://网页链接。
        {
            DHSubjectViewController *subject = [[DHSubjectViewController alloc] init];
            subject.URL = modularListModel.val;
            
            if ([modularListModel.val isEqualToString:ReCharge]) {
                if ([kkUserId isEqual:@""] || !kkUserId) {
                    //去登陆
                    LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                    login.viewControllerIndex = 4;
                    [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
                    [self.navigationController pushViewController:login animated:YES];
                } else {
                    [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
                    [self.navigationController pushViewController:subject animated:YES];
                }
            }
            NSLog(@" 网页链接，，");
        }
            break;
        case 2://商品分类
        {
            ZXYClassifierListViewController *classifierVC = [[ZXYClassifierListViewController alloc] initWithNibName:@"ZXYClassifierListViewController" bundle:nil];
//            classifierVC.leftRow = indexPath.row;
            classifierVC.cat_id = modularListModel.val;
            classifierVC.cat_name = modularListModel.title;
            [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
            [self.navigationController pushViewController:classifierVC animated:YES];
        }
            break;
        case 3://商品详情
        {
            LSYGoodsInfoViewController *goodsInfo = [[LSYGoodsInfoViewController alloc] init];
            goodsInfo.goods_id = modularListModel.val;
            [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
            [self.navigationController pushViewController:goodsInfo animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark  点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ModularModel *modularModel;
    if (self.modularArray.count) {
        if (indexPath.section >2 && indexPath.section <self.modularArray.count+3) {
            modularModel = self.modularArray[indexPath.section - 3];
        }
    }
    if (indexPath.section == 1) {
        
        cateModel *model = self.menus[indexPath.row];
        switch ([model.type intValue]) {
            case 0:
            {
                
                ZXYClassifierListViewController *classifierVC = [[ZXYClassifierListViewController alloc] initWithNibName:@"ZXYClassifierListViewController" bundle:nil];
                classifierVC.leftRow = indexPath.row;
                classifierVC.cat_id = model.jump_val;
                classifierVC.cat_name = model.name;
                [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
                [self.navigationController pushViewController:classifierVC animated:YES];

            }
                break;
            case 1:
            {
                //  网页链接
                
                DHSubjectViewController *subject = [[DHSubjectViewController alloc] init];
                subject.URL = model.jump_val;
                
                if ([model.jump_val isEqualToString:ReCharge]) {
                    if ([kkUserId isEqual:@""] || !kkUserId) {
                        //去登陆
                        LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                        login.viewControllerIndex = 4;
                        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
                        [self.navigationController pushViewController:login animated:YES];
                    } else {
                        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
                        [self.navigationController pushViewController:subject animated:YES];
                    }
                }
                
//                [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
//                [self.navigationController pushViewController:subject animated:YES];
                NSLog(@" 网页链接，，");

            }
                break;
            case 2:
            {
                
                
                
                if ([model.jump_val isEqualToString:@"0"]) {
                    //  全部分类
                    CJAllCategoriesViewController *allContrller = [[CJAllCategoriesViewController alloc] init];
                    [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
                    [self.navigationController pushViewController:allContrller animated:YES];

                }else{
                    
                    ZXYClassifierListViewController *classifierVC = [[ZXYClassifierListViewController alloc] initWithNibName:@"ZXYClassifierListViewController" bundle:nil];
                    classifierVC.leftRow = indexPath.row;
                    classifierVC.cat_id = model.jump_val;
                    classifierVC.cat_name = model.name;
                    [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
                    [self.navigationController pushViewController:classifierVC animated:YES];


                }
                
            }
                break;
            default:
                break;
        }

    }
    else if ([modularModel.template isEqualToString:TEMPLATETHREETWO] || [modularModel.template isEqualToString:TEMPLATESIXONE] || [modularModel.template isEqualToString:TEMPLATEELEVENONE] || [modularModel.template isEqualToString:TEMPLATETENONE]){

        ModularListModel *modelListModel = modularModel.list[indexPath.row];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PushURLOrCategoryOrShopInfo" object:self userInfo:@{@"ModularListModel":modelListModel}];
    }
    else if (indexPath.section == 2){
        ActivityModel *activityModel = self.activityArray[indexPath.row];
        LSYSeckillingListViewController * seckillingListiVC = [[LSYSeckillingListViewController alloc] init];
        seckillingListiVC.miaoShaID=activityModel.id;
        seckillingListiVC.childMiaoShaID= ((ActitvityListModel *)activityModel.list[0]).id;
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        [self.navigationController pushViewController:seckillingListiVC animated:YES];

    }else if (indexPath.section == self.modularArray.count+3){
        
        RecommendModel *model = self.RecommendArray[indexPath.row];
        LSYGoodsInfoViewController *goodsInfo = [[LSYGoodsInfoViewController alloc] init];
        goodsInfo.goods_id = model.id;
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        [self.navigationController pushViewController:goodsInfo animated:YES];
    }

}
-(void)selectHistroyContent:(NSString *)content
{
    self.maskView.hidden = YES;
    [self.rightButton removeFromSuperview];
    isCancelSearch = YES;
    self.mShoppingButton.hidden = NO;
    [self.search setText:content];
    [self.search resignFirstResponder];
    
    if(![self.search.text isEqualToString:@""]){
        ZXYClassifierListViewController *classifierVC = [[ZXYClassifierListViewController alloc] initWithNibName:@"ZXYClassifierListViewController" bundle:nil];
        classifierVC.leftRow = 0;
        classifierVC.cat_id = @"0";
        classifierVC.cat_name = @"全部";
        classifierVC.searchName = self.search.text;
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        [self.navigationController pushViewController:classifierVC animated:YES];
    }
}
#pragma mark - 轮播瓶Delegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    //45014
    if (index == 0) {
        NSDictionary * dic=   [self.imageURLs objectAtIndex:self.imageURLs.count - 1];
        [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.host,[dic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"defaultimg_4.png"]];
        
    }else if (index == self.imageURLs.count + 1){
        NSDictionary * dic=   [self.imageURLs objectAtIndex:0];
        [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.host,[dic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"defaultimg_4.png"]];
    }else{
        NSDictionary * dic=   [self.imageURLs objectAtIndex:index-1];
        [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.host,[dic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"defaultimg_4.png"]];
    }

}
#pragma  mark  轮播  
//点击轮播图页面跳转
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    if (index-1>=0&&index-1<=self.imageURLs.count) {
        NSDictionary * dic=   [self.imageURLs objectAtIndex:index-1];
//        IfNullToString(<#x#>)
        if ([IfNullToString([dic objectForKey:@"type"]) isEqualToString:@"0"]) {
            
            LSYGoodsInfoViewController * goodsVC=[[LSYGoodsInfoViewController alloc]init];
            goodsVC.goods_id=[dic objectForKey:@"jump_val"];
            [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
            [self.navigationController pushViewController:goodsVC animated:YES];
        }else{
            
            DHSubjectViewController *subject = [[DHSubjectViewController alloc] init];
            subject.URL = [dic objectForKey:@"jump_val"];
            
            if ([[dic objectForKey:@"jump_val"] isEqualToString:ReCharge]) {
                if ([kkUserId isEqual:@""] || !kkUserId) {
                    //去登陆
                    LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                    login.viewControllerIndex = 4;
                    [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
                    [self.navigationController pushViewController:login animated:YES];
                } else {
                    [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
                    [self.navigationController pushViewController:subject animated:YES];
                }
            }
            
//            [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
//            [self.navigationController pushViewController:subject animated:YES];
            NSLog(@" 网页链接，，");
            
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
