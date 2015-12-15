//
//  ModularModel.h
//  MarketManage
//
//  Created by 许文波 on 15/8/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "JSONModel.h"
#import "ModularListModel.h"
@protocol ModularListModel;

@interface ModularModel : JSONModel

@property (nonatomic,copy) NSString *id;
/** 名称 */
@property (nonatomic,copy) NSString *name;
/** 模板标识 */
@property (nonatomic,copy) NSString *template;

@property (nonatomic,copy) NSString *start_time;

@property (nonatomic,copy) NSString *end_time;
/**  null, 是否推荐:0=否，1=是 */
@property (nonatomic,copy) NSString *is_recommended;

/** 排序 */
@property (nonatomic,copy) NSString *sort;

@property (nonatomic,copy) NSString *create_time;


@property(nonatomic,strong)NSArray <ModularListModel> *list;

@end
