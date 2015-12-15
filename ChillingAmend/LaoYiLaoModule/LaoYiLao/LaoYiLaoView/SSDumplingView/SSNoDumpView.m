//
//  SSNoDumpView.m
//  LaoYiLao
//
//  Created by sunsu on 15/11/26.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "SSNoDumpView.h"

#define JiaoziView_Y (160.0/2)
#define JiaoziView_X ((kkViewWidth-JiaoziView_W)/2)
#define JiaoziView_W (194.0/2)
#define JiaoziView_H (115.0/2)

@interface SSNoDumpView ()
{
    UIImageView * _jiaoziImgView1;
    UILabel * _textLabel;
}
@end

@implementation SSNoDumpView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        self.backgroundColor = [UIColor colorWithPatternImage:[LYLTools scaleImage:[UIImage imageNamed:@"lao_bg"] ToSize:CGSizeMake(kkViewWidth, self.frame.size.height)]];
    }
    return self;
}

-(void)initUI{
    _jiaoziImgView1 = [[UIImageView alloc]init];
    [self addSubview:_jiaoziImgView1];
    
    _textLabel = [[UILabel alloc]init];
    [self addSubview:_textLabel];
    
    [self createNoDumplingView];
}

- (void) createNoDumplingView{
    CGRect infoFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.frame = infoFrame;

    CGRect jiaoziFrame = CGRectMake(JiaoziView_X,JiaoziView_Y, JiaoziView_W, JiaoziView_H);
    _jiaoziImgView1.frame = jiaoziFrame;
    _jiaoziImgView1.image = [UIImage imageNamed:@"4_expression"];
    
    
    _textLabel.frame = CGRectMake(0, CGRectGetMaxY(_jiaoziImgView1.frame)+17, kkViewWidth, 30);
    _textLabel.text = @"还没有捞到饺子哎~";
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.font = UIFont30;
//    _textLabel.textColor = RGBACOLOR(130, 0, 0, 1);
    _textLabel.textColor =[UIColor yellowColor];
    
}


@end
