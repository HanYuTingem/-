//
//  SelectButton.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/24.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "SelectButton.h"

@implementation SelectButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"activity_content_btn_normal"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"activity_content_btn_normal_selected"] forState:UIControlStateSelected];
    }
    return self;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, ViewHeight / 2, ViewHeight / 2);//图片的位置大小
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(ViewHeight / 2 + 5 , 0 , ViewHeight , ViewHeight / 2);//文本的位置大小
}

@end
