//
//  LaoYiLaoMacro.h
//  LaoYiLao
//
//  Created by sunsu on 15/10/29.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#ifndef LaoYiLaoMacro_h
#define LaoYiLaoMacro_h

#import "LaoYiLaoBaseViewController.h"
#import "LaoYiLao_URL.h"
#import "LYLAFNetWorking.h"
#import "LYLHttpTool.h"
#import "AFNetworking.h"
#import "UIViewController+HUD.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"


#define TARGET_IPHONE_DEBUG   //ZHLog打印开关，打开即可打印

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define IS_IPHONE6_PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//永久保存的数据
#define MySetObjectForKey(object,key) [[NSUserDefaults standardUserDefaults]setObject:object forKey:key]//赋值
#define MyObjectForKey(key) [[NSUserDefaults standardUserDefaults]objectForKey:key]//取值
#define IsStrWithNUll(str) [str isEqualToString:@""] || !str || [str isEqual:[NSNull null]]
#define IsStrWithNONull(str) ![str isEqual:@""] && str //不为空
 //判断为空

//是不是第一次进入应用
#define IsFirstKey @"IsFirstKey"//是不是第一次的key
#define IsFirstYES @"1"//是第一次
#define IsFirstNO @"0"//不是第一次





#define UserIDKey @"UserIDKey"//登陆人userid保存的key
#define LoginPhoneKey @"LoginPhoneKey"//登录人手机号key

#define LYLUserId  MyObjectForKey(UserIDKey)//登陆的UserId
#define LYLPhone   MyObjectForKey(LoginPhoneKey)//登陆的手机号
//#define LYLIsNOLoging IsStrWithNUll(LYLUserId) //未登录
#define LYLIsLoging IsStrWithNONull(LYLUserId)//已登陆

//分享界面类型
#define ShareTypeKey @"ShareTypeKey"
#define ShareTypeWithBounce @"1"
#define ShareTypeWithNavBar @"2"
#define ShareTypeWithMyDumpling @"3"


#define DumplingNoLogingTimeKey @"DumplingTimeKey" // 未登录上一次捞饺子时间
#define DumplingInforNoLogingPath [NSString stringWithFormat:@"%@/Library/DumplingInforWithNOLoging.plist",NSHomeDirectory()]//未登录饺子Path



#define DumplingLogingKey @"DumplingTimeLogingKey" //登录状态捞饺子存的key
#define DumplingInforLogingPath [NSString stringWithFormat:@"%@/Library/DumplingInforWithLoging.plist",NSHomeDirectory()] //登陆饺子path


#define kkViewWidth [[UIScreen mainScreen] bounds].size.width
#define kkViewHeight [[UIScreen mainScreen] bounds].size.height
#define KPercenX    (kkViewWidth / 320.0)
#define KPercenY    (kkViewHeight / 568.0)
#define NavgationBarHeight 64
#define TabBarHeight 60
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define BackColor [UIColor colorWithRed:0.22f green:0.20f blue:0.20f alpha:0.8f];

#define UIFont10 [UIFont systemFontOfSize:5]
#define UIFont20 [UIFont systemFontOfSize:10]
#define UIFont22 [UIFont systemFontOfSize:11]
#define UIFont24 [UIFont systemFontOfSize:12]
#define UIFont26 [UIFont systemFontOfSize:13]
#define UIFont28 [UIFont systemFontOfSize:14]
#define UIFont30 [UIFont systemFontOfSize:15]
#define UIFont32 [UIFont systemFontOfSize:16]
#define UIFont36 [UIFont systemFontOfSize:18]
#define UIFont40 [UIFont systemFontOfSize:20]
#define UIFont50 [UIFont systemFontOfSize:25]
#define UIFontBild60 [UIFont boldSystemFontOfSize:30]
#define UIFontBild34 [UIFont boldSystemFontOfSize:17]
//#define UIFontBild40 [UIFont boldSystemFontOfSize:20]
#define UIFontBild30 [UIFont boldSystemFontOfSize:15]

#define PosterHeight   0  // KPercenY * 140/2
#define SelectSwitchX 5

//#define SwitchHeight  KPercenY * 62 / 2
#define SwitchHeight   62 / 2


#define SessionValue [LYLTools getPhoneUuid]  //手机IMEI
#define SysType  @"3"    //手机系统是iOS





#endif /* LaoYiLaoMacro_h */
