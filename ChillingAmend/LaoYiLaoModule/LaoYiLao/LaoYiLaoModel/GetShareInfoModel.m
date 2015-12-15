//
//  GetShareInfoModel.m
//  LaoYiLao
//
//  Created by sunsu on 15/11/11.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "GetShareInfoModel.h"

@implementation GetShareInfoModel

+(GetShareInfoModel *)getShareInfoModelWithDic:(NSDictionary *)dic{
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
        _resultModel = [GetShareInfoResultModel getShareInfoResultModelWithDic:(NSDictionary *)value];
    }
}

@end
