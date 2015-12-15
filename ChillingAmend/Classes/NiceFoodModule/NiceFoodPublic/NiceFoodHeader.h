//
//  NiceFoodHeader.h
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/2.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#ifndef PRJ_NiceFoodModule_NiceFoodHeader_h
#define PRJ_NiceFoodModule_NiceFoodHeader_h

#import "AFHTTPRequestOperationManager.h"
#import "MJExtension.h"
#import "Url_NiceFood.h"
#import "Parameter.h"
#import <BaiduMapAPI/BMapKit.h>
#import "AFRequest.h"
#import <AlipaySDK/AlipaySDK.h>


#import "StaticPublic.h"



//百度云检索key
//#define BD_AK @"GWIL5qn0nLqf8f03Kvr3HLVp"
//#define MAPID @"89546"
#define BD_AK @"xYoOHgE0dvFkPRM1GoYz555y"
#define MAPID @"113614"
//#define MAPID @"113611"

//#define BD_MAP @"9RZG56CIK1faPWGVxCqFBerm"
#define BD_MAP @"xDkekB1FUG8XZmfcoemPHVnA"

#define ProIden @"2"

//支付宝scheme
#define AliPayScheme @"HeiTuDiApp"

// 判断是否为iOS7以上系统
#define iOS7 ([UIDevice currentDevice].systemVersion.doubleValue >= 7.0)

// 获取RGB颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

//外卖模块各类信息栏View的高度
#define ViewHeight 50

//userId的key
//#define UserId @"userid"
#define HUserId kkNickDicPHP[@"userid"]

//获取用户手机号
#define PhoneNumber kkNickDicPHP[@"user_name"]

// 筛选菜单按钮
#define TopMenuH (44-10)
#define TopMenuItemW (SCREEN_WIDTH/3)

// 导航栏高
#define NavigationH 65

// 取屏幕宽、高
#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)

//获取经纬度
#define LONGITUDE [[NSUserDefaults standardUserDefaults] floatForKey:@"longitude"]
#define LATITUDE  [[NSUserDefaults standardUserDefaults] floatForKey:@"latitude"]

//获取城市id
//#define City_Id [[NSUserDefaults standardUserDefaults] stringForKey:@"cityId"]?[[NSUserDefaults standardUserDefaults] stringForKey:@"cityId"]:@"110100"
//获取城市id
#define City_Id [[NSUserDefaults standardUserDefaults] stringForKey:@"cityId"]?[[NSUserDefaults standardUserDefaults] stringForKey:@"cityId"]:@"500100"

//城市名称
#define CityName [[NSUserDefaults standardUserDefaults] stringForKey:@"CityName"]

//购物车一级列表占屏宽比例
#define ListScale 0.3

//筛选菜单比例
#define TableScale 0.4 //一级菜单占屏宽比例
#define TableHightScale 0.7 //占屏高比例

//#define DefaultPicture @"morenshop.png"
#define DefaultPicture @"default_pictrue.png"
#define FailLoadPicture @"shibai_pictrue.png"

#endif
