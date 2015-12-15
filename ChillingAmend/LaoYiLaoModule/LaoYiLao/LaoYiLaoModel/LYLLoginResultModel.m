//
//  LYLLoginResultModel.m
//  LaoYiLao
//
//  Created by sunsu on 15/11/9.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "LYLLoginResultModel.h"

@implementation LYLLoginResultModel
+ (LYLLoginResultModel *)getLYLLoginResultWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

- (id)initWithDic:(NSDictionary *)dic{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    if ([key isEqualToString:@"id"]) {
//        
//        self.myID = @"";
//        self.myID = key;
//    }
}

@end
