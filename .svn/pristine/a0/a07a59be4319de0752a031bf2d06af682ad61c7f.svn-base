//
//  CrazyBasisModel.m
//  MarketManage
//
//  Created by fielx on 15/4/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisModel.h"

@implementation CrazyBasisModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        dic = [CrazyBasisModel crazyModelDeleteNull:dic];
        
    }
    return self;
}


+(NSMutableDictionary *)crazyModelDeleteNull:(NSDictionary *)dic
{
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithCapacity:10];
    
    NSArray *array = [mDic allKeys];
    for (int i = 0; i < array.count; i++) {
        if ([dic[array[i]] isEqual: [NSNull null]]) {
            [mDic setObject:@"" forKey:array[i]];
        }
        else {
            [mDic setObject:dic[array[i]] forKey:array[i]];
        }
    }
    
    return mDic;
}

@end
