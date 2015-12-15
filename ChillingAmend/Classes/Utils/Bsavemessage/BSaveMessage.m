//
//  BSaveMessage.m
//  HealthExamine
//
//  Created by pipixia on 13-10-25.
//  Copyright (c) 2013年 SinoTeam. All rights reserved.
//

#import "BSaveMessage.h"

#define usernameMessage @"usernameMessage"

static BSaveMessage *gUserManager = nil;

@implementation BSaveMessage
@synthesize userId = _userId;

// 设置单例信息
- (void)resetInfo:(NSDictionary*)aDict
{
    self.userId = IfNullToString([aDict objectForKey:@"id"]);
    self.userCenterId = IfNullToString([aDict objectForKey:@"userid"]);
    self.userName = IfNullToString([aDict objectForKey:@"user_name"]);
    self.nickName = IfNullToString([aDict objectForKey:@"nike_name"]);
    self.userRemark = IfNullToString([aDict objectForKey:@"remark"]);
    self.userTag = IfNullToString([aDict objectForKey:@"tag"]);
    self.userBackground = IfNullToString([aDict objectForKey:@"background"]);
    self.userImage = IfNullToString([aDict objectForKey:@"img"]);
    self.userSex = IfNullToString([aDict objectForKey:@"sex"]);
    self.quyu = IfNullToString([aDict objectForKey:@"quyu"]);
    self.userType = IfNullToString([aDict objectForKey:@"type"]);
    self.shengri = IfNullToString([aDict objectForKey:@"shengri"]);
    if ([[aDict objectForKey:@"jifen"] isEqual:@""]) {
        self.jifen = @"0";
    } else self.jifen = [aDict objectForKey:@"jifen"];
    self.emial = IfNullToString([aDict objectForKey:@"email"]);
}

// 清除
- (void)clearInfo
{
    self.userId=@"";
    self.userCenterId = @"";
    self.userName = @"";
    self.nickName = @"";
    self.userRemark = @"";
    self.userTag = @"";
    self.userBackground = @"";
    self.userImage = @"";
    self.userSex = @"";
    self.quyu = @"";
    self.userType = @"";
    self.shengri = @"";
    self.jifen = @"";
    self.emial =@"";
}

- (id)init
{
    self = [super init];
    if (self) {
        self.userId = @"";
        self.userCenterId = @"";
        self.userName = @"";
        self.nickName = @"";
        self.userRemark = @"";
        self.userTag = @"";
        self.userBackground = @"";
        self.userImage = @"";
        self.userSex = @"";
        self.userType = @"";
        self.jifen = @"";
        self.shengri = @"";
        self.jifen = @"";
        self.emial =@"";
    }
    return self;
    
}

// 单例
+ (BSaveMessage *)Share
{
    if (!gUserManager) {
        gUserManager = [[BSaveMessage alloc] init];
    }
    return gUserManager;
}

- (void)dealloc {
    
    self.userId = nil;
    self.userCenterId = nil;
    self.userName = nil;
    self.nickName = nil;
    self.userRemark = nil;
    self.userTag = nil;
    self.userBackground = nil;
    self.userImage = nil;
    self.userSex = nil;
    self.userType = nil;
    self.jifen = nil;
    self.shengri = nil;
    self.jifen = nil;
    self.emial =nil;
    
}

+ (void)saveUserMessage:(NSDictionary *)userMsg
{
    [[NSUserDefaults standardUserDefaults] setObject:userMsg
                                              forKey:usernameMessage];
    [[NSUserDefaults standardUserDefaults] setObject:userMsg
                                              forKey:usernameMessagePHP];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)clear
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:usernameMessage];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:usernameMessagePHP];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
