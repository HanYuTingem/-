//
//  GDHRsModel.h
//  Wallet
//
//  Created by GDH on 15/10/28.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDHRsModel : NSObject

/**
 "amount":"100", //金额
 "createTime":"", //创建时间
 "amountType":"0" //收支   0收入  1支出
 “businessTypekey”:”25”     //业务类型
 “tradeSn”:”7427536567”     //交易号
 “walletSn”:”124857245”      //钱包流水号
*/

/** 金额 */
@property (nonatomic,copy) NSString *amount;
/** 创建时间 */
@property (nonatomic,copy) NSString *createDate;
/** 0收入  1支出 */
@property (nonatomic,copy) NSString *amountType;
/** 业务类型 */
@property (nonatomic,copy) NSString *businessTypekey;
/** 交易号 */
@property (nonatomic,copy) NSString *tradeSn;
/** 钱包流水号 */
@property (nonatomic,copy) NSString *walletSn;
/**  名称 */
@property (nonatomic,copy) NSString *bussinessName;

-(id)initWithDic:(NSDictionary *)dic;
@end
