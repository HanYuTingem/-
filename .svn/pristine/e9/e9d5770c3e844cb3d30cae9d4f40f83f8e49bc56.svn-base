//
//  CrazyBgBlackView.m
//  MarketManage
//
//  Created by fielx on 15/4/27.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBgBlackView.h"

@implementation CrazyBgBlackView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        frame.size = CGSizeMake(SCREENWIDTH, SCREENHEIGHT  - frame.origin.y);
        
        self.mPointType = CrazyBgBlackViewPointScreenCentre;
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];

        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        self.mPointType = CrazyBgBlackViewPointScreenCentre;
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }
    return self;
}

-(void)setMShowView:(CrazyBasisView *)mShowView
{
    _mShowView = mShowView;
    [self addSubview:mShowView];
    if (self.mPointType == CrazyBgBlackViewPointScreenCentre) {
        [CrazyBasisFrameTool CrazyBasisFrameToolSubCentersuperView:[UIApplication sharedApplication].keyWindow  suberView:_mShowView];
    }
}



-(void)setMPointType:(CrazyBgBlackViewPointType)mPointType
{
    _mPointType = mPointType;
    if (mPointType == CrazyBgBlackViewPointScreenCentre) {
        [CrazyBasisFrameTool CrazyBasisFrameToolSubCenter:CrazyBasisFrameToolRelativePositionHorizontalCenter superView:[UIApplication sharedApplication].keyWindow suberView:self.mShowView];
        [CrazyBasisFrameTool CrazyBasisFrameToolSubCenter:CrazyBasisFrameToolRelativePositionVerticalCenter superView:[UIApplication sharedApplication].keyWindow suberView:self.mShowView];
    }
}

@end
