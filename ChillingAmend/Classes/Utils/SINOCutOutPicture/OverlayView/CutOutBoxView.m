//
//  CutOutBoxView.m
//  SINOCutOutPictureDemo
//
//  Created by xn on 14-6-26.
//  Copyright (c) 2014年 like. All rights reserved.
//

#import "CutOutBoxView.h"

@implementation CutOutBoxView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置矩形填充颜色：黑色
//    CGContextSetRGBFillColor(context, 0, 0, 0, 0);
    //填充矩形
//    CGContextFillRect(context, rect);
    //设置画笔颜色：红色
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    //设置画笔线条粗细
    CGContextSetLineWidth(context, 2.0);
    //画矩形边框
    CGContextAddRect(context,rect);
    //执行绘画
    CGContextStrokePath(context);
}

@end
