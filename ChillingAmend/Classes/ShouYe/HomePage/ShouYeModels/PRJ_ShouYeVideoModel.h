//
//  PRJ_ShouYeVideoModel.h
//  ChillingAmend
//
//  Created by svendson on 14-12-25.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BXAPI.h"
@interface PRJ_ShouYeVideoModel : NSObject

/*
 *videoID          视屏ID
 *videoImageUrl    视屏图片地址
 *videoName        视屏名称
 */
@property (nonatomic, strong) NSString *videoID;
@property (nonatomic, strong) NSString *videoImageUrl;
@property (nonatomic, strong) NSString *videoName;
@property (nonatomic, strong) NSString *videoDuration;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *record;

+(PRJ_ShouYeVideoModel *)getVideoDetailModelWithDic:(NSDictionary *)dic;

@end
