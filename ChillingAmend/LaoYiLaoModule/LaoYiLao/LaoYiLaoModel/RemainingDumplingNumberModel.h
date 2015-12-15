//
//  RemainingDumplingNumberModel.h
//  LaoYiLao
//
//  Created by wzh on 15/11/10.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemainingDumplingNumberModel : NSObject
@property (nonatomic, copy) NSString * code;
@property (nonatomic, copy) NSString * message;
@property (nonatomic, strong) NSString *number;
+ (RemainingDumplingNumberModel *)remainingDumplingNumberModelWithDic:(NSDictionary *)dic;

@end
