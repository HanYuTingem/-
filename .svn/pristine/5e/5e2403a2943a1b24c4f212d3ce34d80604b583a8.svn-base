//
//  DHHeadAllBuy.m
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHHeadAllBuy.h"

@implementation DHHeadAllBuy
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = CrazyColor(240, 242, 245);
        self.leftLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*SP_WIDTH, 20, 100*SP_WIDTH, 0.5)];
        self.leftLineImageView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.leftLineImageView];
        
        
        self.centerArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftLineImageView.frame)+6, 12, 15, 15)];
        self.centerArrowImageView.image = [UIImage imageNamed:@"home_icon_arrow_default@2x"];
        [self addSubview:self.centerArrowImageView];
        
        self.titleName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.centerArrowImageView.frame)+2,10,80*SP_WIDTH,18)];
        self.titleName.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.titleName];
        
        
        self.rightLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleName.frame), 20, 100*SP_WIDTH, 0.5)];
        [self addSubview:self.rightLineImageView];
        self.rightLineImageView.backgroundColor = [UIColor lightGrayColor];
        
        
        self.titleName.textColor = [UIColor lightGrayColor];
    }
    return self;
}
- (void)refreshAllBuy:(NSString *)name {
    
    self.titleName.text = name;
}
@end
