//
//  UserShoppingAddorRemoveModel.h
//  MarketManage
//
//  Created by fielx on 15/4/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(int, CrazyShoppingAddorRemoveModelType)
{
    CrazyShoppingAddorRemoveModelTypeAdd = 0,
    CrazyShoppingAddorRemoveModelTypeRemove
};

typedef void (^completeBlock)(NSDictionary * infoDic);

/**
 *  购物车添加或删除
 */
@interface CrazyShoppingAddorRemoveModel : NSObject

+(void)crazyShoppingAddorRemoveModelType:(CrazyShoppingAddorRemoveModelType)type loadController:(id)controller  goodsId:(NSString *)goodsId completeBlock:(completeBlock)block  ;

/**
 * 15.8.11添加 type添加或删除 goodsId商品的ID spec_arr属性选择后的属性数组 spec_id属性选择后的具体商品ID nums 购买的商品数量
 */
+(void)crazyShoppingAddorRemoveModelType:(CrazyShoppingAddorRemoveModelType)type loadController:(id)controller  goodsId:(NSString *)goodsId goodsAttributeArray:(NSArray *)spec_arr goodsAttributeId:(NSString *)spec_id goodsAttributeNums:(NSString *)nums isupdate:(BOOL)isupdate completeBlock:(completeBlock)block;

@end
