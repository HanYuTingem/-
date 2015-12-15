//
//  ShopListModel.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/6/26.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "ShopListModel.h"

@implementation ShopListModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}


+ (ShopListModel *)modelWithCloudPOIInfo:(BMKCloudPOIInfo *)info{
    
    ShopListModel *model= [ShopListModel objectWithKeyValues:info.customDict];
    
    NSString *longitude = [NSString stringWithFormat:@"%.6f", info.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%.6f", info.latitude];
    
    model.location = [[NSArray alloc] initWithObjects:longitude, latitude, nil];
    model.uid = info.uid;
    model.geotable_id = info.geotableId;
    model.title = info.title;
    model.address = info.address;
    model.province = info.province;
    model.city = info.city;
    model.district = info.district;
    model.distance = info.distance;
    model.weight = info.weight;
    model.create_time = info.creattime;
    model.modify_time = info.modifytime;
    model.type = info.type;
    model.flag = info.customDict[@"deleteFlag"];
    
    return model;
    
}

+ (ShopListModel *)modelWithDic:(NSDictionary *)dic{
    
    return [[ShopListModel alloc]initWithDic:dic];
    
}


- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@", key);
}

@end
