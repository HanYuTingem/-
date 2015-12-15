//
//  PrizeMessageModel.h
//  ChillingAmend
//
//  Created by 许文波 on 14/12/26.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrizeMessageModel : NSObject

@property (nonatomic,strong) NSString * prizeId; // id
@property (nonatomic,strong) NSString * prizeBeginTime; // 领奖开始时间
@property (nonatomic,strong) NSString * prizeEndTime; // 领奖结束时间
@property (nonatomic,strong) NSString * day; // 天数
@property (nonatomic,strong) NSString * prizeName; // 奖品名称
@property (nonatomic,strong) NSString * prizeImageUrl; // 奖品图片
@property (nonatomic,strong) NSString * prizeStatus; // 状态
@property (nonatomic,strong) NSString * prizeType; // 类型

- (void)parse:(id)aJsonString;

@end
