//
//  SINOHttptool.m
//  AFNetWorking
//
//  Created by 许文波 on 15/10/14.
//  Copyright (c) 2015年 GDH. All rights reserved.
//

#import "LYLHttpTool.h"
#import "LYLTools.h"

#include <CommonCrypto/CommonDigest.h>

@implementation LYLHttpTool


/**
 *  字典转字符串
 *
 *  @param jsonMutdic 字典
 *
 *  @return 字符串
 */


+ (NSString *)urlWithJson:(NSMutableDictionary *)jsonMutdic{
    NSError *error ;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonMutdic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return json;
}

+ (NSString *)currentDumplingWithNumberProductCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic setObject:productCode forKey:@"productCode"];
    [mutDic setObject:sysType forKey:@"sysType"];
    [mutDic setObject:sessionValue forKey:@"sessionValue"];
    NSString * url = [NSString stringWithFormat:@"%@%@json=%@",URL_LYL_SERVER,NowDumplingNumber,[self urlWithJson:mutDic]];
    ZHLog(@"当前剩余饺子数量=%@",url);
    return url;
}

+ (NSString *)userDumplingListWithProductCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic setObject:productCode forKey:@"productCode"];
    [mutDic setObject:sysType forKey:@"sysType"];
    [mutDic setObject:sessionValue forKey:@"sessionValue"];
    NSString * url = [NSString stringWithFormat:@"%@%@json=%@",URL_LYL_SERVER,UserWithDumplingList,[self urlWithJson:mutDic]];
    ZHLog(@"%@",url);
    return url;
}

//一期不做
+ (NSString *)searchDumplingListWithProductCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic setObject:productCode forKey:@"productCode"];
    [mutDic setObject:sysType forKey:@"sysType"];
    [mutDic setObject:sessionValue forKey:@"sessionValue"];
    NSString * url = [NSString stringWithFormat:@"%@%@json=%@",URL_LYL_SERVER,SearchDoDumplingAndUserList,[self urlWithJson:mutDic]];
    return url;
}

+ (NSString *)markShareWithUserId:(NSString *)userId productCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic setObject:userId forKey:@"userId"];
    [mutDic setObject:productCode forKey:@"productCode"];
    [mutDic setObject:sysType forKey:@"sysType"];
    [mutDic setObject:sessionValue forKey:@"sessionValue"];
    NSString * url = [NSString stringWithFormat:@"%@%@json=%@",URL_LYL_SERVER,MarkShare,[self urlWithJson:mutDic]];
    ZHLog(@"%@",url);
    return url;
}

+ (NSString *)addDumplingNuumberWithUserId:(NSString *)userId productCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic setObject:userId forKey:@"userId"];
    [mutDic setObject:productCode forKey:@"productCode"];
    [mutDic setObject:sysType forKey:@"sysType"];
    [mutDic setObject:sessionValue forKey:@"sessionValue"];
//    [mutDic setObject:number forKeyedSubscript:@"number"];
    NSString * url = [NSString stringWithFormat:@"%@%@json=%@",URL_LYL_SERVER,AddNumberWithDumpling,[self urlWithJson:mutDic]];
    ZHLog(@"增加捞饺子机会接口 =%@",url);
    return url;
}

+ (NSString *)logingUserDumplingWithUserId:(NSString *)userId logingPhone:(NSString *)logingPhone productCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic setObject:userId forKey:@"userId"];
    [mutDic setObject:productCode forKey:@"productCode"];
    [mutDic setObject:sysType forKey:@"sysType"];
    [mutDic setObject:sessionValue forKey:@"sessionValue"];
    [mutDic setObject:logingPhone forKey:@"phone"];
    NSString * url = [NSString stringWithFormat:@"%@%@json=%@",URL_LYL_SERVER,LogingUserWithDumpling,[self urlWithJson:mutDic]];
    ZHLog(@"%@",url);
    return url;
}

+ (NSString *)noLogingNumberCeilingWithProductCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic setObject:productCode forKey:@"productCode"];
    [mutDic setObject:sysType forKey:@"sysType"];
    [mutDic setObject:sessionValue forKey:@"sessionValue"];
    NSString * url = [NSString stringWithFormat:@"%@%@json=%@",URL_LYL_SERVER,NOLogingNumberCeiling,[self urlWithJson:mutDic]];
    ZHLog(@"%@",url);
    return url;
}

+ (NSString *)noLogingUserDumplingWithProductCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic setObject:productCode forKey:@"productCode"];
    [mutDic setObject:sysType forKey:@"sysType"];
    [mutDic setObject:sessionValue forKey:@"sessionValue"];
    NSString * url = [NSString stringWithFormat:@"%@%@json=%@",URL_LYL_SERVER,NOLogingWithDumpling,[self urlWithJson:mutDic]];
    ZHLog(@"%@",url);
    return url;
}

+ (NSString *)noLogingGetMoneyWithProductCode:(NSString *)productCode sysType:(NSString *)sysType sessionValue:(NSString *)sessionValue phone:(NSString *)phone prizeidList:(NSString *)prizeidList andUserId:(NSString *)userId{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic setObject:productCode forKey:@"productCode"];
    [mutDic setObject:sysType forKey:@"sysType"];
    [mutDic setObject:sessionValue forKey:@"sessionValue"];
    [mutDic setObject:phone forKey:@"phone"];
    [mutDic setObject:prizeidList forKey:@"prizeidList"];
    [mutDic setObject:userId forKey:@"userId"];
    NSString * url = [NSString stringWithFormat:@"%@%@json=%@",URL_LYL_SERVER,NOLogingUserGetWithMoney,[self urlWithJson:mutDic]];
    ZHLog(@"%@",url);
    return url;
}


+ (NSString *)myDumplingWithProductCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue andUserId:(NSString*)userId{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic setObject:userId forKey:@"userId"];
    [mutDic setObject:productCode forKey:@"productCode"];
    [mutDic setObject:sysType forKey:@"sysType"];
    [mutDic setObject:sessionValue forKey:@"sessionValue"];
    NSString * url = [NSString stringWithFormat:@"%@%@json=%@",URL_LYL_SERVER,MyDumpling,[self urlWithJson:mutDic]];
    return url;
}


+ (NSString *)sendIdentifyCodeWithUserName:(NSString *)userName andType:(NSString*)type{
    NSString * url = [NSString stringWithFormat:@"%@%@userName=%@&type=%@",URL_LYL_SINOCENTER,LYL_validateLogin,userName,type];
    ZHLog(@"%@",url);
    return url;
}

+ (NSString *)quickLoginWithUserName:(NSString *)userName Vcode:(NSString *)vcode Type:(NSString*)type andpProIden:(NSString *)proIden{
    NSString * url = [NSString stringWithFormat:@"%@%@userName=%@&vcode=%@&type=%@&proIden=%@",URL_LYL_SINOCENTER,LYL_QucikLogin,userName,vcode,type,proIden];
    ZHLog(@"%@",url);
    return url;
}

//php获取登陆信息
+ (NSMutableDictionary *)accessToLoginInformationUserId:(NSString *)userId userName:(NSString *)userName sex:(NSString *)sex nickName:(NSString *)nickName src:(NSString *)src jifen:(NSString *)jifeng status:(NSString *)status lat:(NSString *)lat ing:(NSString *)ing token:(NSString *)token {
//    NSLog(@"%@?por=%@&userId=%@&userName=%@&sex=%@&nickName=%@&src=%@&jifen=%@&status=%@&lat=%@&ing=%@&token=%@",ADDRESSPHP,@"9000",userId,userName,sex,nickName,src,jifeng,status,lat,ing,token);
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


+ (NSString *)getUserAndCountAgreementWithType:(NSString *)type{
    NSString * url = [NSString stringWithFormat:@"%@%@type=%@",URL_LYL_SINOCENTER,LYL_GetAgreement,type];
    ZHLog(@"用户协议url =%@",url);
    return url;
}

+ (NSString *)getShareInfoWithTempid:(NSString*)temp_id andProduct:(NSString *)producid andShareplat:(NSString *)share_plat andPicurl:(NSString *)picurl andParameterdes:(NSString *)parameter_des{
    
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic setObject:temp_id forKey:@"temp_id"];
    [mutDic setObject:producid forKey:@"productid"];
    [mutDic setObject:share_plat forKey:@"share_plat"];
    [mutDic setObject:picurl forKey:@"picurl"];
    [mutDic setObject:parameter_des forKey:@"parameter_des"];
    NSString * url = [NSString stringWithFormat:@"%@%@json=%@",URL_LYL_SHARE,LYL_GetShareInfo,[self urlWithJson:mutDic]];
    ZHLog(@"%@",url);
    return url;
}
@end
