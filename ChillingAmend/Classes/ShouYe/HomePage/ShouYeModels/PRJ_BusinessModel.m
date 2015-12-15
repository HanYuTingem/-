//
//  PRJ_BusinessModel.m
//  ChillingAmend
//
//  Created by 孙瑞 on 15/9/16.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import "PRJ_BusinessModel.h"

@implementation PRJ_BusinessModel
+ (PRJ_BusinessModel *)getBusinessModelWithDic:(NSDictionary *)dic
{
    PRJ_BusinessModel *model = [[PRJ_BusinessModel alloc]init];
    model.businessID = dic[@"bus_id"];
    return model;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@",self.businessID];
}
@end
