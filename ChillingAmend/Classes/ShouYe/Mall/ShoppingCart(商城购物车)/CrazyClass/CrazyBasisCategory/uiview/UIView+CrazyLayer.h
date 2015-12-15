//
//  UIView+CrazyLayer.h
//  MarketManage
//
//  Created by fielx on 15/4/29.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  视图Layer类目
 */
@interface UIView (CrazyLayer)
/**
 *  添加边框
 */
-(void)cornerRadius:(float)cornerRadius lineColor:(UIColor *)borderColor borderWidth:(float)borderWidth;
@end
