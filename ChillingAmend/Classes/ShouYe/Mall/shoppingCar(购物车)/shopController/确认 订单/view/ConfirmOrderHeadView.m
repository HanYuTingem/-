//
//  ConfirmOrderHeadView.m
//  MarketManage
//
//  Created by 许文波 on 15/7/28.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ConfirmOrderHeadView.h"

@implementation ConfirmOrderHeadView
-(instancetype)initWithFrame:(CGRect)frame shopImageView:(NSString *)shopImageView shopName:(NSString *)shopName{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        UIImageView *shopImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, 15, 15)];
        shopImage.image = [UIImage imageNamed:shopImageView];
        [self addSubview:shopImage];
        
        
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 200*SP_WIDTH, 20)];
        name.text = shopName;
        name.font = [UIFont systemFontOfSize:12];
        [self addSubview:name];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
