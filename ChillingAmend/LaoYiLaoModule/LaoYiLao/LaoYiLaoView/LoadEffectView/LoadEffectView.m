//
//  LoadEffectView.m
//  LaoYiLao
//
//  Created by sunsu on 15/11/2.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "LoadEffectView.h"

@interface LoadEffectView ()
{

}
@end

@implementation LoadEffectView

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBACOLOR(192, 21, 32, 1);
    }
    return self;
}

- (void) initUI{
//    _loadEffectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kkViewWidth, kkViewHeight)];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self performSelector:@selector(startUpView) withObject:nil afterDelay:1];
    
    //下载view上的控件
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kkViewWidth, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"捞饺子";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = UIFont36;
    [self addSubview:titleLabel];
    
    CGFloat jiaoziW = 246/2;
    CGFloat jiaoziH = 224/2;
    CGRect jiaoziFrame = CGRectMake((kkViewWidth-jiaoziW)/2, CGRectGetMaxY(titleLabel.frame)+105, jiaoziW, jiaoziH);
    UIImageView * jiaoziView = [[UIImageView alloc]initWithFrame:jiaoziFrame];
    jiaoziView.image = [UIImage imageNamed:@"0_jiaozi"];
    [self addSubview:jiaoziView];
    
    
    
    UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(jiaoziView.frame)+20, kkViewWidth, 20)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.text = @"加载中...";
    textLabel.font = UIFont28;
    [self addSubview:textLabel];
}

-(void)startUpView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(startupview)]) {
        [self.delegate startupview];
    }
}


@end
