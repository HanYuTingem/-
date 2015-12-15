//
//  DumplingInforListDetailModel.h
//  LaoYiLao
//
//  Created by wzh on 15/11/6.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DumplingInforListResultModel : NSObject

@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *info;

+ (DumplingInforListResultModel *)dumplingInforListResultModelWithDic:(NSDictionary *)dic;
@end
