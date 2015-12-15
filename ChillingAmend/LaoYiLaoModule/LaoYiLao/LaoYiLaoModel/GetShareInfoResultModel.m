//
//  GetShareInfoResultModel.m
//  LaoYiLao
//
//  Created by sunsu on 15/11/11.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "GetShareInfoResultModel.h"

@implementation GetShareInfoResultModel
+(GetShareInfoResultModel *)getShareInfoResultModelWithDic:(NSDictionary *)dic{
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
