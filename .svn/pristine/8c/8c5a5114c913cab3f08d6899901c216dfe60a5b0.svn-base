//
//  CashierDeskViewController.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/31.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "CashierDeskViewController.h"
#import "OrderPutinViewController.h"
#import "ListTableViewController.h"
#import "MyTakeoutOrderViewController.h"


@interface CashierDeskViewController ()
@property (weak, nonatomic) IBOutlet UIButton *aliPay;

@property (weak, nonatomic) IBOutlet UIButton *savingsCard;

@property (weak, nonatomic) IBOutlet UIButton *creditCard;

@property (weak, nonatomic) IBOutlet UILabel *actualPriceLabel;

@property (nonatomic, assign) NSInteger ViewControllerindex;

@end

@implementation CashierDeskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _ViewControllerindex = 0;

    titleButton.hidden = NO;
    [titleButton setTitle:@"收银台" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_actualPriceLabel setText:[NSString stringWithFormat:@"¥ %.2f元", [_actualPrice floatValue]]];
    [_actualPriceLabel setTextColor:RGBACOLOR(230, 82, 60, 1)];
    
    [_aliPay.layer setCornerRadius:5];
    [_aliPay.layer setBorderWidth:1];
    [_aliPay.layer setBorderColor:[RGBACOLOR(200, 200, 200, 0.7) CGColor]];
    [_aliPay addTarget:self action:@selector(clickAliPay) forControlEvents:UIControlEventTouchUpInside];
    
    [_savingsCard.layer setCornerRadius:5];
    [_savingsCard.layer setBorderWidth:1];
    [_savingsCard.layer setBorderColor:[RGBACOLOR(200, 200, 200, 0.7) CGColor]];
    [_savingsCard addTarget:self action:@selector(clickSavingsCard) forControlEvents:UIControlEventTouchUpInside];
    
    [_creditCard.layer setCornerRadius:5];
    [_creditCard.layer setBorderWidth:1];
    [_creditCard.layer setBorderColor:[RGBACOLOR(200, 200, 200, 0.7) CGColor]];
    [_creditCard addTarget:self action:@selector(clickCreditCard) forControlEvents:UIControlEventTouchUpInside];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MyTakeoutOrderViewController class]]) {
            _ViewControllerindex = 1;
        }
    }

}

#pragma mark -- 支付宝支付点击事件
- (void)clickAliPay{
    
    [self chrysanthemumOpen];
    [self close];
    
    NSDictionary *par = [Parameter payInfoSignWithPayType:@"0" orderCode:_orderCode];
    
    [AFRequest GetRequestWithUrl:NiceFood_Url parameters:par andBlock:^(NSDictionary *Datas, NSError *error) {
        [self chrysanthemumClosed];
        [self open];
        if (error == nil && [Datas[@"rescode"]isEqualToString:@"0000"]) {
            [[AlipaySDK defaultService] payOrder:Datas[@"signed"] fromScheme:AliPayScheme callback:^(NSDictionary *resultDic) {
                
                switch ([resultDic[@"resultStatus"] intValue]) {
                    case 9000:{
                        [self showMsg:@"订单支付成功"];
                        [self updatePayTypeWithPayType:@"0"];
                        
                        
                        
                        OrderPutinViewController *vc = [[OrderPutinViewController alloc] init];
                        vc.orderId = _orderId;
                        vc.orderCode = _orderCode;
                        [self.navigationController pushViewController:vc animated:YES];
                        
                        break;
                    }
                    case 8000:{
                        [self showMsg:@"等待确认支付结果"];
                        break;
                    }
                    case 4000:{
                        [self showMsg:@"订单支付失败"];
                        break;
                    }
                    case 6001 ... 6002:{
                        [self showMsg:@"取消支付"];
                        break;
                    }

                    default:
                        [self showMsg:@"支付失败，请重试"];
                        break;
                }
                
            }];
        }
    }];
}

#pragma mark -- 储蓄卡支付
- (void)clickSavingsCard{

}

#pragma mark -- 信用卡支付
- (void)clickCreditCard{

}

- (void)backButtonClick{
    if (_ViewControllerindex == 0) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[ListTableViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteItem" object:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}



- (void)updatePayTypeWithPayType:(NSString *)payType{
    
    NSDictionary *par = [Parameter updatePayTypeWithTradeCode:_orderCode price:_actualPrice payType:payType];
    
    [AFRequest GetRequestWithUrl:NiceFood_Url parameters:par andBlock:^(id Datas, NSError *error) {
        
    }];
    
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
