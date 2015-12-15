//
//  CrazyShoppingCartShopModel.h
//  MarketManage
//
//  Created by fielx on 15/4/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisModel.h"

#import "CrazyShoppingCartShopCommodityModel.h"
#import "CrazyShoppingCartViewFile.h"
#import "CrazyShoppingCartShopTool.h"
/**
 *   购物车 用户购买物品的店面  里面有该店面用户购买商品的数组
 */
@interface CrazyShoppingCartShopModel : CrazyBasisModel




/**
 *  商品数组
 */
@property (retain,nonatomic) NSMutableArray *mArray;



/**
 *  选中的商品
 */
@property (retain,nonatomic) NSMutableArray *mSelectArray;

/**
 *  cell高度
 */
@property (assign,nonatomic) float mCellHeight;

/**
 *  总价
 */
@property (assign,nonatomic) float mTotalPrice;

/**
 *  总积分
 */
@property (assign,nonatomic) float mTotalIntegral;


/**
 *  小计
 */
@property (retain,nonatomic) NSString *mShowPrice;

/**
 * 运费
 */
@property (retain,nonatomic) NSString * mCountFreight;


@end
