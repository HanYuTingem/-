//
//  PreferNiceViewCell.m
//  MyNiceFood
//
//  Created by liujinhe on 15/7/24.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "PreferNiceViewCell.h"
#import "FoodInfoBaseView.h"
#import "ProtiketModel.h"
#import "CouponModel.h"
#import "CouponListView.h"
@interface PreferNiceViewCell ()
{
    CGRect baseViewFrame;
}
@end
@implementation PreferNiceViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)reshCellMode:(ProtiketModel*) model andName:(NSString *)name{
    CGRect baseViewFram = CGRectMake(10,5, SCREEN_WIDTH-20, 60);
    CouponListView * baseView = [[CouponListView alloc]initWithCouponListViewFrame:baseViewFram];
    
 //   baseView.iconView.image = [UIImage imageNamed:@"meishi_list_icon_hui.png"];
    baseView.shopName.text = name;
    baseView.coupontimeLabel.text = [NSString stringWithFormat:@"%@至%@",model.validBeginTime,model.validEndTime];
    baseView.descLabel.text = model.couponName;
    [self.contentView addSubview:baseView];

}
- (void)reshCelltoMode:(CouponModel*) model andWithIndex:(NSInteger)inDex{
    if (inDex ==0) {
        baseViewFrame = CGRectMake(10, 30, SCREEN_WIDTH-20, 60);
    }else{
        baseViewFrame = CGRectMake(10, 15, SCREEN_WIDTH-20, 60);}
    CouponListView * baseView = [[CouponListView alloc] initWithCouponListViewFrame:baseViewFrame];
    
    //   baseView.iconView.image = [UIImage imageNamed:@"meishi_list_icon_hui.png"];
    baseView.shopName.text = model.merchantName;
    baseView.coupontimeLabel.text = [NSString stringWithFormat:@"%@至%@",model.validBeginTime,model.validEndTime];
    baseView.descLabel.text = model.couponName;
    [self.contentView addSubview:baseView];
    
}
@end
