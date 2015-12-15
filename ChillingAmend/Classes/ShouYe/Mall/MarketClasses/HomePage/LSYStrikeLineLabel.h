//
//  LSYStrikeLineLabel.h
//  PRJ_Mall_Demo
//
//  Created by liangsiyuan on 15/1/10.
//  Copyright (c) 2015年 Liangsiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSYStrikeLineLabel : UILabel

@property (assign, nonatomic) BOOL strikeThroughEnabled; // 是否画线

@property (strong, nonatomic) UIColor *strikeThroughColor; // 画线颜色

@end
