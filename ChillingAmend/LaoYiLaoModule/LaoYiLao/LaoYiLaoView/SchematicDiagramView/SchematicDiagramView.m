//
//  SchematicDiagramView.m
//  LaoYiLao
//
//  Created by wzh on 15/11/4.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "SchematicDiagramView.h"

//示意图的
#define ImageViewX 125 * KPercenX
#define ImageViewY 100 * KPercenY  + SwitchHeight + NavgationBarHeight + PosterHeight
#define ImageViewW 160 * KPercenX
#define ImageViewH 190 * KPercenY

//开始按钮的坐标
#define StratBtnX 125 * KPercenX
#define StratBtnY 20 * KPercenY + SwitchHeight + NavgationBarHeight + PosterHeight
#define StratBtnW 160 * KPercenX
#define StratBtnH 118 * KPercenY


@implementation SchematicDiagramView


- (instancetype)init{
    if(self  = [super init]){
        
        
        self.frame = CGRectMake(0, 0, kkViewWidth, kkViewHeight);
        self.backgroundColor = BackColor;
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"louShaoShiYi"]];
        _imageView.frame = CGRectMake(ImageViewX, ImageViewY, ImageViewW, ImageViewH);
        _imageView.userInteractionEnabled = YES;
        [self addSubview:_imageView];
        
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _startBtn.backgroundColor = [UIColor blueColor];
        _startBtn.frame =CGRectMake(0, 0, StratBtnW, StratBtnH);
        [_startBtn addTarget:self action:@selector(startBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _startBtn.alpha = 0.5;
        [_imageView addSubview:_startBtn];
        
    }
    return self;
}

- (void)startBtnClicked:(UIButton *)button{
    NSLog(@"点击了示意图的勺子");
    
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        NSLog(@"%@",[UIApplication sharedApplication].keyWindow.subviews);
        if([subView isKindOfClass:[SchematicDiagramView class]]){
            [subView removeFromSuperview];
        }
    }
    _FirstBtnClickedBlock();
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
