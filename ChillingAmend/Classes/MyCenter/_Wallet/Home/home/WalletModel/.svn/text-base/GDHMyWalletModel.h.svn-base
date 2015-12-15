//
//  GDHMyWalletModel.h
//  Wallet
//
//  Created by GDH on 15/10/24.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDHMyWalletModel : NSObject
/**
 balance”:100," //余额
 "isHasPass”:”FALSE”,//是否设置了支付密码
 “walletDetailChange”:”TRUE”,// 我的钱包明细是否有变化
 "bankCardNum":"16", //银行卡数量
 “bankCardChange”:”TRUE”,// 银行卡数量是否发生变化
 */

/** 余额 */
@property (nonatomic,copy) NSString *balance;
/** 是否设置了支付密码 */
@property (nonatomic,copy) NSString *isHasPass;
/** 我的钱包明细是否有变化 */
@property (nonatomic,copy) NSString *walletDetailChange;
/** 银行卡数量 */
@property (nonatomic,copy) NSString *bankCardNum;
/** 银行卡数量是否发生变化 */
@property (nonatomic,copy) NSString *balanceChange;


- (id)initWithDic:(NSDictionary *)dic;

@end
