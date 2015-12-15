//
//  cateModel.h
//  MarketManage
//
//  Created by 许文波 on 15/8/24.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "JSONModel.h"

@interface cateModel : JSONModel

/** 分类ID */
@property (nonatomic,copy) NSString *id;
/** 分类名称 */
@property (nonatomic,copy) NSString *name;
/**  */
@property (nonatomic,copy) NSString *p_id;

@property (nonatomic,copy) NSString *create_time;
@property (nonatomic,copy) NSString *sequence;
@property (nonatomic,copy) NSString *original_url;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *jump_val;


@end
