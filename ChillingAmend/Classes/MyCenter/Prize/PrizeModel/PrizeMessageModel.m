//
//  PrizeMessageModel.m
//  ChillingAmend
//
//  Created by 许文波 on 14/12/26.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "PrizeMessageModel.h"
#import "JPCommonMacros.h"

@implementation PrizeMessageModel

- (void)parse:(id)aJsonString
{
    self.prizeId = IfNullToString([aJsonString objectForKey:@"id"]);
    self.prizeBeginTime = IfNullToString([aJsonString objectForKey:@"create_time"]);
    self.prizeEndTime = IfNullToString([aJsonString objectForKey:@"end_time"]);
    self.day = IfNullToString([aJsonString objectForKey:@"day"]);
    self.prizeName = IfNullToString([aJsonString objectForKey:@"name"]);
    self.prizeImageUrl = IfNullToString([aJsonString objectForKey:@"img"]);
    self.prizeStatus = IfNullToString([aJsonString objectForKey:@"status"]);
    self.prizeType = IfNullToString([aJsonString objectForKey:@"lingqu_type"]);
}

- (void)dealloc {
    self.prizeId=nil;
    self.prizeBeginTime = nil;
    self.prizeEndTime = nil;
    self.day = nil;
    self.prizeName = nil;
    self.prizeImageUrl = nil;
    self.prizeStatus =nil;
    self.prizeType = nil;
}

@end
