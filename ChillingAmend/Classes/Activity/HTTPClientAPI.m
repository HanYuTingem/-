//
//  HTTPClientAPI.m
//  LANSING
//
//  Created by yll on 15/7/21.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "HTTPClientAPI.h"
#import "LogInAPP.h"

@implementation HTTPClientAPI
+(NSMutableDictionary *)applyCountFormUserId:(NSString *)userId
{
    NSMutableDictionary * mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:1];
    //这里我们给的空间大小是5,当添加的数据超过的时候，它的空间大小会自动扩大
    //添加数据，注意：id key  是成对出现的
    [mutableDictionary setValue:LOGOAction forKey:@"product_id"];
    [mutableDictionary setValue:userId forKey:@"userid"];
    return mutableDictionary;
}

+(NSMutableDictionary *)mytheListOfActivitiesFormUserId:(NSString *)userId size:(NSString *)size page:(NSString *)page{
    NSMutableDictionary * mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:1];
    [mutableDictionary setValue:LOGOAction forKey:@"product_id"];
    [mutableDictionary setValue:userId forKey:@"userid"];
    [mutableDictionary setValue:size forKey:@"size"];
    [mutableDictionary setValue:page forKey:@"page"];
    return mutableDictionary;
}

+(NSMutableDictionary *)getAllListOfAllActivitiesFormsize:(NSString *)size page:(NSString *)page{
    NSMutableDictionary * mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:1];
    [mutableDictionary setValue:LOGOAction forKey:@"product_id"];
    [mutableDictionary setValue:size forKey:@"size"];
    [mutableDictionary setValue:page forKey:@"page"];
    return mutableDictionary;
}

+(NSMutableDictionary *)deleteMyCollectListOfActivitiesFormPraiseId:(NSString *)PraiseId
{
    NSMutableDictionary * mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:1];
    [mutableDictionary setValue:PraiseId forKey:@"praise_id"];
     return mutableDictionary;
}

+(NSMutableDictionary *)recordsShareNumberToActionDetailFormUserId:(NSString *)userId activityId:(NSString *)actionId
{
    NSMutableDictionary *recordShare = [NSMutableDictionary dictionaryWithCapacity:1];
    [recordShare setValue:LOGOAction forKey:@"product_id"];
    [recordShare setValue:userId forKey:@"userid"];
    [recordShare setValue:actionId forKey:@"activity_id"];
    return recordShare;
}
@end
