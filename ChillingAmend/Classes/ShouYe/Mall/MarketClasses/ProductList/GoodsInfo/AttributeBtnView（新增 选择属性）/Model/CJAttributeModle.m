//
//  CJAttributeModle.m
//  MarketManage
//
//  Created by 赵春景 on 15-8-3.
//  Copyright (c) 2015年 Rice. All rights reserved.
//  商品属性 一级模型

#import "CJAttributeModle.h"
#import "CJAttributeSpecModel.h"

@implementation CJAttributeModle

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"default"]) {
        self.defaultP = value;
    }
    if ([key isEqualToString:@"spec_id"]) {
        self.spec_idArray = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            CJAttributeSpecModel *specModel = [CJAttributeSpecModel ModelwithDict:dic];
            [self.spec_idArray addObject:specModel];
        }
        NSLog(@"CJAttributeModle.h  ---- %lu",(unsigned long)self.spec_idArray.count);
    }
    if ([key isEqualToString:@"id"]) {
        self.ModeleId = value;
    }
}



@end
