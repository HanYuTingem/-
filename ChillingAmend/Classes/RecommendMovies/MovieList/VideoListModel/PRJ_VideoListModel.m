//
//  PRJ_VideoListModel.m
//  ChillingAmend
//
//  Created by svendson on 14-12-26.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "PRJ_VideoListModel.h"
#import "BXAPI.h"
@implementation PRJ_VideoListModel

+(PRJ_VideoListModel *)getVideoListModelWithDic:(NSDictionary *)dic
{

    PRJ_VideoListModel *model = [[PRJ_VideoListModel alloc]init];
    model.videoID = dic[@"id"];
    model.videoName = dic[@"video_name"];
    model.videoImage = [NSString stringWithFormat:@"%@%@",img_url, dic[@"video_img"] ];
    model.VideoDuration = dic[@"video_duration"];
    model.videoJiFen = dic[@"video_jifen"];
    model.videoTime = dic[@"video_time"];
    model.videoRecord = dic[@"record"];
    model.videosubTitle = dic[@"video_subhead"];
    return model;
}

@end
