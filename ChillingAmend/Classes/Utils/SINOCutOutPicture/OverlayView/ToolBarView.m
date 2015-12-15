//
//  ToolBarView.m
//  SINOCutOutPictureDemo
//
//  Created by xn on 14-6-26.
//  Copyright (c) 2014年 like. All rights reserved.
//

#import "ToolBarView.h"

@implementation ToolBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)settingFlashStateAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [self.toolBarViewDelegate settingFlashStateDelegate:btn.tag];
}

- (IBAction)convertCameraBtnAction:(id)sender
{
    [self.toolBarViewDelegate convertCameraDelegate:YES];
}

- (IBAction)cancelAction:(id)sender
{
    [self.toolBarViewDelegate cancelDelegate];
}

- (IBAction)okAction:(id)sender
{
    [self.toolBarViewDelegate okDelegate];
}

- (IBAction)takePickerAction:(id)sender
{
    [self.toolBarViewDelegate takePictureDelegate];
}
@end
