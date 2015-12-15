//
//  LYLLoginModel.h
//  LaoYiLao
//
//  Created by sunsu on 15/11/9.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 code = 1;
 message = "";
 result =
 */
#import "LYLLoginModel.h"
#import "LYLLoginResultModel.h"


@interface LYLLoginModel : NSObject

@property (nonatomic, copy) NSString * code;
@property (nonatomic, copy) NSString * message;
@property (nonatomic, strong) LYLLoginResultModel *resultModel;
+ (LYLLoginModel *)getLYLLoginModelWithDic:(NSDictionary *)dic;

@end
