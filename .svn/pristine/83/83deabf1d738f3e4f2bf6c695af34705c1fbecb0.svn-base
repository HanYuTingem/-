//
//  FoodInfoBaseView.m
//  QQList
//
//  Created by sunsu on 15/6/25.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "FoodInfoBaseView.h"

@implementation FoodInfoBaseView
+ (instancetype)foodInfoBaseViewWithFrame:(CGRect)frame{
    return [[[self class]alloc ]initWithFoodInfoBaseViewFrame:frame];
}

- (instancetype)initWithFoodInfoBaseViewFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    //ImageView
    CGFloat iconViewH = 20;
    CGFloat iconViewW = 20;
    CGFloat iconViewY = (self.frame.size.height - iconViewH)/2;
    CGRect iconViewFrame = CGRectMake(PADDING,iconViewY, iconViewW, iconViewH);
    self.iconView = [[UIImageView alloc]initWithFrame:iconViewFrame];
    self.iconView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.iconView];
    
//    //Label
//    CGFloat itemLabelX = CGRectGetMaxX(iconViewFrame)+padding;
//    CGRect itemLabelFrame = CGRectMake(itemLabelX, iconViewY, 200, iconViewH);
//    self.itemLabel = [[UILabel alloc]initWithFrame:itemLabelFrame];
//    self.itemLabel.font = [UIFont systemFontOfSize:12.0f];
//    [self addSubview:self.itemLabel];
//    
//    CGFloat displayLabelX = SCREEN_WIDTH - 3*padding  - 60;
//    CGRect displayLabelFrame = CGRectMake(displayLabelX, iconViewY, 60, iconViewH);
//    self.displayLabel = [[UILabel alloc]initWithFrame:displayLabelFrame];
//    [self addSubview:self.displayLabel];
//    
//    CGRect arrowViewFrame = CGRectMake(SCREEN_WIDTH-10-15, iconViewY, 9, 16);
//    self.arrowView        = [[UIImageView alloc]initWithFrame:arrowViewFrame];
//    self.arrowView.image  = [UIImage imageNamed:@"personalhome_list_arrow_right.png"];
//    [self addSubview:self.arrowView];
    
    CGRect couponListViewFrame = CGRectMake(CGRectGetMaxX(self.iconView.frame)+PADDING, (self.frame.size.height-50)/2, SCREEN_WIDTH-PADDING-2*PADDING - 20, 50);
    self.couponListView = [[CouponListView alloc]initWithCouponListViewFrame:couponListViewFrame];
    [self addSubview:self.couponListView];
    
}

-(CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *dict = @{NSFontAttributeName : font};
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}


@end
