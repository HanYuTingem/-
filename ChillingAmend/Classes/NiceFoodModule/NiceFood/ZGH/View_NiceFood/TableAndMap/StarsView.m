//
//  StarsView.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/2.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "StarsView.h"

@implementation StarsView

+ (StarsView *)setStarsWithFrame:(CGRect)frame number:(long)num{
    
    StarsView * stars = [[StarsView alloc] initWithFrame:frame];
    
    UIImageView *backStar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 94, 14)];
    UIImageView *fontStar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 94, 14)];
    backStar.image        = [UIImage imageNamed:@"lb_0001_Star_h"];
    fontStar.image        = [UIImage imageNamed:@"lb_0000_Star_y"];
    
    [stars addSubview:backStar];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 94 * num / 5, 14)];
    view.backgroundColor = [UIColor clearColor];
    [backStar addSubview:view];
    [view addSubview:fontStar];
    view.clipsToBounds = YES;
    
    
    return stars;
}


- (void)setFrame:(CGRect)frame{
    
    frame.size = CGSizeMake(94, 14);
    [super setFrame:frame];
}

@end
