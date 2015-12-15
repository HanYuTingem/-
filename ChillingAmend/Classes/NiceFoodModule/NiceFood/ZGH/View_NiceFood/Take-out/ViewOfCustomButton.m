//
//  ViewOfCustomButton.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/23.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "ViewOfCustomButton.h"

@implementation ViewOfCustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"personalhome_list_arrow_right"] forState:UIControlStateNormal];
    }
    return self;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(SCREEN_WIDTH - 28, ViewHeight / 3 , 8, ViewHeight / 3);//图片的位置大小
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(20, ViewHeight / 3 , SCREEN_WIDTH - 20 - 35, ViewHeight / 3);//文本的位置大小
}

@end
