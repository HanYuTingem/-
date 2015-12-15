//
//  ZXYClassifierListViewController.m
//  Chiliring
//
//  Created by Rice on 14-9-9.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "ZXYClassifierListViewController.h"
#import "bSaveMessage.h"

extern NSInteger count;

@interface ZXYClassifierListViewController ()
<UITextFieldDelegate>
{
    /** 商品列表大图 */
    AnimationView             *animationTableView;
    /** 分类 */
    ZXYCategoryView           *categoryView;
    /** 筛选 */
    ZXYFillerView             *fillerView;
    /** 分类数据 */
    ZXYCatogeryModel          *categoryModel;
    /** 商品列表数据 */
    ZXYClassfierListModel     *classfierListModel;
    ZXYFillerSaveModel        *saveFillModel;
    
    //保存请求参数
    /** 保存筛选类型 */
    NSString                  *saveFillerType;
    
    /** 保存筛选类型(上次保存的结果) */
    NSString                  *_saveFillerTypeOld;
    /** 保存筛选金额左值 */
    NSString                  *saveLeftValue;
    /** 保存筛选金额右值 */
    NSString                  *saveRightValue;
    
    /** 请求页数 */
    NSInteger                  pageNum;
    /** 记录排序选择行 */
    NSInteger                  orderRow;
    /** 记录点击分类/排序 */
    NSInteger                  saveCategoryTag;
    
    /** 本类所有请求都用这个对象 */
    ASIFormDataRequest         * mRequest;
    /** 导航栏上的搜索条 */
    UITextField                * navSearch;
    
    /** 是否取消搜索 */
    BOOL                       isCancelSearch;
    /** 历史搜索页 */
    ZXYSearchHistroyView       *searchView;
    
    /** 上拉刷新 */
    MJRefreshFooterView *_footer;
    // xuwenbo add
    /**  table滑动结束 */
    BOOL isTableViewScrollEnd;
    
    /** 蒙板遮盖View */
    UIView *_coverView;
}
@property (weak, nonatomic) IBOutlet UIView *top_line;

/** 1 兑换数 2 积分 3 售卖时间 */
@property (strong, nonatomic) NSString *sort_by;
/** 1 降序 2 升序 */
@property (strong, nonatomic) NSString *sort_type;
/** 分类数组 */
@property (strong, nonatomic) NSMutableArray *catAry;
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 列表数据源 */
@property (strong, nonatomic) NSMutableArray *listDataAry;
/** 筛选无结果显示view */
@property (weak, nonatomic) IBOutlet UIView *wuShangpinView;
/** 筛选背景 */
@property (weak, nonatomic) IBOutlet UIView *topNavBgView;
/** 类目按钮 （现改为默认排序）*/
@property (weak, nonatomic) IBOutlet UIButton *categaryButton;
/** 类目按钮的高度（现改为默认排序） */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *categaryBtnW;
/** 排序按钮（现改为销量优先） */
@property (weak, nonatomic) IBOutlet UIButton *orderButton;
/** 排序按钮的高度（现改为销量优先） */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderBtnW;
/** 筛选按钮 */
@property (weak, nonatomic) IBOutlet UIButton *fillterBtn;
/** 筛选按钮的高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fillterBtnW;
/** 类目按钮的箭头图片 */
@property (weak, nonatomic) IBOutlet UIImageView *ArrowImageview_a;
/** 排序按钮的箭头图片 */
@property (weak, nonatomic) IBOutlet UIImageView *ArrowImageview_b;
/** 筛选按钮的箭头图片 */
@property (weak, nonatomic) IBOutlet UIImageView *ArrowImageview_c;
/** 搜索白色背景遮罩层 */
@property (weak, nonatomic) IBOutlet UIView *searchMaskView;

/** 原来为排序箭头 15.8 改为销量优先 箭头取消 */
@property (weak, nonatomic) IBOutlet UIImageView *orderImage;
/** 横线的高度 0.5 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;


/**点击分类或排序
 */
- (IBAction)topBtnClicked:(id)sender;

@end

@implementation ZXYClassifierListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

#pragma mark - Lifycycle
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self  setNavigationBarStyle];
    saveFillModel = [ZXYFillerSaveModel shareInstance];
    [saveFillModel resetSaveModel];
    
    //适配按钮宽度
    CGFloat btnW = SCREENWIDTH / 3;
    self.categaryBtnW.constant = btnW;
    self.orderBtnW.constant = btnW;
    self.fillterBtnW.constant = btnW;
    //隐藏 销量优先 的箭头
    self.orderImage.hidden = YES;
    self.ArrowImageview_a.hidden = YES;
    self.ArrowImageview_b.hidden = YES;
    self.ArrowImageview_c.hidden = YES;
    
    self.categaryButton.imageEdgeInsets = UIEdgeInsetsMake(0, 75 * SP_WIDTH, 0, 0);
    self.fillterBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 65 * SP_WIDTH, 0, 0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    
    if (self.searchName ) {
        if(![self.searchName isEqualToString:@""])
        {
            [MarketAPI saveSearchHistroy:self.searchName];
        }
        [self RequestWithCatId:@"" andSortBy:@"" andSortType:@"" andFilter:@"" andFilter1:@"" andFilter2:@"" withName:self.searchName];
    }else{
        [self RequestWithCatId:self.cat_id andSortBy:_sort_by andSortType:_sort_type andFilter:saveFillerType andFilter1:saveLeftValue andFilter2:saveRightValue withName:@""];
    }
    // xuwenbo add
    isTableViewScrollEnd = YES;
    
    
    //    [self loadHistoryMessage];
    
    
    self.lineH.constant = 0.5;
    self.navigationItem.leftBarButtonItem =[UIBarButtonItem itemWithImage:@"title_btn_back" higlightedImage:@"title_btn_back" target:self action:@selector(back)];
    
    
}
-(void)back
{
    [mRequest cancel];
    [navSearch resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Request 网络请求
-(void)RequestWithCatId:(NSString *)cat_id andSortBy:(NSString *)sort_by andSortType:(NSString *)sort_type andFilter:(NSString *)filter andFilter1:(NSString *)filter1 andFilter2:(NSString *)filter2 withName:(NSString *)name
{
    cat_id = [cat_id isEqual:@""]?cat_id:_cat_id;
    sort_by = [sort_by isEqual:@""]?sort_by:_sort_by;
    sort_type = [sort_type isEqual:@""]?sort_type:_sort_type;
    
    NSMutableDictionary *dict = [@{} mutableCopy];
    [dict setObject:@"101" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:name forKey:@"name"];
    [dict setObject:IfNullToString(cat_id) forKey:@"cate_id"];
    [dict setObject:sort_by forKey:@"sort_by"];
    [dict setObject:sort_type forKey:@"sort_type"];
    [dict setObject:filter forKey:@"filter"];
    [dict setObject:filter1 forKey:@"filter1"];
    [dict setObject:filter2 forKey:@"filter2"];
    [dict setObject:@"60" forKey:@"pageSize"];
    [dict setObject:[NSNumber numberWithInteger:pageNum] forKey:@"pageNum"];
    [self requestparams:dict];
}

- (void)requestparams:(NSDictionary *)aDict
{
    mRequest=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[SHANGCHENG_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    mRequest.timeOutSeconds = REQUEST_TIMEOUTSECONDS;
    mRequest.delegate=self;
    mRequest.requestMethod=@"POST";
    if (aDict!=nil) {
        for(NSString *key in aDict){
            id value = [aDict objectForKey:key];
            [mRequest setPostValue:value forKey:key];
        }
    }
    [mRequest addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [mRequest startAsynchronous];
    [self startActivity];
}

- (void)requestFinished:(ASIHTTPRequest *)request;
{
    [self stopActivity];
    [_footer endRefreshing];
    NSString *tEndString=[[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    tEndString = [tEndString stringByReplacingOccurrencesOfString:@"\n" withString:@"\n"];
    NSMutableDictionary *dict = [tEndString JSONValue];
    NSLog(@"%@",dict);
    if (dict == nil) {
        NSLog(@"接口错误");
        [self showMsg:@"请求失败,请重试"];
    }else{
        if ([dict[@"code"] integerValue] == 0 && dict[@"code"] != nil) {
            if (pageNum > 0 && [dict[@"list"] count] == 0) {
                pageNum = -1;
                [self showMsg:@"到底啦"];
            }else{
                
                if (pageNum == 0) {
                    if (self.listDataAry.count != 0) {
                        [self.listDataAry removeAllObjects];
                    }
                    self.catAry = [NSMutableArray arrayWithCapacity:0];
                    self.dataArray = [NSMutableArray arrayWithCapacity:0];
                    [self.catAry addObjectsFromArray:dict[@"collections"]];
                    NSLog(@"%@",self.catAry);
                    
                    self.dataArray.array = self.catAry;
                    //初始化筛选
                    [self initFillerView];
                    [self initCategoryView];
                    
                }
                pageNum ++;
                
                
                [self.listDataAry addObjectsFromArray:dict[@"list"]];
                NSMutableArray *leftAry = [[NSMutableArray alloc] init];
                NSMutableArray *rightAry = [[NSMutableArray alloc] init];
                for (int i = 0; i < self.listDataAry.count; i++) {
                    if (i%2 == 0) {
                        [leftAry addObject:self.listDataAry[i]];
                    }else
                    {
                        [rightAry addObject:self.listDataAry[i]];
                    }
                }
                classfierListModel.leftDataAry = leftAry;
                classfierListModel.rightDataAry = rightAry;
                animationTableView.imageHostUrl = dict[@"host"];
                
                if (self.listDataAry.count == 0) {
                    animationTableView.hidden = YES;
                    self.wuShangpinView.hidden = NO;
                }else{
                    self.wuShangpinView.hidden = YES;
                    animationTableView.hidden = NO;
                }
                
                [animationTableView.listTableView reloadData];
                if(pageNum == 1){
                    [animationTableView.listTableView scrollRectToVisible:CGRectMake(ORIGIN_X(animationTableView.listTableView), ORIGIN_Y(animationTableView.listTableView), FRAMNE_W(animationTableView.listTableView), FRAMNE_W(animationTableView.listTableView)) animated:YES];
                }
                
            }
        }else{
            [self showMsg:dict[@"message"]];
        }
    }
    
}
- (void)requestFailed:(ASIHTTPRequest *)request;
{
    [_footer endRefreshing];
    [self stopActivity];
    [self showMsg:@"请求失败，请检查网路设置"];
}

#pragma mark - Init
//导航栏
-(void)setNavigationBarStyle
{
    //搜索栏
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(56, 27, 200 *SP_WIDTH, 30)];
    navSearch=[[UITextField alloc]initWithFrame:CGRectMake(65,0, 140 *SP_WIDTH, 30)];
    UIImageView  * searchViewImage = [[UIImageView alloc]initWithFrame:CGRectMake(50,10, 10, 10)];
    searchViewImage.image = [UIImage imageNamed:@"zxy_shop_title_icon_search.png"];
    [view addSubview:searchViewImage];
    navSearch.placeholder=@"请输入关键词";
    navSearch.delegate = self;
    navSearch.borderStyle = UITextBorderStyleNone;
    navSearch.font = [UIFont systemFontOfSize:13];
    navSearch.returnKeyType =UIReturnKeySearch;
    navSearch.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    navSearch.textColor = [UIColor blackColor];
    [view.layer setCornerRadius:4];
    [view.layer setMasksToBounds:YES];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    navSearch.clearButtonMode =  UITextFieldViewModeAlways;
    
    if (self.searchName.length > 0) {
        navSearch.text = self.searchName;
    }
    [view addSubview:navSearch];
    [self.barCenterView addSubview:view];
    
}

-(void)leftBackCliked:(UIButton *)sender
{
    isCancelSearch = YES;
    [categoryModel.dataAry performSelector:@selector(removeAllObjects)];
    categoryModel.dataAry = [[NSMutableArray alloc] initWithArray:self.catAry];
    
    [self.navigationController popViewControllerAnimated:YES];
}

//初始化数据
-(void)initData
{
    pageNum        = 0;
    orderRow       = 0;
    _sort_by       = @"4";
    _sort_type     = @"1";
    saveFillerType = @"";
    _saveFillerTypeOld = saveFillerType;
    saveLeftValue  = @"";
    saveRightValue = @"";
    isCancelSearch = NO;
    
    [self.top_line setFrame:CGRectMake(0, 43.3, SCREENWIDTH, 0.7)];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideAllCategoryView) name:@"scrollHideCatagoryView" object:nil];
    classfierListModel = [ZXYClassfierListModel shareInstance];
    categoryModel      = [ZXYCatogeryModel shareInstance];
    self.listDataAry   = [[NSMutableArray alloc] init];
    if(_fromAppBanner){
        _topNavBgView.hidden = YES;
        animationTableView = [[AnimationView alloc] initWithFrame:CGRectMake(0,64, SCREENWIDTH, SCREENHEIGHT - 64)];
    }else{
        animationTableView = [[AnimationView alloc] initWithFrame:CGRectMake(0, FRAMNE_H(self.topNavBgView) + 64, SCREENWIDTH, SCREENHEIGHT - FRAMNE_H(self.topNavBgView) - 64)];
    }
    animationTableView.animationDelegate = self;
    [self.view insertSubview:animationTableView belowSubview:self.topNavBgView];
    
    //    [self.categaryButton setTitle:self.cat_name forState:UIControlStateNormal];
    [self.categaryButton setTitle:@"默认排序" forState:UIControlStateNormal];
    [self.wuShangpinView setHidden:YES];
    animationTableView.hidden = YES;
    
    //添加的历史搜索页面
    searchView = [ZXYSearchHistroyView shanreInstance];
    searchView.histroyAry = [NSMutableArray arrayWithArray:[MarketAPI loadsearchHistroy]];
    searchView.histroydelegate = self;
    
    [searchView setFrame:CGRectMake(0, 64, SCREENWIDTH, 44 * 6)];
    [searchView setLayout];
    [self.searchMaskView addSubview:searchView];
    [self.searchMaskView setFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64)];
    [self.view insertSubview:self.searchMaskView aboveSubview:self.topNavBgView];
    
    [self addFooter];
}

/**
 初始化分类
 */
-(void)initCategoryView
{
    categoryView                = [ZXYCategoryView shareInstance];
    categoryView.costomDelegate = self;
    [categoryView setListFrame:CGRectMake(0, ORIGIN_Y(self.topNavBgView) + FRAMNE_H(self.topNavBgView), SCREENWIDTH, 0)];
    [self.view insertSubview:categoryView belowSubview:self.topNavBgView];
    
    //添加蒙板遮盖View
    _coverView = [self makeCoverView];
    _coverView.userInteractionEnabled = YES;
    _coverView.hidden = YES;
    
    [self.view insertSubview:_coverView belowSubview:categoryView];
}

/**
 初始化筛选
 */
-(void)initFillerView
{
    fillerView  = [ZXYFillerView shareInstance];
    fillerView.fillerView.fillerSubLabel.text = self.cat_name;
    
    //原来的类目跳转
    [self loadHistoryMessage];
    //    [categoryModel.dataAry performSelector:@selector(removeAllObjects)];
    categoryModel.dataAry = self.catAry;
    
    [fillerView setListFrame:CGRectMake(0, ORIGIN_Y(self.topNavBgView) + FRAMNE_H(self.topNavBgView), SCREENWIDTH, 0) fillerCategoryArray:categoryModel.dataAry subTitleName:self.cat_name];
    fillerView.delegate = self;
    [self.view insertSubview:fillerView belowSubview:self.topNavBgView];
    
    //分类按钮的点击事件的回调
    __block ZXYClassifierListViewController *weakSelf = self;
    fillerView.blockFillerCategoryBtn = ^(NSInteger rowNum){
        [weakSelf setCat_idDataWithRowNum:rowNum];
    };
}

- (void)setCat_idDataWithRowNum:(NSInteger)rowNum
{
    _cat_id = IfNullToString(categoryModel.dataAry[rowNum][@"cate_id"]);
    _cat_name = IfNullToString(categoryModel.dataAry[rowNum][@"cate_name"]);
}

#pragma mark - 刷新加载
// 上拉加载更多
- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = animationTableView.listTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        [self leftTableViewFooterRefresh];
    };
    _footer = footer;
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
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self hideAllCategoryView];
    [self judgeBtnStatu];
    self.leftButton.hidden = YES;
    self.imageVL.hidden =   YES;
    _coverView.hidden = YES;
    
    [self.rightButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(cancelBttonActionCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.barCenterView addSubview:self.rightButton];
    
    self.searchMaskView.hidden = NO;
    
    searchView.histroyAry = [NSMutableArray arrayWithArray:[MarketAPI loadsearchHistroy]];
    [searchView reloadData];
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.leftButton.hidden = NO;
    self.imageVL.hidden =   NO;
    
    self.searchMaskView.hidden = YES;
    
    if (!isCancelSearch) {
        pageNum = 0;
        if (![textField.text isEqual:@""]) {
            
            [MarketAPI saveSearchHistroy:textField.text];
            [self RequestWithCatId:self.cat_id andSortBy:_sort_by andSortType:_sort_type andFilter:saveFillerType andFilter1:saveLeftValue andFilter2:saveRightValue withName:textField.text];
        }else{
            
            [self showMsg:@"请输入搜索内容"];
//            [self searcgbackAllData];
//            [self RequestWithCatId:@"" andSortBy:@"" andSortType:@"" andFilter:@"" andFilter1:@"" andFilter2:@"" withName:textField.text];
            
        }
    }
    
}

/** 设置搜素全部返回的数据 */
- (void)searcgbackAllData
{
    pageNum        = 0;
    orderRow       = 0;
    _sort_by       = @"4";
    _sort_type     = @"1";
    saveFillerType = @"";
    saveLeftValue  = @"";
    saveRightValue = @"";
    self.leftRow   =0;
    
    self.categaryButton.selected = NO;
    self.orderButton.selected    = NO;
    self.fillterBtn.selected     = NO;
    
    [self.categaryButton setTitle:@"默认排序" forState:UIControlStateNormal];
    //    [self.orderButton setTitle:@"排序" forState:UIControlStateNormal];
    [self.fillterBtn setTitle:@"筛选" forState:UIControlStateNormal];
    
    saveFillModel = [ZXYFillerSaveModel shareInstance];
    [saveFillModel resetSaveModel];
    
    
    UIImage *downImage      = [UIImage imageNamed:@"zxy_gray_arrow_down"];
    UIColor *unselectColor  = [UIColor colorWithRed:95/255. green:100/255. blue:110/255. alpha:1];
    //    self.ArrowImageview_a.image = downImage;
    //    [self.categaryButton setImage:downImage forState:UIControlStateNormal];
    //    [self.orderButton setImage:downImage forState:UIControlStateNormal];
    [self.fillterBtn setImage:downImage forState:UIControlStateNormal];
    //    self.ArrowImageview_b.image = downImage;
    //    self.ArrowImageview_c.image = downImage;
    [self.orderButton setTitleColor:unselectColor forState:UIControlStateNormal];
    [self.categaryButton setTitleColor:unselectColor forState:UIControlStateNormal];
    [self.fillterBtn setTitleColor:unselectColor forState:UIControlStateNormal];
    
    [categoryView removeFromSuperview];
    [fillerView removeFromSuperview];
    
    [self initCategoryView];
    [self initFillerView];
    
}
-(void)cancelBttonActionCliked:(id)sender
{
    [self.rightButton removeFromSuperview];
    isCancelSearch = YES;
    navSearch.text = @"";
    [navSearch resignFirstResponder];
}

-(void)selectHistroyContent:(NSString *)content
{
    [self.rightButton removeFromSuperview];
    
    self.leftButton.hidden = NO;
    self.imageVL.hidden =   NO;
    
    
    isCancelSearch = YES;
    [navSearch setText:content];
    [navSearch resignFirstResponder];
    pageNum = 0;
    [self RequestWithCatId:self.cat_id andSortBy:_sort_by andSortType:_sort_type andFilter:saveFillerType andFilter1:saveLeftValue andFilter2:saveRightValue withName:navSearch.text];
}

#pragma mark - refresh
- (void)leftTableViewFooterRefresh
{
    if (pageNum == -1) {
        [_footer endRefreshing];
        [self showMsg:@"到底啦"];
    }else{
        if (self.searchName.length > 0) {
            [self RequestWithCatId:self.cat_id andSortBy:_sort_by andSortType:_sort_type andFilter:saveFillerType andFilter1:saveLeftValue andFilter2:saveRightValue withName:self.searchName];
        }else{
            [self RequestWithCatId:self.cat_id andSortBy:_sort_by andSortType:_sort_type andFilter:saveFillerType andFilter1:saveLeftValue andFilter2:saveRightValue withName:navSearch.text];
        }
        
    }
}

#pragma mark - Push
/** 商品详情 */
-(void)pushZXYProductDetailVCWithID:(NSString *)productID
{
    [self hideAllCategoryView];
    [self judgeBtnStatu];
    LSYGoodsInfoViewController *productVC = [[LSYGoodsInfoViewController alloc] initWithNibName:@"LSYGoodsInfoViewController" bundle:nil];
    productVC.goods_id = productID;
    [self.navigationController pushViewController:productVC animated:YES];
}

#pragma mark - loadCategoryAry
/** 加载数据 */
-(void)loadHistoryMessage
{
    
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSLog(@"%@",defaults);
    //    NSMutableArray *saveMenulistDate = [NSMutableArray arrayWithArray:[defaults objectForKey:@"All_Classification"]];
    //    if ([saveMenulistDate count] != 0) {
    //        self.catAry = saveMenulistDate;
    //    }
    
    self.catAry.array = self.dataArray;
}

#pragma mark - Choose
//999 类目 998 排序
- (IBAction)topBtnClicked:(id)sender {
    [navSearch resignFirstResponder];
    UIButton *button = (UIButton *)sender;
    saveCategoryTag = button.tag;
    if (isTableViewScrollEnd) { // xuwenbo add tableview 滑动结束
        if (button.selected) {//点击已展开项--执行收回--Return
            
            [self hideAllCategoryView];
            [self judgeBtnStatu];
            
            if (button.tag == 999) {
                //销量最高的数据刷新
                [self highestSalesLodeData];
            }
            
            return;
        }
        
        
        //点击未展开项---全部收起---展开选中项
        [self hideAllCategoryView];
        
        if (button.tag == 999) {//点击显示类目 15.8改
            
//            [self showCategoryViewWithType:@"类目" withSlectedRow:self.leftRow] ;
            
            //销量最高的数据刷新
            [self highestSalesLodeData];
            
        }else if (button.tag == 998){//点击显示排序 15.8改
            
            [self showCategoryViewWithType:@"排序" withSlectedRow:orderRow];
            
            
            
        }else if (button.tag == 997){//点击显示筛选
            
            [self showFillerView];
        }
        
        [self judgeBtnStatu];
    }
}

/** 销量最高的数据刷新 */
- (void)highestSalesLodeData
{
    _sort_by = @"1";
    _sort_type = @"1";
    pageNum = 0;
    [self RequestWithCatId:_cat_id andSortBy:_sort_by andSortType:_sort_type andFilter:saveFillerType andFilter1:saveLeftValue andFilter2:saveRightValue withName:navSearch.text];
    [self hideAllCategoryView];
    [self judgeBtnStatu];
}

/**
 展开类目或排序列表
 */
-(void)showCategoryViewWithType:(NSString *)type withSlectedRow:(NSInteger)row
{
    
    if ([type isEqual:@"类目"]) {
        //        //原来的类目跳转
        //        [self loadHistoryMessage];
        //        [categoryModel.dataAry performSelector:@selector(removeAllObjects)];
        //        categoryModel.dataAry = self.catAry;
        //        self.categaryButton.selected = YES;
        //销量最高的数据刷新
        [self highestSalesLodeData];
        
        
    }else if ([type isEqual:@"排序"]) {
        NSMutableArray *orderAry;
        if ([saveFillerType isEqual:@"2"]) {//现金
            orderAry = [[NSMutableArray alloc] initWithObjects:@"默认排序",@"现金最少",@"最新上架",nil];
        }else if ([saveFillerType isEqual:@"3"]){//积分
            orderAry = [[NSMutableArray alloc] initWithObjects:@"默认排序",@"最新上架",[NSString stringWithFormat:@"%@从低到高",INTERGRAL_NAME],nil];
        }else{
            orderAry = [[NSMutableArray alloc] initWithObjects:@"默认排序",@"现金最少",@"最新上架",[NSString stringWithFormat:@"%@从低到高",INTERGRAL_NAME],nil];
        }
        
        [categoryModel.dataAry performSelector:@selector(removeAllObjects)];
        for (int i = 0; i < orderAry.count; i++) {
            NSMutableDictionary *dict = [@{} mutableCopy];
            [dict setObject:orderAry[i] forKey:@"name"];
            [dict setObject:[NSString stringWithFormat:@"%d",i] forKey:@"id"];
            [categoryModel.dataAry insertObject:dict atIndex:i];
        }
        //        self.orderButton.selected = YES;
        self.categaryButton.selected = YES;
        //
        long int categoryCount = categoryModel.dataAry.count > 6?6:categoryModel.dataAry.count;
        [UIView animateWithDuration:.3 animations:^{
            [categoryView setListFrame:CGRectMake(0, ORIGIN_Y(self.topNavBgView) + FRAMNE_H(self.topNavBgView), SCREENWIDTH, 44*categoryCount)];
            _coverView.hidden = NO;
        }];
        [categoryView.categoryListTableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    
}

/** 判断筛选按钮展开情况 */
-(void)judgeBtnStatu
{
    UIImage *downImage      = [UIImage imageNamed:@"zxy_gray_arrow_down"];
    UIImage *redUpImage     = [UIImage imageNamed:@"zxy_red_arrow_up"];
    UIImage *redDownImage   = [UIImage imageNamed:@"zxy_red_arrow_down"];
    UIColor *selectRedColor = [UIColor colorWithRed:184/255. green:6/255. blue:6/255. alpha:1];
    UIColor *unselectColor  = [UIColor colorWithRed:95/255. green:100/255. blue:110/255. alpha:1];
    
    switch (saveCategoryTag) {
        case 998:
        {
            if (self.categaryButton.selected) {
                //                self.ArrowImageview_a.image = redUpImage;
                [self.categaryButton setImage:redUpImage forState:UIControlStateNormal];
            }else{
                //                self.ArrowImageview_a.image = redDownImage;
                [self.categaryButton setImage:redDownImage forState:UIControlStateNormal];
                _coverView.hidden = YES;
            }
            
            //            self.ArrowImageview_b.image = downImage;
            //            self.ArrowImageview_c.image = downImage;
            //            [self.orderButton setImage:downImage forState:UIControlStateNormal];
            [self.fillterBtn setImage:downImage forState:UIControlStateNormal];
            [self.categaryButton setTitleColor:selectRedColor forState:UIControlStateNormal];
            [self.orderButton setTitleColor:unselectColor forState:UIControlStateNormal];
            [self.fillterBtn setTitleColor:unselectColor forState:UIControlStateNormal];
            break;
        }
        case 999:
        {
            if (self.orderButton.selected) {
                //                self.ArrowImageview_b.image = redUpImage;
                //                [self.orderButton setImage:redUpImage forState:UIControlStateNormal];
            }else{
                //                self.ArrowImageview_b.image = redDownImage;
                //                [self.orderButton setImage:redDownImage forState:UIControlStateNormal];
            }
            
            //            self.ArrowImageview_a.image = downImage;
            //            self.ArrowImageview_c.image = downImage;
            [self.categaryButton setImage:downImage forState:UIControlStateNormal];
            [self.fillterBtn setImage:downImage forState:UIControlStateNormal];
            [self.orderButton setTitleColor:selectRedColor forState:UIControlStateNormal];
            [self.categaryButton setTitleColor:unselectColor forState:UIControlStateNormal];
            [self.fillterBtn setTitleColor:unselectColor forState:UIControlStateNormal];
            
            break;
        }
        case 997:
        {
            if (self.fillterBtn.selected) {
                //                self.ArrowImageview_c.image = redUpImage;
                [self.fillterBtn setImage:redUpImage forState:UIControlStateNormal];
            }else{
                //                self.ArrowImageview_c.image = redDownImage;
                [self.fillterBtn setImage:redDownImage forState:UIControlStateNormal];
            }
            //            self.ArrowImageview_a.image = downImage;
            //            self.ArrowImageview_b.image = downImage;
            
            //            [self.orderButton setImage:downImage forState:UIControlStateNormal];
            [self.categaryButton setImage:downImage forState:UIControlStateNormal];
            [self.fillterBtn setTitleColor:selectRedColor forState:UIControlStateNormal];
            [self.categaryButton setTitleColor:unselectColor forState:UIControlStateNormal];
            [self.orderButton setTitleColor:unselectColor forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
}

#pragma mark - show/hide

/**显示筛选
 */
-(void)showFillerView
{
    //原来的类目跳转
    [self loadHistoryMessage];
    //    [categoryModel.dataAry performSelector:@selector(removeAllObjects)];
    categoryModel.dataAry = self.catAry;
    
    self.fillterBtn.selected = YES;
    [UIView animateWithDuration:.4 animations:^{
        
        [fillerView setListFrame:CGRectMake(0, ORIGIN_Y(self.topNavBgView) + FRAMNE_H(self.topNavBgView), SCREENWIDTH, SCREENHEIGHT - FRAMNE_H(self.topNavBgView) - 64) fillerCategoryArray:categoryModel.dataAry subTitleName:self.cat_name];
        
        //        [fillerView setListFrame:CGRectMake(0, ORIGIN_Y(self.topNavBgView) + FRAMNE_H(self.topNavBgView), SCREENWIDTH, SCREENHEIGHT - CGRectGetMaxY(self.topNavBgView.frame))fillerCategoryArray:categoryModel.dataAry];
        
    } completion:^(BOOL finished) {
        
    }];
}

/**隐藏所有筛选
 */
-(void)hideAllCategoryView
{
    self.categaryButton.selected = NO;
    self.orderButton.selected    = NO;
    self.fillterBtn.selected     = NO;
    
    
    //原来的类目跳转
    //    [self loadHistoryMessage];
    //    [categoryModel.dataAry performSelector:@selector(removeAllObjects)];
    categoryModel.dataAry = self.catAry;
    
    //    [UIView animateWithDuration:.4 animations:^{
    [fillerView setListFrame:CGRectMake(0, ORIGIN_Y(self.topNavBgView) + FRAMNE_H(self.topNavBgView), SCREENWIDTH, 0) fillerCategoryArray:categoryModel.dataAry subTitleName:self.cat_name];
    [categoryView setListFrame:CGRectMake(0, ORIGIN_Y(self.topNavBgView) + FRAMNE_H(self.topNavBgView), SCREENWIDTH, 0)];
    _coverView.hidden = YES;
    //    }];
}

/** 添加蒙板遮盖的View */
- (UIView *)makeCoverView
{
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    coverView.backgroundColor = [UIColor colorWithRed:16/255.0 green:16/255.0 blue:16/255.0 alpha:.5];
    return coverView;
}

#pragma mark - categorySlectedDelegate
-(void)didSelectedCategoryWithIndexRow:(NSInteger)row
{
    
    switch (saveCategoryTag) {
        case 999://类目 15.8改销量优先
        {
            self.leftRow = row;
            //之前分类的
            //            [self.categaryButton setTitle:categoryModel.dataAry[row][@"name"] forState:UIControlStateNormal];
            
            //            [self.orderButton setTitle:categoryModel.dataAry[row][@"name"] forState:UIControlStateNormal];
            _cat_id = IfNullToString(categoryModel.dataAry[row][@"id"]);
            
            
            
            _sort_by = @"1";
            _sort_type = @"1";
            
            
            
            break;
        }
        case 998://排序
        {
            orderRow = row;
            //            [self.orderButton setTitle:categoryModel.dataAry[row][@"name"] forState:UIControlStateNormal];
            
            [self.categaryButton setTitle:categoryModel.dataAry[row][@"name"] forState:UIControlStateNormal];
            _sort_by = [self judgeSortby:IfNullToString(categoryModel.dataAry[row][@"name"])];
            
            
            break;
        }
        default:
            break;
    }
    pageNum = 0;
    [self RequestWithCatId:_cat_id andSortBy:_sort_by andSortType:_sort_type andFilter:saveFillerType andFilter1:saveLeftValue andFilter2:saveRightValue withName:navSearch.text];
    [self hideAllCategoryView];
    [self judgeBtnStatu];
    
}

/**
 将UI和后台的sortby顺序对接
 */
-(NSString *)judgeSortby:(NSString *)sortby
{
    if ([sortby isEqual:@"默认排序"]) {
        sortby = @"4";
        _sort_type = @"1";
    }else if ([sortby isEqual:@"购买最多"]){
        sortby = @"1";
        _sort_type = @"1";
    }else if ([sortby isEqual:@"积分从低到高"]){
        sortby = @"2";
        _sort_type = @"2";
    }else if ([sortby isEqual:@"现金最少"]){
        sortby = @"5";
        _sort_type = @"2";
    }else if ([sortby isEqual:@"最新上架"]){
        sortby = @"6";
        _sort_type = @"1";
    }
    return sortby;
}

#pragma mark - FinishFillerDelegate
-(void)fillerResultWithType:(NSInteger)fillerType andLeftValue:(CGFloat)leftValue andRightValue:(CGFloat)rightValue;
{
    [self hideAllCategoryView];
    [self judgeBtnStatu];
    
    NSString *fillerTitle ;
    switch (fillerType) {
        case 0://现金
        {
            saveFillerType = @"2";
            
            if (![_saveFillerTypeOld isEqual:saveFillerType]) {
                _saveFillerTypeOld = saveFillerType;
                [self.categaryButton setTitle:@"默认排序" forState:UIControlStateNormal];
                orderRow = 0;
                _sort_by       = @"4";
                _sort_type     = @"1";
            }
            
            fillerTitle = [NSString stringWithFormat:@"￥%.0f-￥%.0f",[ZXYFillerSliderCalculate calculateSliderForCashWithValue:leftValue],[ZXYFillerSliderCalculate calculateSliderForCashWithValue:rightValue]];
            if (rightValue == 1.00) {
                fillerTitle = [NSString stringWithFormat:@"￥%.0f-不限",[ZXYFillerSliderCalculate calculateSliderForCashWithValue:leftValue]];
            }
            break;
        }
        case 1://积分
        {
            saveFillerType = @"3";
            
            if (![_saveFillerTypeOld isEqual:saveFillerType]) {
                _saveFillerTypeOld = saveFillerType;
                [self.categaryButton setTitle:@"默认排序" forState:UIControlStateNormal];
                orderRow = 0;
                _sort_by       = @"4";
                _sort_type     = @"1";
            }
            
            fillerTitle = [NSString stringWithFormat:@"%d-%d",[ZXYFillerSliderCalculate calculateSliderForCoinWithValue:leftValue],[ZXYFillerSliderCalculate calculateSliderForCoinWithValue:rightValue]];
            if (rightValue == 1.00) {
                fillerTitle = [NSString stringWithFormat:@"%d-不限",[ZXYFillerSliderCalculate calculateSliderForCoinWithValue:leftValue]];
            }
            break;
        }
        case 2://现金+积分
        {
            saveFillerType = @"4";
            if (![_saveFillerTypeOld isEqual:saveFillerType]) {
                _saveFillerTypeOld = saveFillerType;
                [self.categaryButton setTitle:@"默认排序" forState:UIControlStateNormal];
                orderRow = 0;
                _sort_by       = @"4";
                _sort_type     = @"1";
            }
            fillerTitle = [NSString stringWithFormat:@"现金+%@",INTERGRAL_NAME];
            break;
        }
        case 3://未选择
        {
            fillerTitle = @"筛选";
            [self.fillterBtn setTitle:fillerTitle forState:UIControlStateNormal];
            self.fillterBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            pageNum = 0;
//            [self RequestWithCatId:self.cat_id andSortBy:_sort_by andSortType:_sort_type andFilter:@"" andFilter1:saveLeftValue andFilter2:saveRightValue withName:navSearch.text];
            
            [self RequestWithCatId:self.cat_id andSortBy:_sort_by andSortType:_sort_type andFilter:saveFillerType andFilter1:saveLeftValue andFilter2:saveRightValue withName:navSearch.text];
            return;
        }
        default:
            break;
    }
    //现在都为筛选 15.9
    fillerTitle = @"筛选";
    
    if (fillerTitle.length > 6) {
        self.fillterBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    }else if(fillerTitle.length > 4){
        self.fillterBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }else{
        self.fillterBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    
    
    [self.fillterBtn setTitle:fillerTitle forState:UIControlStateNormal];
    
    pageNum = 0;
    
    switch (fillerType) {
        case 0://现金
        {
            if([self.orderButton.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%@最少",INTERGRAL_NAME]]){
                //劳燕桥 添加第三个帅选
                orderRow = 0;
                _sort_by = @"4";
                [self.orderButton setTitle:@"默认排序" forState:UIControlStateNormal];
                
            }
            
            saveLeftValue = [NSString stringWithFormat:@"%.2f",[ZXYFillerSliderCalculate calculateSliderForCashWithValue:leftValue]];
            saveRightValue = [NSString stringWithFormat:@"%.2f",[ZXYFillerSliderCalculate calculateSliderForCashWithValue:rightValue]];
            break;
        }
        case 1://积分
        {
            
            if([self.orderButton.titleLabel.text isEqualToString:@"现金最少"]){
                //劳燕桥 添加第三个帅选
                orderRow = 0;
                _sort_by = @"4";
                [self.orderButton setTitle:@"默认排序" forState:UIControlStateNormal];
            }
            saveLeftValue = [NSString stringWithFormat:@"%d",[ZXYFillerSliderCalculate calculateSliderForCoinWithValue:leftValue]];
            saveRightValue = [NSString stringWithFormat:@"%d",[ZXYFillerSliderCalculate calculateSliderForCoinWithValue:rightValue]];
            
            
            
            break;
        }
        case 2://现金+积分
        {
            saveLeftValue = @"0";
            saveRightValue = @"0";
            break;
        }
        default:
            break;
    }
    if ([saveRightValue isEqual:@"1000.00"] || [saveRightValue isEqual:@"1000000"]) {
        saveRightValue = @"-1";
    }
    
    [self RequestWithCatId:self.cat_id andSortBy:_sort_by andSortType:_sort_type andFilter:saveFillerType andFilter1:saveLeftValue andFilter2:saveRightValue withName:navSearch.text];
}
#pragma mark - AnimationSelectedRowDelegate
-(void)animationSelectedBtnWithLeft:(BOOL)isleft WithIndexRow:(NSInteger)row
{
    [self hideAllCategoryView];
    [self judgeBtnStatu];
    if (isleft) {
        [self pushZXYProductDetailVCWithID:classfierListModel.leftDataAry[row][@"id"]];
    }else{
        [self pushZXYProductDetailVCWithID:classfierListModel.rightDataAry[row][@"id"]];
    }
}

// xuwenbo add
- (void)scrollViewEndScroll:(BOOL)isScrollEnd
{
    isTableViewScrollEnd = isScrollEnd;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    fillerView.oneSelectBtn = @"";
    fillerView.once = NO;
    fillerView.lastExTag = -1;
    fillerView.currExTag = -1;
//    fillerView.cashorIntegral= @"";
}

@end
