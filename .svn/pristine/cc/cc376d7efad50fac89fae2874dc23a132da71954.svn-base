//
//  CommomListModel.m
//  LANSING
//
//  Created by yll on 15/7/21.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "CommomListModel.h"

@implementation CommomListModel
+(id)initWithMyApplyModelInforJSONDic:(NSDictionary *)dicInfor{
    CommomListModel *model = [[CommomListModel alloc]init];
    if (dicInfor == nil ||
        dicInfor.count < 1) {
        return model;
    }
    model.actionId = [dicInfor objectForKey:@"id"];
    model.name = [dicInfor objectForKey:@"name"];
    model.apply_status = [dicInfor objectForKey:@"apply_status"];
    model.active_status = [dicInfor objectForKey:@"active_status"];
    model.list_url = [dicInfor objectForKey:@"list_url"];
    model.end_time = [dicInfor objectForKey:@"end_time"];
    model.share_content = [dicInfor objectForKey:@"share_content"];
    model.type = [dicInfor objectForKey:@"type"];
    return model;
}

+(id)initWithMyCollectModelInforJSONDic:(NSDictionary *)dicInfor{
    CommomListModel *model = [[CommomListModel alloc]init];
    if (dicInfor == nil ||
        dicInfor.count < 1) {
        return model;
    }
    model.actionId = [dicInfor objectForKey:@"id"];
    model.name = [dicInfor objectForKey:@"name"];
    model.active_status = [dicInfor objectForKey:@"status"];
    model.list_url = [dicInfor objectForKey:@"list_url"];
    model.end_time = [dicInfor objectForKey:@"end_time"];
    model.share_content = [dicInfor objectForKey:@"share_content"];
    model.praise_id = [dicInfor objectForKeyedSubscript:@"praise_id"];
    model.type = [dicInfor objectForKey:@"type"];
    return model;
}
+(id)initWithALlActionListModelInforJSONDic:(NSDictionary *)dicInfor{
    CommomListModel *model = [[CommomListModel alloc]init];
    if (dicInfor == nil ||
        dicInfor.count < 1) {
        return model;
    }
    model.actionId = [dicInfor objectForKey:@"id"];
    model.name = [dicInfor objectForKey:@"name"];
    model.active_status = [dicInfor objectForKey:@"status"];
    model.list_url = [dicInfor objectForKey:@"list_url"];
    model.end_time = [dicInfor objectForKey:@"end_time"];
    model.share_content = [dicInfor objectForKey:@"share_content"];
    model.share = [dicInfor objectForKey:@"share"];
    model.browse = [dicInfor objectForKey:@"browse"];
    model.participate = [dicInfor objectForKey:@"participate"];
    model.start_time = [dicInfor objectForKey:@"start_time"];
    model.type = [dicInfor objectForKey:@"type"];
    return model;
}

@end
