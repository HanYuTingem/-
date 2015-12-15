//
//  InvalidModel.m
//  MarketManage
//
//  Created by 许文波 on 15/8/7.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "InvalidModel.h"

@implementation InvalidModel

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self ;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@",key);
}

@end
