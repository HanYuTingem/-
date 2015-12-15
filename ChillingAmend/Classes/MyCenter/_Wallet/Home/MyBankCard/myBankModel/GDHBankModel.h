//
//  GDHBankModel.h
//  Wallet
//
//  Created by GDH on 15/10/31.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDHBankModel : NSObject
/**
 “bankName”: 1 ,   //银行名称    *******
 “cardSn”: 1 ,   //银行卡卡号    *******
 “bankIcon”: 1 ,   //银行图标    *******
*/


/** 银行名称 */
@property (nonatomic,copy) NSString *bankName;
/** 银行卡卡号 */
@property (nonatomic,copy) NSString *cardSn;
/** 银行图标 */
@property (nonatomic,copy) NSString *bankIcon;
/** 银行卡id */
@property (nonatomic,copy) NSString *userbcid;
/** 用户名称 */
@property (nonatomic,copy) NSString *cardName;

-(instancetype)initWithDic:(NSDictionary *)dic;
@end
