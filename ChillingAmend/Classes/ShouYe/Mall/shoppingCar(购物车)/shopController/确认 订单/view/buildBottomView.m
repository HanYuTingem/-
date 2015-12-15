//
//  buildBottomView.m
//  MarketManage
//
//  Created by 许文波 on 15/7/28.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "buildBottomView.h"

@implementation buildBottomView
-(instancetype)initWithFrame:(CGRect)frame totalLabel:(NSString *)money OrderButton:(SEL)orderButton target:(id)targrt{
    self = [super initWithFrame:frame];
    if (self) {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 49)];
//        [self addSubview:view];
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *total = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-40, 10, 50, 20)];
        [self addSubview:total];
        total.font = [UIFont systemFontOfSize:14];
        total.text = @"合计：";
        
        
        UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-10 , 10, 70, 20)];
        [self addSubview:moneyLabel];
        moneyLabel.tag = 1111;
        moneyLabel.text = money;
        moneyLabel.font = [UIFont systemFontOfSize:14];
        moneyLabel.textColor= [UIColor redColor];
        
        UIButton *order = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        order.frame = CGRectMake(SCREENWIDTH - 100, 0, 100, 49);
        order.backgroundColor = [UIColor yellowColor];
        [order setTitle:@"提交订单" forState:UIControlStateNormal];
        [order setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        order.titleLabel.font = [UIFont systemFontOfSize:14];
        order.backgroundColor = CrazyColor(166, 0, 9);
        [order addTarget:targrt action:orderButton forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:order];
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
