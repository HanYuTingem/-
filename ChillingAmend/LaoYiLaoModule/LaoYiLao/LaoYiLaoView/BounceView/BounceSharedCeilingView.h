//
//  BounceSharedCeilingView.h
//  LaoYiLao
//
//  Created by wzh on 15/11/2.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LaoYiLaoViewController.h"
@interface BounceSharedCeilingView : UIView

/**
 *  饺子
 */
@property (nonatomic, strong) UIButton *dumpingBtn;

/**
 *  标题
 */
@property (nonatomic, strong) UILabel *titleLab;
- (void)sharedWithCeiling;


@property (nonatomic, strong) LaoYiLaoViewController *viewController;
@end
