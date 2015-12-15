//
//  ZXYIndicatorView.m
//  MarketManage
//
//  Created by Rice on 15/1/19.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYIndicatorView.h"

@implementation ZXYIndicatorView

+(ZXYIndicatorView *)shareInstance
{
    static ZXYIndicatorView *indicatorView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        indicatorView = [[ZXYIndicatorView alloc] init];
        [indicatorView addIndicatorView];
        [indicatorView setFrame:CGRectMake(0, 64, 320*SP_WIDTH, [UIScreen mainScreen].bounds.size.height)];
    });
    return indicatorView;
}

-(void)addIndicatorView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 40, [UIScreen mainScreen].bounds.size.height/3, SCREENWIDTH/4, SCREENWIDTH/4)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.layer.cornerRadius = 8;
    bgView.alpha = .5;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, bgView.frame.size.height - 25, bgView.frame.size.width, 20)];
    label.text = @"加载中...";
    label.font = [UIFont systemFontOfSize:14.];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:label];
    
    [self addSubview:bgView];
    UIActivityIndicatorView *acitvityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(SCREENWIDTH/3, [UIScreen mainScreen].bounds.size.height/3, SCREENWIDTH/3, SCREENWIDTH/3)];
    [acitvityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [acitvityView setColor:[UIColor whiteColor]];
    self.backgroundColor = [UIColor clearColor];
    self.alpha = 0;
    [self addSubview:acitvityView];
    
    
    [bgView setCenter:CGPointMake(acitvityView.center.x, acitvityView.center.y + 5)];

    [acitvityView startAnimating];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

-(void)showIndicator
{
    self.alpha = 1;
}

-(void)hideIndicator
{
    self.alpha = 0;
}

@end
