//
//  CJNotSufficientFundsView.h
//  Wallet
//
//  Created by zhaochunjing on 15-10-28.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//  选择充值支付类型的页面 默认为 余额不足

#import <UIKit/UIKit.h>

typedef NS_ENUM(int, BalanceViewType){
    /** 余额不足 */
    BalanceViewTypeNoBalance,
    /** 余额充足 */
    BalanceViewTypeHaveBalance
};

@protocol CJNotSufficientFundsViewDelegate <NSObject>
@optional
/** 隐藏界面后的事件 */
- (void)notSufficientFundsViewHiddenEvent;
@end


@interface CJNotSufficientFundsView : UIView

/** 点击事件的回调方法 tag 0支付宝 1微信 2U付 3钱包 */
@property (nonatomic, copy) void(^blookBtnClick)(UIButton *);
@property (nonatomic, assign) id<CJNotSufficientFundsViewDelegate> delegate;

/** 单例对象 必须先实现单例方法 */
+ (CJNotSufficientFundsView *)sharedView;

/** 选择充值支付类型的状态 balanceViewType余额是否充足 */
- (void)notSufficientFundsViewType:(BalanceViewType)balanceViewType;

/** 隐藏弹出界面 */
- (void)hiddenNotSufficientFundsView;
/** 展示没有余额的弹出界面 */
- (void)showNotSufficientFundsView;

@end
