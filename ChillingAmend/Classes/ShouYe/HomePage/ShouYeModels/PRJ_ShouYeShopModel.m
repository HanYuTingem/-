//
//  PRJ_ShouYeShopModel.m
//  ChillingAmend
//
//  Created by svendson on 14-12-25.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "PRJ_ShouYeShopModel.h"
#import "BXAPI.h"
@implementation PRJ_ShouYeShopModel

+(PRJ_ShouYeShopModel *)getShopDetailModelWithDic:(NSDictionary *)dic
{
    PRJ_ShouYeShopModel *model = [[PRJ_ShouYeShopModel alloc]init];
    model.shopCash = [NSString stringWithFormat:@"现金%@",dic[@"cash"]];
    model.ShopID = dic[@"id"];
    model.ShopImageUrl = [NSString stringWithFormat:@"%@",dic[@"img_url"]];
    model.shopName = dic[@"name"];
    if ([dic[@"price"] intValue] == 0) {
        model.shopJiFenPrice = @"";
    } else {
        model.shopJiFenPrice = [NSString stringWithFormat:@"+%@积分", dic[@"price"] ];
    }

    return model;
}
@end
