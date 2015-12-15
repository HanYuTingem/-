//
//  RemainingDumplingNumberModel.m
//  LaoYiLao
//
//  Created by wzh on 15/11/10.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "RemainingDumplingNumberModel.h"

@implementation RemainingDumplingNumberModel
+ (RemainingDumplingNumberModel *)remainingDumplingNumberModelWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

- (id)initWithDic:(NSDictionary *)dic{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"resultList"]){
       _number = ((NSDictionary *)value)[@"num"];
    }
}
@end
