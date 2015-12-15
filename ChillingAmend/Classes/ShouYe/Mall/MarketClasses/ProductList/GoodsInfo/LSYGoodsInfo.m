//
//  LSYGoodsInfo.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYGoodsInfo.h"

@implementation LSYGoodsInfo

+(instancetype)goodsWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}

@end
