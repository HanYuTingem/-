//
//  CashierDeskViewController.h
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/31.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "TakeoutRootViewController.h"

@interface CashierDeskViewController : TakeoutRootViewController

@property (nonatomic, copy) NSString *actualPrice; //支付金额
@property (nonatomic, copy) NSString *orderCode;//订单编号
@property (nonatomic, copy) NSString *orderId;  //订单id

@end
