//
//  BXAPI.m
//  黑土
//
//  Created by BobNee on 14-12-23.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "BXAPI.h"
#import "JSON.h"

@implementation BXAPI
/**
 *  获取个人资料 por：900
 *
 *  @param userId 用户id
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)personMessageUserId:(NSString*)userId
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"900" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    NSLog(@"personMessage = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@", CHONG_url, @"900", userId]);
    return requestDic;
}

/**
 *  修改用户头像 por：901
 *
 *  @param userId 用户id
 *  @param pic    用户的图片（base64编码）
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)changeHeadImageUserId:(NSString*)userId andPic:(NSString*)pic
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"901" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:pic forKey:@"pic"];
    NSLog(@"changeHeadImage = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&pic=%@", CHONG_url, @"901", userId, pic]);
    return requestDic;
}

/**
 *  修改昵称 por：902
 *
 *  @param userId    用户id
 *  @param nike_name 昵称
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)changeNicknameUserId:(NSString*)userId andNike_name:(NSString*)nike_name
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"902" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:nike_name forKey:@"nike_name"];
    NSLog(@"changeNickname = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&nike_name=%@",CHONG_url,@"902",userId,nike_name]);
    return requestDic;
}

/**
 *  修改性别 por：903
 *
 *  @param userId 用户id
 *  @param sex    性别 1 男 2 女
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)changeSexUserId:(NSString*)userId andSex:(NSString*)sex
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"903" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:sex forKey:@"sex"];
    NSLog(@"changeSex = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&sex=%@", CHONG_url, @"903", userId, sex]);
    return requestDic;
}

/**
 *  修改密码 por：904
 *
 *  @param userId       用户ID
 *  @param old_password 原密码
 *  @param new_password 新密码
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)changePassworduserId:(NSString*)userId andOld_password:(NSString*)old_password andNew_password:(NSString*)new_password
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"904" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:old_password forKey:@"old_password"];
    [requestDic setValue:new_password forKey:@"new_password"];
    NSLog(@"changePassword = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&old_password=%@&new_password=%@", CHONG_url, @"904", userId, old_password, new_password]);
    return requestDic;
}

/**
 *  添加个性标签 por：905
 *
 *  @param userId id
 *  @param tag    标签
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)addHotwordUserId:(NSString*)userId andTag:(NSString*)tag
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"905" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:tag forKey:@"tag"];
    NSLog(@"addHotword = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&tag=%@", CHONG_url, @"905", userId, tag]);
    return requestDic;
}

/**
 *  修改个性标签 pro：906
 *
 *  @param userId  id
 *  @param old_tag 原标签
 *  @param new_tag 新标签
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)changeHotwordUserId:(NSString*)userId andOld_tag:(NSString*)old_tag andNew_tag:(NSString*)new_tag
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"906" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:old_tag forKey:@"old_tag"];
    [requestDic setValue:new_tag forKey:@"new_tag"];
    NSLog(@"changeHotword = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&old_tag=%@&new_tag=%@", CHONG_url, @"906", userId, old_tag, new_tag]);
    return requestDic;
}

/**
 *  删除个性标签 por：907
 *
 *  @param userId id
 *  @param tag    标签
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)deleteHotwordUserId:(NSString*)userId andTag:(NSString*)tag
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"907" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:tag forKey:@"tag"];
    NSLog(@"deleteHotword = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&tag=%@", CHONG_url, @"907", userId, tag]);
    return requestDic;
}

/**
 *  修改个人签名 por：908
 *
 *  @param userId    id
 *  @param signature 签名
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)changeSignatureUserId:(NSString*)userId andSignature:(NSString*)signature
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"908" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:signature forKey:@"remark"];
    NSLog(@"changeSignature = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&remark=%@", CHONG_url, @"908", userId, signature]);
    return requestDic;
}

/**
 *  消息列表 por：909
 *
 *  @param userId  id
 *  @param type    类型 3 = 其它
 *  @param status  状态 0：是我的消息 1：是系统消息
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)messageListUserId:(NSString*)userId andType:(NSString*)type andStatus:(NSString*)status
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"909" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:type forKey:@"type"];
    [requestDic setValue:status forKey:@"status"];
    NSLog(@"messageList = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&type=%@&status=%@", CHONG_url, @"909", userId, type, status]);
    return requestDic;
}

/**
 *  关于我们 por：913
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)aboutUs
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"913" forKey:@"por"];
    NSLog(@"aboutUs = %@", [NSString stringWithFormat:@"%@?por=%@", CHONG_url, @"913"]);
    return requestDic;
}

/**
 *  意见反馈 pro：914
 *
 *  @param userId    id
 *  @param user_mail 用户邮箱
 *  @param content   反馈内容
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)userFeedbackUserId:(NSString*)userId andUser_mail:(NSString*)user_mail andContent:(NSString*)content
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"914" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:user_mail forKey:@"user_mail"];
    [requestDic setValue:content forKey:@"content"];
    NSLog(@"userFeedback = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&user_mail=%@&content=%@", CHONG_url, @"914", userId, user_mail, content]);
    return requestDic;
}

/**
 *  检测更新 por：915
 *
 *  @param type 1:ios 2:Android
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)checkUpdateType:(NSString*)type
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"915" forKey:@"por"];
    [requestDic setValue:type forKey:@"type"];
    NSLog(@"checkUpdate = %@", [NSString stringWithFormat:@"%@?por=%@&type=%@", CHONG_url, @"915", type]);
    return requestDic;
}

/**
 *  背景图片 por：916
 *
 *  @param userId     id
 *  @param background 背景图片（拍照上传使用base64编码）
 *  @param type       1表示拍照上传  2表示是本地图像选择
 *
 *  @return 用户信息
 */
+ (NSMutableDictionary *)changeBgImageUserId:(NSString*)userId andBackground:(NSString*)background andType:(NSString*)type
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"916" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:background forKey:@"background"];
    [requestDic setValue:type forKey:@"type"];
    NSLog(@"changeBgImage = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&background=%@&type=%@", CHONG_url, @"916", userId, background, type]);
    return requestDic;
}

/**
 *  第三方分享绑定 por：917
 *
 *  @param userId id
 *  @param type   1表示qq  2表示新浪
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)shareBindingUserId:(NSString*)userId andType:(NSString*)type
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"917" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:type forKey:@"type"];
    NSLog(@"shareBinding = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&type=%@", CHONG_url, @"917", userId, type]);
    return requestDic;
}

/**
 *  奖品列表 por：918
 *
 *  @param userId id
 *
 *  @return 奖品信息
 */
+ (NSMutableDictionary *)prizeListUserId:(NSString*)userId
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"918" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    NSLog(@"prizeList = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@", CHONG_url, @"918", userId]);
    return requestDic;
}

/**
 *  领奖方式 por：919
 *
 *  @param type    领奖类型  1、现场  2、快递
 *  @param prizeId 奖品记录的id（918中返回的id）
 *  @param day     只有是在第一次选择现场领取的时候传值，（否则传空值，如果是修改配送方式的时候，选择的该项，day也传空值）
 *
 *  @return 奖品信息
 */
+ (NSMutableDictionary *)prizeType:(NSString*)type andPrizeId:(NSString*)prizeId andDay:(NSString*)day
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"919" forKey:@"por"];
    [requestDic setValue:type forKey:@"type"];
    [requestDic setValue:prizeId forKey:@"id"];
    [requestDic setValue:day forKey:@"day"];
    NSLog(@"prizeType = %@", [NSString stringWithFormat:@"%@?por=%@&type=%@&id=%@&day=%@", CHONG_url, @"918", type, prizeId, day]);
    return requestDic;
}

/**
 *  奖品详情 por：922
 *
 *  @param prizeId 奖品id
 *
 *  @return 奖品信息
 */
+ (NSMutableDictionary *)prizeMessagePrizeId:(NSString*)prizeId
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"922" forKey:@"por"];
    [requestDic setValue:prizeId forKey:@"id"];
    NSLog(@"prizeMessage = %@", [NSString stringWithFormat:@"%@?por=%@&id=%@", CHONG_url, @"922", prizeId]);
    return requestDic;
}

/**
 *  手机是否验证 por：924
 *
 *  @param userId id
 *
 *  @return 1 已经验证过，0,未验证
 */
+ (NSMutableDictionary *)phoneIsValidationUserId:(NSString*)userId
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"924" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    NSLog(@"phoneIsValidation = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@", CHONG_url, @"924", userId]);
    return requestDic;
}

/**
 *  领奖验证手机 por：925
 *
 *  @param userId id
 *  @param code   验证码
 *  @param phone  手机号
 *
 *  @return 0 验证失败，1, 验证成功
 */
+ (NSMutableDictionary *)phoneCheckUserId:(NSString*)userId andCode:(NSString *)code andPhone:(NSString *)phone
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"925" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:code forKey:@"code"];
    [requestDic setValue:phone forKey:@"phone"];
    NSLog(@"phoneCheck = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&code=%@&phone=%@", CHONG_url, @"925", userId, code, phone]);
    return requestDic;
}

/**
 *  修改邮箱 por：926
 *
 *  @param userId id
 *  @param email  email
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)changEmailUserId:(NSString*)userId andEmail:(NSString*)email
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"926" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:email forKey:@"email"];
    NSLog(@"changEmail = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&email=%@", CHONG_url, @"926", userId, email]);
    return requestDic;
}

/**
 *  修改生日 por：927
 *
 *  @param userId   id
 *  @param birthday 生日
 *
 *  @return 请求字典描述
 */
+ (NSMutableDictionary *)changeBirthUserId:(NSString*)userId andBirthday:(NSString*)birthday
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"927" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:birthday forKey:@"shengri"];
    NSLog(@"changeBirth = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&shengri=%@", CHONG_url, @"927", userId, birthday]);
    return requestDic;
}

/**
 *  修改居住地区 por：928
 *
 *  @param userId  id
 *  @param address 居住区域(必填项)
 *
 *  @return 修改请求字典
 */
+ (NSMutableDictionary *)changeAreaUserId:(NSString*)userId andAddress:(NSString*)address
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"928" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:address forKey:@"quyu"];
    NSLog(@"changeArea = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&quyu=%@", CHONG_url, @"928", userId, address]);
    return requestDic;
}

/**
 *  获取验证码 por：929
 *
 *  @param iphone 手机号
 *  @param type   获取验证码分类 1：注册获取，2：忘记密码获取，3：领取奖品获取
 *
 *  @return 0 获取失败，1,获取成功
 */
+ (NSMutableDictionary *)getValidCodePhone:(NSString*)iphone andType:(NSString*)type
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"929" forKey:@"por"];
    [requestDic setValue:iphone forKey:@"phone"];
    [requestDic setValue:type forKey:@"type"];
    NSLog(@"getValidCode = %@", [NSString stringWithFormat:@"%@?por=%@&phone=%@&type=%@", CHONG_url, @"929", iphone, type]);
    return requestDic;
}

/**
 *  登录 por：1000
 *
 *  @param user_name 用户名
 *  @param password  密码
 *
 *  @return 用户信息
 */
+ (NSMutableDictionary *)loginUser_name:(NSString *)user_name andPassword:(NSString*)password
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1000" forKey:@"por"];
    [requestDic setValue:user_name forKey:@"user_name"];
    [requestDic setValue:password forKey:@"password"];
    NSLog(@"login = %@", [NSString stringWithFormat:@"%@?por=%@&user_name=%@&password=%@",CHONG_url,@"1000",user_name,password]);
    return requestDic;
}

/**
 *  注册 por：1001
 *
 *  @param userName  用户名(手机号)
 *  @param nickName  昵称
 *  @param password  密码
 *  @param validCode 验证码
 *
 *  @return 用户信息
 */
+ (NSMutableDictionary *)registerUserName:(NSString*)userName andNickName:(NSString*)nickName andPassword:(NSString*)password andValidCode:(NSString*)validCode andChannel:(NSString*)channel
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1001" forKey:@"por"];
    [requestDic setValue:userName forKey:@"user_name"];
    [requestDic setValue:nickName forKey:@"nike_name"];
    [requestDic setValue:password forKey:@"password"];
    [requestDic setValue:validCode forKey:@"code"];
    [requestDic setValue:channel forKey:@"channel"];
    NSLog(@"register = %@", [NSString stringWithFormat:@"%@?por=%@&user_name=%@&nike_name=%@&password=%@&code=%@channel=%@",CHONG_url,@"1001",userName,nickName,password,validCode,channel]);
    return requestDic;
}

/**
 *  邮箱找回密码 por：1002
 *
 *  @param type      默认为1
 *  @param user_mail 用户注册邮箱
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)mailFindPasswordType:(NSString *)type andUser_mail:(NSString*)user_mail
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1002" forKey:@"por"];
    [requestDic setValue:type forKey:@"type"];
    [requestDic setValue:user_mail forKey:@"user_mail"];
    NSLog(@"mailFindPassword = %@", [NSString stringWithFormat:@"%@?por=%@&type=%@&user_mail=%@",CHONG_url,@"1002",type,user_mail]);
    return requestDic;
}

/**
 *  手机找回密码 por：1003
 *
 *  @param type       默认认为1
 *  @param user_phone 用户注册手机号
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)phoneFindPasswordType:(NSString *)type andUser_phone:(NSString*)user_phone
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1003" forKey:@"por"];
    [requestDic setValue:type forKey:@"type"];
    [requestDic setValue:user_phone forKey:@"user_phone"];
    NSLog(@"phoneFindPassword = %@", [NSString stringWithFormat:@"%@?por=%@&type=%@&user_phone=%@",CHONG_url,@"1003",type,user_phone]);
    return requestDic;
}

/**
 *  完善资料 por：1005
 *
 *  @param userName 用户名
 *  @param email    邮箱
 *  @param birth    生日
 *  @param sex      性别
 *
 *  @return 用户信息
 */
+ (NSMutableDictionary *)perfectInformationUserName:(NSString*)userName andEmail:(NSString*)email andBirthday:(NSString*)birth andSex:(NSString*)sex
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1005" forKey:@"por"];
    [requestDic setValue:userName forKey:@"user_name"];
    [requestDic setValue:email forKey:@"email"];
    [requestDic setValue:birth forKey:@"shengri"];
    [requestDic setValue:sex forKey:@"sex"];
    NSLog(@"perfectInformation = %@", [NSString stringWithFormat:@"%@?por=%@&user_name=%@&email=%@&shengri=%@&sex=%@",CHONG_url,@"1005",userName,email,birth,sex]);
    return requestDic;
}

/**
 *  手机找回密码之前的验证 por：1006
 *
 *  @param phoneNum  手机号
 *  @param validCode 验证码
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)getResetPasswordPhoneNum:(NSString*)phoneNum andCode:(NSString*)validCode
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1006" forKey:@"por"];
    [requestDic setValue:phoneNum forKey:@"user_name"];
    [requestDic setValue:validCode forKey:@"code"];
    NSLog(@"getResetPassword = %@", [NSString stringWithFormat:@"%@?por=%@&user_name=%@&code=%@",CHONG_url,@"1006",phoneNum,validCode]);
    return requestDic;
}

/**
 *  重置密码 por：1007
 *
 *  @param userName      用户名(手机号)
 *  @param password      原密码
 *  @param againPassword 新密码
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)resetPasswordUserName:(NSString*)userName andPassword:(NSString*)password andAgainPassword:(NSString*)againPassword
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1007" forKey:@"por"];
    [requestDic setValue:userName forKey:@"user_name"];
    [requestDic setValue:password forKey:@"password1"];
    [requestDic setValue:againPassword forKey:@"password2"];
    NSLog(@"getResetPassword = %@", [NSString stringWithFormat:@"%@?por=%@&user_name=%@&password1=%@&password2=%@",CHONG_url,@"1007",userName,password,againPassword]);
    return requestDic;
}

/**
 *  用户消息 por：1008
 *
 *  @param userId  id
 *  @param pageSize    每页显示消息的条数
 *  @param page  当前的页码
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)personMessageUserId:(NSString*)userId andPageSize:(NSString*)pageSize andPage:(NSString*)page
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1008" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:pageSize forKey:@"pageSize"];
    [requestDic setValue:page forKey:@"page"];
    NSLog(@"personMessage = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&pageSize=%@&page=%@",CHONG_url,@"1008",userId,pageSize,page]);
    return requestDic;
}

/**
 *  视频首页 por：1201
 *
 *  @param userId  id
 *  @param size    默认每期分类下面视频的个数 6
 *  @param periods 默认首页显示的期数 5
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)videoHomepageUserId:(NSString*)userId andSize:(NSString*)size andPeriods:(NSString*)periods
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1201" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:size forKey:@"size"];
    [requestDic setValue:periods forKey:@"periods"];
    NSLog(@"videoHomepage = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&size=%@&periods=%@",CHONG_url,@"1201",userId,size, periods]);
    return requestDic;
}

/**
 *  视频加载更多 por：1202
 *
 *  @param userId  id
 *  @param size    默认每期分类下面视频的个数 6
 *  @param periods 默认首页显示的期数 5
 *  @param page    当前页码（首次请求页码默认为2）
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)loadingMoreVideoUserId:(NSString*)userId andSize:(NSString*)size andPeriods:(NSString*)periods andPage:(NSString*)page
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1202" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:size forKey:@"size"];
    [requestDic setValue:periods forKey:@"periods"];
    [requestDic setValue:page forKey:@"page"];
    NSLog(@"loadingMoreVideo = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&size=%@&periods=%@&page=%@",CHONG_url,@"1202",userId,size, periods, page]);
    return requestDic;
}

/**
 *  视频列表 por：1203
 *
 *  @param userId id
 *  @param size   默认每期分类下面视频的个数
 *  @param day    请求显示视频的期数
 *  @param page   当前页码（首次请求页码默认为1）
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)videoListUserId:(NSString*)userId andSize:(NSString*)size andDay:(NSString*)day andpage:(NSString*)page
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1203" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:size forKey:@"size"];
    [requestDic setValue:day forKey:@"day"];
    [requestDic setValue:page forKey:@"page"];
    NSLog(@"videoList = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&size=%@&day=%@&page=%@",CHONG_url,@"1203",userId,size, day, page]);
    return requestDic;
}

/**
 *  视频详情 por：1204
 *
 *  @param userId  id
 *  @param videoId 视频id
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)videoMessageUserId:(NSString*)userId andVideoId:(NSString*)videoId
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1204" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:videoId forKey:@"videoId"];
    NSLog(@"videoMessage = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&videoId=%@",CHONG_url,@"1204",userId,videoId]);
    return requestDic;
}

/**
 *  微视频点赞/收藏 por：1205
 *
 *  @param userId   id
 *  @param objId    视频id
 *  @param joinType 1是点赞，2是收藏
 *  @param objType 1是视频，2是其它
 *  @return 请求字典
 */

+ (NSMutableDictionary *)videoPraiseAndCollectionUserId:(NSString*)userId andObjId:(NSString*)objId andJoinType:(NSString*)joinType andObjType:(NSString *)objType
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1205" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:objId forKey:@"objId"];
    [requestDic setValue:joinType forKey:@"joinType"];
    [requestDic setValue:objType forKey:@"objType"];
    NSLog(@"videoPraiseAndCollectionUser = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&objId=%@&joinType=%@&objType=%@",CHONG_url,@"1205",userId,objId,joinType,objType]);
    return requestDic;
}

/**
 *  推荐视频 por：1206
 *
 *  @param userId id
 *  @param size   默认每页显示的条数
 *  @param page   当前页码（首次请求页码默认为1）
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)recommendedVideoUserId:(NSString*)userId andSize:(NSString*)size andpage:(NSString*)page andPlayingVideoID:(NSString *)videoId
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1206" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:size forKey:@"size"];
    [requestDic setValue:page forKey:@"page"];
    [requestDic setValue:page forKey:@"videoId"];
    NSLog(@"recommendedVideo = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&size=%@&page=%@&videoId=%@",CHONG_url,@"1206",userId,size,page,videoId]);
    return requestDic;
}

/**
 *  看视频加积分 por：1207
 *
 *  @param userId  id
 *  @param videoId 视频id
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)videoAddCoinUserId:(NSString*)userId andVideoId:(NSString*)videoId
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1207" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:videoId forKey:@"videoId"];
    NSLog(@"videoAddCoin = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&videoId=%@",CHONG_url,@"1207", userId, videoId]);
    return requestDic;
}

/**
 *  规则 por：1208
 *
 *  @param type 1是视频，2是其他（如以后添加的购物，游戏等）
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)ruleType:(NSString*)type
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1208" forKey:@"por"];
    [requestDic setValue:type forKey:@"type"];
    NSLog(@"rule = %@", [NSString stringWithFormat:@"%@?por=%@&type=%@",CHONG_url,@"1208", type]);
    return requestDic;
}

/**
 *  获取分享内容 por:1209
 *
 *  @param type 1=幸运转盘，2=刮刮乐，3=摇一摇，4=关于我们
 *
 *  @return 字典
 */
+ (NSMutableDictionary *)shareContentType:(NSString*)type
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1209" forKey:@"por"];
    [requestDic setValue:type forKey:@"type"];
    NSLog(@"shareContent = %@", [NSString stringWithFormat:@"%@?por=%@&type=%@",CHONG_url,@"1209", type]);
    return requestDic;
}

/**
 *  首页 por：1301
 *
 *  @param userId id
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)homePageUserId:(NSString*)userId
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1301" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    NSLog(@"homePage = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@",CHONG_url,@"1301", userId]);
    NSLog(@"%@",requestDic);
    return requestDic;
}

/**
 *  个人收藏 por：1302
 *
 *  @param userId   id
 *  @param type     收藏的类型  1=视频|2=其它
 *  @param pageNum  请求的页数
 *  @param pageSize 每页条数 （默认显示10条）
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)collectionUserId:(NSString*)userId andType:(NSString*)type andPage:(NSString*)page andSize:(NSString*)size
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1302" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:type forKey:@"type"];
    [requestDic setValue:page forKey:@"page"];
    [requestDic setValue:size forKey:@"size"];
    NSLog(@"collection = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&type=%@&page=%@&size=%@",CHONG_url,@"1302", userId, type, page, size]);
    return requestDic;
}

/**
 *  天天宝箱首页 por：1100
 *
 *  @param activityId 活动id（1）
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)dayChestId:(NSString*)activityId andUserId:(NSString*)userId
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1100" forKey:@"por"];
    [requestDic setValue:activityId forKey:@"id"];
    [requestDic setValue:userId forKey:@"userId"];
    NSLog(@"dayChestId = %@", [NSString stringWithFormat:@"%@?por=%@&id=%@&userId=%@",CHONG_url,@"1100", activityId, userId]);
    return requestDic;
}

/**
 *  开启宝箱 por：1101
 *
 *  @param userID  用户id
 *
 *  @param activityId 活动id（1）
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)openTheDayChestWithUserID:(NSString *)userID andActivityId:(NSString*)activityId
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1101" forKey:@"por"];
    [requestDic setValue:userID forKey:@"userId"];
    [requestDic setValue:activityId forKey:@"id"];
    NSLog(@"openChest = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&id=%@",CHONG_url,@"1100", userID, activityId]);
    return requestDic;
}

/**
 *  游戏列表 por：shenhe
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)gameList
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"shenhe" forKey:@"por"];
    NSLog(@"gameList = %@", [NSString stringWithFormat:@"%@?por=%@",CHONG_url,@"shenhe"]);
    return requestDic;
}

/**
 *  摇一摇  pro：100
 *
 *  @param userID     用户id
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)yaoYiYaoDetailsWithUserID:(NSString *)userID
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"100" forKey:@"por"];
    [requestDic setValue:userID forKey:@"userId"];
    NSLog(@"yaoYiYaoDetails = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@", CHONG_url, @"100", userID]);
    return requestDic;
}

/**
 *  摇一摇摇奖  pro：101
 *
 *  @param userID     用户id
 *  @param activityId 摇一摇的id
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)yaoYiYaoOpenAwardsWithUserID:(NSString *)userID andActivityId:(NSString*)activityId
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"101" forKey:@"por"];
    [requestDic setValue:userID forKey:@"userId"];
    [requestDic setValue:activityId forKey:@"id"];
    NSLog(@"yaoYiYaoOpenAwards = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&id=%@", CHONG_url, @"101", userID, activityId]);
    return requestDic;
}

/**
 *  摇一摇接收Token值    pro：102
 *
 *  @param userID 用户Id
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)yaoYiYaoReceiveTokenWithUserID:(NSString *)userID
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"102" forKey:@"por"];
    [requestDic setValue:userID forKey:@"id"];
    NSLog(@"yaoYiYaoReceiveToken = %@", [NSString stringWithFormat:@"%@?por=%@&id=%@", CHONG_url, @"102", userID]);
    return requestDic;
}

/**
 *  摇一摇背景图片     pro：103
 *
 *  @param Resolution 分辨率（必须类似480*320这种格式）
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)yaoYiYaoBackGroundImageWithResolution:(NSString *)Resolution
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"103" forKey:@"por"];
    [requestDic setValue:Resolution forKey:@"img_resolution"];
    NSLog(@"yaoYiYaoBackGroundImage = %@", [NSString stringWithFormat:@"%@?por=%@&img_resolution=%@", CHONG_url, @"103", Resolution]);
    return requestDic;
}

/**
 *  刮刮乐  列表   pro：200
 *
 *  @param userID 用户ID
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)guaGuaLeListWithUserID:(NSString *)userID
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"200" forKey:@"por"];
    [requestDic setValue:userID forKey:@"userId"];
    NSLog(@"guaGuaLeList = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@", CHONG_url, @"200", userID]);
    return requestDic;
}

//
/**
 *   获取奖品   pro：201
 *
 *  @param userid  用户id
 *  @param fanwei  范围
 *  @param classid id
 *
 *  @return 请求字典
 */
+(NSMutableDictionary *)guaGuaLePremiumUserid:(NSString*)userid fanwei:(NSString *)fanwei classid:(NSString *)classid
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"201" forKey:@"por"];
    [requestDic setValue:userid forKey:@"userId"];
    [requestDic setValue:fanwei forKey:@"fanwei"];
    [requestDic setValue:classid forKey:@"classid"];
    NSLog(@"guaGuaLePremium = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&fanwei=%@&classid=%@",CHONG_url,@"201", userid, fanwei, classid]);
    return requestDic;
}

/**
 *  刮刮开始    pro：202
 *
 *  @param userId 用户id
 *  @param suiji  随机码
 *
 *  @return 请求字典
 */
+(NSMutableDictionary *)guaGuaLeStartScratchuserId:(NSString *)userId suiji:(NSString *)suiji
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"202" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:suiji forKey:@"suiji"];
    NSLog(@"guaGuaLeStartScratch = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&suiji=%@", CHONG_url, @"202", userId, suiji]);
    return requestDic;
    
}

/**
 *  刮刮结束    pro： 202
 *
 *  @param userId 用户id
 *  @param suiji  随机码
 *
 *  @return 请求字典
 */
+(NSMutableDictionary *)guaGuaLeEnduserId:(NSString *)userId suiji:(NSString *)suiji
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"203" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    [requestDic setValue:suiji forKey:@"suiji"];
    NSLog(@"guaGuaLeEnd = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&suiji=%@", CHONG_url, @"203", userId, suiji]);
    return requestDic;
}

/**
 *  刮刮乐-积分兑换刮奖    pro：204
 *
 *  @param userid 用户id
 *
 *  @return 请求字典
 */
+(NSMutableDictionary *)guaGuaLeExchangeJiFenForChangcesWithUserid:(NSString*)userid
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"204" forKey:@"por"];
    [requestDic setValue:userid forKey:@"userId"];
    NSLog(@"guaGuaLeEnd = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@", CHONG_url, @"204", userid]);
    return requestDic;
}

/**
 *  转盘  键盘列表   pro：401
 *
 *  @param userID 用户ID
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)zhuanPanAwardListWithUserID:(NSString *)userID
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"401" forKey:@"por"];
    [requestDic setValue:@"1" forKey:@"type"];
    [requestDic setValue:userID forKey:@"userId"];
    NSLog(@"zhuanPanAwardList = %@", [NSString stringWithFormat:@"%@?por=%@&type=%@&userId=%@",CHONG_url,@"401", @"1", userID]);
    return requestDic;
}
/**
 *  转盘   中奖信息   pro：402
 *
 *  @param userID 用户ID
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)zhuanPanAwardDetailsWithUserID:(NSString *)userID
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"402" forKey:@"por"];
    [requestDic setValue:userID forKey:@"userId"];
    NSLog(@"zhuanPanAwardList = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@",CHONG_url,@"402", userID]);
    return requestDic;
}

/**
 *  启动页广告    pro：403
 *
 *  @param Resolution 分辨率（必须类似480*320这种格式）
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)advertiseMentForAppStartWithResolution:(NSString *)Resolution
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"403" forKey:@"por"];
    [requestDic setValue:Resolution forKey:@"img_resolution"];
    NSLog(@"AdvertiseMentForAppStart = %@", [NSString stringWithFormat:@"%@?por=%@&img_resolution=%@",CHONG_url,@"403", Resolution]);
    return requestDic;
}

/**
 *  转盘   积分兑换抽奖中奖信息   pro：405
 *
 *  @param userID 用户ID
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)zhuanPanZhongJiangDetailsWithUserID:(NSString *)userID
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"405" forKey:@"por"];
    [requestDic setValue:userID forKey:@"userId"];
    NSLog(@"zhuanPanZhongJiang  = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@",CHONG_url,@"405", userID]);
    return requestDic;
}

/**
 *  取消点赞、收藏    pro:1303
 *
 *  @param userID   用户中心中用户ID
 *  @param objId    被操作对象的ID
 *  @param joinType 传1是点赞，2是收藏
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)ZanOrCollectionCancleWithUserID:(NSString *)userID andObjId:(NSString *)objId andJoinType:(NSString *)joinType andObjectType:(NSString *)objType
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1303" forKey:@"por"];
    [requestDic setValue:userID forKey:@"userId"];
    [requestDic setValue:objId forKey:@"objId"];
    [requestDic setValue:joinType forKey:@"joinType"];
    [requestDic setValue:objType forKey:@"objType"];
    NSLog(@"ZanOrCollectionCancleWithUserID  = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@&objId=%@&joinType=%@",CHONG_url,@"1303", userID,objId,joinType]);
    return requestDic;
}

/**
 *  APP活动场分享获取积分 pro:1304
 *
 *  @param userId 用户中心中用户ID
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)addJifenUserCenterId:(NSString*)userId
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1304" forKey:@"por"];
    [requestDic setValue:userId forKey:@"userId"];
    NSLog(@"addJifen  = %@", [NSString stringWithFormat:@"%@?por=%@&userId=%@",CHONG_url,@"1304", userId]);
    return requestDic;
}

/**
 *  活动列表 por 1305
 *
 *  @param userId 用户中心中用户ID
 *
 *  @return 请求字典
 */
+ (NSMutableDictionary *)activityList
{
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:@"1305" forKey:@"por"];
    NSLog(@"activityList  = %@", [NSString stringWithFormat:@"%@?por=%@",CHONG_url,@"1305"]);
    return requestDic;
}

/************************************商城***************************************************/
/*
 "por" : "5001",     //请求接口  用户收货地址
 "user_id" : "1",     //用户ID
 “proIden”:“”，  //产品标识
 
 */

+ (NSString*)getAddressListWithUserID:(NSString*)userID
{
    NSLog(@"%@",[NSString stringWithFormat:@"%@?por=5001&proIden=%@&user_id=%@",SHANGCHENG_url,PROINDEN,userID]);
    return [NSString stringWithFormat:@"%@?por=5001&proIden=%@&user_id=%@",SHANGCHENG_url,PROINDEN,userID];
}

/*
 por" : "5003",     //请求接口
 "user_id" : "1",     //用户ID
 "id" : "***",     //地址id
 "action" : "***",     //1：删除、2：设置默认收货地址
 “proIden”:“”，  //产品标识
 */
+ (NSString*)setAddressWithUserID:(NSString*)userId andaddressId:(NSString*)addressId andAction:(NSString*)action
{
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@?proIden=%@&por=5003&&user_id=%@&id=%@&action=%@",SHANGCHENG_url,PROINDEN,userId,addressId,action]);
    return [NSString stringWithFormat:@"%@?proIden=%@&por=5003&&user_id=%@&id=%@&action=%@",SHANGCHENG_url,PROINDEN,userId,addressId,action];
}

//获取默认地址
+ (NSString *)userDefaultAddress:(NSString *)userid
{
    NSString *url = [NSString stringWithFormat:@"%@?por=5004&proIden=%@&user_id=%@",SHANGCHENG_url,PROINDEN,userid];
    return url;
}

/**
 *  获取商品收藏列表 por:506
 *
 *  @param userCenterId 用户中心id
 *  @param page         页码
 *  @param pageSize     页数
 *
 *  @return 字典
 */
+ (NSMutableDictionary*)goodsCollectionUserCenterId:(NSString*)userCenterId andPage:(NSString*)page andPageSize:(NSString*)pageSize
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"506" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(userCenterId) forKey:@"user_id"];
    [dict setObject:pageSize forKey:@"pageSize"];
    [dict setObject:IfNullToString(page) forKey:@"page"];
    NSLog(@"goodsCollection  = %@", [NSString stringWithFormat:@"%@?por=%@&proIden=%@&user_id=%@&page=%@&pageSize=%@",SHANGCHENG_url,@"506", PROINDEN, userCenterId, page, pageSize]);
    return dict;
}

/**
 *  删除商品收藏 por:507
 *
 *  @param userCenterId 用户中心id
 *  @param collectionId 商品id
 *
 *  @return 字典
 */
+ (NSMutableDictionary*)deleteGoodCollectionUserCenterId:(NSString*)userCenterId andCollectionId:(NSString*)collectionId
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"507" forKey:@"por"];
    [dict setObject:PROINDEN forKey:@"proIden"];
    [dict setObject:IfNullToString(userCenterId) forKey:@"user_id"];
    [dict setObject:IfNullToString(collectionId) forKey:@"obj_id"];
    NSLog(@"deleteGoodCollection  = %@", [NSString stringWithFormat:@"%@?por=%@&proIden=%@&user_id=%@&id=%@",SHANGCHENG_url,@"507", PROINDEN, userCenterId, collectionId]);
    return dict;
}

/**
 *  获取推荐商户信息
 *
 *  @param businessId 商户ID数字
 *
 *  @return 字典
 */

+ (NSMutableDictionary*)getBusinessInfo:(NSMutableArray *)businessId {
    NSString *json = [NSString stringWithFormat:@"{\"businessIdList\":[{\"contentId\":\"%@\"},{\"contentId\":\"%@\"}],\"page\":\"1\",\"rows\":\"10\"}",businessId[0],businessId[1]];
    NSLog(@"%@",json);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"queryBusinessList" forKey:@"method"];
    [dict setObject:json forKey:@"json"];
    return dict;
}

/**
 *  获取Banner商户信息
 *
 *  @param businessId 商户ID数字
 *
 *  @return 字典
 */

+ (NSMutableDictionary*)getBannerBusinessInfo:(NSMutableArray *)businessId {
    NSString *json = [NSString stringWithFormat:@"{\"businessIdList\":[{\"contentId\":\"%@\"},{\"contentId\":\"%@\"},{\"contentId\":\"%@\"}],\"page\":\"1\",\"rows\":\"10\"}",businessId[0],businessId[1],businessId[2]];
    NSLog(@"%@",json);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"queryBusinessList" forKey:@"method"];
    [dict setObject:json forKey:@"json"];
    NSLog(@"%@",dict);
    return dict;
}

/**
 *  获取商户收藏列表
 *
 *  @param userCenterId 用户中心id
 *  @param page         页码
 *  @param pageSize     页数
 *
 *  @return 字典
 */

+ (NSMutableDictionary*)merchantCollectionUserCenterId:(NSString*)userCenterId andPage:(NSString*)page {

    NSString * pageStr = [NSString stringWithFormat:@"%@",page];
    NSDictionary *parameter =@{@"oId":HUserId,@"page":pageStr,@"rows":@"10"};
    NSDictionary *dic = @{@"method":GET_MYCOLLECTIONLIST,@"json":[parameter JSONRepresentation]};
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:dic];
    return dict;
    
}
/**
 *  删除商户收藏
 *
 *  @param userCenterId 用户中心id
 *  @param collectionId 商品id
 *
 *  @return 字典
 */
+ (NSMutableDictionary*)deleteMerchantCollectionUserCenterId:(NSString*)userCenterId andCollectionId:(NSString*)collectionId {
    NSDictionary *parameter =@{@"oId":HUserId,@"collectionId":collectionId};
    NSDictionary *dic = @{@"method":DELETEMYCOLLECTION,@"json":[parameter JSONRepresentation]};
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:dic];
    return dict;
}

@end
