//
//  TakeoutRootViewController.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/14.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "TakeoutRootViewController.h"


@interface TakeoutRootViewController()
@property (nonatomic, strong) UIView *closeview;
@end

@implementation TakeoutRootViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    

    
    [backView setBackgroundColor:RGBACOLOR(249, 249, 249, 1)];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, NavigationH-1, SCREEN_WIDTH, 1)];
    [line setBackgroundColor:RGBACOLOR(200, 200, 200, 1)];
    [backView addSubview:line];
    
    [returnButton setImage:[UIImage imageNamed:@"msxq_0013_title_back"] forState:UIControlStateHighlighted];
    [returnButton setImage:[UIImage imageNamed:@"msxq_0013_title_back"] forState:UIControlStateNormal];
    
}

- (void)close{
    _closeview = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_closeview setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_closeview];
    [self.view bringSubviewToFront:_closeview];
}

- (void)open{
    [_closeview removeFromSuperview];
}



@end
