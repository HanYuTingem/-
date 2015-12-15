//
//  BackButton.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/6/18.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "BackButton.h"

@implementation BackButton

- (instancetype)initBackButtonWithImage:(NSString *)image{
    
    return [BackButton setBackButtonWithImage:image];
    
}

+ (instancetype)setBackButtonWithImage:(NSString *)image{
    
    BackButton *returnBtn     = [BackButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame           = CGRectMake(15, (NavigationH - 20 -30)/2+20, 0, 0);
    
    [returnBtn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    return returnBtn;
}

- (void)setFrame:(CGRect)frame{
    frame.size = CGSizeMake(30, 30);
    [super setFrame:frame];
}




@end
