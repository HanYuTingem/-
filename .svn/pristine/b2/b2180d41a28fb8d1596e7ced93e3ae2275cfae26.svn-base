//
//  CommodityModel.m
//  ChillingAmend
//
//  Created by 许文波 on 15/1/12.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import "CommodityModel.h"
#import "JPCommonMacros.h"

@implementation CommodityModel

- (void)parse:(id)aJsonString
{
    self.collectionId = IfNullToString([aJsonString objectForKey:@"obj_id"]);
    self.commdity_orderId = IfNullToString([aJsonString objectForKey:@"id"]);
    self.commodity_name = IfNullToString([aJsonString objectForKey:@"name"]);
    self.commodity_img = IfNullToString([aJsonString objectForKey:@"img_url"]);
    self.commodity_price = IfNullToString([aJsonString objectForKey:@"price"]);
    self.commodity_cash = IfNullToString([aJsonString objectForKey:@"cash"]);
    self.create_time = IfNullToString([aJsonString objectForKey:@"create_time"]);
}

- (void)dealloc {
    self.collectionId = nil;
    self.commdity_orderId = nil;
    self.commodity_name = nil;
    self.commodity_img = nil;
    self.commodity_price = nil;
    self.commodity_cash= nil;
    self.create_time = nil;
}

@end
