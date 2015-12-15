//
//  GetShareInfoModel.h
//  LaoYiLao
//
//  Created by sunsu on 15/11/11.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetShareInfoResultModel.h"
@interface GetShareInfoModel : NSObject
@property (nonatomic, copy) NSString * code;
@property (nonatomic, copy) NSString * message;
@property (nonatomic, strong) GetShareInfoResultModel * resultModel;
+(GetShareInfoModel *)getShareInfoModelWithDic:(NSDictionary *)dic;

@end
