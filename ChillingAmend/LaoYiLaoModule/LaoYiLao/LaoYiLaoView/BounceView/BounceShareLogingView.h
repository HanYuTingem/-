//
//  BounceShareLogingView.h
//  LaoYiLao
//
//  Created by wzh on 15/11/2.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BounceShareLogingView : UIView

/**
 *  饺子
 */
@property (nonatomic, strong) UIButton *dumpingBtn;
/**
 *  标题
 */
@property (nonatomic, strong) UILabel *titleLab;

/**
 *  金额
 */
@property (nonatomic, strong) UILabel *moneyLab;
- (void)sharedWithLoging;
@end
