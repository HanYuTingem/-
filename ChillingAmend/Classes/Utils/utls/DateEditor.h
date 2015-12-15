//
//  DateEditor.h
//  日期编辑
//
//  Created by pipixia on 14/10/24.
//  Copyright (c) 2014年 pipixia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateEditor : NSObject
//日期计算
+(NSDate *)getPriousDateFromDate:(NSDate *)date withDay:(int)day;
//日期获取
+(NSDateComponents*)comps_withDay:(int)day;
//把当前时间转换问datae
+(NSDate*)dateString:(NSString*)string;
//计算当月在星期几
+(int)howManyDaysInThisYear:(int)year imonth:(int)imonth day:(int)day;
//判断当月有多少天
+(int)howManyDaysInThisMonth:(int)year month:(int)imonth;
//计算当前时间和到期时间之间间隔多少天
+(NSInteger) daysFromDate:(NSDate *) startDate toDate:(NSDate *) endDate;
//计算当前时间和到期时间之间间隔多少年
+(NSInteger) yearFromDate:(NSDate *) startDate toDate:(NSDate *) endDate;
//获取当前日期年月日
+ (NSString *) getCurrentTime:(NSDate *)today;
// 如果str代表今天，则返回时间，否则返回日期
+(NSString *)changeDate:(NSString *)str;
//时间戳转换为时间字符串
+ (NSString *)getTimeString :(NSString *)timeStamp;
//计算当前时间和到期时间之间间隔多分钟
+(int) minuteString:(NSString *) startString toString:(NSString *) endString;
//时间戳转换为年月
+ (NSArray *)getTimeArray :(NSString *)timeStamp;

//时间戳转换
+ (NSString *)timeString :(NSString *)timeStamp;
//把当前时间转换问datae
+(NSDate*)dateSFMString:(NSString*)string;

@end
