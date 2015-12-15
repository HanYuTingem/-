//
//  PRJ_ActivityModel.m
//  ChillingAmend
//
//  Created by svendson on 15-1-20.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import "PRJ_ActivityModel.h"
#import "JPCommonMacros.h"

@implementation PRJ_ActivityModel

+(PRJ_ActivityModel *)getActivityDetailModelForShouYeWithDic:(NSDictionary *)dic
{
    PRJ_ActivityModel *model = [[PRJ_ActivityModel alloc]init];
    model.canyu_nums = dic[@"canyu_nums"];
    model.tupian = [NSString stringWithFormat:@"%@%@",img_url,dic[@"tupian"]];
    model.title = dic[@"title"];
    model.url = dic[@"url"];
    return model;
}
@end
