//
//  SSBaoJiaoZiBtnView.m
//  LaoYiLao
//
//  Created by sunsu on 15/11/26.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "SSBaoJiaoZiBtnView.h"
#define BaoJiaoziBtn_W 60
#define BaoJiaoziBtn_H 20
#define BaoJiaoziBtn_X ((kkViewWidth-BaoJiaoziBtn_W)/2)
#define BaoJiaoziBtn_Y 0

#define Space_lineLabel (6.0/2)
#define Space_imageView (23.0/2)

@interface SSBaoJiaoZiBtnView ()
{
    UIImageView * _tishiImgView;
    UILabel     * _tishiLabel;
    
}
@end

@implementation SSBaoJiaoZiBtnView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        self.userInteractionEnabled = YES;
    }
    return self;
}


-(void)initUI{
    _tishiImgView = [[UIImageView alloc]init];
    [self addSubview:_tishiImgView];
    
    _tishiLabel = [[UILabel alloc]init];
    [self addSubview:_tishiLabel];
    
    _lineLabel = [[UILabel alloc]init];
    [self addSubview:_lineLabel];
    
    _clickedBtn = [[UIButton alloc]init];
    [self addSubview:_clickedBtn];
    
    [self setcontrolFrame];
    [self setAttributes];
}

-(void)setcontrolFrame{
    CGRect clickFrame = CGRectMake(BaoJiaoziBtn_X, BaoJiaoziBtn_Y, BaoJiaoziBtn_W, BaoJiaoziBtn_H);
    _clickedBtn.frame = clickFrame;
    
    CGFloat lineLabel_Y = CGRectGetMaxY(_clickedBtn.frame)+ Space_lineLabel;
    _lineLabel .frame = CGRectMake(BaoJiaoziBtn_X, lineLabel_Y,BaoJiaoziBtn_W, 0.5);
    
    CGFloat tishiW = 10;
    CGFloat tishiLabelW =  430/2;
    CGFloat tishi_X = (kkViewWidth - tishiLabelW -tishiW)/2;
    CGFloat tishi_Y = CGRectGetMaxY(_lineLabel.frame)+ Space_imageView;
    _tishiImgView.frame = CGRectMake(tishi_X, tishi_Y, tishiW, tishiW);
    
    _tishiLabel.frame = CGRectMake(CGRectGetMaxX(_tishiImgView.frame)+4, _tishiImgView.frame.origin.y, tishiLabelW, tishiW);
}


-(void)setAttributes{
    
    _tishiImgView.image = [UIImage  imageNamed:@"iconfont-xiaogantanhao"];
    
    _tishiLabel.text = @"通过活动获得的现金及优惠劵明细请到我的钱包中查询";
    _tishiLabel.font = [UIFont systemFontOfSize:8.0f];
    _tishiLabel.textColor = [UIColor lightGrayColor];
    
    _lineLabel.backgroundColor = [UIColor yellowColor];//[UIColor colorWithRed:0.81f green:0.16f blue:0.16f alpha:1.00f];
    
    [_clickedBtn setTitle:@"我包的饺子" forState:UIControlStateNormal];
    _clickedBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_clickedBtn setTitleColor:[UIColor colorWithRed:0.81f green:0.16f blue:0.16f alpha:1.00f] forState:UIControlStateNormal];
    [_clickedBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];

    _clickedBtn.titleLabel.font = UIFont24;
    [_clickedBtn addTarget:self action:@selector(woBaoDeJiaozi) forControlEvents:UIControlEventTouchUpInside];
}

- (void) woBaoDeJiaozi{
    NSLog(@"woBaoDeJiaozi");
    if (self.delegate && [self.delegate respondsToSelector:@selector(ClickWoBaodeJiaozi)]) {
        [self.delegate ClickWoBaodeJiaozi];
    }
}

@end
