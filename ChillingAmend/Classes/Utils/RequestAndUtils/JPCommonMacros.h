//
//  JPCommonMacros.h
//  JiPiao
//
//  Created by pipixia on 13-9-5.
//  Copyright (c) 2013年 pipixia. All rights reserved.

#import "GCViewController.h"

#ifndef iTotemFrame_ITTCommonMacros_h
#define iTotemFrame_ITTCommonMacros_h
////////////////////////////////////////////////////////////////////////////////
#pragma mark - shortcuts

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

////////////////////////////////////////////////////////////////////////////////
#pragma mark - common functions 

#define RELEASE_SAFELY(__POINTER) { if(__POINTER) {[__POINTER release]; __POINTER = nil; }}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - color functions 

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

////////////////////////////////////////////////////////////////////////////////
#pragma mark - iPhone4

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kkViewHeight [[UIScreen mainScreen] bounds].size.height-20

#define HHnavigationHeight self.navigationController.navigationBar.bounds.size.height+ios7-10

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ?20:0)

#define kkViewWidth [[UIScreen mainScreen] bounds].size.width

#define kkAColor [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] // 黑
#define kkBColor [UIColor colorWithRed:104/255.0 green:104/255.0 blue:104/255.0 alpha:1.0] // 深灰
#define kkCColor [UIColor colorWithRed:141/255.0 green:141/255.0 blue:141/255.0 alpha:1.0] // 浅灰
#define kkDColor [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0] // 背景    
#define kkRColor [UIColor colorWithRed:61/255.0 green:66/255.0 blue:69/255.0 alpha:1.0] // 右上角button颜色

#define CreatImage(imagePath) [UIImage imageNamed:imagePath]

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue] //判断版本号码

#define ScreenWidth [UIScreen mainScreen].bounds.size.width //屏幕的宽度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height//屏幕的高度
#define isIos7 [[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO) //判读是否是640*1136的屏幕
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ?20:0)//判读时候是IOS7以上的系统
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ?20:0)//判读时候是IOS8以上的系统
#define NAVBARHEIGHT _navigationBarView.frame.size.height //导航的高度

#define ORIGIN_X(o_x) o_x.frame.origin.x  //x
#define ORIGIN_Y(o_y) o_y.frame.origin.y  //y
#define FRAMNE_W(f_w) f_w.frame.size.width //width
#define FRAMNE_H(f_h) f_h.frame.size.height//height
#define IfNullToString(x)       ([(x) isEqual:[NSNull null]]||(x)==nil)?@"":TEXTString(x) //判断字段时候为空的情况
#define TEXTString(x) [NSString stringWithFormat:@"%@",x]  //转换为字符串

#define PROINDEN @"XN01_LNTV_HT"                //黑土的产品标识
//#define PROINDEN @"cf18f7feae8a9e6daa1876e1383fffea"   //食话食说的产品标识

#define B_JIFEN @"B_JIFEN"                      //定义积分的弘

#define APP_LOGIN_STATUS @"APP_LOGIN_STATUS" // 是否已经登录

// 友盟统计
#define CHANNEL_Appstore @"appstore"
#define CHANNEL_Enterprise @"ios_sino"

#endif
