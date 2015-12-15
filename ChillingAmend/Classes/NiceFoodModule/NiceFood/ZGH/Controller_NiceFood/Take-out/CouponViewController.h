//
//  CouponViewController.h
//  PRJ_NiceFoodModule
//
//  Created by 张恭豪 on 15/8/2.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "TakeoutRootViewController.h"

@interface CouponViewController : TakeoutRootViewController

@property (nonatomic, copy) NSString *ownerId;//商户id
@property (nonatomic, copy) NSString *totalprice;//订单金额

@end
