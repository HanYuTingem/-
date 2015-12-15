//
//  DayDayTreasureWinnerListModel.h
//  ChillingAmend
//
//  Created by svendson on 14-12-25.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DayDayTreasureWinnerListModel : NSObject

/*
 *ceatTime        获奖时间
 *awardName       奖品名称
 *winner          获奖者
 */
@property (nonatomic, strong) NSString *ceatTime;
@property (nonatomic, strong) NSString *awardName;
@property (nonatomic, strong) NSString *winner;

+(DayDayTreasureWinnerListModel *)getAwardListModelWithDic:(NSDictionary *)dic;

@end
