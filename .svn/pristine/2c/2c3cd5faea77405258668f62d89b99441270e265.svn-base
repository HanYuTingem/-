//
//  CrazyShoppingCartShopTool.h
//  MarketManage
//
//  Created by fielx on 15/4/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  显示价格计算类
 */
@interface CrazyShoppingCartShopTool : NSObject


/**
 *  总价
 */
@property (assign,nonatomic) float mTotalPrice;


/**
 *  总积分
 */
@property (assign,nonatomic) float mTotalIntegral;


/**
 *  
    返回显示 价格 + 积分
    pirce 需要价格
    integral 需要积分
    number 购买数量
 */
+(NSString *)CrazyShoppingCartShopToolShowPriceWithPrice:(NSString *)pirce  integral:(NSString *)integral
                                                  number:(int)number;

/**
 *  刷新数据
 */
+(void)CrazyShoppingCartShopToolReloadData;


/**
 *
    返回显示 总价格 + 总积分  计算完毕刷新
    pirce 需要价格
    integral 需要积分
    number 购买数量
 */
+(NSString *)CrazyShoppingCartShopToolShowTotalPriceWithPrice:(NSString *)price  integral:(NSString *)integral
                                                       number:(int)number;

//总价
+(float)mTotalPrice;
//总积分
+(float)mTotalIntegral;


@end
