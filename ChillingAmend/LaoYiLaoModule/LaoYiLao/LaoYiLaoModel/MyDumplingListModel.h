//
//  MyDumplingListModel.h
//  LaoYiLao
//
//  Created by sunsu on 15/11/9.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 blessingNumber = 0;
 cardNumber = 0;
 count = 0;
 couponNumber = 0;
 price = "0.0";
 */
@interface MyDumplingListModel : NSObject
@property (nonatomic, copy) NSString * blessingNumber;
@property (nonatomic, copy) NSString * cardNumber;
@property (nonatomic, copy) NSString * count;
@property (nonatomic, copy) NSString * couponNumber;
@property (nonatomic, copy) NSString * price;

+ (MyDumplingListModel *)getMyDumplingListModelWithDic:(NSDictionary *)dic;
@end
