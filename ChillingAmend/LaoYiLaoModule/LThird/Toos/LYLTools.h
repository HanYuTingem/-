//
//  Toos.h
//  LaoYiLao
//
//  Created by wzh on 15/10/29.
//  Copyright (c) 2015年 王兆华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DumplingInforModel.h"
#import "UIDevice+IdentifierAddition.h"
#import "BouncedView.h"




#define ZHLog(s, ...)  [LYLTools file:__FILE__ function: (char *)__FUNCTION__ lineNumber:__LINE__ format:(s),##__VA_ARGS__]

/** 网络判断提示语 */
//#define WIFI @"正在使用Wifi"
//#define WWAN @"正在使用蜂窝移动网络"
//#define NotReachable @"当前无网络"

typedef void (^connectedToNetBlock)(NSString *connectedToNet);
//按钮的

@class WZHButton;
typedef void(^MyBlock)(WZHButton *button) ;
@interface WZHButton : UIButton
+ (WZHButton *)buttonWithFrame:(CGRect)frame
                     fontSize:(int)size
                        title:(NSString *)title
                         type:(UIButtonType)type
                          tag:(int)tag
              backgroundImage:(NSString *)backgroundImage
                        image:(NSString *)image
                     andBlock:(MyBlock)myBlock;

+ (WZHButton *)buttonWithFrame:(CGRect)frame
                     fontSize:(int)size
                        title:(NSString *)title
                        image:(NSString *)image
                     andBlock:(MyBlock)myBlock;

+ (WZHButton *)buttonWithFrame:(CGRect)frame
                     fontSize:(UIFont *)fontsize
                        title:(NSString *)title
        backgroundSelectImage:(NSString *)backgroundSelectImage
        backgroundNormalImage:(NSString *)backgroundNormalImage
                     andBlock:(MyBlock)myBlock;
@end

@interface LYLTools : NSObject

/**
 *  快捷打印
 *
 *  @param sourceFile   文件夹名字
 *  @param functionName 类名
 *  @param lineNumber   多少行
 *  @param format       格式
 */
+(void)file:(char*)sourceFile function:(char*)functionName lineNumber:(int)lineNumber format:(NSString*)format, ...;


/**
 *  字符串的内容大小
 *
 *  @param strTest 字符串
 *  @param width   字符串宽度
 *  @param font    字体大小
 *
 *  @return 字符串的内容大小
 */
+ (CGSize)contentSizeWithLabString:(NSString*)strTest labelWidth:(CGFloat)width font:(UIFont *)font;
/**
 *  已知字符串高度求宽度
 *
 *  @param str         字符串
 *  @param labelHeight 字符串的高度
 *  @param font       字体大小
 *
 *  @return 字符串的宽度
 */
+ (float)labWithStringW:(NSString*)str andLabelHeight:(float)labelHeight andFontSize:(UIFont *)font;


/**
 *  已知字符串的宽度求高度
 *
 *  @param string  字符串
 *  @param labStrW 字符串的宽度
 *  @param font    字体大小
 *
 *  @return 字符串的高度
 */
+ (CGFloat)boundingRectWithStrH:(NSString*)string labStrW:(CGFloat)labStrW andFont:(UIFont *)font;

/**
 *  已知字符串的高度求宽度
 *
 *  @param string  字符串
 *  @param labStrH 字符串的高度
 *  @param font    字体大小
 *
 *  @return 字符串的宽度
 */
+ (CGFloat)boundingRectWithStrW:(NSString*)string labStrH:(CGFloat)labStrH andFont:(UIFont *)font;

/*
 * 网络状态返回字符串
 */
+(void)connectedToNetwork:(connectedToNetBlock)type;

/**
 *  监听网络状态的改变
 *
 *  @param didConnectionStateChanged 网络状态改变的回调
 */
+ (void)didConnectionStateChangedBlock:(void(^)(AFNetworkReachabilityStatus netWorkStatusChangeBlock))didConnectionStateChanged;

/**
 *  监听网络连接成功与否
 *
 *  @param connectionSuccessful 网络连接成功回调
 *  @param connectionFailure    网络链接失败回调
 */
+ (void)didConnectionStateChangedIsSuccessful:(void (^)())connectionSuccessful andFailure:(void(^)())connectionFailure;

/**
 *  监听网络连接成功与否 回调网络状态对象
 *
 *  @param connectionSuccessfulWithState 网络连接成功回调的状态 回调对象出去
 *  @param connectionFailure             网络链接失败回调
 */
+ (void)didConnectionStateChangedIsSuccessfulStatus:(void (^)(AFNetworkReachabilityStatus networkStatus))connectionSuccessfulWithState andFailure:(void(^)())connectionFailure;

/**
 *  网络状态改变
 *
 *  @param didConnectionStateChanged 回调
 */
+ (void)didConnectionStateChanged:(void (^)())didConnectionStateChanged;
//字典转字符串
+(NSString *)JsonWithDict:(NSDictionary*)dict;

/**
 *  提示框
 *
 *  @param aInfo 提示信息
 */
+ (void)showInfoAlert:(NSString*)aInfo;


/**
 *  拉伸图片
 *
 *  @param name 图片名字
 *
 *  @return 拉伸后图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

/**
 *  拉伸图片
 *
 *  @param aImage 图片Image
 *  @param aSize  拉伸的大小
 *
 *  @return 拉伸后图片
 */
+ (UIImage*)scaleImage:(UIImage*)aImage ToSize:(CGSize)aSize;

/**
 *  手机号验证
 *
 *  @param mobileNum 手机号
 *
 *  @return 是否为手机号 yes 是
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  获取当期时间 天
 *
 *  @return 返回天
 */
+ (NSString *)currentDateWithDay;

+ (NSMutableArray *)modelArrayWithJson:(NSMutableArray *)array;



/**
 *  移除弹框
 *
 *  @param vc 哪一个vc
 */
+ (void)removeBounceViewWithVC:(UIViewController *)vc;


/**
 *  获得手机串号
 *
 *  @return 返回串号
 */
+ (NSString *)getPhoneUuid;

/**
 * @brief 显示正在加载进度视图
 * @param N/A
 * @return N/A
 */
+(void)showloadingProgressView;

/**
 * @brief 隐藏加载进度视图
 * @param N/A
 * @return N/A
 */
+(void)hideloadingProgressView;


///**
// *  保存登陆信息
// *
// *  @param json  登陆成功后返回的信息
// */
//+ (void)addSaveCacheInLoginWithJson:(id)json;
//
///**
// *  清除缓存并标记退出登陆
// */
//+ (void)removeCacheAndOutLogin;

/**
 *  今日捞到的总钱数
 *
 *  @param path 路径
 *
 *  @return 今日的总钱数
 */
+ (CGFloat)todayTotalMoneyWithPath:(NSString *)path;

/**
 *  清除失效饺子
 *
 *  @param path 饺子的路径  分为登陆 未登录
 */
+ (void)removeDumplingInforOfFailureWithPath:(NSString *)path;
@end
