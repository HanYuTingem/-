//
//  DumplingInforModel.m
//  LaoYiLao
//
//  Created by wzh on 15/11/6.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "DumplingInforModel.h"

@implementation DumplingInforModel

+ (DumplingInforModel *)dumplingInforModelWithDic:(NSDictionary *)dic{
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
        _resultListModel = [DumplingInforResultModel dumplingInforResultModelWithDic:(NSDictionary *)value];
    }
}
@end
