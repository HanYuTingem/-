//
//  ModularListModel.h
//  MarketManage
//
//  Created by 许文波 on 15/8/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "JSONModel.h"

@interface ModularListModel : JSONModel

@property (nonatomic,copy) NSString *id;

/** 模块id */
@property (nonatomic,copy) NSString *m_id;
/** 标题 */
@property (nonatomic,copy) NSString *title;
/** 副标题 */
@property (nonatomic,copy) NSString *sub_title;


/** 目标类型：1=外部链接，2=商品分类，3=活动列表，4=专题页 */
@property (nonatomic,copy) NSString *type;
/** 目标值 */
@property (nonatomic,copy) NSString *val;
/** 图片地址 */
@property (nonatomic,copy) NSString *img;
/** null, 是否推荐：0=否，1=是 */
@property (nonatomic,copy) NSString *is_recommended;
/** 排序 */
@property (nonatomic,copy) NSString *sort;

@property (nonatomic,copy) NSString *create_time;





@end
