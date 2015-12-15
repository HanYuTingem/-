//
//  CrazyBasisFrameTool.h
//  MarketManage
//
//  Created by fielx on 15/4/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

/**
 *  居中位置
 */
typedef NS_ENUM(int, CrazyBasisFrameToolRelativePosition)
{
    /**
     *  水平居中
     */
    CrazyBasisFrameToolRelativePositionHorizontalCenter = 0,
    
    /**
     *  垂直居中
     */
    CrazyBasisFrameToolRelativePositionVerticalCenter
    
};


@interface CrazyBasisFrameTool : NSObject



/**
 *  视图对其  两个子视图
 */
+(void)CrazyBasisFrameToolCenter:(CrazyBasisFrameToolRelativePosition)Position mainView:(UIView *)mainView moveView:(UIView *)view;



/**
 *  视图对其  父子视图
 */
+(void)CrazyBasisFrameToolSubCenter:(CrazyBasisFrameToolRelativePosition)Position superView:(UIView *)superView suberView:(UIView *)view;


+(void)CrazyBasisFrameToolSubCentersuperView:(UIView *)superView suberView:(UIView *)view
;

@end
