//
//  MyTakeOutView.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/8/5.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "MyTakeOutView.h"

@implementation MyTakeOutView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor: RGBACOLOR(150, 150, 150, 0.5)];
        
        
        UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(10, frame.size.height, SCREEN_WIDTH - 20 , 180)];
        [bottom setBackgroundColor:RGBACOLOR(250, 250, 250, 1)];
        [bottom.layer setCornerRadius:3];
        [self addSubview:bottom];
        
        UIButton *clear = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, bottom.frame.size.width- 20, ViewHeight)];
        [clear setTitle:@"清除过期和取消的订单" forState:UIControlStateNormal];
        [clear setBackgroundColor:RGBACOLOR(230, 60, 82, 1)];
        [clear.layer setCornerRadius:3];
        [bottom addSubview:clear];
        [clear addTarget:self action:@selector(clickClearButton) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(clear.frame)+20, clear.frame.size.width, ViewHeight)];
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        [cancel setBackgroundColor:RGBACOLOR(220, 220, 220, 1)];
        [cancel.layer setCornerRadius:3];
        [bottom addSubview:cancel];
        [cancel addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height - bottom.frame.size.height - 10)];
        [back setBackgroundColor:[UIColor clearColor]];
        [self addSubview:back];
        [back addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
        
        [UIView animateWithDuration:0.3 animations:^{
            bottom.frame = CGRectMake(10, frame.size.height - bottom.frame.size.height - 10, bottom.frame.size.width, bottom.frame.size.height);
        }];
    }
    return self;
}

- (void)clickClearButton{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelOrder" object:nil];
    [self removeFromSuperview];
}

- (void)clickCancelButton{
    [self removeFromSuperview];
}

- (void)setFrame:(CGRect)frame{
    frame.size = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [super setFrame:frame];
}



@end
