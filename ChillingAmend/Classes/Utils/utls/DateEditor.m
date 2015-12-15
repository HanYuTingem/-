//
//  DateEditor.m
//  日期编辑
//
//  Created by pipixia on 14/10/24.
//  Copyright (c) 2014年 pipixia. All rights reserved.
//

#import "DateEditor.h"

@implementation DateEditor

//日期获取
+(NSDateComponents*)comps_withDay:(int)day{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate* before_now1 = [self getPriousDateFromDate:now withDay:day];
    comps = [calendar components:unitFlags fromDate:before_now1];
    return comps;
}

//日期计算 日计算
+(NSDate *)getPriousDateFromDateday:(NSDate *)date withDay:(int)day
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:day];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}

//把当前时间转换问datae
+(NSDate*)dateString:(NSString*)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}

//计算当月在星期几
+(int)howManyDaysInThisYear:(int)year imonth:(int)imonth day:(int)day
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setDay:day];
    
    [comps setMonth:imonth];
    
    [comps setYear:year];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *date = [gregorian dateFromComponents:comps];
    
    NSDateComponents *weekdayComponents =
    
    [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    
    int weekday = (int)[weekdayComponents weekday];
    
    NSLog(@"weekday:%d",weekday);
    return weekday;
}

//判断当月有多少天
+(int)howManyDaysInThisMonth:(int)year month:(int)imonth
{
    if((imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
        return 31;
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
        return 30;
    if(((year%4 == 0)&&!(year%100 == 0))||(year%400 == 0))
        return 29;
    else
        return 28;
    return 29;
}

//计算当前时间和到期时间之间间隔多少天
+(NSInteger) daysFromDate:(NSDate *) startDate toDate:(NSDate *) endDate {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit units=NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *comp1=[gregorian components:units fromDate:startDate];
    NSDateComponents *comp2=[gregorian components:units fromDate:endDate];
    
    [comp1 setHour:12];
    [comp2 setHour:12];
    
    NSDate *date1=[gregorian dateFromComponents: comp1];
    NSDate *date2=[gregorian dateFromComponents: comp2];
    
    return [[gregorian components:NSDayCalendarUnit fromDate:date1 toDate:date2 options:0] day];
}

//计算当前时间和到期时间之间间隔多少年
+(NSInteger) yearFromDate:(NSDate *) startDate toDate:(NSDate *) endDate {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit units=NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *comp1=[gregorian components:units fromDate:startDate];
    NSDateComponents *comp2=[gregorian components:units fromDate:endDate];
    
    [comp1 setHour:12];
    [comp2 setHour:12];
    
    NSDate *date1=[gregorian dateFromComponents: comp1];
    NSDate *date2=[gregorian dateFromComponents: comp2];
    
    return [[gregorian components:NSCalendarUnitYear fromDate:date1 toDate:date2 options:0] year];
}


//获取当前日期年月日
+ (NSString *) getCurrentTime:(NSDate *)today{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    return currentTime;
}

// 如果str代表今天，则返回时间，否则返回日期
+(NSString *)changeDate:(NSString *)str{
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString * nowStr = [formatter stringFromDate:date];
    
    NSString * dbStr = [str substringWithRange:NSMakeRange(0, 10)];
    if ([nowStr isEqualToString:dbStr]) {
        return [str substringWithRange:NSMakeRange(11, 8)];
    }else{
        return dbStr;
    }
}

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
//    NSLog(@"%d--%d",[comps year],[comps month]);
    NSString* timeString;
    if (minuteInterval==0) {
        timeString=@"1分钟前";
    } else if(minuteInterval<60)
    {
        timeString=[NSString stringWithFormat:@"%ld分钟前",(long)minuteInterval];
    } else
    {
        NSInteger hourInterval=minuteInterval/60;
        if (hourInterval<10) {
            timeString=[NSString stringWithFormat:@"%ld小时前",(long)hourInterval];
        } else
        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            //设置日期的格式,hh与HH的区别:分别表示12小时制,24小时制
            [formatter setDateFormat:@"YYYY-MM-dd  HH:mm:ss"];
            timeString=[formatter stringFromDate:confromTimesp];
        }
    }
    return timeString;
}

//时间戳转换为年月
+ (NSArray *)getTimeArray :(NSString *)timeStamp
{
    
    //追加时差后的日期
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp intValue]];
    //设置时区
    NSTimeZone *timeZone=[NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    NSInteger timeZoneInterval=[timeZone secondsFromGMTForDate:confromTimesp];
    //追加时差后的日期
    NSDate *localSubmitDate=[confromTimesp dateByAddingTimeInterval:timeZoneInterval];
    NSArray* timeArray = [[DateEditor getCurrentTime:localSubmitDate] componentsSeparatedByString:@"-"];
    return timeArray;
}

//计算当前时间和到期时间之间间隔多分钟
+(int) minuteString:(NSString *)startString toString:(NSString *)endString{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //结束时间
    NSDate *endDate1 = [dateFormatter dateFromString:endString];
    //当前时间
    NSDate *senderDate = [dateFormatter dateFromString:startString];
    //得到相差秒数
    NSTimeInterval time=[endDate1 timeIntervalSinceDate:senderDate];
    return (int)time;
}

//时间戳转换
+ (NSString *)timeString :(NSString *)timeStamp{
    NSLog(@"%@",timeStamp);
    //追加时差后的日期
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp intValue]];
    //设置时区
    //    NSLog(@"%d--%d",[comps year],[comps month]);
    NSString* timeString;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //设置日期的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    timeString=[formatter stringFromDate:confromTimesp];
    return timeString;
}

//把当前时间转换问datae
+(NSDate*)dateSFMString:(NSString*)string{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}

@end
