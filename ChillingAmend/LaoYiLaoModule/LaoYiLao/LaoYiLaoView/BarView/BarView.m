//
//  BarView.m
//  LaoYiLao
//
//  Created by sunsu on 15/10/29.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "BarView.h"
@interface BarView()
{

}
@end

@implementation BarView

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithRed:0.81f green:0.16f blue:0.16f alpha:1.00f];
        self.backgroundColor = [UIColor colorWithPatternImage:[LYLTools scaleImage:[UIImage imageNamed:@"lao_bg"] ToSize:CGSizeMake(kkViewWidth, NavgationBarHeight)]];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    CGFloat buttonY = 20;
    //返回按钮
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setExclusiveTouch:YES];
    leftButton.frame = CGRectMake(0, buttonY, 44, 44);
    [leftButton addTarget:self action:@selector(leftBarButtonOnclick) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat imageViewW = 24/2;
    CGFloat imageViewH = 43/2;
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (leftButton.frame.size.height-imageViewH)/2, imageViewW, imageViewH)];
    imageView.image = [UIImage imageNamed:@"1_return"];
    [leftButton addSubview:imageView];
    [self addSubview:leftButton];
    
    CGFloat titleLabelW = kkViewWidth - 44 - 70;
    _titleLabel  = [[UILabel alloc] initWithFrame:CGRectMake(60,  buttonY, titleLabelW, 44)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    
    
    
    //信息按钮
    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareButton setExclusiveTouch:YES];
    _shareButton.frame = CGRectMake(kkViewWidth-30, buttonY, 30, 44);
    [_shareButton addTarget:self action:@selector(shareButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat imageViewW2 = 46/2;
    CGFloat imageViewH2 =  38/2;
    UIImageView * imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, (_shareButton.frame.size.height-imageViewH2)/2, imageViewW2, imageViewH2)];
    imageView2.image = [UIImage imageNamed:@"1_iconfont-share"];
    [_shareButton addSubview:imageView2];
    [self addSubview:_shareButton];
    
    
    //分享按钮
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setExclusiveTouch:YES];
    CGFloat shareW = 30;
    _rightButton.frame = CGRectMake(kkViewWidth-_shareButton.frame.size.width-10-shareW, buttonY, shareW, 44);
    [_rightButton addTarget:self action:@selector(rightBarButtonOnclick) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat imageViewW3 = 41/2;
    CGFloat imageViewH3 = 40/2;
    UIImageView * imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(_rightButton.frame.size.width-imageViewW3, (_rightButton.frame.size.height-imageViewH3)/2, imageViewW3, imageViewH3)];
    imageView3.image = [UIImage imageNamed:@"1_iconfont-bangzhu"];
    [_rightButton addSubview:imageView3];
    [self addSubview:_rightButton];
}


-(void)leftBarButtonOnclick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(backBtnClicked)]) {
        [self.delegate backBtnClicked];
    }
}

-(void)rightBarButtonOnclick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(helpBtnClicked)]) {
        [self.delegate helpBtnClicked];
    }
}
- (void)shareButtonOnclick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareBtnClicked:)]) {
        [self.delegate shareBtnClicked:btn];
    }
}

@end
