//
//  ActionListModel.h
//  LANSING
//
//  Created by yll on 15/7/21.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActionListModel : NSObject

@property (nonatomic ,copy) NSString *active_url;     //活动地址
@property (nonatomic ,copy) NSString *img_urlToList;     //图片地址
@property (nonatomic ,strong) NSMutableArray *listArray; //活动列表
@property (nonatomic, copy) NSString *pageCount;       //总页数

@property (nonatomic ,copy) NSString *actionId;     //活动ID
@property (nonatomic ,copy) NSString *name;     ///活动名称
@property (nonatomic ,copy) NSString *list_url;     //活动缩略图
@property (nonatomic ,copy) NSString *share;     //分享数
@property (nonatomic ,copy) NSString *start_time;     //开始时间
@property (nonatomic ,copy) NSString *end_time;     //活动结束时间

@property (nonatomic ,copy) NSString *status;     //活动状态 2=通过审核、3=活动已结束
@property (nonatomic ,copy) NSString *share_content;     //浏览数

+(id)initWithMyActionListModelInforActionListWithJSONDic:(NSDictionary *)dicInfor;
@end
