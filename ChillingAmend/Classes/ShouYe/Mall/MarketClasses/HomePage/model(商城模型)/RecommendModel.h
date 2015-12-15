//
//  RecommendModel.h
//  MarketManage
//
//  Created by 许文波 on 15/8/21.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "JSONModel.h"

@interface RecommendModel : JSONModel

/** 商品ID */
@property (nonatomic,copy) NSString *id;
/** 商品名称 */
@property (nonatomic,copy) NSString *name;
/** 商品图片 */
@property (nonatomic,copy) NSString *img_url2;
/** 积分 */
@property (nonatomic,copy) NSString *price;
/** <#type#> */
@property (nonatomic,copy) NSString *discount;

/** <#type#> */
@property (nonatomic,copy) NSString *bum_convert;
/** 开始时间 */
@property (nonatomic,copy) NSString *start_time;
/** 结束时间 */
@property (nonatomic,copy) NSString *end_time;
/** 商品价格 */

@property (nonatomic,copy) NSString *cash;
@property (nonatomic,copy) NSString *buy_nums;

@end
