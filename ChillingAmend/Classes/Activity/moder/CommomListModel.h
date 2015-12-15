//
//  CommomListModel.h
//  LANSING
//
//  Created by yll on 15/7/21.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommomListModel : NSObject
@property (nonatomic ,copy) NSString *actionId;         //活动ID
@property (nonatomic ,copy) NSString *name;            //活动名称
@property (nonatomic ,copy) NSString *apply_status; //报名状态 1=未审核、2=通过审核、3=未通过
@property (nonatomic ,copy) NSString *active_status;//活动状态 2=通过审核、3=活动已结束
@property (nonatomic ,copy) NSString *list_url;        //活动缩略图
@property (nonatomic ,copy) NSString *end_time;//活动结束时间
@property (nonatomic ,copy) NSString *share_content;   //分享内容
@property (nonatomic ,copy) NSString *type;   //活动类型 1=仅展示类型、2=报名类型、3=问卷类型

//活动列表添加的参数
@property (nonatomic ,copy) NSString *share;//分享数
@property (nonatomic ,copy) NSString *browse;        //浏览数
@property (nonatomic ,copy) NSString *participate;///参与数
@property (nonatomic ,copy) NSString *start_time;   //开始时间

//收藏列表加的参数
@property (nonatomic ,copy) NSString *praise_id;   //收藏的id

///我的报名列表
+(id)initWithMyApplyModelInforJSONDic:(NSDictionary *)dicInfor;

///我的收藏列表
+(id)initWithMyCollectModelInforJSONDic:(NSDictionary *)dicInfor;

//所有活动列表
+(id)initWithALlActionListModelInforJSONDic:(NSDictionary *)dicInfor;

@end
