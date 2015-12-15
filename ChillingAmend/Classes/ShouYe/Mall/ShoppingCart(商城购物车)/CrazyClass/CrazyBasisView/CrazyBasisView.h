//
//  CrazyBasisView.h
//  MarketManage
//
//  Created by fielx on 15/4/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CrazyBasisFile.h"
#import "CrazyBasisLabel.h"
#import "CrazyBasisButton.h"
#import "CrazyBasisImageView.h"
#import "CrazyBasisFrameTool.h"


/**
 *  基础View
 */
@interface CrazyBasisView : UIView

/**
 *  设置圆角 边框
 */
-(void)cornerRadius:(float)cornerRadius lineColor:(UIColor *)borderColor borderWidth:(float)borderWidth;

/**
 *  取控制器
 */
- (UIViewController*)viewController;

@end
