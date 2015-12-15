//
//  WalletHome.h
//  Wallet
//
//  Created by GDH on 15/10/21.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#ifndef Wallet_WalletHome_h
#define Wallet_WalletHome_h


#define WalletHomeLeftSize 15
#define  WalletHomeUpSize 13
//最大提现金额
#define MaxMoney  50000

//supView的背景颜色
#define WalletHomeBackGRD [UIColor colorWithRed:0.82f green:0.82f blue:0.82f alpha:1.00f];
// 导航栏的背景颜色
#define WalletHomeNAVGRD  [UIColor colorWithRed:0.84f green:0.18f blue:0.13f alpha:1.00f];
//  导航栏 title 字体大小
#define WalletHomeNAVTitleFont [UIFont systemFontOfSize:18];
// 导航栏 右侧按钮字大小
#define WalletHomeNAVRigthFont [UIFont systemFontOfSize:14]

// 圆角大小
#define walletHomeButtonLayer 10

#define WalletHomeHeadGRD [UIColor colorWithRed:0.98f green:0.73f blue:0.49f alpha:1.00f]
//标题栏的文字的颜色
#define WalletHomeNAVTitleColor [UIColor whiteColor]


#define WalletSP_Width [UIScreen mainScreen].bounds.size.width/320
#define WalletSP_height [UIScreen mainScreen].bounds.size.height/568

#ifdef DEBUG
#define DHLog(...) NSLog(__VA_ARGS__)
#else
#define DHLog(...)
#endif

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

/** 余额明细中的活动文字  */
#define AccountBalanceTitle           @"快来捞饺子，大奖等你拿！"
#define ShowMessage                   @"您的网络异常，请重新加载。"
#define ShowNoMessage                 @"暂无数据"
#define ShowMessageCorrectData        @"请输入正确的金额"

#define Wallet_PROINDEN               @"XN01_LNTV_HT"    //辣椒圈的产品标识

#define showMessageNOData             @"没有更多数据了"

#define HasPassWord                   @"isHasPassWord"

// 请求，模型（三方）SB 解析。
#import "WalletRequsetHttp.h"
#import "MJExtension.h"
#import "NSObject+SBJSON.h"

#define user_ID  [[NSUserDefaults standardUserDefaults]objectForKey:@"user"]

#define payMask RGBACOLOR(83, 83, 83, .7)


#define walletMybankimh_UrL                @"http://192.168.10.86:9902"


/** 钱包  地址*/
#define   WalletHttp                       @"http://192.168.10.86:8091/"
/** 加密服务器地址 */
#define   WalletHttp_encryption            @"http://192.168.10.86:8093/"



//#define   WalletHttp_TopUp                 @"http://192.168.10.162:8091/"

//#define   wallte162                       @"http://192.168.10.162:8081/"

//#define   wallte110                       @"http://192.168.10.204:8081/"

/** 1001 余额  */
#define   WalletHttp_Balance               [NSString stringWithFormat:@"%@wallet/getBalance?json=",WalletHttp]
/** 1002  获取余额明细列表 */
#define   WalletHttp_BalanceDetail         [NSString stringWithFormat:@"%@balance/getDetail?json=",WalletHttp]

/** 获取手机验证码接口1113 */
#define   WalletHttp_getCode               [NSString stringWithFormat:@"%@pay/getCode.do?json=",WalletHttp]
/** 1003. 设置支付密码 */
#define   WalletHttp_setPassword1003       [NSString stringWithFormat:@"%@pay/setPassword?json=",WalletHttp]
/** 1004. 验证支付密码 */
#define   WalletHttp_checkPassword1004     [NSString stringWithFormat:@"%@pay/checkPassword?json=",WalletHttp]
/** 1010. 添加银行卡 */
#define   WalletHttp_addBankCard           [NSString stringWithFormat:@"%@wallet/addBankCard?json=",WalletHttp]

#warning 这的请求头需要更换
/** 1007. 提现 */
#define   WalletHttp_Record1107            [NSString stringWithFormat:@"%@tixian/getMoney?json=",WalletHttp]

/** 1108. 获取充值/提现记录 */
#define   WalletHttp_Record1108            [NSString stringWithFormat:@"%@money/getDrawMoneyLog?json=",WalletHttp]

#define   WalletHttp_CancelBound1111       [NSString stringWithFormat:@"%@bank/CancelBound?json=",WalletHttp]
/** 1112. 获取用户银行卡列表 */
#define   WalletHttp_BankCardList1112      [NSString stringWithFormat:@"%@bankcardlist/getBankCardList.do?json=",WalletHttp]

/** 1109. 获取提现支持的银行列表 */
#define   WalletHttp_getBankCardList1109   [NSString stringWithFormat:@"%@bankcardlist/getBankCardList?json=",WalletHttp]

/** 1115 接口获取银行卡详情  */
#define WalletHttp_getBankCardDetail1115   [NSString stringWithFormat:@"%@bank/getBankCardDetail?json=",WalletHttp]

/** 110 接口获取密码错误次数的接口请求串  */
#define WalletHttp_getPassWordErrorNum110  [NSString stringWithFormat:@"%@wallet/getErrNum?json=",WalletHttp]

/** 120 接口获取密钥的请求接口  */
#define WalletHttp_getPassWordKey120       [NSString stringWithFormat:@"%@encrypt/getkey",WalletHttp_encryption]

#endif



