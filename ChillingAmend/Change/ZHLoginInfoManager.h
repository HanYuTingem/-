//
//  ZHLoginInfoManager.h
//  LaoYiLao
//
//  Created by wzh on 15/11/30.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>

//登陆的type
#define LOGINGTYPE 2 //1 只调java 2. 先调java后调php 不同app类型不同
#define ProductCode @"XN01_LNTV_HT"   //每个app对应自己的产品标识

//应用需要传入的Key
/****   友盟分享  *****/
#define LYL_UM_KEY      @"565d3d56e0f55a169f0004c3"  //@"5328fbfa56240b9ada067458"
#define QQ_APPID        @"1104996522"  //"1101248410"
#define QQ_APPKEY       @"fLQqwcFnOaY026fi"  //"c7394704798a158208a74ab60104f0ba"
#define WX_APPID        @"wx68cbf500fcda3024"     //"wx1611bbef8acfa7ca"
#define WX_AppSecret    LYL_UM_KEY
#define WB_APPKEY       LYL_UM_KEY
#define OpenSSOWithRedirectURL @"http://sns.whalecloud.com/sina2/callback"



//Php登陆正式接口 不同app接口不同需要更改
#define WZHLogingPHPWithUrl @"http://ht.sinosns.cn/app/"


//Php登陆测试接口 不同app接口不同需要更改
//#define WZHLogingPHPWithUrl @"http://192.168.10.11:2019/app/"


@interface ZHLoginInfoManager : NSObject

/**
 *  保存PHP登陆信息
 *
 *  @param json PHP登陆成功后返回的信息
 */
+ (void)addSavePHPCacheInLoginWithJson:(id)json;
/**
 *  保存java登陆信息
 *
 *  @param json  java登陆成功后返回的信息
 */
+ (void)addSaveJavaCacheInLoginWithJson:(id)json;


/**
 *  清除缓存并标记退出登陆
 */
+ (void)removeCacheAndOutLogin;
@end
