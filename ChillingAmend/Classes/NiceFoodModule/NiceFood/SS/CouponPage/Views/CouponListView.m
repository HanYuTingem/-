//
//  CouponListView.m
//  QQList
//
//  Created by sunsu on 15/6/26.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "CouponListView.h"

@implementation CouponListView

+ (instancetype)couponListViewWithFrame:(CGRect)frame{
    return [[[self class]alloc ]initWithCouponListViewFrame:frame];
}

- (instancetype)initWithCouponListViewFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    UIView * bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:bgView];
    
    UIImageView *leftImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mycoupon_listcoupon_bg_white"]];
    leftImageV.frame = CGRectMake(0, 0, self.frame.size.width-85, self.frame.size.height);
    [bgView addSubview:leftImageV];
    
    self.rightImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mycoupon_listcoupon_bg_right_s"]];
    self.rightImageV.frame = CGRectMake(self.frame.size.width-85, 0, 80, self.frame.size.height);
    [bgView addSubview:self.rightImageV];
    
    
    CGRect shopNameFrame = CGRectMake(0, 2, 175, 20);
    self.shopName = [[UILabel alloc]initWithFrame:shopNameFrame];
    self.shopName.textAlignment = NSTextAlignmentCenter;
    self.shopName.font = [UIFont systemFontOfSize:16.0f];
    self.shopName.textColor = RGBCOLOR(230, 61, 82);
    [bgView addSubview:self.shopName];
    
    
    CGRect coupontimeLabelFrame = CGRectMake(0, CGRectGetMaxY(shopNameFrame)+5, 175, 20);
    self.coupontimeLabel = [[UILabel  alloc]initWithFrame:coupontimeLabelFrame];
    self.coupontimeLabel.textAlignment = NSTextAlignmentCenter;
    self.coupontimeLabel.textColor = RGBCOLOR(138, 138, 138);
    self.coupontimeLabel.font = [UIFont systemFontOfSize:10.0f];
    [bgView addSubview:self.coupontimeLabel];
    

    
    CGRect discLabelFrame = CGRectMake(self.frame.size.width-85,0,80, 60);
    self.descLabel = [[UILabel alloc]initWithFrame:discLabelFrame];
    self.descLabel.numberOfLines = 0;
    self.descLabel.textColor = [UIColor whiteColor];
    self.descLabel.font = [UIFont systemFontOfSize:12.0f];
    self.descLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:self.descLabel];
    
}

-(void)layoutSubviews{
    

}

//计算高度
-(CGFloat)getHeight:(NSString*)text{
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH-20, 0);
    if (![text isEqual:[NSNull null]]) {
        frame=[text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
        frame.size.height += 0.001;
    }
    return frame.size.height;
}

@end
