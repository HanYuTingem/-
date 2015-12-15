//  收藏视频model
//  CollectionMessageModel.m
//  ChillingAmend
//
//  Created by 许文波 on 14/12/26.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "CollectionMessageModel.h"

@implementation CollectionMessageModel

// 解析数据
- (void)parse:(id)aJsonString
{
    self.collectionId = IfNullToString([aJsonString objectForKey:@"id"]);
    self.video_name = IfNullToString([aJsonString objectForKey:@"video_name"]);
    self.video_img = IfNullToString([aJsonString objectForKey:@"video_img"]);
    self.create_time = IfNullToString([aJsonString objectForKey:@"create_time"]);
    self.status = IfNullToString([aJsonString objectForKey:@"status"]);
}

- (void)dealloc {
    self.collectionId = nil;
    self.video_name = nil;
    self.video_img = nil;
    self.create_time = nil;
    self.status = nil;
}

@end
