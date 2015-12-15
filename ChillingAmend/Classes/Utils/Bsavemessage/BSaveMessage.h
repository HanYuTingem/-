//
//  BSaveMessage.h
//  HealthExamine
//
//  Created by pipixia on 13-10-25.
//  Copyright (c) 2013年 SinoTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPCommonMacros.h"

@interface BSaveMessage : NSObject
/**
 用户信息
 */
@property (nonatomic, retain) NSString *userId; // 黑土本地id
@property (nonatomic, retain) NSString *userCenterId; // 用户中心id
@property (nonatomic, retain) NSString *userName; // 用户名
@property (nonatomic, retain) NSString *nickName; // 昵称
@property (nonatomic, retain) NSString *userRemark; // 个性签名
@property (nonatomic, retain) NSString *userTag; // 标签
@property (nonatomic, retain) NSString *userBackground; // 背景图片
@property (nonatomic, retain) NSString *userImage; // 用户头像
@property (nonatomic, retain) NSString *userSex; // 性别
@property (nonatomic, retain) NSString *userType;//0 普通   1记者
//@property(nonatomic,retain)NSString *userHide;
@property (nonatomic, retain) NSString *jifen; // 积分
//@property(nonatomic,retain)NSString *password;
@property (nonatomic, strong) NSString * quyu; // 居住地
@property (nonatomic, strong) NSString * shengri; // 生日
@property (nonatomic, strong) NSString * emial; // 邮箱
@property (nonatomic, retain) NSString * userHostUrl;
+ (BSaveMessage *)Share;

/**
 用户信息 定义宏变量
 */
#define kkUserInfo [BSaveMessage Share]
#define kkUserId [BSaveMessage Share].userId
#define kkUserCenterId [BSaveMessage Share].userCenterId
#define kkUserName [BSaveMessage Share].userName
#define kkUserNickName [BSaveMessage Share].nickName
#define kkUserRemark [BSaveMessage Share].userRemark
#define kkUserTag [BSaveMessage Share].userTag
#define kkUserbackground [BSaveMessage Share].userBackground
#define kkUserImage [BSaveMessage Share].userImage
#define kkUserSex [BSaveMessage Share].userSex
//#define kkUserSecurity [BSaveMessage Share].security
#define kkUserType [BSaveMessage Share].userType
#define kkUserJifen [BSaveMessage Share].jifen
#define kkUserquyu [BSaveMessage Share].quyu
#define kkUsershengri [BSaveMessage Share].shengri
#define kkUseremial [BSaveMessage Share].emial
#define KKUserHostUrl [BSaveMessage Share].userHostUrl
//#define kkUserHide [BSaveMessage Share].userHide
- (void)resetInfo:(NSDictionary*)aDict;
- (void)clearInfo;

+ (void)saveUserMessage:(NSDictionary *)userMsg;
+ (void)clear;


@end
