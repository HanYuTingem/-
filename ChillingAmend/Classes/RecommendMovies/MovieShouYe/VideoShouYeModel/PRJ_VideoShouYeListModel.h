//
//  PRJ_VideoShouYeListModel.h
//  ChillingAmend
//
//  Created by svendson on 14-12-29.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRJ_VideoShouYeListModel : NSObject

/*
 *videoID        视频ID
 *videoName       视频名称
 *videoImage         视频图片
 *VideoDuration    视频时间
 *videoJiFen       视频积分
 *videoTime        视频当天时间
 *videoRecord      播放记录
 */
@property (nonatomic, strong) NSString *videoID;
@property (nonatomic, strong) NSString *videoName;
@property (nonatomic, strong) NSString *videoImage;
@property (nonatomic, strong) NSString *VideoDuration;
@property (nonatomic, strong) NSString *videoJiFen;
@property (nonatomic, strong) NSString *videoTime;
@property (nonatomic, strong) NSString *videoRecord;

+ (PRJ_VideoShouYeListModel *)getVideoListModelWithDic:(NSDictionary *)dic;

@end
