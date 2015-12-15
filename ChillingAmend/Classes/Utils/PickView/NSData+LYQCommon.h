//
//  NSData+LYQCommon.h
//  Chiliring
//
//  Created by nsstring on 14-8-18.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LYQCommon)
/****************************************************
 06
 *@Description:获得NSDate对应的年份
 07
 *@Params:nil
 08
 *@Return:NSDate对应的年份
 09
 ****************************************************/
- (NSUInteger)year;

/****************************************************
 13
 *@Description:获得NSDate对应的月份
 14
 *@Params:nil
 15
 *@Return:NSDate对应的月份
 16
 ****************************************************/
- (NSUInteger)month;

/****************************************************
 21
 *@Description:获得NSDate对应的日期
 22
 *@Params:nil
 23
 *@Return:NSDate对应的日期
 24
 ****************************************************/
- (NSUInteger)day;

/****************************************************
 29
 *@Description:获得NSDate对应的小时数
 30
 *@Params:nil
 31
 *@Return:NSDate对应的小时数
 32
 ****************************************************/
- (NSUInteger)hour;

/****************************************************
 37
 *@Description:获得NSDate对应的分钟数
 38
 *@Params:nil
 39
 *@Return:NSDate对应的分钟数
 40
 ****************************************************/
- (NSUInteger)minute;

/****************************************************
 45
 *@Description:获得NSDate对应的秒数
 46
 *@Params:nil
 47
 *@Return:NSDate对应的秒数
 48
 ****************************************************/
- (NSUInteger)second;

/****************************************************
 52
 *@Description:获得NSDate对应的星期
 53
 *@Params:nil
 54
 *@Return:NSDate对应的星期
 55
 ****************************************************/
- (NSUInteger)weekday;


@end
