//
//  CJAttributeModle.h
//  MarketManage
//
//  Created by 赵春景 on 15-8-3.
//  Copyright (c) 2015年 Rice. All rights reserved.
//  商品属性 一级模型

#import "BaseModel.h"


@interface CJAttributeModle : BaseModel

/** 商品的父类ID */
@property (nonatomic, copy) NSString *ModeleId;

/** 现金 */
@property (nonatomic, copy) NSString *cash;
/** 个数 */
@property (nonatomic, copy) NSString *nums;
/** 默认选中 */
@property (nonatomic, copy) NSString *defaultP;

/** spec_id 规格属性 数组 分别套有 key 和 Value 两个键值队 */
@property (nonatomic, strong) NSMutableArray *spec_idArray;

@end
