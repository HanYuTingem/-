//
//  GDHPassWordModel.h
//  Wallet
//
//  Created by GDH on 15/10/24.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDHPassWordModel : NSObject<NSCoding>

/** 设置支付密码*/
@property (nonatomic,copy) NSString *payPassword;

/** 原来的密码 */
@property (nonatomic,copy) NSString * oldPayPassword;

/** 新的密码 */
@property (nonatomic,copy) NSString *newpayPassword;
//
//@property (nonatomic, copy) NSString *setPassword;

/** 存储账号 */
+(void)save:(GDHPassWordModel *)passWord;

/** 读取账号 */
+(GDHPassWordModel *)passWord;
@end
