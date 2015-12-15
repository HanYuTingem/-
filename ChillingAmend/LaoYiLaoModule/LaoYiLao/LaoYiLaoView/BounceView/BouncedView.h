//
//  BouncedView.h
//  LaoYiLao
//
//  Created by wzh on 15/10/31.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BounceShareLogingView.h"
#import "BounceSharedCeilingView.h"
#import "DumplingInforModel.h"
#import "LaoYiLaoViewController.h"
#import "BounceDumplingInforView.h"
@interface BouncedView : UIView


/**
 *  登陆成功分享的弹框
 */
@property (nonatomic, strong) BounceShareLogingView *bounceWithLogingView;


/**
 *  分享次数用完的弹框
 */
@property (nonatomic, strong) BounceSharedCeilingView *bounceSharedCeilingView;


/**
 *  饺子信息的model
 */
@property (nonatomic, strong) DumplingInforModel *dumplingInforModel;


@property (nonatomic, strong) LaoYiLaoViewController *viewController;
/**
 *  添加捞到饺子信息的弹框
 */
- (void)addDumplingInforView;


///**
// *  登陆完分享的弹框
// */
//- (void)addSharedWithLogingView;


/**
 *  捞饺子上限
 */
- (void)addSharedWithCeilingView;
@end
