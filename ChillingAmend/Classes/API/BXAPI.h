//
//  BXAPI.h
//  黑土
//
//  Created by BobNee on 14-1-14.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPCommonMacros.h"

@interface BXAPI : NSObject

////测试地址
//#define CHONG_url @"http://192.168.10.11:2039/app/"
//#define img_url @"http://192.168.10.11:2039/"
//
//#define GAME_URL @"http://192.168.10.11:2005"
//#define activity_url @"http://192.168.10.11:93"

////线上测试地址
//#define CHONG_url @"http://php.test.sinosns.cn/app/"
//#define img_url @"http://php.test.sinosns.cn/"
////
//#define GAME_URL @"http://192.168.10.11:2005"
//#define activity_url @"http://192.168.10.11:93"

//线上地址
#define CHONG_url @"http://ht.sinosns.cn/app/"
#define img_url @"http://ht.sinosns.cn"

#define GAME_URL @"http://game.sinosns.cn"
//#define activity_url @"http://192.168.10.11:2039/"
#define activity_url @"http://ht.sinosns.cn"

//商城测试地址
//#define SHANGCHENG_url @"http://192.168.10.11:8013/app_v1.3.0/?"
//#define imageViewUrl @"http://192.168.10.11:8013/"

//商城线上test
#define imageViewUrl @"http://mall.sinosns.cn/"
#define SHANGCHENG_url @"http://mall.sinosns.cn/app_v1.3.0/?"

//商城test环境访问地址

//#define  SHANGCHENG_url  @"http://malltest.sinosns.cn/app_v1.2.0/?"


//// 商城线上地址
//#define SHANGCHENG_url @"http://mall.sinosns.cn/app_v1.2.0/?"
//#define SHANGCHENG_img_url @"http://mall.sinosns.cn/app_v1.2.0"

//#define SHANGCHENG_url @"http://mall.sinosns.cn/app_v1.3.0/?"
//#define imageViewUrl @"http://mall.sinosns.cn/"
//#define SHANGCHENG_img_url @"http://mall.sinosns.cn/app_v1.3.0"

// 获取个人资料
+ (NSMutableDictionary *)personMessageUserId:(NSString*)userId;
// 修改用户头像
+ (NSMutableDictionary *)changeHeadImageUserId:(NSString*)userId andPic:(NSString*)pic;
// 修改昵称
+ (NSMutableDictionary *)changeNicknameUserId:(NSString*)userId andNike_name:(NSString*)nike_name;
// 修改性别
+ (NSMutableDictionary *)changeSexUserId:(NSString*)userId andSex:(NSString*)sex;
// 修改密码
+ (NSMutableDictionary *)changePassworduserId:(NSString*)userId andOld_password:(NSString*)old_password andNew_password:(NSString*)new_password;
// 添加个性标签
+ (NSMutableDictionary *)addHotwordUserId:(NSString*)userId andTag:(NSString*)tag;
// 修改个性标签
+ (NSMutableDictionary *)changeHotwordUserId:(NSString*)userId andOld_tag:(NSString*)old_tag andNew_tag:(NSString*)new_tag;
// 删除个性标签
+ (NSMutableDictionary *)deleteHotwordUserId:(NSString*)userId andTag:(NSString*)tag;
// 修改个人签名
+ (NSMutableDictionary *)changeSignatureUserId:(NSString*)userId andSignature:(NSString*)signature;
// 消息列表
+ (NSMutableDictionary *)messageListUserId:(NSString*)userId andType:(NSString*)type andStatus:(NSString*)status;
// 关于我们
+ (NSMutableDictionary *)aboutUs;
// 意见反馈
+ (NSMutableDictionary *)userFeedbackUserId:(NSString*)userId andUser_mail:(NSString*)user_mail andContent:(NSString*)content;
// 检测更新
+ (NSMutableDictionary *)checkUpdateType:(NSString*)type;
// 背景图片
+ (NSMutableDictionary *)changeBgImageUserId:(NSString*)userId andBackground:(NSString*)background andType:(NSString*)type;
// 第三方分享绑定
+ (NSMutableDictionary *)shareBindingUserId:(NSString*)userId andType:(NSString*)type;
// 奖品列表
+ (NSMutableDictionary *)prizeListUserId:(NSString*)userId;
// 领奖方式
+ (NSMutableDictionary *)prizeType:(NSString*)type andPrizeId:(NSString*)prizeId andDay:(NSString*)day;
// 奖品详情
+ (NSMutableDictionary *)prizeMessagePrizeId:(NSString*)prizeId;
// 手机是否验证
+ (NSMutableDictionary *)phoneIsValidationUserId:(NSString*)userId;
// 领奖验证手机
+ (NSMutableDictionary *)phoneCheckUserId:(NSString*)userId andCode:(NSString *)code andPhone:(NSString *)phone;
// 修改邮箱
+ (NSMutableDictionary *)changEmailUserId:(NSString*)userId andEmail:(NSString*)email;
// 修改生日
+ (NSMutableDictionary *)changeBirthUserId:(NSString*)userId andBirthday:(NSString*)birthday;
// 修改居住地区
+ (NSMutableDictionary *)changeAreaUserId:(NSString*)userId andAddress:(NSString*)address;
// 获取验证码
+ (NSMutableDictionary *)getValidCodePhone:(NSString*)iphone andType:(NSString*)type;
// 登录
+ (NSMutableDictionary *)loginUser_name:(NSString *)user_name andPassword:(NSString*)password;
// 注册
+ (NSMutableDictionary *)registerUserName:(NSString*)userName andNickName:(NSString*)nickName andPassword:(NSString*)password andValidCode:(NSString*)validCode andChannel:(NSString*)channel;
// 邮箱找回密码
+ (NSMutableDictionary *)mailFindPasswordType:(NSString *)type andUser_mail:(NSString*)user_mail;
// 手机找回密码
+ (NSMutableDictionary *)phoneFindPasswordType:(NSString *)type andUser_phone:(NSString*)user_phone;
// 完善资料
+ (NSMutableDictionary *)perfectInformationUserName:(NSString*)userName andEmail:(NSString*)email andBirthday:(NSString*)birth andSex:(NSString*)sex;
// 手机密码找回之前的验证
+ (NSMutableDictionary *)getResetPasswordPhoneNum:(NSString*)phoneNum andCode:(NSString*)validCode;
// 重置密码
+ (NSMutableDictionary *)resetPasswordUserName:(NSString*)userName andPassword:(NSString*)password andAgainPassword:(NSString*)againPassword;
// 用户消息
+ (NSMutableDictionary *)personMessageUserId:(NSString*)userId andPageSize:(NSString*)pageSize andPage:(NSString*)page;
// 视频首页
+ (NSMutableDictionary *)videoHomepageUserId:(NSString*)userId andSize:(NSString*)size andPeriods:(NSString*)periods;
// 视频加载更多
+ (NSMutableDictionary *)loadingMoreVideoUserId:(NSString*)userId andSize:(NSString*)size andPeriods:(NSString*)periods andPage:(NSString*)page;
// 视频列表
+ (NSMutableDictionary *)videoListUserId:(NSString*)userId andSize:(NSString*)size andDay:(NSString*)day andpage:(NSString*)page;
// 视频详情
+ (NSMutableDictionary *)videoMessageUserId:(NSString*)userId andVideoId:(NSString*)videoId;
// 微视频点赞/收藏
+ (NSMutableDictionary *)videoPraiseAndCollectionUserId:(NSString*)userId andObjId:(NSString*)objId andJoinType:(NSString*)joinType andObjType:(NSString *)objType;
// 推荐视频
+ (NSMutableDictionary *)recommendedVideoUserId:(NSString*)userId andSize:(NSString*)size andpage:(NSString*)page andPlayingVideoID:(NSString *)videoId;
// 看视频加积分
+ (NSMutableDictionary *)videoAddCoinUserId:(NSString*)userId andVideoId:(NSString*)videoId;
// 规则
+ (NSMutableDictionary *)ruleType:(NSString*)type;
// 分享内容
+ (NSMutableDictionary *)shareContentType:(NSString*)type;
// 首页
+ (NSMutableDictionary *)homePageUserId:(NSString*)userId;
// 个人收藏
+ (NSMutableDictionary *)collectionUserId:(NSString*)userId andType:(NSString*)type andPage:(NSString*)page andSize:(NSString*)size;
// 天天宝箱首页
+ (NSMutableDictionary *)dayChestId:(NSString*)activityId andUserId:(NSString*)userId;
// 天天宝箱开启宝箱
+ (NSMutableDictionary *)openTheDayChestWithUserID:(NSString *)userID andActivityId:(NSString*)activityId;
// 游戏列表
+ (NSMutableDictionary *)gameList;
// 摇一摇活动情况
+ (NSMutableDictionary *)yaoYiYaoDetailsWithUserID:(NSString *)userID;
// 摇一摇摇奖
+ (NSMutableDictionary *)yaoYiYaoOpenAwardsWithUserID:(NSString *)userID andActivityId:(NSString*)activityId;
// 摇一摇接受token值
+ (NSMutableDictionary *)yaoYiYaoReceiveTokenWithUserID:(NSString *)userID;
// 摇一摇背景图片
+ (NSMutableDictionary *)yaoYiYaoBackGroundImageWithResolution:(NSString *)Resolution;


// 刮刮乐  列表
+ (NSMutableDictionary *)guaGuaLeListWithUserID:(NSString *)userID;
// 刮刮开始
+(NSMutableDictionary *)guaGuaLeStartScratchuserId:(NSString *)userId suiji:(NSString *)suiji;
// 刮刮结束
+(NSMutableDictionary *)guaGuaLeEnduserId:(NSString *)userId suiji:(NSString *)suiji;
// 获取奖品
+(NSMutableDictionary *)guaGuaLePremiumUserid:(NSString*)userid fanwei:(NSString *)fanwei classid:(NSString *)classid;
// 刮刮乐-积分兑换刮奖
+(NSMutableDictionary *)guaGuaLeExchangeJiFenForChangcesWithUserid:(NSString*)userid;


// 转盘  奖品列表
+ (NSMutableDictionary *)zhuanPanAwardListWithUserID:(NSString *)userID;
// 转盘  中奖信息
+ (NSMutableDictionary *)zhuanPanAwardDetailsWithUserID:(NSString *)userID;
// 转盘  启动页广告
+ (NSMutableDictionary *)advertiseMentForAppStartWithResolution:(NSString *)Resolution;
// 转盘  积分兑换抽奖中奖信息
+ (NSMutableDictionary *)zhuanPanZhongJiangDetailsWithUserID:(NSString *)userID;

// 取消点赞、收藏
+ (NSMutableDictionary *)ZanOrCollectionCancleWithUserID:(NSString *)userID andObjId:(NSString *)objId andJoinType:(NSString *)joinType andObjectType:(NSString *)objType;
// APP活动场分享获取积分
+ (NSMutableDictionary *)addJifenUserCenterId:(NSString*)userId;
// 活动列表
+ (NSMutableDictionary *)activityList;

/*******************************************商城********************************************/
// 收货人地址
+(NSString*)getAddressListWithUserID:(NSString*)userID;
// 对地址的操作
+(NSString*)setAddressWithUserID:(NSString*)userId andaddressId:(NSString*)addressId andAction:(NSString*)action;
// 获取用户默认地址
+(NSString *)userDefaultAddress:(NSString *)userid;
// 获取商品收藏列表
+ (NSMutableDictionary*)goodsCollectionUserCenterId:(NSString*)userCenterId andPage:(NSString*)page andPageSize:(NSString*)pageSize;
// 删除商品收藏
+ (NSMutableDictionary*)deleteGoodCollectionUserCenterId:(NSString*)userCenterId andCollectionId:(NSString*)collectionId;

// 获取推荐商户信息
+ (NSMutableDictionary*)getBusinessInfo:(NSMutableArray *)businessId;

// 获取banner商户信息
+ (NSMutableDictionary*)getBannerBusinessInfo:(NSMutableArray *)businessId;

// 获取商品收藏列表
+ (NSMutableDictionary*)merchantCollectionUserCenterId:(NSString*)userCenterId andPage:(NSString*)page;
// 删除商品收藏
+ (NSMutableDictionary*)deleteMerchantCollectionUserCenterId:(NSString*)userCenterId andCollectionId:(NSString*)collectionId;
@end
