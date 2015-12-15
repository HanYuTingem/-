//
//  ProtiketModel.m
//  MyNiceFood
//
//  Created by liujinhe on 15/7/24.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "ProtiketModel.h"

@implementation ProtiketModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{


}
- (id)valueForUndefinedKey:(NSString *)key{

    return nil;
}
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;

};
- (ProtiketModel*)protiketModelWithDic:(NSDictionary *)dic{
    ProtiketModel* model = [[ProtiketModel alloc] initWithDic:dic];
    return model;
    
};
@end
