//
//  BottomBtn.m
//  MyNiceFood
//
//  Created by sunsu on 15/7/28.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "BottomBtn.h"
@interface BottomBtn ()

@end
@implementation BottomBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return self;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 35, 24, 20);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 10, 24, 24);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
