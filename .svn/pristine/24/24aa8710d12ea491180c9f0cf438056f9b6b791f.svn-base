//
//  MessageModel.m
//  ChillingAmend
//
//  Created by 许文波 on 14/12/22.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "MessageModel.h"
#import "JPCommonMacros.h"

@implementation MessageModel

- (void)parse:(id)aJsonString
{
    self.messageId = IfNullToString([aJsonString objectForKey:@"id"]);
    self.createTime = IfNullToString([aJsonString objectForKey:@"create_time"]);
    self.createUser = IfNullToString([aJsonString objectForKey:@"create_user"]);
    self.updateTime = IfNullToString([aJsonString objectForKey:@"update_time"]);
    self.updateUser = IfNullToString([aJsonString objectForKey:@"update_user"]);
    self.content = IfNullToString([aJsonString objectForKey:@"content"]);
    self.imageUrl = IfNullToString([aJsonString objectForKey:@"create_time"]);
    self.type = IfNullToString([aJsonString objectForKey:@"type"]);
}
- (void)clearInfo
{
    self.messageId=@"";
    self.createTime = @"";
    self.createUser = @"";
    self.updateTime = @"";
    self.updateUser = @"";
    self.content = @"";
    self.imageUrl = @"";
    self.type = @"";
}
- (id)init
{
    self = [super init];
    if (self) {
        self.messageId=@"";
        self.createTime = @"";
        self.createUser = @"";
        self.updateTime = @"";
        self.updateUser = @"";
        self.content = @"";
        self.imageUrl = @"";
        self.type = @"";
    }
    return self;
    
}
@end
