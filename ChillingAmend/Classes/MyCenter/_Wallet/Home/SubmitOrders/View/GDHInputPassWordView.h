//
//  GDHInputPassWordView.h
//  Wallet
//
//  Created by GDH on 15/10/26.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDHInputPassWordView : UIView

/** 关闭按钮 */
@property (nonatomic,copy) void(^closeBlock)(UIButton *);

/** 找回密码 */
@property (nonatomic,copy) void (^findBlock)(UIButton *);


/** 支付密码 */
@property(nonatomic,strong)void (^payPassWordBlock)(NSString *);

/** 提现的金额数 title */
@property (nonatomic, copy) NSString *payMoney;

-(instancetype)initWithFrame:(CGRect)frame andPayMoney:(NSString *)payMoney ;

/** 清空密码 是否是激活状态 */
- (void)clearTextPassWordWithOneTextFiledEnabled:(BOOL)oneTextFiledEnabled;

/** 调出键盘 */
- (void)theKeyboardShow;
/** 推出键盘 */
- (void)theKeyboardResign;

@end
