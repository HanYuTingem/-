//
//  MyUtils.m
//  MyNiceFood
//
//  Created by sunsu on 15/8/5.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "MyUtils.h"

@implementation MyUtils
//判断字符串是否为空  0标识有字符串  1标识没有字符串
+ (BOOL) isBlankString:(NSString *)string {
    if (!string) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (BOOL) isCharacter:(NSString *)str{
    if (str  && ![str isEqualToString:@""] && str.length != 0){
        return YES;
    }
    return NO;
}
//截取时间
+(NSString *)timeToMyTime:(NSString *)time
{
    //2014-12-18 13:36:37
    if ([time isEqualToString:@""])
    {
        return @"";
    }
    if (time == nil) {
        return @"";
    }
    NSArray *array = [time componentsSeparatedByString:@" "];
    NSString *str1 = array[0];
    NSString *str2 = array[1];
    
    NSArray *arr1 = [str1 componentsSeparatedByString:@"-"];
    NSArray *arr2 = [str2 componentsSeparatedByString:@":"];
    
    NSString *month = arr1[1];
    NSString *day   = arr1[2];
    
    NSString *hour = arr2[0];
    NSString *minute = arr2[1];
    
    NSString *myTime = [NSString stringWithFormat:@"%@月%@日 %@:%@",month,day,hour,minute];
    return myTime;
}

+(CGSize)sizeWithString:(NSString *)str font:(CGFloat)fontSize maxSize:(CGSize)maxSize{
    UIFont * font = [UIFont systemFontOfSize:fontSize];
    NSDictionary *dict = @{NSFontAttributeName:font};
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}


@end
