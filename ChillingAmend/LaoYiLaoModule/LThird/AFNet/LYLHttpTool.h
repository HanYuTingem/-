//
//  SINOHttptool.h
//  AFNetWorking
//
//  Created by 许文波 on 15/10/14.
//  Copyright (c) 2015年 GDH. All rights reserved.


/*--------  可以把我们请求的参数放在此类中 ----------*/

#import <Foundation/Foundation.h>
@interface LYLHttpTool : NSObject


///**
// *  返回请求体
// *
// *  @return 请求体参数
// */
//+(NSDictionary *)nowDumplingNumber;

/**
 *  1001. 显示当前饺子剩余总数量
 *
 *  @param productCode  产品标识
 *  @param sysType       /渠道：1 H5，2 Android，3 IOS
 *  @param sessionValue /浏览器用cookie ,APP用IMEI
 *
 *  @return 显示当前饺子剩余总数量
 */
+ (NSString *)currentDumplingWithNumberProductCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue;

/**
 *  1002. 捞饺子用户列表(按时间倒序)
 *
 *  @param productCode  产品标识
 *  @param sysType      /渠道：1 H5，2 Android，3 IOS
 *  @param sessionValue /浏览器用cookie ,APP用IMEI
 *
 *  @return 捞饺子用户列表(按时间倒序)
 */
+ (NSString *)userDumplingListWithProductCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue;


/**
 *  1003. 查询用户包/捞的饺子列表(一期不做)
 *
 *  @param productCode  产品标识
 *  @param sysType      /渠道：1 H5，2 Android，3 IOS
 *  @param sessionValue /浏览器用cookie ,APP用IMEI
 *
 *  @return 查询用户包/捞的饺子列表(一期不做)
 */
+ (NSString *)searchDumplingListWithProductCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue;


/**
 *  1004. 标记分享1次
 *
 *  @param userId       用户id（主键）
 *  @param productCode  产品标识*
 *  @param sysType      渠道：1 H5，2 Android，3 IOS
 *  @param sessionValue 浏览器用cookie ,APP用IMEI
 *
 *  @return 标记分享1次
 */
+ (NSString *)markShareWithUserId:(NSString *)userId productCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue;


/**
 *  1005增加捞饺子机会接口 (在前段和APP页面第一次请求捞一捞页面 登陆状态)
 *
 *  @param userId       用户id（主键）
 *  @param productCode  产品标识*
 *  @param sysType      渠道：1 H5，2 Android，3 IOS
 *  @param sessionValue 浏览器用cookie ,APP用IMEI
 *  @return 增加捞饺子机会接口 (在前段和APP页面第一次请求捞一捞页面 登陆状态)
 */
+ (NSString *)addDumplingNuumberWithUserId:(NSString *)userId productCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue;

/**
 *  1006登陆用户捞饺子
 *
 *  @param userId       用户id（主键）
 *  @param productCode  产品标识*
 *  @param sysType      渠道：1 H5，2 Android，3 IOS
 *  @param sessionValue 浏览器用cookie ,APP用IMEI
 *
 *  @return 登陆用户捞饺子
 */
+ (NSString *)logingUserDumplingWithUserId:(NSString *)userId logingPhone:(NSString *)logingPhone productCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue;


/**
 *  1007未登录获取捞饺子上限
 *
 *  @param productCode  产品标识*
 *  @param sysType      /渠道：1 H5，2 Android，3 IOS
 *  @param sessionValue /浏览器用cookie ,APP用IMEI
 *
 *  @return 未登录获取捞饺子上限url
 */
+ (NSString *)noLogingNumberCeilingWithProductCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue;


/**
 *  1008未登陆用户捞饺子
 *
 *  @param productCode  产品标识*
 *  @param sysType      /渠道：1 H5，2 Android，3 IOS
 *  @param sessionValue /浏览器用cookie ,APP用IMEI
 *
 *  @return 未登陆用户捞饺子
 */
+ (NSString *)noLogingUserDumplingWithProductCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue;


/**
 *  1009未登录用户登陆领取接口
 *
 *  @param productCode  产品标识*
 *  @param sysType      /渠道：1 H5，2 Android，3 IOS
 *  @param sessionValue /浏览器用cookie ,APP用IMEI
 *  @param phone        手机号*
 *  @param userId         userID
 *  @param prizeidList  饺子ID(多个逗号分隔)
 *
 *  @return 未登录用户登陆领取接口
 */
+ (NSString *)noLogingGetMoneyWithProductCode:(NSString *)productCode sysType:(NSString *)sysType sessionValue:(NSString *)sessionValue phone:(NSString *)phone prizeidList:(NSString *)prizeidList andUserId:(NSString *)userId;

/**
 *  1010我的饺子
 *
 *  @param productCode  产品标识*
 *  @param sysType      /渠道：1 H5，2 Android，3 IOS
 *  @param sessionValue /浏览器用cookie ,APP用IMEI
 *
 *  @return 我的饺子
 */
//+ (NSString *)myDumplingWithProductCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue andUserId:(NSString*)userId;
+ (NSString *)myDumplingWithProductCode:(NSString *)productCode sysType:(NSString *)sysType andSessionValue:(NSString *)sessionValue andUserId:(NSString*)userId;
/**
 *  //发送登陆验证码
 *
 *  @param userName
 *  @param type     3.登录验证码
 *
 *  @return 发送登录验证码接口
 */
+ (NSString *)sendIdentifyCodeWithUserName:(NSString *)userName andType:(NSString*)type;



/**
 *  //JAVA验证码登陆
 *  @param NSString 用户名、验证码、产品标识
 *  @return 快速登录
 */
//+ (NSString *)quickLoginWithUserName:(NSString *)userName Pwd:(NSString *)pwd andpProIden:(NSString *)proIden;
+ (NSString *)quickLoginWithUserName:(NSString *)userName Vcode:(NSString *)vcode Type:(NSString*)type andpProIden:(NSString *)proIden;

/**
 *  PHP登陆
 *
 *  @param userId   <#userId description#>
 *  @param userName <#userName description#>
 *  @param sex      <#sex description#>
 *  @param nickName <#nickName description#>
 *  @param src      <#src description#>
 *  @param jifeng   <#jifeng description#>
 *  @param status   <#status description#>
 *  @param lat      <#lat description#>
 *  @param ing      <#ing description#>
 *  @param token    <#token description#>
 *
 *  @return <#return value description#>
 */
+ (NSMutableDictionary *)accessToLoginInformationUserId:(NSString *)userId userName:(NSString *)userName sex:(NSString *)sex nickName:(NSString *)nickName src:(NSString *)src jifen:(NSString *)jifeng status:(NSString *)status lat:(NSString *)lat ing:(NSString *)ing token:(NSString *)token;
/**
 *  获取用户协议和账号说明
 *
 *  @param type 协议类型 1.用户协议 2.服务协议
 *
 *  @return 获取用户协议
 */
+ (NSString *)getUserAndCountAgreementWithType:(NSString *)type;



/**
 *  获取分享内容接口
 *
 *  @param temp_id       模板ID  10001：活动分享  10002：饺子分享
 *  @param producid      产品标识
 *  @param share_plat    分享平台
 *  @param picurl        图片URL
 *  @param parameter_des 参数
 *
 *  @return 获取分享信息
 */
+ (NSString *)getShareInfoWithTempid:(NSString*)temp_id andProduct:(NSString *)producid andShareplat:(NSString *)share_plat andPicurl:(NSString *)picurl andParameterdes:(NSString *)parameter_des;

@end
