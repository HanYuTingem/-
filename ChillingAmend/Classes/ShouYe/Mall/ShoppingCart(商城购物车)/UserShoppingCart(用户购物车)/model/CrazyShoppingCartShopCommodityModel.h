//
//  CrazyShoppingCartShopCommodity.h
//  MarketManage
//
//  Created by fielx on 15/4/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisModel.h"
#import "CrazyShoppingCartShopTool.h"

/**
 *   购物车 用户购买商品
 */
@interface CrazyShoppingCartShopCommodityModel : CrazyBasisModel




/**
 *  商家Id
 */
@property (retain,nonatomic) NSString *mShopId;


/**
 *  可购买数量
 */
@property (assign,nonatomic) int mAvailable;

/**
 *  限购数量
 */
@property (retain,nonatomic) NSString *mRestrictionmNumber;



/**
 *  显示价格
 */
@property (retain,nonatomic) NSString *mShowPrice;

/**
 *  是否选中
 */
@property (assign,nonatomic) BOOL mIsSelect;


/**
 *  用户购买数量
 */
@property (assign,nonatomic) int mNumber;

/**
 *   库存
 */
@property (assign,nonatomic) int mMaxNumber;


/**
 *  用户是否可以购买
 */
//@property (assign,nonatomic) BOOL mIsPurchase;


/**
 *  记录原来的状态
 */
//@property (assign,nonatomic) BOOL mIsOriginally;

@end
