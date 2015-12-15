//
//  LSYStrikeLineLabel.m
//  PRJ_Mall_Demo
//
//  Created by liangsiyuan on 15/1/10.
//  Copyright (c) 2015年 Liangsiyuan. All rights reserved.
//

#import "LSYStrikeLineLabel.h"

@implementation LSYStrikeLineLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.strikeThroughEnabled = YES;
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 
 }
 */

- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:rect];
    
    CGSize textSize = [[self text] sizeWithFont:[self font]];
    
    CGFloat strikeWidth = textSize.width;
    
    CGRect lineRect;
    
    if ([self textAlignment] == NSTextAlignmentRight)
    {
        // 画线居中
        lineRect = CGRectMake(rect.size.width - strikeWidth, rect.size.height/2, strikeWidth, 1);
        
        // 画线居下
        //lineRect = CGRectMake(rect.size.width - strikeWidth, rect.size.height/2 + textSize.height/2, strikeWidth, 1);
    }
    else if ([self textAlignment] == NSTextAlignmentCenter)
    {
        // 画线居中
        lineRect = CGRectMake(rect.size.width/2 - strikeWidth/2, rect.size.height/2, strikeWidth, 1);
        
        // 画线居下
        //lineRect = CGRectMake(rect.size.width/2 - strikeWidth/2, rect.size.height/2 + textSize.height/2, strikeWidth, 1);
    }
    else
    {
        // 画线居中
        lineRect = CGRectMake(0, rect.size.height/2, strikeWidth, 1);
        
        // 画线居下
        //lineRect = CGRectMake(0, rect.size.height/2 + textSize.height/2, strikeWidth, 1);
    }
    


        CGContextRef context = UIGraphicsGetCurrentContext();
    
        CGContextSetAlpha(context, 0.4);
    
        CGContextSetFillColorWithColor(context, [self strikeThroughColor].CGColor);
        
        CGContextFillRect(context, lineRect);

}

@end

