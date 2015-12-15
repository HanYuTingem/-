//
//  PRJ_ShouYeVideoModel.m
//  ChillingAmend
//
//  Created by svendson on 14-12-25.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "PRJ_ShouYeVideoModel.h"

@implementation PRJ_ShouYeVideoModel

+(PRJ_ShouYeVideoModel *)getVideoDetailModelWithDic:(NSDictionary *)dic
{
    PRJ_ShouYeVideoModel *model = [[PRJ_ShouYeVideoModel alloc]init];
    model.videoID = dic[@"id"];
    model.videoImageUrl = [NSString stringWithFormat:@"%@%@",img_url,dic[@"video_img"]];
    model.videoName = dic[@"video_name"];
    model.videoDuration = dic[@"video_duration"];
    model.record = dic[@"record"];
    model.subTitle = dic[@"video_subhead"];
    
    return model;
}

@end
