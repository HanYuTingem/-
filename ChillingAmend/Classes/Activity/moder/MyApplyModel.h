//
//  MyApplyModel.h
//  LANSING
//
//  Created by yll on 15/7/21.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyApplyModel : NSObject

@property (nonatomic ,copy) NSString *active_url;     //活动地址
@property (nonatomic ,copy) NSString *img_urlToApply;         //图片地址
@property (nonatomic ,strong) NSMutableArray *myApplyArray; //我的报名列表
@property (nonatomic, copy) NSString *pageCount;       //总页数


+(id)initWithMyApplyModelInforApplyListWithJSONDic:(NSDictionary *)dicInfor;
@end
