//
//  OnlineMOdel.h
//  HCheap
//
//  Created by JianDan on 14/12/28.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//
/*
 *  订座Model
 */
#import <Foundation/Foundation.h>

@interface OnlineModel : NSObject
//  订座时间
@property (nonatomic, copy)NSString *seatTime;

//  订座人数
@property (nonatomic, copy)NSString *seatPeople;

//  商家Id
@property (nonatomic, copy)NSString *ownerId;

//  用户ID
@property (nonatomic, copy)NSString *customerId;

//  用户名
@property (nonatomic, copy)NSString *userName;

//  性别  0女  1 男
@property (nonatomic, copy)NSString *sex;

//  手机号码
@property (nonatomic, copy)NSString *phone;

//  备注
@property (nonatomic, strong)NSString *note;

//  订座ID
@property (nonatomic, strong)NSString *seatOrderId;

//  商家名字
@property (nonatomic,strong)NSString *ownerName;

//更新时间
@property (nonatomic,strong)NSString *updateTime;

@end
