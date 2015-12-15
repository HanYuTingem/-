//
//  CrazyBasisButton.h
//  MarketManage
//
//  Created by fielx on 15/4/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CrazyBasisFile.h"


@interface CrazyBasisButton : UIButton

/**
 *  设置圆角
 */
-(void)cornerRadius:(float)cornerRadius lineColor:(UIColor *)borderColor borderWidth:(float)borderWidth;


+(CrazyBasisButton *)buttonAddInView:(UIView *)view andButtonTitleText:(NSString *)text  andTextColor:(UIColor *)color  andBackGroundColor:(UIColor *)bGColor andCorner:(BOOL)corner  andFrame:(CGRect)rect   andNormalImage:(UIImage *)normalImage andTextFont:(int)size andCorneNumberr:(int) cornerNumber andTarget:(id)controller andSelector:(SEL)selector;

/**
 *  添加默认与选中图片
 */
-(void)crazyButtonSetNormalImage:(NSString *)normalImage selectImage:(NSString *)selectImage;

/**
 *  高亮与默认图片 和文字
 */
-(void)crazyButtonSetNormalImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage  normalString:(NSString *)normalString highlightedString:(NSString *)highlightedString normalTextColor:(UIColor *)normalTextColor  highlightedTextColor:(UIColor *)highlightedTextColor;



/**
 *  扩大frame 图片大小不变
 */
-(void)crazyButtonSizeExpand:(float)scale;

@end
