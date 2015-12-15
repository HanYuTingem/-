//
//  CrazyBasisLabel.m
//  MarketManage
//
//  Created by fielx on 15/4/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisLabel.h"

@implementation CrazyBasisLabel
@synthesize verticalCrazyAlignment = verticalCrazyAlignment_;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.verticalAlignment = VerticalCrazyAlignmentMiddle;
        self.textColor = C8;
        self.font = H6;
    }
    return self;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.verticalAlignment = VerticalCrazyAlignmentMiddle;
        self.textColor = C8;
        self.font = H6;

    }
    return self;
}

- (void)setVerticalAlignment:(VerticalCrazyAlignment)verticalAlignment {
    verticalCrazyAlignment_ = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalCrazyAlignment) {
        case VerticalCrazyAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalCrazyAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalCrazyAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}






+(CrazyBasisLabel *)labelAddInController:(UIView *)view  andTitle:(NSString *)title  andFrame:(CGRect)rect  andTextAlignment:(NSTextAlignment)textAlignment andTextColor:(UIColor *)color andRow:(int)row andFont:(int)size andBackGroundColor:(UIColor*)bgColor andCorner:(BOOL)corner
{
    CrazyBasisLabel *label = [[CrazyBasisLabel alloc]initWithFrame:rect];
    label.text = title;
    if (bgColor) {
        label.backgroundColor = bgColor;
    }
    else
    {
        label.backgroundColor = [UIColor clearColor];
    }
    label.textAlignment = textAlignment;
    if (color) {
        label.textColor = color;

    }
    label.numberOfLines = row;
    label.font = [UIFont systemFontOfSize:size];
    
    if (corner) {
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 7;
    }
    
    [view addSubview:label];
    return label;
}



+(CrazyBasisLabel *)labelAddInController:(UIView *)view  andMutableTitle:(NSMutableAttributedString *)title  andFrame:(CGRect)rect  andTextAlignment:(NSTextAlignment)textAlignment andTextColor:(UIColor *)color andRow:(int)row andFont:(int)size andBackGroundColor:(UIColor*)bgColor andCorner:(BOOL)corner
{
    
    CrazyBasisLabel *label = [[CrazyBasisLabel alloc]initWithFrame:rect];
    if (bgColor) {
        label.backgroundColor = bgColor;
    }
    else
    {
        label.backgroundColor = [UIColor clearColor];
    }
    label.textColor = color;
    label.attributedText = title;
    
    label.textAlignment = textAlignment;
    
    label.numberOfLines = row;
    label.font = [UIFont systemFontOfSize:size];
    
    if (corner) {
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 7;
    }
    
    [view addSubview:label];
    return label;
}



@end
