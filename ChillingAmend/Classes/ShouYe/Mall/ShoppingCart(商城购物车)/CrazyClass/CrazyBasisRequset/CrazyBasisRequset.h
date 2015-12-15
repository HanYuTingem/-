//
//  CrazyBasisRequset.h
//  MarketManage
//
//  Created by fielx on 15/4/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"


typedef void (^CompletionBlock)(NSDictionary *dic);
typedef void (^FailedBlock)(NSError *error);


/**
 *  请求数据类
 */
@interface CrazyBasisRequset : NSObject <ASIHTTPRequestDelegate>

+(ASIHTTPRequest *)requestGetInClass:(id)controller andWithUrlString:(NSString *)string  Completion:(CompletionBlock)Completion  Failed:(FailedBlock)Failed;

+(ASIFormDataRequest *)requestPostInClass:(id)controller andWithUrlString:(NSString *)string andContentDic:(NSDictionary *)dic Completion:(CompletionBlock)Completion  Failed:(FailedBlock)Failed;

@end
