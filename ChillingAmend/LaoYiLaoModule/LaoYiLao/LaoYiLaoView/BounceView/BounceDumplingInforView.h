//
//  BounceDumplingInforView.h
//  LaoYiLao
//
//  Created by wzh on 15/11/11.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoGetMoneyView.h"


@interface BounceDumplingInforView : UIView
/**
 *  <#Description#>
 */
typedef NS_ENUM(NSInteger, ButtonTagWithType){
    /**
     *  去领钱
     */
    ButtonTagWithGotoGetMoneyType = 0,
    /**
     *  去登陆
     */
    ButtonTagWithGoToLoginType,
    /**
     *  去分享
     */
    ButtonTagWithGoToShareType,
    /**
     *  明天再捞
     */
    ButtonTagWithTomorrowAgainScoopType,
    /**
     *  继续捞
     */
    ButtonTagWithContinueToMakeType,
    /**
     *  查看钱包
     */
    ButtonTagWithCheckTheBalanceType
};

/**
 *  头像btn
 */
@property (nonatomic, strong) UIButton *iconBtn;

/**
 *  标题lab
 */
@property (nonatomic, strong) UILabel *titleLab;
/**
 *  金额lab
 */
@property (nonatomic, strong) UILabel *moneyLab;
/**
 *  内容lab
 */
@property (nonatomic, strong) UILabel *contentLab;
/**
 *  剩余次数
 */
@property (nonatomic, strong) UILabel *remainingNumberLab;


/**
 *  分享或领钱的btn
 */
@property (nonatomic, strong) UIButton *goToGetMoneyOrShareBtn;
/**
 *  继续捞的btn
 */
@property (nonatomic, strong) UIButton *continueToMakeBtn;


/**
 *  VC
 */
@property (nonatomic, strong) LaoYiLaoViewController *viewController;

///**
// *  代理
// */
//@property (nonatomic, weak) __weak id<BounceWithTypeViewDelegate>delegate;

/**
 *  饺子信息的model
 */
//@property (nonatomic, strong) DumplingInforModel *dumplingInforModel;
+ (BounceDumplingInforView *)shareBounceDumplingInforView;

- (void)refreshDataWithModel:(DumplingInforModel *)model;

- (void)addAnimationWithDuration:(int)duration;
@end
