//
//  NSDate+LSY.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "NSDate+LSY.h"

@implementation NSDate (LSY)
+ (NSString *)dateWithString:(NSString *)string
{
    NSTimeInterval msgTime = [string longLongValue]/ 1000.0;
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:msgTime];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"HH:mm";
    NSString *time = [fmt stringFromDate:timeDate];
    
    return time;
}

+ (NSString *)dateWithStringHMS:(NSString *)string
{

    NSTimeInterval msgTime = [string longLongValue];
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:msgTime];
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"HH:mm:ss";
    [fmt setTimeZone:GTMzone];
    NSString *time = [fmt stringFromDate:timeDate];
    
    return time;
}

+ (NSString *)dateWithStringHMS1000:(NSString *)string andFormat:(NSString*)format
{
    NSTimeInterval msgTime = [string longLongValue];
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:msgTime];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = format;
    NSString *time = [fmt stringFromDate:timeDate];
    
    return time;
}

@end
