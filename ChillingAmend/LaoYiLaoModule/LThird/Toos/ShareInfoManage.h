//
//  ShareInfoManage.h
//  LaoYiLao
//
//  Created by sunsu on 15/11/16.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareInfoManage : NSObject
//+ (void) shareJiaoziInfoWithButton:(UIButton *)btn andController:(LaoYiLaoBaseViewController *)controller;
//+ (void) shareActivityWithButton:(UIButton *)btn andController:(LaoYiLaoBaseViewController *)controller;
//+ (void)shareJiaoziInfoWithButton:(UIButton *)btn andController:(LaoYiLaoBaseViewController *)controller andAllMoney:(NSString * )allMoney;

/**
 *  点击他弹出分享
 *
 *  @param type            1. 奖励次的分享接口 捞饺子的弹框  2.导航的分享 分享活动 3.炫耀一下的分享，分享饺子的
 *  @param allMoney       炫耀一下需要的当前用户捞到的现金
 *  @param viewController vc
 *  @param btn            所点击的按钮
 */
+ (void)shareWithType:(NSString *)type andAllMoney:(NSString *)allMoney andViewController:(LaoYiLaoBaseViewController *)viewController;
@end
