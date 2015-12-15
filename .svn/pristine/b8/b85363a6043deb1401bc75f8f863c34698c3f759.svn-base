//
//  CrazyBasisView.m
//  MarketManage
//
//  Created by fielx on 15/4/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisView.h"




@implementation CrazyBasisView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


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

//取到控制区
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
