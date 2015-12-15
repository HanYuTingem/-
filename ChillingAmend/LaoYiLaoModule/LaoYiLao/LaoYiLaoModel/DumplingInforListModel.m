//
//  DumplingInforList.m
//  LaoYiLao
//
//  Created by wzh on 15/11/6.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "DumplingInforListModel.h"

@implementation DumplingInforListModel

+ (DumplingInforListModel *)dumplingInforListModelWithDic:(NSDictionary *)dic{
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
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSDictionary *subDic in (NSArray *)value) {
            DumplingInforListResultModel *model = [DumplingInforListResultModel dumplingInforListResultModelWithDic:subDic];
            [dataArray addObject:model];
        }
        self.dumplingInforList = dataArray;
    }
}
@end
