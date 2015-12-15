//
//  ListModel.h
//  tableView
//
//  Created by 许文波 on 15/7/10.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "JSONModel.h"

#import "goodsAttributeModel.h"


@protocol  goodsAttributeModel;

//@protocol ListModel <NSObject>
//
//@end

@interface ListModel : JSONModel

@property (nonatomic,copy) NSString *id;

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

/** 原价 */
@property (nonatomic,copy) NSString *market_cash;

/** 9.10  现金价钱用这个 */
@property (nonatomic,copy) NSString *goods_cash;


/** 商家id
 */

@property (nonatomic ,copy) NSString *shop_id;

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

/** 新版本 1.3.0  积分 */
@property (nonatomic,copy) NSString *goods_price;

/**
 *  失效 原因
 */
@property (nonatomic,copy) NSString *caption;

@property (nonatomic,strong) NSArray  <goodsAttributeModel>*goods_specarr;
/** cat_id */

@property (nonatomic, copy) NSString *cat_id;;

/**
 * 具体商品ID、
 */
@property (nonatomic, copy) NSString *goods_specid;
//@property (nonatomic,copy) NSString *goods_specarr;
/** 商品属性 */
/** 商品失效具体原因 */
@property (nonatomic,copy) NSString *type;




@end
