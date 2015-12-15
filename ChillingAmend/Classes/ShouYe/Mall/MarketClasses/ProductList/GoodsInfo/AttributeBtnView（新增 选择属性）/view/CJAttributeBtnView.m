//
//  CJAttributeBtnView.m
//  MarketManage
//
//  Created by 赵春景 on 15-7-22.
//  Copyright (c) 2015年 Rice. All rights reserved.
//  商品详情页 新添加的商品属性 按钮

#import "CJAttributeBtnView.h"



//边线的颜色
#define CellBorderColor [UIColor colorWithRed:226 / 255.0 green:226 / 255.0 blue:226 / 255.0 alpha:1]

@interface CJAttributeBtnView ()

{
    /** 接受的外界的controller 全局的 */
    UIViewController *_controller;
}

@end

@implementation CJAttributeBtnView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self makeBtnWithFrame:frame];
        
    }
    return self;
}

- (void)makeBtnWithFrame:(CGRect)frame{
    //添加选择字样文本
    UILabel *selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 * SP_WIDTH, 10 * SP_HEIGHT, 40 * SP_WIDTH, 24 * SP_HEIGHT)];
    selectLabel.font = [UIFont systemFontOfSize:14];
    selectLabel.textColor = [UIColor colorWithRed:141/255.0 green:141/255.0 blue:141/255.0 alpha:1];
    selectLabel.text = @"选择";
    selectLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:selectLabel];
    _selectLabel = selectLabel;
    
    //添加右边箭头
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW - (10 + 7 * SP_WIDTH), (frame.size.height - 12 * SP_WIDTH) / 2, (7 * SP_WIDTH) , (12 * SP_HEIGHT) )];
    imageView.image = [UIImage imageNamed:@"mall_ico_arrow.png"];
    [self addSubview:imageView];
    
    //添加属性文本
    CGFloat X = CGRectGetMaxX(selectLabel.frame) ;
    
    UILabel *attributeLabel = [[UILabel alloc] initWithFrame:CGRectMake( X, CGRectGetMinY(selectLabel.frame), ScreenW - X - 20 *SP_WIDTH - CGRectGetWidth(imageView.frame), 24 * SP_HEIGHT)];
    attributeLabel.font = [UIFont systemFontOfSize:14];
    attributeLabel.textColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1];
    attributeLabel.text = @"商品属性";
    [self addSubview:attributeLabel];
    _attributeLabel = attributeLabel;
    
    
    //添加按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [self addSubview:btn];
    _btn = btn;
    
    
    UIView *viewUp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.5)];
    viewUp.backgroundColor = CellBorderColor;
    [self addSubview:viewUp];
    UIView *viewDown = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height, SCREENWIDTH, 0.5)];
    viewDown.backgroundColor = CellBorderColor;
    [self addSubview:viewDown];
    
}


@end
