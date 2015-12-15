//
//  CJAllCatgoriesReusableView.m
//  MarketManage
//
//  Created by 赵春景 on 15-7-21.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CJAllCatgoriesReusableView.h"

#define LableTextColor [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1]
#define LableFontSize 12

@interface CJAllCatgoriesReusableView ()

{
    /** 二级标题文字 */
    UILabel *_lable;
}

@end

@implementation CJAllCatgoriesReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        _lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, frame.size.width - 40, 15)];
        _lable.textAlignment = NSTextAlignmentLeft;
        _lable.font = [UIFont systemFontOfSize:LableFontSize];
        _lable.textColor = LableTextColor;
        [view addSubview:_lable];
        
    }
    return self;
}

- (void)ReusableViewLableName:(NSString *)nameStr
{
    _lable.text = nameStr;
}

@end
