//
//  UIView+CrazyLayer.m
//  MarketManage
//
//  Created by fielx on 15/4/29.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "UIView+CrazyLayer.h"
#define C8 [UIColor colorWithRed:37/255.0 green:37/255.0 blue:37/255.0 alpha:1]

@implementation UIView (CrazyLayer)

-(void)cornerRadius:(float)cornerRadius lineColor:(UIColor *)borderColor borderWidth:(float)borderWidth
{
    self.layer.masksToBounds = YES;
    
    if (!cornerRadius) {
        self.layer.cornerRadius = 0;
    }
    else {
        self.layer.cornerRadius = cornerRadius;
    }
    
    
    if (!borderColor) {
        self.layer.borderColor = C8.CGColor;
    }
    else {
        self.layer.borderColor = borderColor.CGColor;
    }
    
    if (!borderWidth) {
        self.layer.borderWidth = 1;
    }
    else {
        self.layer.borderWidth = borderWidth;
    }
    
}

@end
