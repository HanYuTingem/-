//
//  HTTPClientAPI.h
//  LANSING
//
//  Created by yll on 15/7/21.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#pragma mark=======================================================================================******找到放置网络请求头的类，可以直接粘过去********========================================
//#define HttpHead   @"http://192.168.10.10:89/"

//测试环境
#define HttpHead @"http://192.168.10.11:2017/"
//正式环境
//#define HttpHead  @"http://activity.sinosns.cn/"
#define ActivityPort @"index.php/port/"
#define Http  @"http://activity.sinosns.cn/index.php/port/"
//#define Http   [NSString stringWithFormat:@"%@%@",HttpHead,ActivityPort] //测试

#define SINOApplyCount @"applyCount"  //我的活动数
#define SINOApplyActionList  @"applyList"   //我的活动列表
#define SINOCollectList  @"praiseList"   //我的收藏列表
#define SINOALlActionList  @"indexList"   //所有活动列表
#define SINODeleteCollectCell  @"praiseDel"   //删除收藏
#define SINOrecordsShareNumber  @"addNum"   //记录分享数


// size : 10  //每页多少条数据   page : 1  //当前页数
#define ActionSize    @"10"
#define ActionPage    @"1"

#import <Foundation/Foundation.h>

@interface HTTPClientAPI : NSObject

//我的活动（显示我报名的、我收藏的数量）
+(NSMutableDictionary *)applyCountFormUserId:(NSString *)userId;

//报名的活动列表  我的收藏的活动列表
+(NSMutableDictionary *)mytheListOfActivitiesFormUserId:(NSString *)userId size:(NSString *)size page:(NSString *)page;

//删除我的收藏的活动列表
+(NSMutableDictionary *)deleteMyCollectListOfActivitiesFormPraiseId:(NSString *)PraiseId;


//所有活动列表
+(NSMutableDictionary *)getAllListOfAllActivitiesFormsize:(NSString *)size page:(NSString *)page;

//分享数量记录
+ (NSMutableDictionary *)recordsShareNumberToActionDetailFormUserId:(NSString *)userId activityId:(NSString *)actionId;
@end
