//
//  DumplingInforDetailResultDumplingModel.m
//  LaoYiLao
//
//  Created by wzh on 15/11/7.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "DumplingInforDetailResultDumplingModel.h"

@implementation DumplingInforDetailResultDumplingModel
+ (DumplingInforDetailResultDumplingModel *)dumplingInforResultDumplingModelWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}
- (id)initWithDic:(NSDictionary *)dic{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
