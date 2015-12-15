//
//  CJAllCategoriesThreeModel.m
//  MarketManage
//
//  Created by 赵春景 on 15-7-31.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CJAllCategoriesThreeModel.h"

@implementation CJAllCategoriesThreeModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
