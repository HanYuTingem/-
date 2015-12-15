//
//  InvalidModel.h
//  MarketManage
//
//  Created by 许文波 on 15/8/7.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvalidModel : NSObject

/**
 商品名字
 */
@property(nonatomic,strong)NSString *goods_name;
/**
 商品数量
 */
@property(nonatomic,assign)int goods_nums;
/**  商品图片 */
@property(nonatomic,copy) NSString *goods_imgurl;
/** 现金 */
@property (nonatomic,copy) NSString *cash;
/** 商家id
 */
@property (nonatomic,copy) NSString *shop_id;

/** 商品id */
@property(nonatomic,copy) NSString *goods_id;
/**
 *   库存
 */
@property (assign,nonatomic) int nums;
/** 用户可购买数量 */
@property(nonatomic,copy) NSString * available;

/**   限购数量 */
@property (nonatomic,assign) int restriction;

/** 积分 */
@property (nonatomic,copy) NSString *price;



@property (nonatomic,copy) NSString *caption;

- (id)initWithDic:(NSDictionary *)dic;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
