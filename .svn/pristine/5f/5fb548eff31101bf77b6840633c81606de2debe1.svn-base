//
//  AFRequest.h
//  AFN的封装
//
//  Created by 刘雅楠 on 15/7/27.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface AFRequest : AFHTTPRequestOperationManager

+ (instancetype)sharedManager;

//无参数Get请求
+ (void)GetRequestWithUrl:(NSString *)url andBlock:(void (^)(id Datas, NSError *error))block;

//带参数Get请求
+ (void)GetRequestWithUrl:(NSString *)url parameters:(NSDictionary *)parameters andBlock:(void (^)(id Datas, NSError *error))block;

//无参数Post请求
+ (void)PostRequestWithUrl:(NSString *)url andBlock:(void (^)(id Datas, NSError *error))block;

//无参数Post请求
+ (void)PostRequestWithUrl:(NSString *)url parameters:(NSDictionary *)parameters andBlock:(void (^)(id Datas, NSError *error))block;



@end
