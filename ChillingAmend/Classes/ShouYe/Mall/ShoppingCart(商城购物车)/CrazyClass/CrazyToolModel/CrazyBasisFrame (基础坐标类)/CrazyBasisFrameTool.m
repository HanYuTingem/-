//
//  CrazyBasisFrameTool.m
//  MarketManage
//
//  Created by fielx on 15/4/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisFrameTool.h"

@implementation CrazyBasisFrameTool


+(void)CrazyBasisFrameToolCenter:(CrazyBasisFrameToolRelativePosition)Position mainView:(UIView *)mainView moveView:(UIView *)view
{
    CGPoint mainPoint = mainView.center;
    CGPoint movePoint = view.center;
    
    if (Position == CrazyBasisFrameToolRelativePositionHorizontalCenter) {
        movePoint.x = mainPoint.x;
    }
    else if (Position == CrazyBasisFrameToolRelativePositionVerticalCenter){
        movePoint.y = mainPoint.y;
    }
    
    view.center = movePoint;
    

}


+(void)CrazyBasisFrameToolSubCenter:(CrazyBasisFrameToolRelativePosition)Position superView:(UIView *)superView suberView:(UIView *)view
{
    CGPoint mainPoint = CGPointMake(CGRectGetWidth(superView.frame)/2, CGRectGetHeight(superView.frame)/2);
    CGPoint movePoint = view.center;
    
    if (Position == CrazyBasisFrameToolRelativePositionHorizontalCenter) {
        movePoint.x = mainPoint.x;
    }
    else if (Position == CrazyBasisFrameToolRelativePositionVerticalCenter){
        movePoint.y = mainPoint.y;
    }
    
    view.center = movePoint;

}



+(void)CrazyBasisFrameToolSubCentersuperView:(UIView *)superView suberView:(UIView *)view
{
    CGPoint mainPoint = CGPointMake(CGRectGetWidth(superView.frame)/2, CGRectGetHeight(superView.frame)/2);
    CGPoint movePoint = view.center;
    
  //  if (Position == CrazyBasisFrameToolRelativePositionHorizontalCenter) {
        movePoint.x = mainPoint.x;
   // }
  //  else if (Position == CrazyBasisFrameToolRelativePositionVerticalCenter){
        movePoint.y = mainPoint.y;
  //  }
    
    view.center = movePoint;
}

@end
