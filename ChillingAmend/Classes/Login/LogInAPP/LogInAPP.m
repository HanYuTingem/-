//
//  LogInAPP.m
//  LANSING
//
//  Created by nsstring on 15/6/2.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "LogInAPP.h"

@implementation LogInAPP

//登陆
+(NSMutableDictionary *)loginUserName:(NSString *)userName andpwd:(NSString *)andpwd{
    NSLog(@"%@?proIde=%@&userName=%@&pwd=%@",ADDRESS,LOGO,userName,andpwd);
    //需要我们初始化一个空间大小，用dictionaryWithCapacity
    NSMutableDictionary * mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:5];
    //这里我们给的空间大小是5,当添加的数据超过的时候，它的空间大小会自动扩大
    //添加数据，注意：id key  是成对出现的
    [mutableDictionary setObject:LOGO forKey:@"proIden"];
    [mutableDictionary setObject:userName forKey:@"userName"];
    [mutableDictionary setObject:andpwd forKey:@"pwd"];
    NSLog(@"%@",mutableDictionary);
    return mutableDictionary;
}

//修改密码
+(NSMutableDictionary *)changeThePasswordOldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd userId:(NSString *)userId{
    NSLog(@"%@updatePwd/?id=%@&oldPwd=%@&newPwd=%@",ADDRESS,userId,oldPwd,newPwd);
    //需要我们初始化一个空间大小，用dictionaryWithCapacity
    NSMutableDictionary * mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:5];
    //这里我们给的空间大小是5,当添加的数据超过的时候，它的空间大小会自动扩大
    //添加数据，注意：id key  是成对出现的
    [mutableDictionary setObject:userId forKey:@"id"];
    [mutableDictionary setObject:oldPwd forKey:@"oldPwd"];
    [mutableDictionary setObject:newPwd forKey:@"newPwd"];
    return mutableDictionary;
}

//找回密码设置密码
+(NSMutableDictionary *)retrievePasswordUserName:(NSString *)userName pwd:(NSString *)pwd{
    
    NSLog(@"%@updateAppPwd/?userName=%@&pwd=%@",ADDRESS,userName,pwd);
    //需要我们初始化一个空间大小，用dictionaryWithCapacity
    NSMutableDictionary * mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:5];
    //这里我们给的空间大小是5,当添加的数据超过的时候，它的空间大小会自动扩大
    //添加数据，注意：id key  是成对出现的
    [mutableDictionary setObject:userName forKey:@"userName"];
    [mutableDictionary setObject:pwd forKey:@"pwd"];
    return mutableDictionary;
}








//发送验证码
+(NSMutableDictionary *)getVerificationCode:(NSString *)cellphone type:(NSString *)type{
    NSLog(@"%@findCode/?id=%@&type=%@",ADDRESS,cellphone,type);
    //需要我们初始化一个空间大小，用dictionaryWithCapacity
    NSMutableDictionary * mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:5];
    //这里我们给的空间大小是5,当添加的数据超过的时候，它的空间大小会自动扩大
    //添加数据，注意：id key  是成对出现的
    [mutableDictionary setObject:cellphone forKey:@"userName"];
    [mutableDictionary setObject:type forKey:@"type"];
    return mutableDictionary;
}

//验证验证码
+(NSMutableDictionary *)verifyTheVerificationCodeUserName:(NSString *)userName vcode:(NSString *)vcode type:(NSString *)type{
    NSLog(@"%@validateLoginCode/?userName=%@&vcode=%@&proIden=%@",ADDRESS,userName,vcode,LOGO);
    //需要我们初始化一个空间大小，用dictionaryWithCapacity
    NSMutableDictionary * mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:5];
    //这里我们给的空间大小是5,当添加的数据超过的时候，它的空间大小会自动扩大
    //添加数据，注意：id key  是成对出现的
    [mutableDictionary setObject:userName forKey:@"userName"];
    [mutableDictionary setObject:vcode forKey:@"vcode"];
    [mutableDictionary setObject:type forKey:@"type"];
    [mutableDictionary setObject:LOGO forKey:@"proIden"];
    return mutableDictionary;
}

//注册
+(NSMutableDictionary *)registeredUserName:(NSString *)userName pwd:(NSString *)pwd inviteCode:(NSString *)inviteCode{
    NSLog(@"%@registeredUser/?userName=%@&pwd=%@&proIden=%@&channel=%@&type=%@&nickname=%@&realName=%@&phone=%@&sex=%@&thridPlatform=%@&inviteCode=%@",ADDRESS,userName,pwd,LOGO,@"ios",@"3",@"",@"",userName,@"1",@"",inviteCode);
    //需要我们初始化一个空间大小，用dictionaryWithCapacity
    NSMutableDictionary * mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:11];
    //这里我们给的空间大小是5,当添加的数据超过的时候，它的空间大小会自动扩大
    //添加数据，注意：id key  是成对出现的
    [mutableDictionary setObject:userName forKey:@"userName"];
    [mutableDictionary setObject:pwd forKey:@"pwd"];
    [mutableDictionary setObject:LOGO forKey:@"proIden"];
    [mutableDictionary setObject:@"ios" forKey:@"channel"];
    [mutableDictionary setObject:@"3" forKey:@"type"];
    [mutableDictionary setObject:@"" forKey:@"nickname"];
    [mutableDictionary setObject:@"" forKey:@"realName"];
    [mutableDictionary setObject:userName forKey:@"phone"];
    [mutableDictionary setObject:@"1" forKey:@"sex"];
    [mutableDictionary setObject:@"" forKey:@"thridPlatform"];
    [mutableDictionary setObject:inviteCode forKey:@"inviteCode"];
    return mutableDictionary;
}

//php获取登陆信息
+(NSMutableDictionary *)accessToLoginInformationUserId:(NSString *)userId userName:(NSString *)userName sex:(NSString *)sex nickName:(NSString *)nickName src:(NSString *)src jifen:(NSString *)jifeng status:(NSString *)status lat:(NSString *)lat ing:(NSString *)ing token:(NSString *)token{
    NSLog(@"%@?por=%@&userId=%@&userName=%@&sex=%@&nickName=%@&src=%@&jifen=%@&status=%@&lat=%@&ing=%@&token=%@",ADDRESSPHP,@"9000",userId,userName,sex,nickName,src,jifeng,status,lat,ing,token);
    //需要我们初始化一个空间大小，用dictionaryWithCapacity
    NSMutableDictionary * mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:12];
    //这里我们给的空间大小是5,当添加的数据超过的时候，它的空间大小会自动扩大
    //添加数据，注意：id key  是成对出现的
    [mutableDictionary setObject:@"9000" forKey:@"por"];
    [mutableDictionary setObject:userId forKey:@"userId"];
    [mutableDictionary setObject:userName forKey:@"userName"];
    [mutableDictionary setObject:sex forKey:@"sex"];
    [mutableDictionary setObject:nickName forKey:@"nickName"];
    [mutableDictionary setObject:src forKey:@"src"];
    [mutableDictionary setObject:jifeng forKey:@"jifen"];
    [mutableDictionary setObject:status forKey:@"status"];
    [mutableDictionary setObject:lat forKey:@"lat"];
    [mutableDictionary setObject:ing forKey:@"ing"];
    [mutableDictionary setObject:token forKey:@"token"];
    return mutableDictionary;
}

/*
 //用户协议 账号说明
 type = 1 用户协议   2 账号说明
 */
+(NSMutableDictionary *)userAgreementType:(NSString *)type{
    NSLog(@"%@getAgreement/?type=%@",ADDRESS,type);
    //需要我们初始化一个空间大小，用dictionaryWithCapacity
    NSMutableDictionary * mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:5];
    //这里我们给的空间大小是5,当添加的数据超过的时候，它的空间大小会自动扩大
    //添加数据，注意：id key  是成对出现的
    [mutableDictionary setObject:type forKey:@"type"];
    return mutableDictionary;
}

@end
