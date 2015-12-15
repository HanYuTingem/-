//
//  PRJ_YaoYiYaoDetailsModel.m
//  ChillingAmend
//
//  Created by svendson on 15-1-5.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import "PRJ_YaoYiYaoDetailsModel.h"
#import "BXAPI.h"
@implementation PRJ_YaoYiYaoDetailsModel

+(PRJ_YaoYiYaoDetailsModel *)getYaoYiYaoDetailModelWithDic:(NSDictionary *)dic
{
    PRJ_YaoYiYaoDetailsModel *model = [[PRJ_YaoYiYaoDetailsModel alloc]init];
    model.reCordID = [dic objectForKey:@"id"];
    model.yaoJiangMusic = [dic objectForKey:@"song"];
    model.yaoDongMusic  = [dic objectForKey:@"rock_song"];
    model.channel = [dic objectForKey:@"channel"];
    model.start_time = [dic objectForKey:@"start_time"];
    model.stop_time = [dic objectForKey:@"stop_time"];
    model.image  = [dic objectForKey:@"image"];
    model.status = [dic objectForKey:@"status"];
    model.next = [dic objectForKey:@"next"];
    
    return model;
}

@end
