//
//  DumplingInforResultModel.h
//  LaoYiLao
//
//  Created by wzh on 15/11/7.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DumplingInforDetailResultDumplingModel.h"
@interface DumplingInforResultModel : NSObject

@property (nonatomic, strong) NSString *userHasNum;
@property (nonatomic, strong) NSString *starIcon;
@property (nonatomic, strong) NSString *starName;
/**
 * 分享是否增加次数，0 增加 1不增加
 */
@property (nonatomic, strong) NSString *isMarkShare;
@property (nonatomic, strong) DumplingInforDetailResultDumplingModel *dumplingModel;

@property (nonatomic, strong) NSString *todayMoney;

+ (DumplingInforResultModel *)dumplingInforResultModelWithDic:(NSDictionary *)dic;

@end
