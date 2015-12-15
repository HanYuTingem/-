//
//  PRJ_VideoShouYeBannerModel.h
//  ChillingAmend
//
//  Created by svendson on 14-12-29.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRJ_VideoShouYeBannerModel : NSObject

/*
 *activityID        广告所展示内容的ID
 *activityImage     广告图片链接地址
 *activityType      广告类型
 *activityUrl       广告标题
 */
@property (nonatomic, strong) NSString *bannerID;
@property (nonatomic, strong) NSString *bannerImage;
@property (nonatomic, strong) NSString *bannerType;
@property (nonatomic, strong) NSString *bannerName;

+ (PRJ_VideoShouYeBannerModel *)getActivityModelWithDic:(NSDictionary *)dic;

@end
