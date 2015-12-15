//
//  ActivityListModel.m
//  ChillingAmend
//
//  Created by 许文波 on 15/4/2.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import "ActivityListModel.h"
#import "JPCommonMacros.h"

@implementation ActivityListModel

+ (ActivityListModel *)getActivityListModelWithDic:(NSDictionary *)dic
{
    ActivityListModel *model = [[ActivityListModel alloc] init];
    model.activityImage = [NSString stringWithFormat:@"%@%@",img_url ,dic[@"tupian"]];
    model.activityName = dic[@"title"];
    model.activityPerson = dic[@"canyu_nums"];
    model.activitySharecontent = dic[@"share_content"];
    model.activityUrl = dic[@"url"];
    model.shareUrl = dic[@"share_url"];
    model.activityId = dic[@"activity_id"];
    model.type = dic[@"activity_type"];
    return model;
}

@end
