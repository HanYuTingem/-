//
//  CJAllCategoriesModel.m
//  MarketManage
//
//  Created by 赵春景 on 15-7-29.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CJAllCategoriesModel.h"
#import "CJAllCategoriesThreeModel.h"

@implementation CJAllCategoriesModel



- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
//        self.json = [NSMutableArray arrayWithCapacity:0];
        
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
    NSLog(@"key ===== %@",key);
    
//    if([value isKindOfClass:[NSArray class]]){
//        NSLog(@"------%@",value);
//    }
//    
//    if ([key isEqualToString:@"json"]) {
//        self.json = [NSMutableArray array];
//        for (NSDictionary *dict in value) {
//            CJAllCategoriesThreeModel *thModel = [CJAllCategoriesThreeModel modelWithDict:dict];
//            [self.json addObject:thModel];
//        }
//    }
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
