//
//  GCUtil.h
//  iMagazine2
//
//  Created by dreamRen on 12-11-16.
//  Copyright (c) 2012年 iHope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GameAlertView.h"

typedef enum {
    NETWORK_TYPE_NONE= 0,
    NETWORK_TYPE_2G= 1,
    NETWORK_TYPE_3G= 2,
    NETWORK_TYPE_4G= 3,
    NETWORK_TYPE_5G= 4, //  5G目前为猜测结果
    NETWORK_TYPE_WIFI= 5,
}NETWORK_TYPE;

@interface GCUtil : NSObject
typedef void (^connectedToNetBlock)(NSString *connectedToNet);


/** 网络状态返回字符串     */
+(void)connectedToNetwork:(connectedToNetBlock)type;

+ (BOOL)connectedToNetwork;
+ (BOOL)ThePhoneNumber:(NSString *)string;
+ (BOOL)isValidateEmail:(NSString *)email;
+ (NSString *)randomStrNumStr:(NSString*)numStr;
+ (BOOL)isTextFiledNumber:(NSString*)textField andCount:(NSInteger)count;
+ (BOOL)isTextFiledChinaAndEnglish:(NSString*)textField;
+ (BOOL)isEvaluateWithObject:(NSString*)textField;
+ (BOOL)isMobileNumberOrEmail:(NSString*)loginString;
// 正则判断手机号码地址格式
+(BOOL)isMobileNumber:(NSString *)mobileNum;
+  (int)convertToInt:(NSString*)strtemp;
+ (BOOL)isIncludeSpecialCharact: (NSString *)str;
+ (void)showDxalertTitle:(NSString*)title andMessage:(NSString*)message cancel:(NSString*)cancel andOk:(NSString*)amend;
+ (GameAlertView*) showGameAlertTitle:(NSString*)title andContent:(NSString*)content cancel:(NSString*)cancel andOK:(NSString*)amend;
+ (void)saveLajiaobijifenWithJifen:(id)jifen;
+ (NSString*)getlajiaobiJinfen;
+ (CGFloat)widthOfString:(NSString *)string withFont:(int)font;
+ (void) changeChiliCoinView:(int)coin andCoinImageView:(UIView*)coinView andImageArray:(NSArray*)imgArray;
+ (BOOL)connectedToNetwork;
// 游戏部分网络连接出错  无兑换情况下的弹窗
+ ( GameAlertView * )showGameErrorMessageWithContent:(NSString *)content;
+ (CGRect) changeLabelFrame:(UILabel*)label andSize:(CGSize)size andFontSize:(UIFont*)font;
+ (CGSize)changeSize:(NSString*)text andSize:(CGSize)size andFontSize:(CGFloat)font;

//TextView行间距
+(void)lineSpacingTextView:(UITextView *)textView fontInt:(int )fontInt;

//显示提示框,只有一个确定按钮
+(void)showInfoAlert:(NSString*)aInfo;
//判断网络类型  NETWORK_TYPE 当前网络类型
/*
NETWORK_TYPE_NONE= 0,
NETWORK_TYPE_2G= 1,
NETWORK_TYPE_3G= 2,
NETWORK_TYPE_4G= 3,
NETWORK_TYPE_5G= 4,//  5G目前为猜测结果
NETWORK_TYPE_WIFI= 5,
*/
+(NETWORK_TYPE)getNetworkTypeFromStatusBar;
+ (BOOL)convertToBool:(NSString*)strtemp andLength:(NSInteger)length;
/**
 *  图片九切片
 *
 *  @param imageName 图片名称
 *  @param edgeInset 切片位置
 *  @param state  0 拉伸  1 赋值
 *
 *  @return 切片后图片
 */
+(UIImage *)getResizebalImageFormOldImageWithImageName:(NSString *)imageName andEdgeInsets:(UIEdgeInsets)edgeInset andState:(int) state;

//MD5加密
+(NSString *)md5:(NSString *)str;
//转换时间格式为xxxx年xx月xx日
+(NSString*)getDataZuoGeshi:(NSString*)timeDate;
//时间改变后的值
+(NSString*)getDateChanged:(NSString*)dateStr;

@end