//
//  CouponTableViewCell.h
//  PRJ_NiceFoodModule
//
//  Created by 张恭豪 on 15/8/3.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGHCouponModel.h"

@interface CouponTableViewCell : UITableViewCell


@property (nonatomic, strong) ZGHCouponModel *model;

@property (weak, nonatomic) IBOutlet UIButton *leftImage;

@property (weak, nonatomic) IBOutlet UIButton *rightImage;//右边图片
@property (weak, nonatomic) IBOutlet UILabel *couponName;//优惠券名
@property (weak, nonatomic) IBOutlet UILabel *shopName;//商户名称
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//有效时间


+ (CouponTableViewCell *)cellWithTableView:(UITableView *)tabelView;


@end
