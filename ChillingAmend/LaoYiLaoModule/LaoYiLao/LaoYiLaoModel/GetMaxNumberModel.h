//
//  GetMaxNumberModel.h
//  LaoYiLao
//
//  Created by wzh on 15/11/6.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetMaxNumberModel : NSObject


@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *message;
//@property (nonatomic, strong) NSString *resultList;
@property (nonatomic, strong) NSString *count;

+ (GetMaxNumberModel *)getMaxNumberModelWithDic:(NSDictionary *)dic;
@end
