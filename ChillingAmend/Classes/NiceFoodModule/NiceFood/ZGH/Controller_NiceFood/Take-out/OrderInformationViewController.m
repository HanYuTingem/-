//
//  OrderInformationViewController.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/29.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "OrderInformationViewController.h"
#import "OrderDetailModel.h"
#import "ViewOfCustomButton.h"
#import "CashierDeskViewController.h"

@interface OrderInformationViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) OrderDetailModel *model;      //数据模型

@property (nonatomic, strong) UIScrollView *scrollView;      //

@property (nonatomic, copy) NSArray *arr;


@end

@implementation OrderInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    titleButton.hidden = NO;
    [titleButton setTitle:@"外卖详情" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self requestData];
}


- (void)addUI{
//    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavigationH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationH)];
    [_scrollView setBackgroundColor:[UIColor whiteColor]];
    [mainView addSubview:_scrollView];
    
//    订单状态
    ViewOfCustomButton *OrderState = [[ViewOfCustomButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ViewHeight)];
    [OrderState setBackgroundColor:RGBACOLOR(230, 230, 230, 1)];
    [OrderState setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_scrollView addSubview:OrderState];
    switch ([_model.orderFinishState intValue]) {
        case 0:
            [OrderState setTitle:@"订单未处理……" forState:UIControlStateNormal];
            break;
        case 1:
            [OrderState setTitle:@"订单已接单……" forState:UIControlStateNormal];
            break;
        case 2:
            [OrderState setTitle:@"订单已配送……" forState:UIControlStateNormal];
            break;
        case 3:
            [OrderState setTitle:@"订单已完成……" forState:UIControlStateNormal];
            break;
        case 4:
            [OrderState setTitle:@"订单已关闭……" forState:UIControlStateNormal];
            break;
        case 5:
            [OrderState setTitle:@"订单已拒绝……" forState:UIControlStateNormal];
            break;
        case 6:
            [OrderState setTitle:@"订单已取消……" forState:UIControlStateNormal];
            break;
        case 7:
            [OrderState setTitle:@"订单已过期……" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
//    订单编号
    UILabel *orderCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(OrderState.frame) + ViewHeight /4, 60, ViewHeight/2)];
    [orderCodeLabel setText:@"订单号:"];
    [_scrollView addSubview:orderCodeLabel];
    
    UILabel *orderCode = [[UILabel alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(OrderState.frame) + ViewHeight /4, SCREEN_WIDTH - 100, ViewHeight/2)];
    [orderCode setText:_model.orderCode];
    [orderCode setTextColor:RGBACOLOR(230, 60, 82, 1)];
    [_scrollView addSubview:orderCode];
    
    //    分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(orderCodeLabel.frame) + ViewHeight /4, SCREEN_WIDTH - 20, 1)];
    [line setBackgroundColor:RGBACOLOR(200, 200, 200, 1)];
    [_scrollView addSubview:line];

    
//    商户名称
    UILabel *shopName = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line.frame) + ViewHeight /4, SCREEN_WIDTH - 40, ViewHeight/2)];
    [shopName setText:_model.ownerName];
    [_scrollView addSubview:shopName];
    
//    分割线1
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(shopName.frame) + ViewHeight /4, SCREEN_WIDTH - 20, 1)];
    [line1 setBackgroundColor:RGBACOLOR(200, 200, 200, 1)];
    [_scrollView addSubview:line1];
    
//    商品列表
    for (int i = 0; i < _model.dishesList.count; i++) {
        
        NSDictionary *dic = _model.dishesList[i];
        
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line1.frame) + ViewHeight * (i*3+1) /4, 160, ViewHeight /2)];
        [leftLabel setText:[NSString stringWithFormat:@"%@:%@", dic[@"categoryName"], dic[@"contentName"]]];
        [leftLabel setTextColor:[UIColor grayColor]];
        [_scrollView addSubview:leftLabel];
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 140, CGRectGetMaxY(line1.frame) + ViewHeight * (i*3+1) /4, 120, ViewHeight /2)];
        [rightLabel setText:[NSString stringWithFormat:@"￥%@/%@份", dic[@"price"], dic[@"contentCount"]]];
        [rightLabel setTextColor:[UIColor grayColor]];
        [rightLabel setTextAlignment:NSTextAlignmentRight];
        [_scrollView addSubview:rightLabel];
        
        if (i > 0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line1.frame) + ViewHeight * (i*3.5) /4, SCREEN_WIDTH - 40 , 1)];
            [line setBackgroundColor:RGBACOLOR(240, 240, 240, 1)];
            [_scrollView addSubview:line];
        }
    }
  
//    分割线2
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(line1.frame) + ViewHeight * (_model.dishesList.count * 3 + 1)/4, SCREEN_WIDTH - 20, 1)];
    [line2 setBackgroundColor:RGBACOLOR(200, 200, 200, 1)];
    [_scrollView addSubview:line2];
  
//    支付方式
    UILabel *payModelLeft = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line2.frame) + ViewHeight/4, 100, ViewHeight /2)];
    [payModelLeft setText:@"支付方式"];
    [_scrollView addSubview:payModelLeft];
    
    UILabel *payModelRight = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 170, CGRectGetMaxY(line2.frame) + ViewHeight/4, 150, ViewHeight /2)];
    [payModelRight setTextAlignment:NSTextAlignmentRight];
    if ([_model.payMode isEqualToString:@"1"]) {
        switch ([_model.payState intValue]) {
            case 0:
                [payModelRight setText:@"在线支付-未支付"];
                break;
            case 1:
                [payModelRight setText:@"在线支付-支付中"];
                break;
            case 2:
                [payModelRight setText:@"在线支付-支付成功"];
                break;
            case 3:
                [payModelRight setText:@"在线支付-支付失败"];
                break;
            default:
                break;
        }

    } else {
        [payModelRight setText:@"货到付款"];
    }
    [_scrollView addSubview:payModelRight];
    
//    分割线3
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(line2.frame) + ViewHeight, SCREEN_WIDTH - 20, 1)];
    [line3 setBackgroundColor:RGBACOLOR(200, 200, 200, 1)];
    [_scrollView addSubview:line3];
    
//  发票信息
    UILabel *billLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line3.frame) + ViewHeight/4, 100, ViewHeight /2)];
    [billLabel setText:@"发票信息"];
    [_scrollView addSubview:billLabel];
    
    UIView *line3_1 = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line3.frame) + ViewHeight*3.5/4, SCREEN_WIDTH - 40 , 1)];
    [line3_1 setBackgroundColor:RGBACOLOR(240, 240, 240, 1)];
    [_scrollView addSubview:line3_1];
    
    UILabel *bill = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line3.frame) + ViewHeight, SCREEN_WIDTH - 40, ViewHeight /2)];
    [bill setTextColor:[UIColor grayColor]];
    
    if (_model.invoiceDetail.length > 0) {
        [bill setNumberOfLines:0];
        [bill setText:_model.invoiceDetail];
        [bill setLineBreakMode:NSLineBreakByWordWrapping];
        CGSize size =  [self sizeWithString:bill.text font:bill.font width:bill.frame.size.width];
        [bill setFrame:CGRectMake(20, CGRectGetMaxY(line3.frame) + ViewHeight, SCREEN_WIDTH - 40, size.height)];
    } else {
        [bill setText:@"没有发票信息"];
    }
    
    [_scrollView addSubview:bill];
    
//    分割线4
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(bill.frame) + ViewHeight/4, SCREEN_WIDTH - 20, 1)];
    [line4 setBackgroundColor:RGBACOLOR(200, 200, 200, 1)];
    [_scrollView addSubview:line4];
    
//    备注
    UILabel *markLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line4.frame) + ViewHeight /4, 200, ViewHeight/2)];
    [markLabel setText:@"备注"];
    [_scrollView addSubview:markLabel];
    
    UIView *line4_1 = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line4.frame) + ViewHeight*3.5/4, SCREEN_WIDTH - 40 , 1)];
    [line4_1 setBackgroundColor:RGBACOLOR(240, 240, 240, 1)];
    [_scrollView addSubview:line4_1];
    
    UILabel *remark = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line4.frame) + ViewHeight, SCREEN_WIDTH - 40, ViewHeight /2)];
    [remark setTextColor:[UIColor grayColor]];
    
    if (_model.remark.length > 0) {
        [remark setNumberOfLines:0];
        [remark setText:_model.remark];
        [remark setLineBreakMode:NSLineBreakByWordWrapping];
        CGSize size =  [self sizeWithString:remark.text font:remark.font width:remark.frame.size.width];
        [remark setFrame:CGRectMake(20, CGRectGetMaxY(line4.frame) + ViewHeight, SCREEN_WIDTH - 40, size.height)];
    } else {
        [remark setText:@"暂无备注"];
    }
    [_scrollView addSubview:remark];
    
    //    分割线5
    UIView *line5 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(remark.frame) + ViewHeight/4, SCREEN_WIDTH - 20, 1)];
    [line5 setBackgroundColor:RGBACOLOR(200, 200, 200, 1)];
    [_scrollView addSubview:line5];
    
//    配送地址title
    UILabel *addressTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line5.frame) + ViewHeight/4, 200, ViewHeight/2)];
    [addressTitle1 setText:@"配送地址"];
    [_scrollView addSubview:addressTitle1];
    
//    送餐地址
    UILabel *addressTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line5.frame) + ViewHeight *3.5/4, 85, ViewHeight/2)];
    [addressTitle2 setText:@"送餐地址："];
    [addressTitle2 setTextColor:[UIColor grayColor]];
    [_scrollView addSubview:addressTitle2];
    
//    配送地址
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(addressTitle2.frame), addressTitle2.frame.origin.y, SCREEN_WIDTH - 40 - addressTitle2.frame.size.width, ViewHeight/2)];
    [addressLabel setTextColor:[UIColor grayColor]];
    [addressLabel setFont:[UIFont systemFontOfSize:16]];
    if (_model.sendAddr.length > 0) {
        [addressLabel setNumberOfLines:0];
        [addressLabel setText:_model.sendAddr];
        [addressLabel setLineBreakMode:NSLineBreakByWordWrapping];
        CGSize size =  [self sizeWithString:addressLabel.text font:addressLabel.font width:addressLabel.frame.size.width];
        [addressLabel setFrame:CGRectMake(CGRectGetMaxX(addressTitle2.frame), addressTitle2.frame.origin.y +3, SCREEN_WIDTH - 40 - addressTitle2.frame.size.width, size.height)];
    } else {
        [addressLabel setText:@"暂无配送地址"];
    }
    [_scrollView addSubview:addressLabel];
    
//    联系方式title
    UILabel *touchTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(addressLabel.frame), 85, ViewHeight/2)];
    [touchTitle setText:@"联系方式："];
    [touchTitle setTextColor:[UIColor grayColor]];
    [_scrollView addSubview:touchTitle];
    
//    联系方式
    UILabel *touchLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(touchTitle.frame), touchTitle.frame.origin.y, SCREEN_WIDTH - 40 - touchTitle.frame.size.width, ViewHeight/2)];
    [touchLabel setFont:[UIFont systemFontOfSize:16]];
    if ([_model.linkmanSex isEqualToString:@"0"]) {
        [touchLabel setText:[NSString stringWithFormat:@"%@先生  %@", _model.linkman, _model.linkmanPhone]];
    } else {
        [touchLabel setText:[NSString stringWithFormat:@"%@女士  %@", _model.linkman, _model.linkmanPhone]];
    }
    [touchLabel setTextColor:[UIColor grayColor]];
    [_scrollView addSubview:touchLabel];
    
//    分割线6
    UIView *line6 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(touchTitle.frame) + ViewHeight /4, SCREEN_WIDTH - 20, 1)];
    [line6 setBackgroundColor:RGBACOLOR(200, 200, 200, 1)];
    [_scrollView addSubview:line6];
    
//    外卖总额title
    UILabel *orderPriceTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line6.frame) + ViewHeight /4, 150, ViewHeight/2)];
    [orderPriceTitle setText:@"外卖总额"];
    [_scrollView addSubview:orderPriceTitle];
    
    UILabel *orderPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(orderPriceTitle.frame), orderPriceTitle.frame.origin.y, SCREEN_WIDTH - 40 - orderPriceTitle.frame.size.width, ViewHeight/2)];
    [orderPrice setText:[NSString stringWithFormat:@"￥%.2f", [_model.orderPrice floatValue]]];
    [orderPrice setTextColor:RGBACOLOR(230, 60, 82, 1)];
    [orderPrice setTextAlignment:NSTextAlignmentRight];
    [_scrollView addSubview:orderPrice];
    
//    外送费title
    UILabel *sendPriceTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line6.frame) + ViewHeight *3.5/4, 85, ViewHeight/2)];
    [sendPriceTitle setText:@"外送费"];
    [sendPriceTitle setTextColor:[UIColor grayColor]];
    [_scrollView addSubview:sendPriceTitle];
    
    UILabel *sendPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(sendPriceTitle.frame), sendPriceTitle.frame.origin.y, SCREEN_WIDTH - 40 - sendPriceTitle.frame.size.width, ViewHeight/2)];
    [sendPrice setText:[NSString stringWithFormat:@"%.2f", [_model.sendPrice floatValue]]];
    [sendPrice setTextColor:RGBACOLOR(230, 60, 82, 1)];
    [sendPrice setTextAlignment:NSTextAlignmentRight];
    [_scrollView addSubview:sendPrice];
    
//    优惠价格
    UILabel *salePriceTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(sendPriceTitle.frame), 85, ViewHeight/2)];
    [salePriceTitle setText:@"优惠券"];
    [salePriceTitle setTextColor:[UIColor grayColor]];
    [_scrollView addSubview:salePriceTitle];
    
    UILabel *salePrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(salePriceTitle.frame), salePriceTitle.frame.origin.y, SCREEN_WIDTH - 40 - salePriceTitle.frame.size.width, ViewHeight/2)];
    [salePrice setText:[NSString stringWithFormat:@"-%.2f", [_model.salePrice floatValue]]];
    [salePrice setTextColor:RGBACOLOR(230, 60, 82, 1)];
    [salePrice setTextAlignment:NSTextAlignmentRight];
    [_scrollView addSubview:salePrice];

//    分割线7
    UIView *line7 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(salePriceTitle.frame) + ViewHeight /4, SCREEN_WIDTH - 20, 1)];
    [line7 setBackgroundColor:RGBACOLOR(200, 200, 200, 1)];
    [_scrollView addSubview:line7];
    
//    实付金额
    UILabel *actualPrice = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line7.frame)+ViewHeight/4, SCREEN_WIDTH - 40, ViewHeight /2)];
    [actualPrice setText:[NSString stringWithFormat:@"￥%.2f", [_model.actualPrice floatValue]]];
    [actualPrice setTextColor:RGBACOLOR(230, 60, 82, 1)];
    CGSize actualPriceSize =  [self sizeWithString:actualPrice.text font:actualPrice.font width:actualPrice.frame.size.width];
    [actualPrice setFrame:CGRectMake(SCREEN_WIDTH - 20 - actualPriceSize.width, CGRectGetMaxY(line7.frame)+ViewHeight/4, actualPriceSize.width, ViewHeight/2)];
    [_scrollView addSubview:actualPrice];
    
//    实付金额title
    UILabel *actualPriceTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line7.frame)+ViewHeight/4, SCREEN_WIDTH - 40 - actualPrice.frame.size.width, ViewHeight /2)];
    [actualPriceTitle setText:@"实付金额："];
    [actualPriceTitle setTextColor:[UIColor grayColor]];
    [actualPriceTitle setTextAlignment:NSTextAlignmentRight];
    [_scrollView addSubview:actualPriceTitle];
    
//    分割线8
    UIView *line8 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(actualPriceTitle.frame) + ViewHeight /4, SCREEN_WIDTH - 20, 1)];
    [line8 setBackgroundColor:RGBACOLOR(200, 200, 200, 1)];
    [_scrollView addSubview:line8];

//    下单时间
    UILabel *createTime = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line8.frame) + ViewHeight/4, SCREEN_WIDTH - 40 , ViewHeight/2)];
    [createTime setText:[NSString stringWithFormat:@"下单时间：%@", _model.createTime]];
    [createTime setTextAlignment:NSTextAlignmentRight];
    [createTime setTextColor:[UIColor grayColor]];
    [_scrollView addSubview:createTime];
    
    
//    取消订单按钮
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(line8.frame)+ViewHeight *1.5, SCREEN_WIDTH - 20, ViewHeight)];
    [cancel setTitle:@"取消订单" forState:UIControlStateNormal];
    [cancel setBackgroundColor:[UIColor lightGrayColor]];
    [cancel.layer setCornerRadius:5];
//    [_scrollView addSubview:cancel];
    
//    去支付
    UIButton *goToPay = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + 5, CGRectGetMaxY(line8.frame)+ViewHeight *1.5, (SCREEN_WIDTH -10) / 2 - 10, ViewHeight)];
    [goToPay setTitle:@"去支付" forState:UIControlStateNormal];
    [goToPay setBackgroundColor:RGBACOLOR(230, 60, 82, 1)];
    [goToPay.layer setCornerRadius:5];
//    [_scrollView addSubview:goToPay];
    
//    删除订单
    UIButton *deleteOrder = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(line8.frame)+ViewHeight *1.5, SCREEN_WIDTH - 20, ViewHeight)];
    [deleteOrder setTitle:@"删除订单" forState:UIControlStateNormal];
    [deleteOrder setBackgroundColor:RGBACOLOR(230, 60, 82, 1)];
    [deleteOrder.layer setCornerRadius:5];
//    [_scrollView addSubview:deleteOrder];
    
    UILabel *phone = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(cancel.frame)+20, SCREEN_WIDTH - 40, ViewHeight/2)];
    [phone setText:[NSString stringWithFormat:@"注：如有退款需求请联系%@。", _model.phone]];
    [phone setTextAlignment:NSTextAlignmentCenter];
    [phone setFont:[UIFont systemFontOfSize:15]];
    [phone setTextColor:[UIColor lightGrayColor]];
    [_scrollView addSubview:phone];
    
    switch ([_model.orderFinishState intValue]) {
        case 0:
            if ([_model.payMode isEqualToString:@"1"] && ([_model.payState isEqualToString:@"0"] || [_model.payState isEqualToString:@"3"])) {
                [cancel setFrame:CGRectMake(10, CGRectGetMaxY(line8.frame)+ViewHeight *1.5, (SCREEN_WIDTH -20) / 2 -5 , ViewHeight)];
                [cancel setBackgroundColor:RGBACOLOR(230, 60, 82, 1)];
                
                [_scrollView addSubview:cancel];
                [_scrollView addSubview:goToPay];
                
                [cancel addTarget:self action:@selector(cilckCancelButton) forControlEvents:UIControlEventTouchUpInside];
                
                [goToPay addTarget:self action:@selector(clickGoToPayButton) forControlEvents:UIControlEventTouchUpInside];
            } else {
                [cancel setBackgroundColor:RGBACOLOR(230, 60, 82, 1)];
                [_scrollView addSubview:cancel];
                [cancel addTarget:self action:@selector(cilckCancelButton) forControlEvents:UIControlEventTouchUpInside];
            }
            
            break;
        case 1 ... 2:
            [_scrollView addSubview:cancel];
            [cancel addTarget:self action:@selector(cilckCancelButton) forControlEvents:UIControlEventTouchUpInside];
            break;
        
        case 3 ... 7:
            [_scrollView addSubview:deleteOrder];
            [deleteOrder addTarget:self action:@selector(clickDeleteOrder) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
    [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(phone.frame) + 20)];
}

#pragma mark -- 取消订单按钮点击事件
- (void)cilckCancelButton{
   
    if ([_model.orderFinishState intValue] == 0) {
        [self chrysanthemumOpen];
        [self close];
        
        NSDictionary *par = [Parameter updateTakeOutWithTakeOutid:_model.orderId];
        
        AFHTTPRequestOperationManager *request = [AFHTTPRequestOperationManager manager];
        request.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [request POST:NiceFood_Url parameters:par success:^(AFHTTPRequestOperation * operation, NSDictionary *responseObject) {
            
            if ([responseObject[@"rescode"] isEqualToString:@"0000"]) {
                
                [self chrysanthemumClosed];
                [self open];
                if ([_model.payMode isEqualToString:@"1"]) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"订单取消成功，退款需求请联系商家" delegate:self cancelButtonTitle:@"稍后联系" otherButtonTitles:@"现在联系", nil];
                    [alertView setTag:601];
                    [alertView show];
                } else if ([_model.payMode isEqualToString:@"2"]) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"订单取消成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alertView setTag:602];
                    [alertView show];
                }
                
                
            } else {
                [self chrysanthemumClosed];
                [self open];
                [self showMsg:responseObject[@"resdesc"]];
            }
            
            
        } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
            NSLog(@"%@", error);
            [self chrysanthemumClosed];
            [self open];
            [self showMsg:@"请求失败"];
        }];
        [self changeOrder];
    } else if ([_model.orderFinishState intValue] == 1) {
        [self showMsg:@"商家已接单，不能取消"];
    } else if ([_model.orderFinishState intValue] == 2) {
        [self showMsg:@"订单正在配送，不能取消"];
    }
    
    
    
}

#pragma mark -- 去支付按钮点击事件
- (void)clickGoToPayButton{

    
    CashierDeskViewController *vc = [[CashierDeskViewController alloc] init];
    vc.orderCode = _model.orderCode;
    vc.actualPrice = _model.actualPrice;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    [self changeOrder];
}

#pragma mark -- 删除订单按钮点击事件
- (void)clickDeleteOrder{
    
    [self chrysanthemumOpen];
    [self close];
    
    NSDictionary *par = [Parameter deleteTakeOutWithTakeOutid:_model.orderId];
    
    AFHTTPRequestOperationManager *request = [AFHTTPRequestOperationManager manager];
    request.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [request POST:NiceFood_Url parameters:par success:^(AFHTTPRequestOperation * operation, NSDictionary *responseObject) {
        
        if ([responseObject[@"rescode"] isEqualToString:@"0000"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"订单删除成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            alertView.tag = 603;
            [alertView show];
        }
        
        [self chrysanthemumClosed];
        [self open];
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
        NSLog(@"%@", error);
        
        [self chrysanthemumClosed];
        [self open];
        [self showMsg:@"请求失败"];
    
    }];
    [self changeOrder];
}

- (void)changeOrder{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeOrder" object:nil];
}

//label自适应
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传入的字体字典
                                       context:nil];
    return rect.size;
}


//加载数据
- (void)requestData{
    
    NSDictionary *par = [Parameter getOrderDetailWithOrderId:_orderId];
    
    AFHTTPRequestOperationManager *request = [AFHTTPRequestOperationManager manager];
    request.responseSerializer = [AFJSONResponseSerializer serializer];
    [request POST:NiceFood_Url parameters:par success:^(AFHTTPRequestOperation * operation, NSDictionary *responseObject) {
        
        
        _model = [OrderDetailModel objectWithKeyValues:responseObject];
        
        [self addUI];
        [self chrysanthemumClosed];
        [self open];
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
        NSLog(@"%@", error);
        [self chrysanthemumClosed];
        [self open];
        [self showMsg:@"加载失败"];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (alertView.tag == 601 || alertView.tag == 602) {
        if (buttonIndex == 1) {
            NSString *phone = [[NSString alloc] init];
            if (_model.phone) {
                phone = [NSString stringWithFormat:@"tel://%@", _model.phone];
            } else {
                phone = [NSString stringWithFormat:@"tel://%@", _model.tel];
            }
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
        }
        [self.navigationController popViewControllerAnimated:NO];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:_orderId forKey:@"orderId"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LookOrder" object:nil userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"order" object:nil userInfo:dic];
    } else if (alertView.tag == 603) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(_model.orderCode.length == 0){
        [self chrysanthemumOpen];
        [self close];
    }
    
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
