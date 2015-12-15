//
//  BaoJiaoziView.m
//  LaoYiLao
//
//  Created by sunsu on 15/11/6.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "BaoJiaoziView.h"

@interface BaoJiaoziView ()
{
    UIImageView * _jiaoziView;
    UIImageView * _qidaiView;
}
@end

@implementation BaoJiaoziView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
//        self.backgroundColor = RGBACOLOR(242, 242, 242, 1);
        self.backgroundColor = [UIColor colorWithPatternImage:[LYLTools scaleImage:[UIImage imageNamed:@"lao_bg"] ToSize:CGSizeMake(kkViewWidth, NavgationBarHeight)]];
    }
    return self;
}


-(void)initUI{
    _jiaoziView = [[UIImageView alloc]init];
    _qidaiView = [[UIImageView alloc]init];
    
    [self addSubview:_jiaoziView];
    [self addSubview:_qidaiView];
    
    CGFloat jiaozi_W = 260/2;
    CGFloat jiaozi_H = 232/2;
    _jiaoziView.frame = CGRectMake((self.frame.size.width-jiaozi_W)/2, 130/2, jiaozi_W, jiaozi_H);
    
    CGFloat qidai_W = 220/2;
    CGFloat qidai_H =  44/2;
    _qidaiView.frame = CGRectMake((self.frame.size.width-qidai_W)/2, CGRectGetMaxY(_jiaoziView.frame)+40/2,qidai_W,qidai_H);
    
    _jiaoziView.image = [UIImage imageNamed:@"jingqingqidai_image"];
    _qidaiView.image = [UIImage imageNamed:@"jingqingqidai_written_words"];
}

@end
