//
//  LYLLoginModel.m
//  LaoYiLao
//
//  Created by sunsu on 15/11/9.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "LYLLoginModel.h"

@implementation LYLLoginModel
+ (LYLLoginModel *)getLYLLoginModelWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

- (id)initWithDic:(NSDictionary *)dic{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"result"]){
        _resultModel = [LYLLoginResultModel getLYLLoginResultWithDic:(NSDictionary *)value];
    }
}


@end
