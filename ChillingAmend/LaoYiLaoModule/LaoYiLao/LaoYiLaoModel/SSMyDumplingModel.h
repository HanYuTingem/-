//
//  SSMyDumplingModel.h
//  LaoYiLao
//
//  Created by sunsu on 15/11/6.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyDumplingListModel.h"
@interface SSMyDumplingModel : NSObject

@property (nonatomic, copy) NSString * code;
@property (nonatomic, copy) NSString * message;
@property (nonatomic, strong) MyDumplingListModel * resultListModel;


+ (SSMyDumplingModel *)getMyDumplingModelWithDic:(NSDictionary *)dic;

@end
