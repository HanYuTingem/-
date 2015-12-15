//
//  LogInAPP.h
//  LANSING
//
//  Created by nsstring on 15/6/2.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APPLICATION 2

/*正式*/
//php
#define ADDRESSPHP @"http://ht.sinosns.cn/app/"
//java
#define ADDRESS @"http://api.ucenter.sinosns.cn/"

///*测试*/
////php
//#define ADDRESSPHP @"http://192.168.10.11:2039/app/"
////java
//#define ADDRESS @"http://192.168.10.86:8081/sinoCenter/"

//#define ADDRESS @"http://192.168.10.78:8192/sinoCenter/"
//#define ADDRESS @"http://192.168.10.133:8080/sinoCenter/"



/*产品标示*/
#define LOGO @"XN01_LNTV_HT"

#define LOGOAction    @"XN01_LNTV_HT"
//本地测试地址
//#define ADDRESS @"http://192.168.10.133:8080/sinoCenter/"
/**/

@interface LogInAPP : NSObject

//登陆
+(NSMutableDictionary *)loginUserName:(NSString *)userName andpwd:(NSString *)andpwd;

//修改密码
+(NSMutableDictionary *)changeThePasswordOldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd userId:(NSString *)userId;

//找回密码设置密码
+(NSMutableDictionary *)retrievePasswordUserName:(NSString *)userName pwd:(NSString *)pwd;

//发送验证码
+(NSMutableDictionary *)getVerificationCode:(NSString *)cellphone type:(NSString *)type;

//验证验证码
+(NSMutableDictionary *)verifyTheVerificationCodeUserName:(NSString *)userName vcode:(NSString *)vcode type:(NSString *)type;

//注册
+(NSMutableDictionary *)registeredUserName:(NSString *)userName pwd:(NSString *)pwd inviteCode:(NSString *)inviteCode;

//php获取登陆信息
+(NSMutableDictionary *)accessToLoginInformationUserId:(NSString *)userId userName:(NSString *)userName sex:(NSString *)sex nickName:(NSString *)nickName src:(NSString *)src jifen:(NSString *)jifeng status:(NSString *)status lat:(NSString *)lat ing:(NSString *)ing token:(NSString *)token;
/*
//用户协议 账号说明
 type = 1 用户协议   2 账号说明
 */
+(NSMutableDictionary *)userAgreementType:(NSString *)type;


@end
