//
//  StaticPublic.h
//  PRJ_NiceFoodModule
//
//  Created by sunsu on 15/6/15.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#ifndef PRJ_NiceFoodModule_StaticPublic_h
#define PRJ_NiceFoodModule_StaticPublic_h


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "BasisImageView.h"

#import "SBJSON.h"
#import "TagDefine.h"
#import "NSObject+SBJSON.h"
#import "MJExtension.h"
#import "GCUtil.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import "AFHTTPRequestOperationManager.h"
#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件

#import <BaiduMapAPI/BMKMapView.h>//只引入所需的单个头文件

#import "AFRequest.h"
#import "ZNLog.h"
#import "MJConst.h"
#import "MJRefresh.h"
#import "UIView+ITTAdditions.h"
#import "UMSocial.h"
#import "MyUtils.h"

#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)

#define SCALE_WIDTH(w) (SCREEN_WIDTH/320.0*w)
#define SCALE_HEIGHT(h) (SCREEN_HEIGHT/568.0*h)



#define RECTFIX_WIDTH(a) (IS_IPHONE4 ? a : SCALE_WIDTH(a))
#define RECTFIX_HEIGHT(a) (IS_IPHONE4 ? a : SCALE_HEIGHT(a))

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define IS_IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE6_PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define APPLICATION ((AppDelegate *)[[UIApplication sharedApplication] delegate])



//#define IOS_VERSION [UIDevice currentDevice].systemVersion

#define UIColorFromRGB(rgbValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#define ShopNameFont [UIFont systemFontOfSize:15.0f]
#define DescriptFont [UIFont systemFontOfSize:12.0f]

//用户名
//#define USER_NAME @"18784160098"
#define USER_ID  HUserId               //用NSUSERDEFUALT保存的值

//版本
#define Version [[[UIDevice currentDevice] systemVersion] floatValue]

//间距
#define PADDING  RECTFIX_WIDTH(10)

#define IfNullToString(x)       ([(x) isEqual:[NSNull null]]||(x)==nil)?@"":TEXTString(x)



#define TARGET_IPHONE_DEBUG   //是否调试 注释掉即为不打印信息



#endif
