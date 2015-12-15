//
//  ProtiketModel.h
//  MyNiceFood
//
//  Created by liujinhe on 15/7/24.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProtiketModel : NSObject
@property(nonatomic,strong)NSString     * couponId;
@property(nonatomic,strong)NSString     * couponName;
@property(nonatomic,strong)NSString     * status;
@property(nonatomic,strong)NSString     * validBeginTime;
@property(nonatomic,strong)NSString     * validEndTime;
- (instancetype)initWithDic:(NSDictionary *)dic;
- (ProtiketModel*)protiketModelWithDic:(NSDictionary *)dic;

@end
