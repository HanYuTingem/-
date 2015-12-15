//
//  CrazyBasisButton.m
//  MarketManage
//
//  Created by fielx on 15/4/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisButton.h"
#import <objc/runtime.h>
@implementation CrazyBasisButton

-(void)cornerRadius:(float)cornerRadius lineColor:(UIColor *)borderColor borderWidth:(float)borderWidth
{
    self.layer.masksToBounds = YES;
    
    if (!cornerRadius) {
        self.layer.cornerRadius = 0;
    }
    else {
        self.layer.cornerRadius = cornerRadius;
    }
    
    
    if (!borderColor) {
        self.layer.borderColor = C8.CGColor;
    }
    else {
        self.layer.borderColor = borderColor.CGColor;
    }
    
    if (!borderWidth) {
        self.layer.borderWidth = 1;
    }
    else {
        self.layer.borderWidth = borderWidth;
    }
    
}

-(void)crazyButtonSetNormalImage:(NSString *)normalImage selectImage:(NSString *)selectImage
{
    [self setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
}

-(void)crazyButtonSetNormalImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage  normalString:(NSString *)normalString highlightedString:(NSString *)highlightedString normalTextColor:(UIColor *)normalTextColor  highlightedTextColor:(UIColor *)highlightedTextColor
{
    [self setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
//    [self setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    
    
    [self setTitle:normalString forState:UIControlStateNormal];
    [self setTitle:highlightedString forState:UIControlStateHighlighted];
    
    
    
    [self setTitleColor:normalTextColor forState:UIControlStateNormal];
    [self setTitleColor:highlightedTextColor forState:UIControlStateHighlighted];

}


+(CrazyBasisButton *)buttonAddInView:(UIView *)view andButtonTitleText:(NSString *)text  andTextColor:(UIColor *)color  andBackGroundColor:(UIColor *)bGColor andCorner:(BOOL)corner  andFrame:(CGRect)rect   andNormalImage:(UIImage *)normalImage andTextFont:(int)size andCorneNumberr:(int) cornerNumber andTarget:(id)controller andSelector:(SEL)selector
{
    CrazyBasisButton *button = [CrazyBasisButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    if (size) {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }
    
    if (normalImage) {
        [button setImage:normalImage forState:UIControlStateNormal];
    }
    [button setBackgroundColor:bGColor];
    button.frame = rect;
    [view addSubview:button];
    if (corner)
    {
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = cornerNumber;
    }
    
    NSLog(@"%@",controller);
    [button addTarget:controller action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}


-(void)crazyButtonSizeExpand:(float)scale
{
    
    CGRect rect =  self.frame;
    self.imageEdgeInsets = UIEdgeInsetsMake(self.frame.size.height * (scale -1)/2, self.frame.size.width * (scale -1)/2, self.frame.size.height * (scale -1)/2, self.frame.size.width * (scale -1)/2);
    
    rect = (CGRect){self.frame.origin.x - self.frame.size.width * (scale -1)/2,self.frame.origin.y - self.frame.size.height * (scale -1)/2,CGSizeMake(self.frame.size.width * scale, self.frame.size.height * scale)};
    
    self.frame = rect;
    
}

@end
