//
//  CouponTableViewCell.m
//  PRJ_NiceFoodModule
//
//  Created by 张恭豪 on 15/8/3.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "CouponTableViewCell.h"

@implementation CouponTableViewCell


- (CouponTableViewCell *)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
    }
    return self;
}

+ (CouponTableViewCell *)cellWithTableView:(UITableView *)tabelView{
    
    static NSString * ident = @"coupon";
    
    CouponTableViewCell *cell = [tabelView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponTableViewCell" owner:self options:nil] lastObject];
        
//        cell = [[CouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        
    }
    return cell;
}


/*
 @property (nonatomic, copy) NSString *ownerName;//商家名称
 @property (nonatomic, copy) NSString *couponId;//优惠券规则id
 @property (nonatomic, copy) NSString *couponCodeId;//优惠券具体id
 @property (nonatomic, copy) NSString *couponName;//优惠券名称
 @property (nonatomic, copy) NSString *validBeginTime;//开始时间
 @property (nonatomic, copy) NSString *validEndTime;//结束时间
 @property (nonatomic, copy) NSString *state;//优惠券状态
 */
- (void)setModel:(ZGHCouponModel *)model{
    _model = model;
    
    if ([_model.state isEqualToString:@"1"]) {
        [_rightImage setImage:[UIImage imageNamed:@"mycoupon_listcoupon_bg_right_u"] forState:UIControlStateNormal];
    }
    
    [_shopName setText:_model.ownerName];
    [_timeLabel setText:[NSString stringWithFormat:@"%@ —— %@", _model.validBeginTime, _model.validEndTime]];
    [_couponName setText:_model.couponName];
    
    [_rightImage setUserInteractionEnabled:NO];
    [_leftImage setUserInteractionEnabled:NO];
    
}

- (void)awakeFromNib {
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
