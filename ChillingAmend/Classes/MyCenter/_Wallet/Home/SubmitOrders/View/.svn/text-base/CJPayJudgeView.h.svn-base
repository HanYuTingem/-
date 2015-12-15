//
//  CJPayJudgeView.h
//  Wallet
//
//  Created by zhaochunjing on 15-11-11.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//  支付密码的相关逻辑判断

#import <UIKit/UIKit.h>

@protocol CJPayJudgeViewDelegate <NSObject>

@optional
/** 密码验证 等逻辑判断 完成后的操作 encryptKey密钥  */
- (void)payJudgeViewSucceedFinishWithPassWord:(NSString *)passWord encryptKey:(NSString *)encryptKey ID:(NSString *)ID;
/** 充值类型的判断 返回的是 类型字符串 */
- (void)topUpJudgeViewSucceedFinishWithTopUpType:(NSString *)topUpType;
@end


@class GCViewController;
@interface CJPayJudgeView : UIView<UITextFieldDelegate>

/** 金钱的提示框 判断 钱数  不能与moneyTextField并存  */
@property (nonatomic, copy) NSString *moneyText;
/** 有UITextField的情况 需要实现 代理 和负值  不能与moneyText并存  */
@property (nonatomic, strong) UITextField *moneyTextField;
@property (nonatomic, weak) id <CJPayJudgeViewDelegate> delegate;

/** 单例  */
+ (CJPayJudgeView *)shareCJPayJudgeViewWithController:(GCViewController *)controller;

/** 按钮的点击事件 逻辑判断入口 */
- (void)toCashBtnClick;

@end
