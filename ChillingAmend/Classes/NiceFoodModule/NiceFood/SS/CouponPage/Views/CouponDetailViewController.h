//
//  CouponDetailViewController.h
//  QQList
//
//  Created by sunsu on 15/6/29.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "BaseViewController.h"

@interface CouponDetailViewController : BaseViewController
{
    NSString *_phoneNumber;
    
}
@property (nonatomic,copy) NSString *couponName;
@property (nonatomic,copy) NSString *couponId;
@property (nonatomic,copy) NSString *proIden;
@property (nonatomic,copy) NSString *shopName;//商家名
@property (nonatomic,copy) NSString *oId;
@property (nonatomic,copy) NSString *lat;//纬度
@property (nonatomic,copy) NSString *lng;//经度
@property (nonatomic, strong) BMKLocationService *locService;   //定位
@property (nonatomic, copy) NSString *ownerId;//商家Id
//@property (nonatomic, copy) NSString * transPhone;//接口内需要传递的phone
@end
