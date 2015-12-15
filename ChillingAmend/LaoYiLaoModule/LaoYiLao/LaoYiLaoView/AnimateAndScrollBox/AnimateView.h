//
//  AnimateView.h
//  animation
//
//  Created by wzh on 15/10/29.
//  Copyright (c) 2015年 王兆华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DumplingsAndSpoonView.h"

@protocol AnimateViewDelegate <NSObject>

- (void)laoYiLaoAnimateBegin;
- (void)laoYiLaoAnimateFinished;

@end

@interface AnimateView : UIView<DumplingsAndSpoonViewDelegate>

@property (nonatomic, weak) __weak id<AnimateViewDelegate>delegate;
@property (nonatomic, strong) UIButton *startBtn;//开始btn
@property (nonatomic, strong) UIImageView *panImageView;//锅的image
@property (nonatomic, strong) UIImageView *panBackImageView;//
@property (nonatomic, strong) UIImageView *steamiImageView;
/**
 *  //锅btn
 */
@property (nonatomic, strong) UIButton *panBtn;
/**
 *  勺and饺子
 */
@property (nonatomic, strong) DumplingsAndSpoonView *dumplingsAndSpoonView;
/**
 *  描述lab
 */
@property (nonatomic , strong) UILabel *describeLab;

@property (nonatomic, assign) int number;

@property (nonatomic, strong)  NSTimer *numTimer;//剩余饺子的定时器

/**
 *  开启定时器
 */
- (void)startTimer;

/**
 *  关闭定时器
 */
- (void)stopTimer;
/**
 *  开始捞饺子
 */
- (void)start;
//- (BOOL)stop;
@end
