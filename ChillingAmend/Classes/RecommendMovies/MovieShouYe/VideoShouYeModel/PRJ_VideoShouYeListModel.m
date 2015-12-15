//
//  PRJ_VideoShouYeListModel.m
//  ChillingAmend
//
//  Created by svendson on 14-12-29.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "PRJ_VideoShouYeListModel.h"
#import "BXAPI.h"
@implementation PRJ_VideoShouYeListModel

+ (PRJ_VideoShouYeListModel *)getVideoListModelWithDic:(NSDictionary *)dic
{
    PRJ_VideoShouYeListModel *model = [[PRJ_VideoShouYeListModel alloc]init];
    model.videoID = dic[@"id"];
    model.videoName = dic[@"video_name"];
    model.videoImage = [NSString stringWithFormat:@"%@%@",img_url, dic[@"video_img"] ];
    model.VideoDuration = dic[@"video_duration"];
    model.videoJiFen = dic[@"video_jifen"];
    model.videoTime = dic[@"video_time"];
    model.videoRecord = dic[@"record"];
    
    return model;
}

@end
