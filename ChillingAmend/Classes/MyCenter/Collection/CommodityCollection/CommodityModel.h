//  收藏商品model
//  CommodityModel.h
//  ChillingAmend
//
//  Created by 许文波 on 15/1/12.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYC_BaseModel.h"

@interface CommodityModel : BYC_BaseModel

@property (nonatomic, strong) NSString *commdity_orderId; // 订单id
@property (nonatomic, strong) NSString *commodity_name; // 名称
@property (nonatomic, strong) NSString *commodity_img; // 图片
@property (nonatomic, strong) NSString *commodity_price; // 价格
@property (nonatomic, strong) NSString *commodity_cash; // 现金


- (void)parse:(id)aJsonString;


@end
