//
//  BounceShareLogingView.m
//  LaoYiLao
//
//  Created by wzh on 15/11/2.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "BounceShareLogingView.h"

// 当前弹框
#define BounceShareLogingViewX 20 * KPercenX
#define BounceShareLogingViewY 154 * KPercenY
#define BounceShareLogingViewW kkViewWidth - 2 * BounceShareLogingViewX
#define BounceShareLogingViewH 207 * KPercenY


//关闭按钮
#define ShutDowbBtnX self.frame.size.width - ShutDowbBtnW - ShutDowbBtnY
#define ShutDowbBtnY 5
#define ShutDowbBtnW 45 / 2 * KPercenY
#define ShutDowbBtnH 45 / 2 * KPercenY

//饺子按钮Frame
#define DumpingBtnX  0 //无所谓设置中心点
#define DumpingBtnY  13 * KPercenY
#define DumpingBtnW  55 * KPercenX
#define DumpingBtnH  33 * KPercenY

//titleFrame
#define TitleLabX 0 //无所谓设置中心点
#define TitleLabY CGRectGetMaxY(_dumpingBtn.frame) + 13 * KPercenY
#define TitleLabW 160 * KPercenX
#define TitleLabH 15 * KPercenY

//moneyFrme
#define MoneyLabX 0 //无所谓设置中心点
#define MoneyLabY CGRectGetMaxY(_titleLab.frame) + 15 * KPercenY
#define MoneyLabW 100  //计算
#define MoneyLabH 40 

//马上分享 和 继续捞y w h
#define ImmediatelyShareContinueToMakeBtnY CGRectGetMaxY(_moneyLab.frame) + 15 * KPercenY
#define ImmediatelyShareContinueToMakeBtnW 90 * KPercenX
#define ImmediatelyShareContinueToMakeBtnH 30 * KPercenY

#define ImmediatelyShareBtnX 40 * KPercenX
#define ContinueToMakeBtnX self.frame.size.width - CGRectGetMaxX(immediatelyShareBtn.frame)


//remainingNumberLabFrme
#define ImmediatelyShareGetNumberLabX 10//无所谓这只中心
#define ImmediatelyShareGetNumberLabY self.frame.size.height - ImmediatelyShareGetNumberLabH - 12
#define ImmediatelyShareGetNumberLabW 200
#define ImmediatelyShareGetNumberLabH 15

@implementation BounceShareLogingView


- (id)init{
    if(self = [super init]){
        self.frame  = CGRectMake(BounceShareLogingViewX, BounceShareLogingViewY, BounceShareLogingViewW, BounceShareLogingViewH);
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        
    }
    return self;
}

- (void)sharedWithLoging{
    
    UIButton *shutDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shutDownBtn setFrame:CGRectMake(ShutDowbBtnX, ShutDowbBtnY, ShutDowbBtnW, ShutDowbBtnH)];
    [shutDownBtn setBackgroundImage:[UIImage imageNamed:@"9_shut_down"] forState:UIControlStateNormal];
    [shutDownBtn addTarget:self action:@selector(shutDownBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shutDownBtn];
    
    _dumpingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dumpingBtn setBackgroundImage:[UIImage imageNamed:@"8_a"] forState:UIControlStateNormal];
    [_dumpingBtn setFrame:CGRectMake(DumpingBtnX, DumpingBtnY, DumpingBtnW, DumpingBtnH)];
    _dumpingBtn.center = CGPointMake(self.frame.size.width / 2, _dumpingBtn.center.y);
    [self addSubview:_dumpingBtn];
    
    
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(TitleLabX, TitleLabY, TitleLabW, TitleLabH)];
    _titleLab.text = @"领取成功！已存入我得钱包";
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.backgroundColor = [UIColor brownColor];
    _titleLab.center = CGPointMake(self.frame.size.width / 2, _titleLab.center.y);
    _titleLab.font = UIFont24;
    [self addSubview:_titleLab];
    
    _moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(MoneyLabX, MoneyLabY, MoneyLabW, MoneyLabH)];
    _moneyLab.text = @"0.88元";
    _moneyLab.font = UIFontBild60;
    _moneyLab.textAlignment = NSTextAlignmentCenter;
    _moneyLab.center = CGPointMake(self.frame.size.width / 2, _moneyLab.center.y);
    _moneyLab.backgroundColor = [UIColor brownColor];
    [self addSubview:_moneyLab];
    
    UIButton *immediatelyShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    immediatelyShareBtn.titleLabel.font = UIFontBild30;
    [immediatelyShareBtn setFrame:CGRectMake(ImmediatelyShareBtnX,ImmediatelyShareContinueToMakeBtnY , ImmediatelyShareContinueToMakeBtnW , ImmediatelyShareContinueToMakeBtnH)];
    [immediatelyShareBtn setTitle:@"马上分享" forState:UIControlStateNormal];
    [immediatelyShareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [immediatelyShareBtn addTarget:self action:@selector(immediatelyShareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [immediatelyShareBtn setBackgroundImage:[UIImage imageNamed:@"9_button_a"] forState:UIControlStateNormal];
    [self addSubview:immediatelyShareBtn];

    
    
    UIButton *continueToMakeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    continueToMakeBtn.titleLabel.font = UIFontBild30;
    [continueToMakeBtn setFrame:CGRectMake(ContinueToMakeBtnX, ImmediatelyShareContinueToMakeBtnY, ImmediatelyShareContinueToMakeBtnW, ImmediatelyShareContinueToMakeBtnH)];
    [continueToMakeBtn setTitle:@"继续捞" forState:UIControlStateNormal];
    [continueToMakeBtn addTarget:self action:@selector(continueToMakeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [continueToMakeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [continueToMakeBtn setBackgroundImage:[UIImage imageNamed:@"9_button_b"] forState:UIControlStateNormal];
    [self addSubview:continueToMakeBtn];
    
  UILabel * immediatelyShareGetNumberLab = [[UILabel alloc]initWithFrame:CGRectMake(ImmediatelyShareGetNumberLabX,ImmediatelyShareGetNumberLabY, ImmediatelyShareGetNumberLabW, ImmediatelyShareGetNumberLabH)];
    immediatelyShareGetNumberLab.center = CGPointMake(self.frame.size.width / 2, immediatelyShareGetNumberLab.center.y);
    immediatelyShareGetNumberLab.font = UIFont24;
    immediatelyShareGetNumberLab.textColor = [UIColor grayColor];
    immediatelyShareGetNumberLab.text = [NSString stringWithFormat:@"马上分享，再得一次机会"];
    immediatelyShareGetNumberLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:immediatelyShareGetNumberLab];
}

#pragma mark -- 去关闭点击
- (void)shutDownBtnClicked:(UIButton *)button{
//    [self.superview removeFromSuperview];
//    [LYLTools removeBounceView];
    NSLog(@"关闭");
    
}

#pragma mark -- 马上分享点击
- (void)immediatelyShareBtnClicked:(UIButton *)button{
    NSLog(@"马上分享");
    
}

#pragma mark -- 继续捞点击
- (void)continueToMakeBtnClicked:(UIButton *)button{
//    [LYLTools removeBounceView];

    NSLog(@"继续捞");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
