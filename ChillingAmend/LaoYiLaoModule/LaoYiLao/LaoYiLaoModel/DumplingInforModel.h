//
//  DumplingInforModel.h
//  LaoYiLao
//
//  Created by wzh on 15/11/6.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DumplingInforResultModel.h"
#define DumplingTypeMoney @"1"//1.钱
#define DumplingTypeBlessing @"2"//2祝福
#define DumplingTypeCoupon @"3"//3优惠卷

@interface DumplingInforModel : NSObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) DumplingInforResultModel *resultListModel;


+ (DumplingInforModel *)dumplingInforModelWithDic:(NSDictionary *)dic;
@end
