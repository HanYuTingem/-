//
//  PRJ_ActivityModel.h
//  ChillingAmend
//
//  Created by svendson on 15-1-20.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRJ_ActivityModel : NSObject

/*
 *canyu_nums         参与人数
 *title    标题
 *tupian      图片地址
 *url      链接地址
 */
@property (nonatomic, strong) NSString *canyu_nums;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *tupian;
@property (nonatomic, strong) NSString *url;

+(PRJ_ActivityModel *)getActivityDetailModelForShouYeWithDic:(NSDictionary *)dic;

@end
