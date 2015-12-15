//
//  OrderStatusViewController.h
//  QQList
//
//  Created by sunsu on 15/7/6.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderStatusViewController : BaseViewController
// 商户名
@property (nonatomic, strong)NSString *ownerName;
// 时间
@property (nonatomic, strong)NSString *numberDate;
// 人数
@property (nonatomic, strong)NSString *numberPerson;
// 联系人
@property (nonatomic, strong)NSString *personName;
// 1先生/0女士
@property (nonatomic, strong)NSString *sex;
// 电话
@property (nonatomic, strong)NSString *numberTell;
// 订座ID
@property (nonatomic, strong)NSString *seatId;
// 商家ID
@property (nonatomic, strong)NSString *ownerId;
//  1-提交订单成功    2-修改订单成功
@property (nonatomic, strong)NSString *isModification;

@end
