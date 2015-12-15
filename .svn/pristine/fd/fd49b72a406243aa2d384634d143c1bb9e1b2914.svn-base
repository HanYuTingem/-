//
//  LuckyGuyModel.m
//  ChillingAmend
//
//  Created by 许文波 on 15/1/21.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import "LuckyGuyModel.h"
#import "JPCommonMacros.h"

@implementation LuckyGuyModel

+ (LuckyGuyModel *)getLuckyGuyModelModelWithDic:(NSDictionary *)dic
{
    LuckyGuyModel *model = [[LuckyGuyModel alloc] init];
    model.img = IfNullToString([dic objectForKey:@"img"]);
    model.big_img = IfNullToString([dic objectForKey:@"big_img"]);
    model.descript = IfNullToString([dic objectForKey:@"descript"]);
    model.level = IfNullToString([dic objectForKey:@"level"]);
    model.weizhi = IfNullToString([dic objectForKey:@"weizhi"]);
    model.content = IfNullToString([dic objectForKey:@"content"]);
    return model;
}

@end
