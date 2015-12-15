//
//  DumplingInforList.h
//  LaoYiLao
//
//  Created by wzh on 15/11/6.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DumplingInforListResultModel.h"
@interface DumplingInforListModel : NSObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSMutableArray * dumplingInforList;
+ (DumplingInforListModel *)dumplingInforListModelWithDic:(NSDictionary *)dic;

@end
