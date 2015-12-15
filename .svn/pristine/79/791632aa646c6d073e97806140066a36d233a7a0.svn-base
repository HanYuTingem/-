//
//  shoppingCarViewController.m
//  MarketManage
//
//  Created by 许文波 on 15/8/6.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "shoppingCarViewController.h"
#import "ShoppingCarCell.h"
/** 下面的选择 结算 */
#import "countView.h"
/** 段头高度 */
#import "shoppingCarHeadView.h"

#import "L_BaseMallViewController.h"
#import "GCRequest.h"

#import "CrazyShoppingCartViewFile.h"

#import "CrazyShoppingCartListCellView.h"

#import "CrazyShoppingCartListNoDataView.h"

#import "CrazyBgBlackView.h"

#import "ASIHTTPRequest.h"

#import "CrazyBasisRequset.h"

#import "AFNetRequest.h"
#import "jsonMyModel.h"
#import "CrazyShoppingAddorRemoveModel.h"

/** 订单详情 */
#import "LSYConfirmOrderViewController.h"


/** dh 更换的vc */
#import "ConfirmOrderViewController.h"
#import "CrazyBasisAlertView.h"

/** 订单详情 */
#import "LSYGoodsInfoViewController.h"
/** 清除失效的 */
#import "CrazyBasisRequset.h"
#import "DHCleanView.h"

@interface shoppingCarViewController ()<UITableViewDataSource,UITableViewDelegate,DHCleanViewDelegate>
{
    UITableView *table;
    
    BOOL _ISEdit;/** 编辑 */
    
    BOOL _isAllSelecte;
    
    ZHButton *selectAllBtn;
    
    NSMutableDictionary *tableDic;
    
    NSMutableArray *selectArray;
    /** 总价 */
    float totalPrice;
    /** 用来保存选好的商品 当结算时将数据传过去*/
   
    NSMutableArray *allCountArr ;
    
    /** 失效的数组 */
    NSMutableArray *InvalidArr;

   /** 积分 */
     float _Integral;
    
    
    NSString *_IntegralAndMoney;
    /** 下面的视图 */
    countView *underViewAll;
}
@property (nonatomic,strong) CrazyBasisTableNoDataView *mNoDataView;
@end

@implementation shoppingCarViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CrazyShoppingCartListCellViewChangeGoodsNumber" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PurchaseQuantityViewNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"GoodsInfoViewControllerReloadData" object:nil];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //进入界面重新刷新数据
//    [table reloadData];
    [self sendRequset];
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:222];
    [btn setImage:[UIImage imageNamed:@"mall_payfor_normal"] forState:UIControlStateNormal];

    //商品数量改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeGoodsNumber:) name:@"CrazyShoppingCartListCellViewChangeGoodsNumber" object:nil];
    
    //超出库存
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moreBigNumber:) name:@"PurchaseQuantityViewNotification" object:nil];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CrazyShoppingCartViewControllerReloadData" object:nil];
}
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self= [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _isAllSelecte = NO;
        _ISEdit = YES;
        self.mInfoArray = [NSMutableArray arrayWithCapacity:0];
        selectArray = [NSMutableArray arrayWithCapacity:0];
        allCountArr = [NSMutableArray arrayWithCapacity:0];
        InvalidArr = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    tableDic = [[NSMutableDictionary alloc]init];
    [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.mallTitleLabel.text = @"购物车";
    [self makeUI];
    [self makeUnderSelectView];
    
       self.mNoDataView = [[CrazyShoppingCartListNoDataView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64) imageString:@"mall_content_icon"];
    self.navigationController.navigationBarHidden = YES;
    

    // Do any additional setup after loading the view from its nib.
}

-(void)leftBackCliked:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark 编辑按钮
-(void)rightBackCliked:(UIButton *)sender{
    
    _ISEdit =!_ISEdit;
    [table reloadData];
    NSLog(@"编辑按钮被点击了 ");
    
    if (!_ISEdit) {
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        UIView *countOrDel = (UIView *)[self.view viewWithTag:1110];
        countOrDel.hidden = YES;
        UIButton *del = (UIButton *)[self.view viewWithTag:1140];
        [del addTarget:self action:@selector(delButtonDown) forControlEvents:UIControlEventTouchUpInside];
        del.hidden=  NO;
    }else
    {
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        UIView *countOrDel = (UIView *)[self.view viewWithTag:1110];
        countOrDel.hidden = NO;
        UIButton *del = (UIButton *)[self.view viewWithTag:1140];
        del.hidden=  YES;
    }
}
#pragma mark 删除商品
-(void)delButtonDown{
    
    NSMutableArray *arr = [self noInvalidShopArr];
    
    if (arr.count == 0) {
        [self showMsg:@"请至少选择一件商品"];
        return;
    }
    //商品Id  格式为 ID,ID,ID,
    NSMutableString *goodsId = [NSMutableString stringWithCapacity:10];
    
    for (int i = 0; i< selectArray.count; i++) {
        ListModel *model = selectArray[i];
        if ([model.caption isEqualToString:@""]) {
            [goodsId appendString:[NSString stringWithFormat:@"%@,",model.id]];

        }else{
            
        }
        NSLog(@"%@",model.cat_id);
        
    }
    
    //提示框
    [CrazyBasisAlertView CrazyBasisAlertViewShowTitle:@"" content:@"确定要删除选中商品吗?" buttonTextArray:@[@"确定",@"取消"] leftSelectBlock:^(CrazyBasisButton *confirmButton) {
        //请求删除
        
        [CrazyShoppingAddorRemoveModel crazyShoppingAddorRemoveModelType:CrazyShoppingAddorRemoveModelTypeRemove loadController:self goodsId:goodsId completeBlock:^(NSDictionary * infoDic) {
            if ([infoDic[@"code"] integerValue] == 0) {
                //排除模型 刷新列表
                [allCountArr removeAllObjects];
                [self sendRequset];
                UIButton *btn = (UIButton *)[self.view viewWithTag:222];
                [btn setImage:[UIImage imageNamed:@"mall_payfor_normal"] forState:UIControlStateNormal];
                
                
         
                     
     
//                UIButton *goCountMoney = (UIButton *)[self.view viewWithTag:4444];
//                [goCountMoney setTitle:[NSString stringWithFormat:@"去结算(0)"] forState:UIControlStateNormal];
//                UILabel *label = (UILabel *)[self.view viewWithTag:2323];
////                label.text = @"0.00";
//                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"合计:￥0.00"];
//                [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,3)];
//                label.attributedText = str;
            }
            else {
                [self showMsg:@"删除失败,请重新尝试"];
            }
        }];
        
    } rigthSelectBlock:^(CrazyBasisButton *cancelBlock) {
        
    }];
    NSLog(@"删除按钮被点击了。。。");
}

/**
 TableView 布局
 */
-(void)makeUI{
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, ScreenHeight-64-49) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
//    table.separatorStyle = UITableViewCellSelectionStyleNone;

    [self.view addSubview:table];
 
}

#pragma  mark  下面的 清除失效的商品

- (UIView *)invaildView{
     DHCleanView *invaild = [[DHCleanView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    invaild.delegate = self;
    
    return invaild;
}
#pragma  mark 清除失效商品的代理方法。
-(void)cleanInvaildBtnDown{
    
    NSMutableString *appstr = [NSMutableString stringWithCapacity:0];
    jsonMyModel *jsonModel = [self.mInfoArray lastObject];
    if ([jsonModel.shop_name isEqualToString:@""]) {
        
        for (int i = 0; i<jsonModel.list.count; i++) {
            if (i==0) {
                [appstr appendFormat:@"%@",((ListModel *)jsonModel.list[i]).id];
            }else{
                [appstr appendFormat:@",%@",((ListModel *)jsonModel.list[i]).id];
            }
        }
        NSLog(@"%@",appstr);
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"116" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(kkUserCenterId) forKey:@"user_id"];
    [dict setObject:appstr forKey:@"cart_id"];
  
    
    [CrazyBasisAlertView CrazyBasisAlertViewShowTitle:@"" content:@"确定清除失效的商品吗?" buttonTextArray:@[@"确定",@"取消"] leftSelectBlock:^(CrazyBasisButton *confirmButton) {
        //请求删除
        [CrazyBasisRequset requestPostInClass:self andWithUrlString:SHANGCHENG_url andContentDic:dict Completion:^(NSDictionary *dic) {
            
            if ([dic[@"code"] integerValue] == 0) {
                [self sendRequset];
            }
            NSLog(@"%@",dic);
        } Failed:^(NSError *error) {
            
        }];
    } rigthSelectBlock:^(CrazyBasisButton *cancelBlock) {
        
    }];

    NSLog(@"清除失效");
}

#pragma mark 底部的视图
-(void)makeUnderSelectView{
    
    underViewAll = [[countView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-49, SCREENWIDTH, 49)];
    underViewAll.tag = 8000;
    selectAllBtn = (ZHButton *)[underViewAll viewWithTag:222];
    UIButton *countBtn = (UIButton *)[underViewAll viewWithTag:4444];
    [countBtn addTarget:self action:@selector(countDownMoney) forControlEvents:UIControlEventTouchUpInside];
    [selectAllBtn addTarget:self action:@selector(allBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:underViewAll];
    underViewAll.hidden= YES;
}
#pragma mark 结算按钮

-(void)countDownMoney{
//    
//    for (int i = 0; i< selectArray.count; i++) {
//        ListModel *model = selectArray[i];
//        NSLog(@"%@",model.goods_name);
//        if (![model.caption isEqualToString:@""]) {
//            [self showMsg:@" 请选择有效的商品"];
//            return;
//        }
//    }
    
    UILabel *totalPriceLabel = (UILabel *)[self.view viewWithTag:2323];
//    totalPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",totalPrice];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计:￥%.2f",totalPrice]];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,3)];
    totalPriceLabel.attributedText = str;
    
       NSMutableArray *noInvalidShopArrary = [self noInvalidShopArr];
    if (selectArray.count) {
        
        ListModel *model = selectArray[0];
        if (![model.caption isEqualToString:@""]) {
            [self showMsg:@"请选择有效的商品"];
            return;
        }else{
            LSYConfirmOrderViewController *viewController = [[LSYConfirmOrderViewController alloc]init];
            viewController.shoppingCartArray = noInvalidShopArrary;
            viewController.buyShopingPriceCount = [NSString stringWithFormat:@"%@",_IntegralAndMoney];
            viewController.shopCountArr = allCountArr;

            [self.navigationController pushViewController:viewController animated:YES];
        }
    }else
    {
        [self showMsg:@"请至少选择一件商品"];
    }
    
}
#pragma mark  排除失效的商品的数组
-(NSMutableArray *)noInvalidShopArr{
    NSMutableArray *noInvalidShopArrary = [NSMutableArray arrayWithCapacity:0];
    for ( int i= 0; i<selectArray.count; i++) {
        ListModel *model = selectArray[i];
        if ([model.caption isEqualToString:@""]) {
            [noInvalidShopArrary addObject:selectArray[i]];
        }
    }
    return noInvalidShopArrary;
}

#pragma mark 合计的钱数 多少钱
/** 合计多少钱 */
-(void)TotalMoney{
    
    /** 总价 */
    totalPrice = 0.0;
    _Integral = 0.0;
    /**  商品的数量  */
    NSInteger shopAllCount = 0;
    for ( int i= 0; i<selectArray.count; i++) {
        ListModel *model = selectArray[i];
        if ([model.caption isEqualToString:@""]) {
            
            /** 商品单价 */
            float shopMoney = [model.goods_cash floatValue];
            /** 商品数量 */
            int singleIntegral = [model.goods_price intValue];
            int shopCount = model.goods_nums;
            shopAllCount += shopCount;
            float allMoney = shopMoney*shopCount;
            float allIntegral = singleIntegral*shopCount;
            _Integral+=allIntegral;
            totalPrice+=allMoney;
        }else{
            
        }
    }
    
    UIButton *goCountMoney = (UIButton *)[self.view viewWithTag:4444];
    [goCountMoney setTitle:[NSString stringWithFormat:@"去结算(%d)",(int)shopAllCount] forState:UIControlStateNormal];
    
    
    NSString *pp = [self allMoneyTotal:[NSString stringWithFormat:@"%.2f",totalPrice] Integral:[NSString stringWithFormat:@"%.f",_Integral]];
    [underViewAll refreshFrame:pp];
    UILabel *totalPriceLabel = (UILabel *)[self.view viewWithTag:2323];
    totalPriceLabel.text = [NSString stringWithFormat:@"%@",pp];
    
    _IntegralAndMoney = pp;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计: %@",pp]];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,3)];
    totalPriceLabel.attributedText = str;

}
/** 合计  多少钱  */
-(NSString *)allMoneyTotal:(NSString *)money Integral:(NSString *)Integral{
    
     if ([money isEqualToString:@"0.00"] && [Integral isEqualToString:@"0"])
    {
        return @"￥0.00";
    }
   else if ([money isEqualToString:@"0.00"]) {
        return [NSString stringWithFormat:@"%@积分",Integral];
    }else if ([Integral isEqualToString:@"0"]){
        return [NSString stringWithFormat:@"￥%@",money];
    }
    else{
        return [NSString stringWithFormat:@"￥%@+%@积分",money,Integral];
    }
}
#pragma mark 请求方式
-(void)sendRequset
{
    [self.mInfoArray removeAllObjects];
    [selectArray removeAllObjects];
    NSString *url = [NSString stringWithFormat:@"por=%d&user_id=%@",110,kkUserCenterId];
    [CrazyBasisRequset requestGetInClass:self andWithUrlString:url Completion:^(NSDictionary *dic) {
        [CrazyBasisImageView CrazySetUrlHost:dic[@"host"]];
        
    //图片地址
        NSString *hostUrl = dic[@"host"];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:hostUrl forKey:@"host"];
        [user synchronize];
            NSArray *jsonArr = dic[@"json"];
        
            for(NSDictionary *dic in jsonArr){
                
                jsonMyModel *model = [[jsonMyModel alloc] initWithDictionary:dic error:nil];
                [self.mInfoArray addObject:model];
            }
/** 用来判断数组中最后一个元素是不是大于0 */
        jsonMyModel *jsonMy = [self.mInfoArray lastObject];
#warning  如果最后一个  jsonMyModel 中shop_name 属性为空是 失效商品
//        for (int i = 0; i < jsonMy.list.count; i++) {
            if ([jsonMy.shop_name isEqualToString:@""]) {
                table.tableFooterView = [self invaildView];
                
            }else{
                [table.tableFooterView removeFromSuperview];
            }
//        }
        [self showNoDataView];
/** 判断数据源是不是为空 */
        jsonMyModel *firstJson = [self.mInfoArray firstObject];
        if (firstJson.list.count>0) {
                if (_ISEdit) {
                    UIView *underView  = (UIView *)[self.view viewWithTag:8000];
                    underView.hidden = NO;
                }
        }else{
            UIView *underView  = (UIView *)[self.view viewWithTag:8000];
            underView.hidden = YES ;
        }
            [self selfCell];
        
            [table reloadData];
        [self TotalMoney];

    } Failed:^(NSError *error) {
        
    }];
}

/** 数据有没有 */
-(void)showNoDataView
{
    jsonMyModel *json = [self.mInfoArray firstObject];
    if (json.list.count == 0 && self.mNoDataView) {
        self.view.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.96f alpha:1.00f];;
        [self.view addSubview:self.mNoDataView];
        NSLog(@"%@",self.mNoDataView);
        self.rightButton.hidden = YES;
    }
    else if (self.mNoDataView && self.mInfoArray.count){
        [self.mNoDataView removeFromSuperview];
    }
}

/**初始化ShoppingCarCell*/
-(void)selfCell{
    if (tableDic) {
        [tableDic removeAllObjects];
    }
    tableDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < self.mInfoArray.count; i++) {
        jsonMyModel *model = self.mInfoArray[i];
        for (int l = 0; l < model.list.count; l++) {
            NSString *idenShop = [NSString stringWithFormat:@"shopCell%d%d",i,l];
            ShoppingCarCell *shopCarCell;
            if (![tableDic objectForKey:idenShop]) {
                shopCarCell = [table dequeueReusableCellWithIdentifier:idenShop];
                if (!shopCarCell) {
                    shopCarCell = [[ShoppingCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenShop];
                }
                /** 给每个cell制定一个model */
                shopCarCell.listModel = (ListModel *)model.list[l];
                shopCarCell.selectBtn.switchRow = 1;
                [tableDic setObject:shopCarCell forKey:idenShop];
            }
        }
        shoppingCarHeadView *headView;
        if (![tableDic objectForKey:[NSString stringWithFormat:@"head%d",i]]) {
            headView = [[shoppingCarHeadView alloc] init];
            headView.selectBtn.switchRow = 1;
            [tableDic setObject:headView forKey:[NSString stringWithFormat:@"head%d",i]];
        }
    }
}
#pragma mark table 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.mInfoArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    jsonMyModel *model = self.mInfoArray[section];
    return model.list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSString *idenShop = [NSString stringWithFormat:@"shopCell%ld%ld",indexPath.section,indexPath.row];
    NSString *idenShop = [NSString stringWithFormat:@"shopCell%d%d",(int)indexPath.section,(int)indexPath.row];
    ShoppingCarCell *shopCarCell = (ShoppingCarCell *)[tableDic objectForKey:idenShop];
    jsonMyModel *model = self.mInfoArray[indexPath.section];
    /** 刷新是否显示编辑的 */
    [shopCarCell refreshCellShowViewOrEditView:_ISEdit];
    [shopCarCell refreshUI:(ListModel *)model.list[indexPath.row]];
    [shopCarCell.selectBtn addTarget:self action:@selector(SelectSingleDown:) forControlEvents:UIControlEventTouchUpInside];
    shopCarCell.selectBtn.tag = indexPath.section;
    shopCarCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self shopCarCell:shopCarCell];
    return shopCarCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    jsonMyModel *model = self.mInfoArray[indexPath.section];
    [self shopInvalidType: ((ListModel *)model.list[indexPath.row])];

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section== self.mInfoArray.count-1) {
        return 0.0001f;
    }else
    {
        return 10.f;
    }
}

/** 商品失效的类型 */
-(void)shopInvalidType:(ListModel *)model{
    
    if ([model.type isEqualToString:@"1"] || [model.type isEqualToString:@"2"]) {
        LSYGoodsInfoViewController *goods = [[LSYGoodsInfoViewController alloc] init];
        goods.goods_id = model.goods_id;
        [self.navigationController pushViewController:goods animated:YES];
    }else if([model.type isEqualToString:@"3"] || [model.type isEqualToString:@"4"]){
        LSYGoodsInfoViewController *goods = [[LSYGoodsInfoViewController alloc] init];
        goods.goods_id = model.goods_id;
        goods.isupdate = YES;
        [self.navigationController pushViewController:goods animated:YES];
    }else {
        LSYGoodsInfoViewController *goods = [[LSYGoodsInfoViewController alloc] init];
        goods.goods_id = model.goods_id;
        [self.navigationController pushViewController:goods animated:YES];
    }
    
}
/** 选择判断*/
-(void)shopCarCell:(ShoppingCarCell*)shopCarCell{
    
    if ([shopCarCell.selectBtn switchRow] == 2) {
        [shopCarCell.selectBtn setImage:[UIImage imageNamed:@"mall_payfor_selected"] forState:UIControlStateNormal];
    }else{
        [shopCarCell.selectBtn setImage:[UIImage imageNamed:@"mall_payfor_normal"] forState:UIControlStateNormal];
    }
}


#pragma mark 选项单选
/** 单个选择按钮 */
-(void)SelectSingleDown:(ZHButton *)singleBtn{
    if (singleBtn.switchRow == 1) {
        singleBtn.switchRow = 2;
    }else{
        singleBtn.switchRow = 1;
    }
    [selectAllBtn setImage:[UIImage imageNamed:[self selYes:1] == NO?@"mall_payfor_normal":@"mall_payfor_selected"] forState:UIControlStateNormal];
    [self selYes:2];
    
    [table reloadData];
}
#pragma mark 1 选中  2，不选中

#pragma mark 选项 全选

/** 全选按钮 */
-(void)allBtnDown:(ZHButton *)btnDown{
    
    if ([self selYes:1] == NO) {
        [self xuanYes:2];
        [btnDown setImage:[UIImage imageNamed:@"mall_payfor_selected"] forState:UIControlStateNormal];
    }else{
        [self xuanYes:1];
        [btnDown setImage:[UIImage imageNamed:@"mall_payfor_normal"] forState:UIControlStateNormal];
    }
    [self selYes:2];
    [table reloadData];
}

/**全部判断 */
-(BOOL)selYes:(int)yesRow{
    [allCountArr removeAllObjects];
    [selectArray removeAllObjects];
    BOOL panduanBool = YES;
    
    for (int i = 0; i < self.mInfoArray.count; i++) {
        jsonMyModel *model = self.mInfoArray[i];
        shoppingCarHeadView *headView = (shoppingCarHeadView *)[tableDic objectForKey:[NSString stringWithFormat:@"head%d",i]];
        if (yesRow == 2) {
            headView.selectBtn.switchRow = 2;
        }
        NSMutableArray *arr =[NSMutableArray arrayWithCapacity:0];
        for (int l = 0; l < model.list.count; l++) {
            NSString *idenShop = [NSString stringWithFormat:@"shopCell%d%d",i,l];
            ShoppingCarCell *shopCarCell = (ShoppingCarCell *)[tableDic objectForKey:idenShop];
            NSLog(@"%@",shopCarCell);
            if (yesRow == 1) {
                if (shopCarCell.selectBtn.switchRow == 1) {
                    
                    panduanBool = NO;
                }else{
                    [arr addObject:shopCarCell.listModel];
                    [selectArray addObject:shopCarCell.listModel];
                }
            }else if (yesRow == 2){
                if (shopCarCell.selectBtn.switchRow == 1) {
                    
                    headView.selectBtn.switchRow = 1;
                }else{
                    if (shopCarCell.listModel) {
                        [arr addObject:shopCarCell.listModel];
                        [selectArray addObject:shopCarCell.listModel];
                    }
                }
            }
        }
        if ([arr count] > 0) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
            [dict setValue:arr forKey:@"listModel"];
            [dict setValue:model.shop_name forKey:@"shop_name"];
            [allCountArr addObject:dict];
        }
    }
    [self TotalMoney];
    return panduanBool;
}

/**全选选择*/
-(void)xuanYes:(int)intRow{
    
    for (int i = 0; i < self.mInfoArray.count; i++) {
        jsonMyModel *model = self.mInfoArray[i];
        for (int l = 0; l < model.list.count; l++) {
            NSString *idenShop = [NSString stringWithFormat:@"shopCell%d%d",i,l];
            ShoppingCarCell *shopCarCell = (ShoppingCarCell *)[tableDic objectForKey:idenShop];
            shopCarCell.selectBtn.switchRow = intRow;
            NSLog(@"---%d",shopCarCell.selectBtn.switchRow);
        }
    }
}

#pragma mark 选项 组选

-(void)groupBtnDown:(id)sender{
    ZHButton * but = (ZHButton *)sender;
    int row = (int)but.tag - 3000;
    if ([self selZuYes:row] == NO) {
        but.switchRow = 2;
        [self xuanZuYes:row intRow:2];
    }else{
        but.switchRow = 1;
        [self xuanZuYes:row intRow:1];
    }
    
    [selectAllBtn setImage:[UIImage imageNamed:[self selYes:1] == NO?@"mall_payfor_normal":@"mall_payfor_selected"] forState:UIControlStateNormal];
    [self TotalMoney];
    [table reloadData];
    //    if (![dic objectForKey:[NSString stringWithFormat:@"%ld",but.tag]]) {
    //        [dic setObject:@"1" forKey:[NSString stringWithFormat:@"%ld",but.tag]];
    //    }else{
    //        [dic setObject:[[dic objectForKey:[NSString stringWithFormat:@"%ld",but.tag]] intValue] == 1?@"2":@"1" forKey:[NSString stringWithFormat:@"%ld",but.tag]];
    //    }
}

/**组选判断 */
-(BOOL)selZuYes:(int)intSection{
    
    jsonMyModel *model = self.mInfoArray[intSection];
    for (int l = 0; l < model.list.count; l++) {
        NSString *idenShop = [NSString stringWithFormat:@"shopCell%d%d",intSection,l];
        ShoppingCarCell *shopCarCell = (ShoppingCarCell *)[tableDic objectForKey:idenShop];
        if (shopCarCell.selectBtn.switchRow == 1) {
            return NO;
        }
    }
    return YES;
}

/**组选选择*/
-(void)xuanZuYes:(int)intSection intRow:(int)intRow{
    
    jsonMyModel *model = self.mInfoArray[intSection];
    for (int l = 0; l < model.list.count; l++) {
        NSString *idenShop = [NSString stringWithFormat:@"shopCell%d%d",intSection,l];
        ShoppingCarCell *shopCarCell = (ShoppingCarCell *)[tableDic objectForKey:idenShop];
        
        shopCarCell.selectBtn.switchRow = intRow;
        NSLog(@"---%d",shopCarCell.selectBtn.switchRow);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110*SP_WIDTH;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    jsonMyModel *model = self.mInfoArray[section];
    /** 判断是否是失效的商品 */
    if ([model.shop_name isEqualToString:@""]) {
        
        return nil;
    }else{
        shoppingCarHeadView *headView = (shoppingCarHeadView *)[tableDic objectForKey:[NSString stringWithFormat:@"head%d",(int)section]];
        headView.tag = 7000+section;
        headView.selectBtn.tag = section+3000;
        
        [headView.selectBtn addTarget:self action:@selector(groupBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        headView.shopNameLabel.text = model.shop_name;
        [headView.selectBtn setImage:[UIImage imageNamed:@"mall_payfor_normal"] forState:UIControlStateNormal];
        
        if (headView.selectBtn.switchRow == 2) {
            [headView.selectBtn setImage:[UIImage imageNamed:@"mall_payfor_selected"] forState:UIControlStateNormal];
        }else{
            [headView.selectBtn setImage:[UIImage imageNamed:@"mall_payfor_normal"] forState:UIControlStateNormal];
        }
        
        return headView;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    jsonMyModel *model = self.mInfoArray[section];

    if ([model.shop_name isEqualToString:@""]) {
        return 0.01f;
    }else{
        return 37.f;

    }
    

}
#pragma mark 改变商品数量
-(void)changeGoodsNumber:(NSNotification *)no
{
    
    ShoppingCarCell *cell = [no object];
    NSLog(@"%d",cell.mQuantityView.mType);
    
    NSString *url = [NSString stringWithFormat:@"por=%d&user_id=%@&goods_id=%@&num=%d&spec_id=%@",112,kkUserCenterId,cell.listModel.goods_id,cell.mQuantityView.mCurrentNumber +cell.mQuantityView.mType,cell.listModel.goods_specid];
    
    [CrazyBasisRequset requestGetInClass:self andWithUrlString:url Completion:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        //请求成功 添加显示
        if ([dic[@"code"] integerValue] == 0) {
            [cell CrazyShoppingCartListCellViewReload];
            [self TotalMoney];
        }
        else {
            [self showMsg:LOAD_FAILURE];
        }
    } Failed:^(NSError *error) {
        
    }];
}

#pragma mark 超过最大库存
-(void)moreBigNumber:(NSNotification *)no
{
    NSInteger restrictionm = [[no object][@"restrictionm"] integerValue];
    NSInteger avaulable = [[no object][@"avaulable"] integerValue];
    
    NSLog(@"%@",[no object][@"restrictionm"]);
    //判断限限购或者库存
    if (restrictionm) {
        if (restrictionm - avaulable > 0) {
            [self showMsg:[NSString stringWithFormat:@"宝贝限购%d件，您已购买%d件",(int)restrictionm,(int)(restrictionm - avaulable)]];
            return;
        }
        [self showMsg:[NSString stringWithFormat:@"限购%d件",(int)restrictionm]];
        return;
    }
    [self showMsg:@"超出库存上限了亲"];
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
