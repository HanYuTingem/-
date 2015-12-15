//
//  DayDayTreasureWinnerListModel.m
//  ChillingAmend
//
//  Created by svendson on 14-12-25.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "DayDayTreasureWinnerListModel.h"

@implementation DayDayTreasureWinnerListModel

+(DayDayTreasureWinnerListModel *)getAwardListModelWithDic:(NSDictionary *)dic
{
    DayDayTreasureWinnerListModel *model = [[DayDayTreasureWinnerListModel alloc] init];
    model.ceatTime = [dic objectForKey:@"create_time"];
    model.awardName = [dic objectForKey:@"jpname"];
    NSString *nickName = [dic objectForKey:@"nike_name"];
    if (nickName.length > 2) {
        model.winner  = [nickName stringByReplacingCharactersInRange:NSMakeRange(1, nickName.length - 2) withString:@"***"];
    } else model.winner  = nickName;
    
    return model;
}

@end
