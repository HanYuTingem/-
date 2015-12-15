//
//  ZXYOrderListViewController.m
//  MarketManage
//
//  Created by Rice on 15/1/13.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYOrderListViewController.h"
#import "LSYHomePageViewController.h"
#import "LYQGoodsEvalutionViewController.h"
#import "GCRequest.h"
#import "BSaveMessage.h"
#import "CrazyBasisAlertView.h"

//头部的状态view
#import "LYQOrderHeaderView.h"
#import "JSBadgeView.h"


@interface ZXYOrderListViewController ()<GCRequestDelegate,OrderHeaderViewDelegate>
{
    
    //操作订单位置
    NSInteger                    cellSelectTag;
    ASIFormDataRequest         * mRequest;

    //订单的状态的view
    LYQOrderHeaderView         * orderHeaderView;
    //订单模型
    ZXYCommitOrderRequestModel *commitModel;
    //上提加载
    MJRefreshFooterView        *_footer;
    //上提加载
    MJRefreshHeaderView        *_header;

    //点击的对应的类型
     NSInteger                   typeIndex;
    
    //当前页
    NSString                   * curentPage;
    //全部当前页
    NSString                   * allCurentPage;
    //待付款当前页
    NSString                   * paymentCurentPage;
    //待发货当前页
    NSString                   * sendGoodCurentPage;
    //待收货当前页
    NSString                   * getGoodCurentPage;
    //待评价当前页
    NSString                   * evaluateCurentPage;
    //请求的状态
    NSString                   * requestStatus;
    
    BOOL                       querenStatus;
    
    NSString                   * act_ID;

    
    
    /** 付款 */
    int _PaymentMoney ;
    /** 发货 */
    int _sendGoos;
    /** 收货 */
    int _takeOverGoods;
    /** 评级 */
    int _Evaluation;
    
    /** 订单状态 */
    NSMutableArray *OrderStatusArrary;

}

@property (weak, nonatomic) IBOutlet UILabel *popMessTitleLabel;
@property (weak, nonatomic) IBOutlet UITableView *orderListTableView;
//数据源 全部的
@property (strong,nonatomic)  NSMutableArray     *orderListDataAry;
//待付款
@property (strong,nonatomic)  NSMutableArray     *paymentDataAry;
//待发货
@property (strong,nonatomic)  NSMutableArray     *sendGoodDataAry;
//待收货
@property (strong,nonatomic)  NSMutableArray     *getGoodDataAry;
//待评价
@property (strong,nonatomic)  NSMutableArray     *evaluateDataAry;
//列表数据
@property (strong,nonatomic)  NSMutableArray     *listDataArray;

//去逛逛
@property (weak, nonatomic) IBOutlet UIButton    *goMallBtn;
//没订单
@property (weak, nonatomic) IBOutlet UIView      *noOrderView;
//申请退款
@property (weak, nonatomic) IBOutlet UIView      *callCustomView;
//提示框遮罩
@property (weak, nonatomic) IBOutlet UIView      *maskView;
//操作提示框-确认
@property (weak, nonatomic) IBOutlet UIButton    *orderAlertConfirm;
//操作提示框-取消
@property (weak, nonatomic) IBOutlet UIButton    *orderAlertCancel;
//操作提示框-显示内容
@property (weak, nonatomic) IBOutlet UILabel     *orderAlertContent;
//操作提示框-提示标题
@property (weak, nonatomic) IBOutlet UILabel     *orderAlertTitle;
//操作提示框
@property (weak, nonatomic) IBOutlet UIView      *orderAlertView;
//申请退款电话号
@property (weak, nonatomic) IBOutlet UILabel     *refuncPhoneLabel;
//
@property (nonatomic,strong) GCRequest           *lsyMainRequest;
/*跳转商城首页
 */




- (IBAction)goMallAction:(id)sender;
@end

@implementation ZXYOrderListViewController

#pragma mark - LifeCycle
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    curentPage          = @"1";
    allCurentPage       = @"1";
    paymentCurentPage   = @"1";
    sendGoodCurentPage  = @"1";
    getGoodCurentPage   = @"1";
    evaluateCurentPage  = @"1";
    
    orderHeaderView.frame = CGRectMake(0,65, 320*SP_WIDTH, 40);


    if (self.listDataArray.count > 0) {
        self.noOrderView.hidden = YES;
    }else{
        self.noOrderView.hidden = NO;
    }


//    orderHeaderView = [[LYQOrderHeaderView alloc]initWithFrame:CGRectMake(0,65, 320*SP_WIDTH, 40)];
//    orderHeaderView.delegate =self;
//    orderHeaderView.clipsToBounds = YES;
//    [self.view addSubview:orderHeaderView];
    
    [self.orderListDataAry removeAllObjects];
    [self.paymentDataAry removeAllObjects];
    [self.sendGoodDataAry removeAllObjects];
    [self.getGoodDataAry removeAllObjects];
    [self.evaluateDataAry removeAllObjects];
    [self.listDataArray removeAllObjects];
    [self requestOrderList];
    [self.orderListTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addFooter];
    [self addheader];
    [self initData];
    [self.orderListTableView  reloadData];
    [self.view bringSubviewToFront:self.maskView];
    [self.view bringSubviewToFront:self.orderAlertView];
    [self.view bringSubviewToFront:self.callCustomView];

    self.noOrderView.hidden = YES;

}

-(void)viewWillDisappear:(BOOL)animated
{
    [_lsyMainRequest cancelRequest];
    self.lsyMainRequest.delegate=nil;
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
    
}
/** 8.29 添加 气泡 */
-(void)addBubble{
    
    if (self.listDataArray.count > 0) {
        self.noOrderView.hidden = YES;
    }else{
        self.noOrderView.hidden = NO;
    }
    NSLog(@"%@",OrderStatusArrary);

    
   _PaymentMoney =0;
    /** 发货 */
     _sendGoos=0;
    /** 收货 */
     _takeOverGoods = 0;
    /** 评级 */
     _Evaluation = 0;
    for (int  i = 0;  i < OrderStatusArrary.count; i++) {
        NSDictionary *dic = OrderStatusArrary[i];
        NSLog(@"%@",dic[@"con"]);
        switch ([dic[@"status"] intValue]) {
            case 1:
            {
                _PaymentMoney = [dic[@"con"] floatValue];
                break;
            }
            case 2:
            {
                _sendGoos = [dic[@"con"] floatValue];

                break;
                
            }   case 3:
            {
                _takeOverGoods = [dic[@"con"] floatValue];

                break;
                
            }   case 4:
            {
                _Evaluation = [dic[@"con"] floatValue];

                break;
                
            }
            default:
                break;
        }
    }
    NSLog(@"_PaymentMoney  %d   , _sendGoos %d  , _takeOverGoods %d ,_Evaluation %d",_PaymentMoney,_sendGoos ,_takeOverGoods,_Evaluation);

    [self Bubble:_PaymentMoney andSendGoos:_sendGoos andTakeOverGoods:_takeOverGoods andEvaluation:_Evaluation];
}

-(void)Bubble:(int)PaymentMoney andSendGoos:(int)sendGoos andTakeOverGoods:(int)takeOverGoods andEvaluation:(int)Evaluation{
    if (PaymentMoney > 0) {
        JSBadgeView *PaymentMoneyView = (JSBadgeView *)[self.view viewWithTag:8001];
        PaymentMoneyView.hidden = NO;
        PaymentMoneyView.badgeText = [NSString stringWithFormat:@"%d",PaymentMoney];
    }else{
        JSBadgeView *PaymentMoneyView = (JSBadgeView *)[self.view viewWithTag:8001];
        PaymentMoneyView.hidden  = YES;
    }
    if (sendGoos > 0) {
        
        JSBadgeView *SendGoosView = (JSBadgeView *)[self.view viewWithTag:8002];
        SendGoosView.hidden = NO;
        SendGoosView.badgeText = [NSString stringWithFormat:@"%d",sendGoos];
    }else{
        JSBadgeView *SendGoosView = (JSBadgeView *)[self.view viewWithTag:8002];
        SendGoosView.hidden = YES;

    }
    if (takeOverGoods > 0) {
        
        JSBadgeView *takeOverGoodsView= (JSBadgeView *)[self.view viewWithTag:8003];
        takeOverGoodsView.hidden = NO;
        takeOverGoodsView.badgeText = [NSString stringWithFormat:@"%d",takeOverGoods];
    }else{
        JSBadgeView *takeOverGoodsView= (JSBadgeView *)[self.view viewWithTag:8003];
        takeOverGoodsView.hidden = YES;
    }
    
    if (Evaluation > 0) {
        JSBadgeView *EvaluationView = (JSBadgeView *)[self.view viewWithTag:8004];
        EvaluationView.hidden = NO;
        EvaluationView.badgeText = [NSString stringWithFormat:@"%d",Evaluation];
    }else{
        JSBadgeView *EvaluationView = (JSBadgeView *)[self.view viewWithTag:8004];
        EvaluationView.hidden = YES;
    }
}
#pragma mark - Init
-(void)initData
{
    self.mallTitleLabel.text = @"我的订单";
    requestStatus       = @"0";
    curentPage = @"1";
    typeIndex  = 0;
    querenStatus = NO;
    self.callCustomView.layer.cornerRadius = 8;
    self.orderAlertView.layer.cornerRadius = 8;
    [MarketAPI setRedButton:self.goMallBtn];
    [MarketAPI setRedButton:self.orderAlertConfirm];
    [MarketAPI setRedButton:self.orderAlertCancel];
    
    commitModel   = [ZXYCommitOrderRequestModel shareInstance];
    
   

    self.orderListDataAry  = [[NSMutableArray alloc] init];
    self.paymentDataAry    = [[NSMutableArray alloc]init];
    self.sendGoodDataAry   = [[NSMutableArray alloc]init];
    self.getGoodDataAry    = [[NSMutableArray alloc]init];
    self.evaluateDataAry   = [[NSMutableArray alloc]init];
    self.listDataArray     = [[NSMutableArray alloc]init];
    
    /** \9.6 号 添加 */
    OrderStatusArrary  = [NSMutableArray arrayWithCapacity:0];

    orderHeaderView = [[LYQOrderHeaderView alloc]init];
    orderHeaderView.delegate =self;
    orderHeaderView.clipsToBounds = YES;
    [self.view addSubview:orderHeaderView];
    [self.orderListTableView setFrame:CGRectMake(0, 105, FRAMNE_W(self.orderListTableView), SCREENHEIGHT-105)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMaskView:)];
    [self.maskView addGestureRecognizer:tap];
    
}


/*隐藏所有提示框
 */
- (IBAction)hideMaskView:(id)sender {
    self.callCustomView.hidden = YES;
    self.maskView.hidden = YES;
    self.orderAlertView.hidden = YES;
}
/*显示退款电话
 */
- (IBAction)callCustomAction:(id)sender {
    [self hideMaskView:nil];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.refuncPhoneLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}
/*显示操作提示框
 */
-(void)showAlertView
{
    self.maskView.hidden = NO;
    self.orderAlertView.hidden = NO;
}
/*隐藏操作提示框
 */
-(void)hideAlertView
{
    self.maskView.hidden = YES;
    self.orderAlertView.hidden = YES;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.listDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    ZXYOrderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:@"orderCell"];
    if (orderCell == nil) {
        orderCell = [[NSBundle mainBundle] loadNibNamed:@"ZXYOrderCell" owner:self options:nil][0];
        orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    orderCell.backgroundColor = [UIColor colorWithRed:0.95f green:0.96f blue:0.97f alpha:1.00f];
    [orderCell setCellWithModel:self.listDataArray[indexPath.row]];
    orderCell.cellTag = indexPath.row + 1000;
    orderCell.delegate = self;
    return orderCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 262;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listDataArray.count > 0) {
        [self pushOrderDetailVCandModel:self.listDataArray[indexPath.row]];
        
    }
}

#pragma mark - 刷新加载

- (void)addheader
{
    MJRefreshHeaderView  * header = [MJRefreshHeaderView header];
    header.scrollView = self.orderListTableView;
    header.beginRefreshingBlock = ^ (MJRefreshBaseView * refreshView){
        //  后台执行：
        [self requestHeader];
        
    };
    _header = header;
}
// 上拉加载更多
- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.orderListTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        //  后台执行：
            [self requestFresh];
    };
    _footer = footer;
}

#pragma mark - Request
/*订单列表
 */
-(void)requestOrderList
{
    [self startActivity];
    self.lsyMainRequest = [MarketAPI requestOderList200WithController:self currenPage:curentPage requestStatus:requestStatus];
}

//头部添加下拉
-(void)requestHeader
{
    curentPage = @"1";
    [self requestOrderList];
}
//底部添加上啦
-(void)requestFresh
{
    if ([curentPage isEqual:@"-1"]) {
        [_footer endRefreshing];
        [self showMsg:@"没有更多订单啦"];
    }else{
        long int page = [curentPage integerValue];
        curentPage = [NSString stringWithFormat:@"%ld",++page];
        [self requestOrderList];
    }
}

/*请求退款电话
 */
-(void)requestRefund
{
    self.lsyMainRequest = [MarketAPI requestRefund208WithController:self];
}
/*请求删除订单
 */
-(void)requestDeleteOrderWithOrderNum:(NSString *)orderNum
{
    [self startActivity];
    self.lsyMainRequest = [MarketAPI requestDeleteOderList207WithCntroller:self oderNum:orderNum];
}
/*请求取消订单
 */
- (void)requestCancelDingdanWithOrderNum:(NSString *)orderNum
{
    [self startActivity];
    self.lsyMainRequest = [MarketAPI requestCancelOder203WithController:self oderNum:orderNum];
}
/*请求确认收获
 */
- (void)requestConfirmReceiveWithOrderNum:(NSString *)orderNum
{
    [self startActivity];
    self.lsyMainRequest = [MarketAPI requestAffirm205WithController:self oderNum:orderNum];
}

-(void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    [_footer endRefreshing];
    [_header endRefreshing];
//    [self.listDataArray removeAllObjects];
//    [self.listDataArray removeAllObjects];
    [OrderStatusArrary removeAllObjects];
    [self stopActivity];
    NSDictionary * dict = [aString JSONValue];
    NSLog(@"list = %@",dict);
    KKUserHostUrl = dict[@"host"];
    
    if (!dict){
        NSLog(@"接口错误");
        [self showMsg:@"请求失败,请重试"];
        return;
    }
    OrderStatusArrary = dict[@"packet"];

    if ([dict[@"code"] integerValue] == 0 && dict[@"code"] != nil) {
        
        NSLog(@"%lu",(unsigned long)aRequest.tag);
        switch (aRequest.tag) {
            case 200://订单列表
            {
                
                [self.listDataArray removeAllObjects];
                if ([curentPage isEqual:@"1"] && [dict[@"list"] count] == 0) {
                    self.noOrderView.hidden = NO;
                }else{
                    self.noOrderView.hidden = YES;
                    [self saveDataWithDic:dict[@"list"]];
                    [self.orderListTableView reloadData];
                    if ([curentPage isEqual:@"1"]) {
                        [self requestRefund];
                    }
//                    if ([dict[@"result"] count] < 10) {
//                        curentPage = @"-1";
//                    }
                    NSLog(@"%@    %@",curentPage,dict[@"pageCount"]);
                    if ([curentPage intValue] == [dict[@"pageCount"] intValue]) {
                        curentPage = @"-1";
                    }
                }
                [self addBubble];

              
            }
                 break;
            case 207://删除订单
            {
                NSIndexPath *index = [NSIndexPath indexPathForRow:cellSelectTag inSection:0];
                NSArray *indexAry = [NSArray arrayWithObjects:index, nil];
                
                [self.listDataArray removeObjectAtIndex:cellSelectTag];
                [self.orderListTableView deleteRowsAtIndexPaths:indexAry withRowAnimation:UITableViewRowAnimationFade];
                [self.orderListTableView reloadData];
                [self addBubble];

                break;
            }
            case 205://确认收货
            {
                querenStatus = YES;
                NSIndexPath *index = [NSIndexPath indexPathForRow:cellSelectTag inSection:0];
                NSArray *indexAry = [NSArray arrayWithObjects:index, nil];
                [self.listDataArray removeObjectAtIndex:cellSelectTag];
                [self.orderListTableView deleteRowsAtIndexPaths:indexAry withRowAnimation:UITableViewRowAnimationFade];
                [self.getGoodDataAry removeAllObjects];
                [self.orderListDataAry removeAllObjects];
                [self.orderListTableView reloadData];
                [self addBubble];

                break;
            }
            case 208://退款电话
            {
                self.refuncPhoneLabel.text = IfNullToString(dict[@"phone"]);
                break;
            }
            default:
                break;
        }
        
    }else if([dict[@"code"] integerValue] == 23 && aRequest.tag == 203){//取消订单成功
        ZXYOrderModell *orderModel = self.listDataArray[cellSelectTag];
        orderModel.orderStatu = @"6";
        [self.orderListTableView reloadData];
    }else{
        [self showMsg:dict[@"message"]];
    }
    [self.orderListTableView reloadData];

}

-(void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self stopActivity];
    [_footer endRefreshing];
    [_header endRefreshing];
    [self showMsg:@"请求失败，请检查网路设置"];
}



#pragma mark - SaveData
-(void)saveDataWithDic:(NSArray *)result
{
    [self.listDataArray removeAllObjects];
    if ([curentPage integerValue] == 1 ) {
        typeIndex == 0? [self.orderListDataAry removeAllObjects]:(typeIndex == 1?[self.paymentDataAry removeAllObjects]:(typeIndex == 2?[self.sendGoodDataAry removeAllObjects]:(typeIndex == 3?[self.getGoodDataAry removeAllObjects]:[self.evaluateDataAry removeAllObjects])));
    }
    for (int i = 0; i < result.count; i++) {
        
         typeIndex == 0? [self.orderListDataAry addObject:[ZXYOrderModell createObjWithDic:result[i]]]:(typeIndex == 1?[self.paymentDataAry addObject:[ZXYOrderModell createObjWithDic:result[i]]]:(typeIndex == 2?[self.sendGoodDataAry addObject:[ZXYOrderModell createObjWithDic:result[i]]]:(typeIndex == 3?[self.getGoodDataAry addObject:[ZXYOrderModell createObjWithDic:result[i]]]:[self.evaluateDataAry addObject:[ZXYOrderModell createObjWithDic:result[i]]])));
    }
    
    [self.listDataArray addObjectsFromArray:typeIndex == 0?self.orderListDataAry:(typeIndex==1?self.paymentDataAry:(typeIndex==2?self.sendGoodDataAry:(typeIndex == 3?self.getGoodDataAry:self.evaluateDataAry)))];
  
}

#pragma mark - OrderHeaderDelegate
//点击头部按钮的触发事件

- (void)selectBtnTypeTag:(NSInteger)typeTag
{
    typeIndex = typeTag;
    [self.listDataArray removeAllObjects];
        switch (typeTag) {
            case 0://全部
            {
                
                curentPage = allCurentPage;
                requestStatus = @"0";
                [self.listDataArray addObjectsFromArray:self.orderListDataAry];
                 self.orderListDataAry.count == 0? [self requestOrderList]:(self.noOrderView.hidden=YES);

            }
                break;
            case 1://待付款
            {
                curentPage = paymentCurentPage;
                requestStatus = @"1";

                [self.paymentDataAry removeAllObjects];
                [self.listDataArray addObjectsFromArray:self.paymentDataAry];
                NSLog(@"%ld",self.paymentDataAry.count);
                self.paymentDataAry.count == 0? [self requestOrderList]:(self.noOrderView.hidden=YES);

            }
                break;
            case 2://待发货
            {
                curentPage = sendGoodCurentPage;
                requestStatus = @"2";
                [self.listDataArray addObjectsFromArray:self.sendGoodDataAry];
                self.sendGoodDataAry.count == 0? [self requestOrderList]:(self.noOrderView.hidden=YES);
            }
                break;
            case 3://待收货
            {
                curentPage = getGoodCurentPage;
                requestStatus = @"3";
                [self.listDataArray addObjectsFromArray:self.getGoodDataAry];
                self.getGoodDataAry.count == 0? [self requestOrderList]:(self.noOrderView.hidden=YES);

            }
                break;
            case 4://待评价
            {
                
                curentPage = evaluateCurentPage;
                requestStatus = @"4";
                [self.listDataArray addObjectsFromArray:self.evaluateDataAry];
                self.evaluateDataAry.count == 0? [self requestOrderList]:(self.noOrderView.hidden=YES);
                if(querenStatus){
                    querenStatus = NO;
                    evaluateCurentPage =@"1";
                    curentPage = evaluateCurentPage;
                    [self requestOrderList];
                }


            }
                break;
            default:
                break;
        }

    [self.orderListTableView reloadData];
}

#pragma mark - OrderStatuDelegate
/*弹出提示框+部分操作-申请退款/评价
 */
-(void)orderStatuWithButton:(id)sender andCellTag:(NSInteger)tag
{
    UIButton *btn = (UIButton *)sender;
    NSString *btnTitlt = btn.titleLabel.text;
    cellSelectTag = tag - 1000;
    ZXYOrderModell *orderModel = self.listDataArray[cellSelectTag];
    
    if ([btnTitlt isEqual:@"申请退款"]||[btnTitlt isEqual:@"申请售后"]) {
//        if ([btnTitlt isEqual:@"申请售后"]) {
//            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//        }
            self.maskView.hidden = NO;
        self.callCustomView.hidden = NO;
        self.popMessTitleLabel.text = [btnTitlt isEqual:@"申请售后"]?@"申请售后":@"退款退货";
        
    }else if ([btnTitlt isEqual:@"删除订单"]){
        
        
        self.orderAlertTitle.text = @"确认删除订单?";
        self.orderAlertContent.text = @"删除后将无法恢复";
        [self showAlertView];
    }else if ([btnTitlt isEqual:@"取消订单"]){
        self.orderAlertTitle.text = @"";
        self.orderAlertContent.text = @"确定要取消订单吗?";
        [self showAlertView];
    }else if ([btnTitlt isEqual:@"支付"]){
        [self pushPayViewWithModel:orderModel];
    }else if ([btnTitlt isEqual:@"确认收货"]){
        self.orderAlertTitle.text = @"";
        self.orderAlertContent.text = @"为确保商品准确送到您手中\n亲，您真的收到商品了吗?";
        [self showAlertView];
        
    }else if ([btnTitlt isEqual:@"评价"]){
        [self pushEvalutionVCandGoodsID:orderModel];
    }
}

//点击对应的cell的方法
- (void)didSelectCellTag:(NSInteger)tag
{
    if (self.listDataArray.count > 0) {
        [self pushOrderDetailVCandModel:self.listDataArray[tag-1000]];
        
    }
}
#pragma mark -PUSH
/*去评论
 */
-(void)pushEvalutionVCandGoodsID:(ZXYOrderModell *)orderModel
{
    LYQGoodsEvalutionViewController * evalutionVC = [[LYQGoodsEvalutionViewController alloc]initWithNibName:@"LYQGoodsEvalutionViewController" bundle:nil];
    evalutionVC.orderGoodsArray = orderModel.goodsImageArray;
    evalutionVC.submitOderNum   =orderModel.orderNum;
    [self.navigationController pushViewController:evalutionVC animated:YES];
  
}
/*去订单详情
 */
-(void)pushOrderDetailVCandModel:(ZXYOrderModell *)orderModel
{
    ZXYOrderDetailViewController *detailVC = [[ZXYOrderDetailViewController alloc] initWithNibName:@"ZXYOrderDetailViewController" bundle:nil];
    detailVC.commitModel = commitModel;
    detailVC.orderModel = orderModel;
    detailVC.refundPhone = self.refuncPhoneLabel.text;
    [self.navigationController pushViewController:detailVC animated:YES];
}
/*去支付
 */
-(void)pushPayViewWithModel:(ZXYOrderModell *)orderModel
{
//修改 9.17 为通过邮费与现金总价判断
    if([orderModel.goodsCashAmout floatValue]+[orderModel.orderFreight floatValue]!=0.00){
        commitModel.pay_type = @"1";
    }else{
        commitModel.pay_type = @"2";
    }
    commitModel.spending = orderModel.goodsSpendingAmount;
    commitModel.cash_apend =orderModel.goodsCashAmout;
    commitModel.orderNum = orderModel.orderNum;
    
    LSYPayViewController *payVC = [[LSYPayViewController alloc] init];
    payVC.act_ID = orderModel.cat_ID;
    NSString *goodsAmountStr = [MarketAPI judgeCostTypeWithCash: [NSString stringWithFormat:@"%f",[orderModel.goodsCashAmout doubleValue]]  andIntegral:[NSString stringWithFormat:@"%.0f",[orderModel.goodsSpendingAmount doubleValue]]  withfreight:[NSString stringWithFormat:@"%f",[orderModel.orderFreight doubleValue]] withWrap:NO];
    payVC.meonyStr = goodsAmountStr;
    
    [self.navigationController pushViewController:payVC animated:YES];
}

/*去首页  劳燕子
 */
- (IBAction)goMallAction:(id)sender {
    
//    LSYHomePageViewController * homeControl = [[LSYHomePageViewController alloc]initWithNibName:@"LSYHomePageViewController" bundle:nil];
//    [self.navigationController pushViewController:homeControl animated:YES];
    GAHomeTabBarController *tabbar = [GAHomeTabBarController sharedHomeTabBarController];
    [tabbar selectTabBarAtIndex:2];
    [tabbar.homeTabBar selectTabBarAtIndex:2];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

#pragma mark - OrderAlert
/*确认操作
 */
- (IBAction)orderConfirm:(id)sender {
    ZXYOrderModell *orderModel = self.listDataArray[cellSelectTag];
    if ([self.orderAlertContent.text isEqual: @"删除后将无法恢复"]) {
        
        [self requestDeleteOrderWithOrderNum:orderModel.orderNum];
//        [self addBubble];
    }else if ([self.orderAlertContent.text isEqual: @"确定要取消订单吗?"]) {
        
        [self requestCancelDingdanWithOrderNum:orderModel.orderNum];
        
    }else if ([self.orderAlertContent.text isEqual: @"为确保商品准确送到您手中\n亲，您真的收到商品了吗?"]) {
        [self requestConfirmReceiveWithOrderNum:orderModel.orderNum];
    }
    self.maskView.hidden = YES;
    self.orderAlertView.hidden = YES;
}
/*取消操作
 */
- (IBAction)orderCancel:(id)sender {
    self.maskView.hidden = YES;
    self.orderAlertView.hidden = YES;
}


@end
