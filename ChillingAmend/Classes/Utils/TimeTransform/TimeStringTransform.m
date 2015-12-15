//
//  TimeStringTransform.m
//  dreamWorks
//
//  Created by purplepeng on 13-7-11.
//  Copyright (c) 2013年 pipixia All rights reserved.
//

#import "TimeStringTransform.h"

@implementation TimeStringTransform
//时间戳转换为时间字符串
+ (NSString *)getTimeString :(NSString *)timeStamp
{
    
    //追加时差后的日期
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp intValue]];
    //设置时区
    NSTimeZone *timeZone=[NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    NSInteger timeZoneInterval=[timeZone secondsFromGMTForDate:confromTimesp];
    //追加时差后的日期
    NSDate *localSubmitDate=[confromTimesp dateByAddingTimeInterval:timeZoneInterval];

    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = kCFCalendarUnitSecond;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:localSubmitDate  toDate:[NSDate date]  options:0];
    NSInteger timeInterval= [comps second];
    
    NSInteger minuteInterval=fabs(timeInterval)/60;
    NSString* timeString;
//    if (minuteInterval==0) {
//        timeString=@"1分钟前";
//    } else if(minuteInterval<60)
//    {
//        timeString=[NSString stringWithFormat:@"%d分钟前",minuteInterval];
//    } else
//    {
//        NSInteger hourInterval=minuteInterval/60;
//        if (hourInterval<10) {
//            timeString=[NSString stringWithFormat:@"%d小时前",hourInterval];
//        } else
//        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            //设置日期的格式,hh与HH的区别:分别表示12小时制,24小时制
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
//        [formatter setDateFormat:@"YYYY-MM-dd"];
            timeString=[formatter stringFromDate:confromTimesp];
//        }
//    }
        return timeString;
}
-(NSInteger)daysWithinEraFromDate:(NSDate *) startDate toDate:(NSDate *) endDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = kCFCalendarUnitMinute;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:startDate  toDate:endDate  options:0];
    int minute = [comps minute];
    return minute;
}
+(NSMutableArray*)HMutabelArray:(NSMutableArray*)array mutabelArray1:(NSArray*)array1
{
    for (int i = 0; i < array1.count; i++) {
        [array addObject:[array1 objectAtIndex:i]];
    }
    return array;
}
@end
