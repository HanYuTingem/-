//
//  SINOHttptool.m
//  AFNetWorking
//
//  Created by 许文波 on 15/10/14.
//  Copyright (c) 2015年 GDH. All rights reserved.
//

#import "SINOHttptool.h"
#import "RSACrypto.h"
#include <CommonCrypto/CommonDigest.h>

@implementation SINOHttptool

+(NSDictionary *)Interface100{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"110" forKey:@"por"];
    [dict setObject:@"8a7dd37255b778b4062deac6dbd5ada9" forKey:@"proIden"];
    [dict setObject:@"247" forKey:@"user_id"];
    return dict;
}




@end
