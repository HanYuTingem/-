//
//  goodsAttributeModel.h
//  MarketManage
//
//  Created by 许文波 on 15/8/10.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "JSONModel.h"


@interface goodsAttributeModel : JSONModel

/** 商品参数 */
@property (nonatomic,copy) NSString *value;
/** 商品参数 */
@property (nonatomic,copy) NSString *key;

@end
