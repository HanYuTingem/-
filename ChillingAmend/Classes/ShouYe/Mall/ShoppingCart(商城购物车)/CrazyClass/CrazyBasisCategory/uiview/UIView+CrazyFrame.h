//
//  UIView+CrazyFrame.h
//  MarketManage
//
//  Created by fielx on 15/4/28.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CrazyFrame)
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

// shortcuts for positions
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;


@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@end
