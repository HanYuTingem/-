//
//  NSData+LYQCommon.m
//  Chiliring
//
//  Created by nsstring on 14-8-18.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "NSData+LYQCommon.h"

@implementation NSDate (LYQCommon)
- (NSDateComponents *)componentsOfDay
{
    static NSDateComponents *dateComponents = nil;
    static NSDate *previousDate = nil;
    static NSCalendar *greCalendar;
    if (!greCalendar) {//NSCalendar日历实例
        greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    if (!previousDate || ![previousDate isEqualToDate:self]) {
        previousDate = self;
        dateComponents = [greCalendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit | NSWeekCalendarUnit | NSWeekOfMonthCalendarUnit | NSWeekOfYearCalendarUnit| NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    }
    
    return dateComponents;
    
}

/****************************************************
 030
 *@Description:获得NSDate对应的年份
 031
 *@Params:nil
 032
 *@Return:NSDate对应的年份
 033
 ****************************************************/
- (NSUInteger)year
{
    return [self componentsOfDay].year;
}

/****************************************************
 040
 *@Description:获得NSDate对应的月份
 041
 *@Params:nil
 042
 *@Return:NSDate对应的月份
 043
 ****************************************************/
- (NSUInteger)month
{
    return [self componentsOfDay].month;
}


/****************************************************
 051
 *@Description:获得NSDate对应的日期
 052
 *@Params:nil
 053
 *@Return:NSDate对应的日期
 054
 ****************************************************/
- (NSUInteger)day
{
    return [self componentsOfDay].day;
}

/****************************************************
 062
 *@Description:获得NSDate对应的小时数
 063
 *@Params:nil
 064
 *@Return:NSDate对应的小时数
 065
 ****************************************************/
- (NSUInteger)hour
{
    return [self componentsOfDay].hour;
}


/****************************************************
 073
 *@Description:获得NSDate对应的分钟数
 074
 *@Params:nil
 075
 *@Return:NSDate对应的分钟数
 076
 ****************************************************/
- (NSUInteger)minute
{
    return [self componentsOfDay].minute;
}


/****************************************************
 084
 *@Description:获得NSDate对应的秒数
 085
 *@Params:nil
 086
 *@Return:NSDate对应的秒数
 087
 ****************************************************/
- (NSUInteger)second
{
    return [self componentsOfDay].second;
}

/****************************************************
 094
 *@Description:获得NSDate对应的星期
 095
 *@Params:nil
 096
 *@Return:NSDate对应的星期
 097
 ****************************************************/
- (NSUInteger)weekday
{
    return [self componentsOfDay].weekday;
}

@end
