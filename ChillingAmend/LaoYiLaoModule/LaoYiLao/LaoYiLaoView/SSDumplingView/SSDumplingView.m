//
//  SSDumplingView.m
//  LaoYiLao
//
//  Created by sunsu on 15/10/30.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "SSDumplingView.h"

#import "SSNoDumpView.h"
#import "SSBaoJiaoZiBtnView.h"
#import "SSInfoDumpView.h"


#define BaoJiaoziView_H 50

@interface SSDumplingView ()
{
    SSNoDumpView  * _noDumplingView;//没捞到饺子的页面
}

@end

@implementation SSDumplingView

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
    _baoJzView = [[SSBaoJiaoZiBtnView alloc]init];
//    [self addSubview:_baoJzView];
    
    
    //有饺子界面
    _infoDumplingView = [[SSInfoDumpView alloc]init];
    _infoDumplingView.hidden = YES;
    [self addSubview:_infoDumplingView];
    
    //无饺子界面
    _noDumplingView = [[SSNoDumpView alloc]init];
    _noDumplingView.hidden = YES;
    [self addSubview:_noDumplingView];
    
}




- (void) createInfoDumplingView{
    CGRect infoFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _infoDumplingView.frame = infoFrame;
    _infoDumplingView.userInteractionEnabled = YES;
    _baoJzView.frame =CGRectMake(0, infoFrame.size.height-BaoJiaoziView_H, kkViewWidth, BaoJiaoziView_H);
    [_infoDumplingView addSubview:_baoJzView];
}




//没有饺子的界面
- (void) createNoDumplingView{
    CGRect infoFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _noDumplingView.frame = infoFrame;
    _baoJzView.frame =CGRectMake(0, infoFrame.size.height-BaoJiaoziView_H, kkViewWidth, BaoJiaoziView_H);
    [_noDumplingView addSubview:_baoJzView];
}




- (void)setMyDumModel:(SSMyDumplingModel *)myDumModel{
    _myDumModel = myDumModel;
//    _baoJzView.backgroundColor =  [UIColor colorWithPatternImage:[LYLTools scaleImage:[UIImage imageNamed:@"lao_bg"] ToSize:CGSizeMake(kkViewWidth, _baoJzView.frame.size.height)]];
    if ( [_myDumModel.resultListModel.count isEqualToString:@"0"]) {
        [self createNoDumplingView];
        _infoDumplingView.hidden = YES;
        _noDumplingView.hidden = NO;
    }else{
        [self createInfoDumplingView];
        _noDumplingView.hidden = YES;
        _infoDumplingView.hidden = NO;
        _baoJzView.backgroundColor  =  RGBACOLOR(242, 242, 242, 1);
        [_baoJzView.clickedBtn setTitleColor:[UIColor colorWithRed:0.81f green:0.16f blue:0.16f alpha:1.00f] forState:UIControlStateNormal];
        _baoJzView.lineLabel.backgroundColor = [UIColor colorWithRed:0.81f green:0.16f blue:0.16f alpha:1.00f];
    }
    _infoDumplingView.myDumModel = _myDumModel;
    
}





-(void)layoutSubviews{
    [super layoutSubviews];
    [_infoDumplingView layoutSubviews];
}

@end
