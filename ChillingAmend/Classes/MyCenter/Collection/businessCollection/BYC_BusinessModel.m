//
//  BYC_BusinessModel.m
//  ChillingAmend
//
//  Created by 孙瑞 on 15/9/21.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import "BYC_BusinessModel.h"
#import "JPCommonMacros.h"

@implementation BYC_BusinessModel

- (void)parse:(id)aJsonString
{
    self.collectionId = IfNullToString([aJsonString objectForKey:@"ownerId"]);
    self.business_name = IfNullToString([aJsonString objectForKey:@"ownerName"]);
    self.business_img = IfNullToString([aJsonString objectForKey:@"shopImageUrl"]);
    self.business_address = IfNullToString([aJsonString objectForKey:@"districtName"]);
    self.business_star = IfNullToString([aJsonString objectForKey:@"star"]);
    self.business_consumption = IfNullToString([aJsonString objectForKey:@"consumption"]);
    self.business_industryName = IfNullToString([aJsonString objectForKey:@"industryName"]);
}

- (void)dealloc {
    self.collectionId = nil;
    self.business_name = nil;
    self.business_img = nil;
    self.business_address = nil;
    self.business_star = nil;
    self.business_consumption = nil;
    self.business_industryName = nil;
}

@end
