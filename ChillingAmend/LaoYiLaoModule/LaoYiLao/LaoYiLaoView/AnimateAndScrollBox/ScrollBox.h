//
//  ScrollBox.h
//  LaoYiLao
//
//  Created by wzh on 15/11/2.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollBox : UIView
#define TimeMid 2 //多久滚动一次

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *moveTimer;//定时器
;

- (void)addItemWithArray:(NSMutableArray *)itemArray;

/**
 *  定时器开始
 */
- (void)startTimer;

/**
 *  定时器停止
 */
- (void)stopTimer;
@end
