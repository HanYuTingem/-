//
//  ZXYOrderDetailViewController.m
//  MarketManage
//
//  Created by Rice on 15/1/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYOrderDetailViewController.h"
#import "LSYPayViewController.h"
#import "BSaveMessage.h"
#import "LSYGoodsInfoViewController.h"
#import "LYQGoodsImageTableViewCell.h"
#import "LYQGoodsEvalutionViewController.h"
#import "ZXYOrderConnectCell.h"
#import "CrazyBasisAlertView.h"
#import "shopManView.h"

/** dh 添加订单详情 */
#import "DHorderCell.h"
/** 留言 */
#import "DHOrderDetailMessageView.h"
/** 收起  还剩多少的按钮 */
#import "DHOrderDetailBtn.h"
@interface ZXYOrderDetailViewController ()
{
    ASIFormDataRequest * mRequest;
    /** 用来判断还有没有商品 */
    BOOL _ifShowAllGoods;
    
    BOOL _ifGOComment;
}

@property (weak, nonatomic) IBOutlet UILabel *popMesageTitleLabel;
@property (weak, nonatomic) IBOutlet UITableView *orderDetailTableView;
//底部右边操作订单按钮 - 确认收货/评价/删除订单/支付/
@property (weak, nonatomic) IBOutlet UIButton *functionBtn_2;
//底部左边操作订单按钮 - 申请退款/取消订单
@property (weak, nonatomic) IBOutlet UIButton *functionBtn_1;
@property (weak, nonatomic) IBOutlet UIButton *funtionBtn_3;
//提示框遮罩
@property (weak, nonatomic) IBOutlet UIView *maskView;
//申请退款
@property (weak, nonatomic) IBOutlet UIView *callCustomView;
//退款电话
@property (weak, nonatomic) IBOutlet UILabel *refundPhoneLabel;
//操作提示框标题
@property (weak, nonatomic) IBOutlet UILabel *detailAlertTitle;
//操作提示框内容
@property (weak, nonatomic) IBOutlet UILabel *detailAlertContent;
//操作提示框-确认按钮
@property (weak, nonatomic) IBOutlet UIButton *detailAlertConfirm;
//操作提示框-取消按钮
@property (weak, nonatomic) IBOutlet UIButton *detailAlertCancel;
//操作提示框
@property (weak, nonatomic) IBOutlet UIView *detailAlertView;

@property (nonatomic,strong) GCRequest * lsyMainRequest;
/*
 操作订单
 */
- (IBAction)handleOrderAcion:(id)sender;

@end

@implementation ZXYOrderDetailViewController

#pragma mark - LifeCycle

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestOrderDetail];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _ifGOComment = YES;
    _ifShowAllGoods = YES;
    [self setNavigationStyle];
    [self initData];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [mRequest cancel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Init
-(void)setNavigationStyle
{
    self.mallTitleLabel.text= @"订单详情";
    self.rightButton .hidden = YES;
    _rightTelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.barCenterView addSubview:_rightTelBtn];
    _rightTelBtn.contentHorizontalAlignment = NSTextAlignmentRight;
    [_rightTelBtn addTarget:self action:@selector(rightBackCliked:) forControlEvents:UIControlEventTouchUpInside];
    _rightTelBtn.frame = CGRectMake(SCREENWIDTH -90, 25, 80, 40);
    [_rightTelBtn setTitle:@"联系客服" forState:UIControlStateNormal];
    [_rightTelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _rightTelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
//    [self.rightButton setTitle:@"联系客服" forState:UIControlStateNormal];
//
//    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
////    self.rightButton.frame = CGRectMake(CGRectGetMidX(self.rightButton.frame)-35, CGRectGetMinY(self.rightButton.frame), CGRectGetWidth(self.rightButton.frame)+16, CGRectGetHeight(self.rightButton.frame));
//    self.rightButton.frame = CGRectMake(SCREENWIDTH - 100 , 0, 100, 40);
//    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:13];

}

-(void)initData
{
     self.commitModel = [ZXYCommitOrderRequestModel shareInstance];
    
    self.callCustomView.layer.cornerRadius = 8;
    self.detailAlertView.layer.cornerRadius = 8;
    self.refundPhoneLabel.text = self.refundPhone;
    
    [MarketAPI setRedButton:self.detailAlertConfirm];
    [MarketAPI setRedButton:self.detailAlertCancel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMaskView:)];
    [self.maskView addGestureRecognizer:tap];
    
}
/*
 判断状态显示操作订单按钮
 */
-(void)setLayout
{
    self.funtionBtn_3.hidden = YES;

    [MarketAPI setRedButton:self.functionBtn_1];
    [MarketAPI setRedButton:self.functionBtn_2];
    
    switch ([self.orderDetailModel.orderStatu integerValue]) {
        case 1://待付款
        {
            self.functionBtn_1.hidden = NO;
            [MarketAPI setGrayButton:self.functionBtn_1];
            [self.functionBtn_1 setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.functionBtn_2 setTitle:@"立即付款" forState:UIControlStateNormal];
            break;
        }
        case 2://未领取/待发货
        {
            self.functionBtn_1.hidden = YES;
            [self.functionBtn_2 setTitle:@"申请退款" forState:UIControlStateNormal];
            break;
        }
        case 3://待收货
        {
            
            // 9.17  修改，
            if (_ifGOComment == YES) {
                self.functionBtn_1.hidden = NO;
                [MarketAPI setRedButton:self.functionBtn_1];
                [self.functionBtn_1 setTitle:@"申请退款" forState:UIControlStateNormal];
                [self.functionBtn_2 setTitle:@"确认收货" forState:UIControlStateNormal];
                break;
            }else{
                self.functionBtn_1.hidden = NO;
                self.funtionBtn_3.hidden = NO;
                
                [MarketAPI setGrayButton:self.functionBtn_1];
                [MarketAPI setRedButton:self.functionBtn_2];
                [MarketAPI setGrayButton:self.funtionBtn_3];
                [self.functionBtn_1 setTitle:@"删除订单" forState:UIControlStateNormal];
                [self.functionBtn_2 setTitle:@"评价" forState:UIControlStateNormal];
                [self.funtionBtn_3 setTitle:@"申请售后" forState:UIControlStateNormal];
                
                break;
            }
          
        }
        case 4://待评价
        {
            self.functionBtn_1.hidden = NO;
            self.funtionBtn_3.hidden = NO;

            [MarketAPI setGrayButton:self.functionBtn_1];
            [MarketAPI setRedButton:self.functionBtn_2];
            [MarketAPI setGrayButton:self.funtionBtn_3];
            [self.functionBtn_1 setTitle:@"删除订单" forState:UIControlStateNormal];
            [self.functionBtn_2 setTitle:@"评价" forState:UIControlStateNormal];
            [self.funtionBtn_3 setTitle:@"申请售后" forState:UIControlStateNormal];

            break;
        }
        case 5://已完成
        {
            self.functionBtn_1.hidden = NO;
            [MarketAPI setRedButton:self.functionBtn_1];

            [self.functionBtn_1 setTitle:@"申请售后" forState:UIControlStateNormal];
            [self.functionBtn_2 setTitle:@"删除订单" forState:UIControlStateNormal];
            break;
        }
        case 6://已取消
        {
            self.functionBtn_1.hidden = YES;
            [self.functionBtn_2 setTitle:@"删除订单" forState:UIControlStateNormal];
            break;
        }
        case 7://已过期
        {
            self.functionBtn_1.hidden = NO;
            [MarketAPI setRedButton:self.functionBtn_1];

            [self.functionBtn_1 setTitle:@"申请退款" forState:UIControlStateNormal];
            [self.functionBtn_2 setTitle:@"删除订单" forState:UIControlStateNormal];
            break;
        }
        case 8://已关闭
        {
            self.functionBtn_1.hidden = YES;
            [self.functionBtn_2 setTitle:@"删除订单" forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
}
/*
 隐藏所有提示框
 */
- (IBAction)hideMaskView:(id)sender {
    self.callCustomView.hidden = YES;
    self.maskView.hidden = YES;
    self.detailAlertView.hidden = YES;
}
/*
 显示操作提示框
 */
-(void)showDetailOrderView
{
    self.detailAlertView.hidden = NO;
    self.maskView.hidden = NO;
}
/*
 隐藏操作提示框
 */
-(void)hideDetailOrderView
{
    self.detailAlertView.hidden = YES;
    self.maskView.hidden = YES;
    
}
/*
 拨打退款电话
 */
- (IBAction)callCustomAction:(id)sender {
    [self hideMaskView:nil];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.refundPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

#pragma mark - UITableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.orderDetailModel != nil) {
        return 5;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section == 2) {
        if (_ifShowAllGoods) {
            if (self.orderDetailModel.goodsArray.count>=2) {
                return 2;
            }
            else
            {
                return 1;
            }
            return 1;
        }else{
            
            return self.orderDetailModel.goodsArray.count;
        }
    }else{
        return 1;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 37)];
        headView.backgroundColor = [UIColor whiteColor];
        UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 14, 14)];
        left.image = [UIImage imageNamed:@"未标题-2_0001_mall_list_ico_shop3@x.png"];
        [headView addSubview:left];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, SCREENWIDTH - 40, 30)];
        label.font =[UIFont systemFontOfSize:12];
        label.textColor =CrazyColor(37, 37, 37);
        label.text = self.orderModel.merchantsName;
        [headView addSubview:label];
        return headView;
    }else if (section == 3) {
        DHOrderDetailMessageView *messageView = [[DHOrderDetailMessageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50) controller:self andNote:self.orderDetailModel.orderNote];
        return messageView;
    }{
        return nil;
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 2 && _orderModel.goodsImageArray.count>2) {

        DHOrderDetailBtn *btn = [[DHOrderDetailBtn alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
        btn.goodsCount = _orderModel.goodsImageArray;
        btn.ifShow = _ifShowAllGoods;
        btn.selected = YES;
        [btn addTarget:self action:@selector(leaveButtonDown:) forControlEvents:UIControlEventTouchUpInside];
        return btn;
    }else{
        return nil;
    }
}
/** 点击查看更多商品，如果商品大于2的话 */
-(void)leaveButtonDown:(DHOrderDetailBtn *)btn{
    _ifShowAllGoods = !_ifShowAllGoods;
       [self.orderDetailTableView reloadData];
    NSLog(@"改变显示");
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    switch (indexPath.section) {
        case OderDetailNumSectionNone:
        {
            ZXYOrderNumCell *numCell = [tableView dequeueReusableCellWithIdentifier:@"orderNumCell"];
            if (numCell == nil) {
                numCell = [[NSBundle mainBundle] loadNibNamed:@"ZXYOrderNumCell" owner:self options:nil][0];
                numCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            numCell.orderModel = self.orderModel;
            numCell.detailModel = self.orderDetailModel;
            [numCell setCellData];
            [numCell setCellLayout];
            return numCell;
            break;
        }case OderDetailNumSectionOne:
        {

            DHorderCell *DHCell = [tableView dequeueReusableCellWithIdentifier:@"DHcell"];
            if (DHCell == nil) {
                DHCell = [[DHorderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DHcell"];
            }
              shopManView *shopMan = [[shopManView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 82) arrowImageView:@"mall_list_ico_address2@x.png" userName:[NSString stringWithFormat:@"收货人：%@",_orderDetailModel.connectName] userTel:_orderDetailModel.connectTel userAdress:[NSString stringWithFormat:@"收货地址：%@",_orderDetailModel.connectAdd] arrow:@""];
            DHCell.backgroundColor = CrazyColor(240, 242, 245);

            DHCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [DHCell addSubview:shopMan];
            return DHCell;
        }
        case OderDetailNumSectionTwo:
        {
            
            LYQGoodsImageTableViewCell * goodImageCell = [tableView dequeueReusableCellWithIdentifier:@"GoodsImageTableViewCell"];
            if(goodImageCell == nil){
                goodImageCell = [[NSBundle mainBundle] loadNibNamed:@"LYQGoodsImageTableViewCell" owner:self options:nil][0];
                goodImageCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if (_ifShowAllGoods) {
                if (indexPath.row< 2) {
                    
                    
#warning 不要删除
                    goodImageCell.detailModel = [self.orderDetailModel.goodsArray objectAtIndex:indexPath.row];
                    [goodImageCell setCellData];
                }
            }else{
                goodImageCell.detailModel = [self.orderDetailModel.goodsArray objectAtIndex:indexPath.row];
                [goodImageCell setCellData];
            }
            
            return goodImageCell;
        }
        case OderDetailNumSectionThree:
        {
            ZXYOrderConnectCell *connectCell = [tableView dequeueReusableCellWithIdentifier:@"orderConnectCell"];
            if (connectCell == nil) {
                connectCell = [[NSBundle mainBundle] loadNibNamed:@"ZXYOrderConnectCell" owner:self options:nil][0];
                connectCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
           
            connectCell.backgroundColor = [UIColor redColor];
            connectCell.detailModel = self.orderDetailModel;
            [connectCell setCellData];
            [connectCell setCellLayout];
            connectCell.hidden = NO;
            return connectCell;
            
        }
            break;
        case OderDetailNumSectionFour:
        {
            
            ZXYOrderGoodsCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:@"orderGoodsCell"];
            
            
            if (goodsCell == nil) {
                goodsCell = [[ZXYOrderGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderGoodsCell" andIden:self.orderModel.orderStatu andSpending_total:self.orderModel.goodsSpendingAmount goodsCashAmout:self.orderModel.goodsCashAmout];
            }
            
            goodsCell.selectionStyle = UITableViewCellSelectionStyleNone;
            goodsCell.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.96f alpha:1.00f];
            goodsCell.orderModel = self.orderModel;
            goodsCell.detailModel = self.orderDetailModel;
            [goodsCell setCellData];
            [goodsCell setCellLayout];
            return goodsCell;

        }
            break;
            
        
        default:
            break;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2 && _orderModel.goodsImageArray.count>2) {
        return 40.f;
    }else
    {
        return 0.1f;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 37.f;
    }
    else if (section == 3){
        return 50.f;
    }
    else{
        return 0.1f;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case OderDetailNumSectionNone:
        {
            return 45;

        }
            break;
        case OderDetailNumSectionOne:
        {
            return 93;
        }
            break;

        case OderDetailNumSectionTwo:
            return 100;
        case OderDetailNumSectionThree:
        {
        
            return 128;
        }
            break;
        case OderDetailNumSectionFour:
        {
            CGFloat addHeigh = [MarketAPI labelAutoCalculateRectWith:self.orderDetailModel.orderNote FontSize:14. MaxSize:CGSizeMake(264, MAXFLOAT)].height;
            //判断有没有积分
            NSLog(@"%@",self.orderModel.goodsSpendingAmount);
            
            
            
            if ([self.orderModel.goodsSpendingAmount isEqualToString:@"0"] || [self.orderModel.goodsCashAmout isEqualToString:@"0.00"]) {
                
                if ([self.orderModel.orderStatu isEqualToString:@"3"]) {
                    //判断是不是代收货
                    return 260;
                }else{
                    return 220;
                }
                
            }else{
                if ([self.orderModel.orderStatu isEqualToString:@"3"]) {
                    return 285;
                }else{
                    return 237;
                }
            }
        }
        default:
            break;
    }
    
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        LSYGoodsInfoViewController *productVC = [[LSYGoodsInfoViewController alloc] initWithNibName:@"LSYGoodsInfoViewController" bundle:nil];
        ZXYOrderDetailModel * orderSubDetailModel = [self.orderDetailModel.goodsArray objectAtIndex:indexPath.row];
        productVC.goods_id = orderSubDetailModel.goods_id;
        [self.navigationController pushViewController:productVC animated:YES];
    }
}

#pragma mark -Request
/*请求订单详情
 */
- (void)requestOrderDetail
{
    [self startActivity];
    self.lsyMainRequest = [MarketAPI requestoderDetail201WithController:self oderNum:self.orderModel.orderNum];
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
    [self stopActivity];
    NSString * tEndString = [aString stringByReplacingOccurrencesOfString:@"\n" withString:@"\n"];
    NSDictionary * dict = [tEndString JSONValue];
    NSLog(@"%@",dict);
    if (!dict){
        NSLog(@"接口错误");
        return;
    }
    if ([dict[@"code"] integerValue] == 0 && dict[@"code"] != nil) {
        switch (aRequest.tag) {
            case 201://订单详情
            {
                self.orderDetailModel = [ZXYOrderDetailModel createObjWithDic:dict WithAry:[[NSDictionary alloc] init]];
                
                [self.orderDetailTableView reloadData];
                [self setLayout];
                break;
            }
            case 207://删除订单
            {
                [self showMsg:@"删除订单成功"];
                [self performSelector:@selector(popVC) withObject:self afterDelay:1.0];
                break;
            }
            case 205://确认收货
            {
                self.orderDetailModel.orderStatu = @"4";
                [self.orderDetailTableView reloadData];
                [self showMsg:@"确认收货成功"];
                [self setLayout];
                [self requestOrderDetail];

                break;
            }
            default:
                break;
        }
    }else if([dict[@"code"] integerValue] == 23 && dict[@"code"] != nil){//取消订单
        if (aRequest.tag == 203) {
            self.orderDetailModel.orderStatu = @"6";
            [self.orderDetailTableView reloadData];
            [self setLayout];
        }
    }else{
        [self showMsg:dict[@"message"]];
    }


}

-(void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self stopActivity];
    [self showMsg:@"请求失败，请检查网路设置"];
}

- (IBAction)handleOrderAcion:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    NSString *btnTitle = btn.titleLabel.text;
    
    if ([btnTitle isEqual:@"申请退款"]||[btnTitle isEqual:@"申请售后"]) {
        self.callCustomView.hidden = NO;
        self.maskView.hidden = NO;
        self.popMesageTitleLabel.text = [btnTitle isEqual:@"申请售后"]?@"申请售后":@"退款退货";
    }else if ([btnTitle isEqual:@"删除订单"]){
        self.detailAlertTitle.text = @"确认删除订单?";
        self.detailAlertContent.text = @"删除后将无法恢复";
        [self showDetailOrderView];
        
    }else if ([btnTitle isEqual:@"取消订单"]){
        self.detailAlertTitle.text = @"";
        self.detailAlertContent.text = @"确定要取消订单吗?";
        [self showDetailOrderView];
        
    }else if ([btnTitle isEqual:@"立即付款"]){
         [self pushPayViewWithModel:self.orderModel];
    }else if ([btnTitle isEqual:@"确认收货"]){
        self.detailAlertTitle.text = @"";
        self.detailAlertContent.text = @"为确保商品准确送到您手中\n亲，您真的收到商品了吗?";
        [self showDetailOrderView];
        
    }else if ([btnTitle isEqual:@"评价"]){
        [self pushEvalutionVC];
    }
}

#pragma mark - OrderAlert
- (IBAction)orderConfirm:(id)sender {
    if ([self.detailAlertContent.text isEqual: @"删除后将无法恢复"]) {
        [self requestDeleteOrderWithOrderNum:self.orderDetailModel.orderNum];
    }else if ([self.detailAlertContent.text isEqual: @"确定要取消订单吗?"]) {
        [self requestCancelDingdanWithOrderNum:self.orderDetailModel.orderNum];
    }else if ([self.detailAlertContent.text isEqual: @"为确保商品准确送到您手中\n亲，您真的收到商品了吗?"]) {
        [self requestConfirmReceiveWithOrderNum:self.orderDetailModel.orderNum];
    }
    self.maskView.hidden = YES;
    self.detailAlertView.hidden = YES;
}
- (IBAction)orderCancel:(id)sender {
    self.maskView.hidden = YES;
    self.detailAlertView.hidden = YES;
}

#pragma mark -PUSH
/*去评论
 */
-(void)pushEvalutionVC
{
    LYQGoodsEvalutionViewController * evalutionVC = [[LYQGoodsEvalutionViewController alloc]initWithNibName:@"LYQGoodsEvalutionViewController" bundle:nil];
    
    //  9.17 修改  获取是否已经没有评价的

    evalutionVC.orderGoodsArray = self.orderDetailModel.goodsArray;
    evalutionVC.submitOderNum   =_orderModel.orderNum;
    [self.navigationController pushViewController:evalutionVC animated:YES];
    
}

-(void)popVC
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*去支付
 */
-(void)pushPayViewWithModel:(ZXYOrderModell *)orderModel
{
    
    if([orderModel.goodsCashAmout floatValue]!=0.00){
        _commitModel.pay_type = @"1";
    }else{
        _commitModel.pay_type = @"2";
    }
    _commitModel.spending = orderModel.goodsSpendingAmount;
    _commitModel.cash_apend =orderModel.goodsCashAmout;
    _commitModel.orderNum = orderModel.orderNum;
    
    LSYPayViewController *payVC = [[LSYPayViewController alloc] init];
    payVC.act_ID    = orderModel.cat_ID;
    NSString *goodsAmountStr = [MarketAPI judgeCostTypeWithCash: [NSString stringWithFormat:@"%f",[orderModel.goodsCashAmout doubleValue]]  andIntegral:[NSString stringWithFormat:@"%.0f",[orderModel.goodsSpendingAmount doubleValue]]  withfreight:[NSString stringWithFormat:@"%f",[orderModel.orderFreight doubleValue]] withWrap:NO];
    payVC.meonyStr = goodsAmountStr;
    [self.navigationController pushViewController:payVC animated:YES];
    
}


-(void)rightBackCliked:(UIButton *)sender
{
        NSLog(@"电话为%@",self.refundPhone);
    
    [CrazyBasisAlertView CrazyBasisAlertViewShowTitle:@"" content:self.refundPhone buttonTextArray:@[@"取消",@"呼叫"] leftSelectBlock:^(CrazyBasisButton *confirmButton) {
        
    } rigthSelectBlock:^(CrazyBasisButton *cancelBlock) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.refundPhone]]];
    }];
    

}

@end
