//
//  Utils.m
//  Saoyisao
//
//  Created by 宋鑫鑫 on 14-8-28.
//  Copyright (c) 2014年 pipixia. All rights reserved.
//

#import "SingNoUtils.h"

@implementation SingNoUtils

+(NSString *)compareCurrentTime:(NSDate*)compareDate
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        //result = [NSString stringWithFormat:@"%ld年前",temp];
        result=@"不久前";
    }
    return  result;
}
@end
