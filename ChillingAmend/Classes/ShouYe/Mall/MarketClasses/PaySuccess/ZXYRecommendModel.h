//
//  ZXYRecommendModel.h
//  MarketManage
//
//  Created by Rice on 15/1/25.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarketAPI.h"

@interface ZXYRecommendModel : NSObject

@property (copy, nonatomic) NSString *goodsImage;    //商品图片
@property (copy, nonatomic) NSString *goodsTitle;    //商品名称
@property (copy, nonatomic) NSString *goodsCash;     //商品单价-现金
@property (copy, nonatomic) NSString *goodsSpending; //商品单价-积分
@property (copy, nonatomic) NSString *goodsId;       //商品id

+(ZXYRecommendModel *)createObjWithDic:(NSDictionary *)subDict withImageHost:(NSString *)host;

@end
