//
//  PRJ_YaoYiYaoDetailsModel.h
//  ChillingAmend
//
//  Created by svendson on 15-1-5.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRJ_YaoYiYaoDetailsModel : NSObject

/*
 *reCordID        这条记录的id
 *yaoJiangMusic     摇奖的语音提示
 *yaoDongMusic      摇动时 的声音
 *channel       摇奖的频道
 *start_time       活动开始的时间。精确到分钟，以分钟的起始值为开始时间
 *stop_time    活动结束时间
 *image
 *status       0表示还没有摇过奖，1表示已经摇过奖 2表示未登陆
 *next       下一次活动的开始时间,如果为空字符表示暂时没有下一次活动
 */
@property (nonatomic, strong) NSString *reCordID;
@property (nonatomic, strong) NSString *yaoJiangMusic;
@property (nonatomic, strong) NSString *yaoDongMusic;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *start_time;
@property (nonatomic, strong) NSString *stop_time;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *next;

+(PRJ_YaoYiYaoDetailsModel *)getYaoYiYaoDetailModelWithDic:(NSDictionary *)dic;

@end
