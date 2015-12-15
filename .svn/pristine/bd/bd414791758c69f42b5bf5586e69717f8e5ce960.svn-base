//
//  CrazyBasisLabel.h
//  MarketManage
//
//  Created by fielx on 15/4/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    VerticalCrazyAlignmentTop = 0, // default
    VerticalCrazyAlignmentMiddle,
    VerticalCrazyAlignmentBottom,
} VerticalCrazyAlignment;

#import "CrazyBasisFile.h"




/**
 *  基础label
 */
@interface CrazyBasisLabel : UILabel
{
@private
    VerticalCrazyAlignment _verticalAlignment;
}

@property (nonatomic) VerticalCrazyAlignment verticalCrazyAlignment;

+(CrazyBasisLabel *)labelAddInController:(UIView *)view  andTitle:(NSString *)title  andFrame:(CGRect)rect  andTextAlignment:(NSTextAlignment)textAlignment andTextColor:(UIColor *)color andRow:(int)row andFont:(int)size andBackGroundColor:(UIColor*)bgColor andCorner:(BOOL)corner;


+(CrazyBasisLabel *)labelAddInController:(UIView *)view  andMutableTitle:(NSMutableAttributedString *)title  andFrame:(CGRect)rect  andTextAlignment:(NSTextAlignment)textAlignment andTextColor:(UIColor *)color andRow:(int)row andFont:(int)size andBackGroundColor:(UIColor*)bgColor andCorner:(BOOL)corner;




@end
