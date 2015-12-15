//
//  PRJ_BusinessModel.h
//  ChillingAmend
//
//  Created by 孙瑞 on 15/9/16.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRJ_BusinessModel : NSObject

//推荐商家ID
@property (nonatomic, strong) NSString *businessID;
+ (PRJ_BusinessModel *)getBusinessModelWithDic:(NSDictionary *)dic;
@end
