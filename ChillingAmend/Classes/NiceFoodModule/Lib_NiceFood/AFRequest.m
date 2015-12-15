//
//  AFRequest.m
//  AFN的封装
//
//  Created by 刘雅楠 on 15/7/27.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "AFRequest.h"

@implementation AFRequest

//单例
+ (instancetype)sharedManager{
    
    static AFRequest *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedManager = [AFRequest manager];
        sharedManager.requestSerializer.timeoutInterval = 20.0;
        sharedManager.responseSerializer = [AFJSONResponseSerializer serializer];
        sharedManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json", @"text/javascript", nil];
    });
    return sharedManager;
}


//带参数Get请求
+ (void)GetRequestWithUrl:(NSString *)url parameters:(NSDictionary *)parameters andBlock:(void (^)(id, NSError *))block{
    NSLog(@"Get请求--开始请求数据");
   ;
    [[AFRequest sharedManager] GET:url parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id data) {
        block(data, nil);
//       NSLog(@"operation=%@",operation);
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@", error);
        block([NSArray array], error);
    }];
}


//无参数Get请求
+ (void)GetRequestWithUrl:(NSString *)url andBlock:(void (^)(id, NSError *))block{
    [AFRequest GetRequestWithUrl:url parameters:nil andBlock:^(id Datas, NSError *error) {
        block(Datas, error);
    }];
}



//带参数Post请求
+ (void)PostRequestWithUrl:(NSString *)url parameters:(NSDictionary *)parameters andBlock:(void (^)(id, NSError *))block{
    NSLog(@"Post请求--开始请求数据");
    [[AFRequest sharedManager] POST:url parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id data) {
        block(data,nil);
//        NSLog(@"operation=%@",operation);
        
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@", error);
        block([NSDictionary dictionary], error);
    }];
}


//无参数Post请求
+ (void)PostRequestWithUrl:(NSString *)url andBlock:(void (^)(id, NSError *))block{
    [AFRequest PostRequestWithUrl:url parameters:nil andBlock:^(id Datas, NSError *error) {
        block(Datas, error);
    }];
}


@end
