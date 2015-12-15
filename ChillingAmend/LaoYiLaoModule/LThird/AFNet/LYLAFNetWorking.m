//
//  SINOAFNetWorking.m
//  AFNetWorking
//
//  Created by 许文波 on 15/10/14.
//  Copyright (c) 2015年 GDH. All rights reserved.
//

#import "LYLAFNetWorking.h"
#import "AFNetworking.h"
#import "MBProgressHUD+Add.h"
@implementation LYLAFNetWorking


/** post 有参数请求 判断是否有网络 */
+(void)postWithBaseURL:(NSString *)url controller:(UIViewController *)controller params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure noNet:(HttpNoNet)noNet{
    // 没有网络时  10.15 添加
    [LYLTools connectedToNetwork:^(NSString *connectedToNet) {
        if ([connectedToNet isEqualToString:[NSString stringWithFormat:@"%d",NotReachable]]) {
            [MBProgressHUD showConnectNetWork:connectedToNet toView:controller.view];
            noNet();
            return ;
        } else {
            [self requestPostWithBaseURL:url params:params success:success failure:failure ];
        }
    }];
}

/** post 无参数请求 判断是否有网络 */
+(void)postWithBaseURL:(NSString *)url controller:(UIViewController *)controller success:(HttpSuccess)success failure:(HttpFailure)failure noNet:(HttpNoNet)noNet
{
    // 没有网络时  10.15 添加
    [LYLTools connectedToNetwork:^(NSString *connectedToNet) {
        if ([connectedToNet isEqualToString:[NSString stringWithFormat:@"%d",NotReachable]]) {
            [MBProgressHUD showConnectNetWork:connectedToNet toView:controller.view];
            noNet();
            return ;
        } else {
            [self requestPostWithBaseURL:url params:nil success:success failure:failure];
        }
    }];
}


/** get 有参数请求 判断是否有网络 */
+(void)getWithBaseURL:(NSString *)url controller:(UIViewController *)controller params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure noNet:(HttpNoNet)noNet{
    // 没有网络时  10.15 添加
    [LYLTools connectedToNetwork:^(NSString *connectedToNet) {
        if ([connectedToNet isEqualToString:[NSString stringWithFormat:@"%d",NotReachable]]) {
            [MBProgressHUD showConnectNetWork:connectedToNet toView:controller.view];
            noNet();
            return ;
        } else {
            [self requestGetWithBaseURL:url params:params success:success failure:failure];
        }
    }];
}

/** get 无参数请求 判断是否有网络 */
+(void)getWithBaseURL:(NSString *)url controller:(UIViewController *)controller success:(HttpSuccess)success failure:(HttpFailure)failure noNet:(HttpNoNet)noNet{
    // 没有网络时  10.15 添加
    [LYLTools connectedToNetwork:^(NSString *connectedToNet) {
        if ([connectedToNet isEqualToString:[NSString stringWithFormat:@"%d",NotReachable]]) {
            [MBProgressHUD showConnectNetWork:connectedToNet toView:controller.view];
            noNet();
            return ;
        } else {
            [self requestGetWithBaseURL:url params:nil success:success failure:failure];
        }
    }];
}



/** post 有参数请求 */
+(void)postWithBaseURL:(NSString *)url params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure{    
    [self requestPostWithBaseURL:url params:params success:success failure:failure ];
}
/** post 无参数请求 */
+(void)postWithBaseURL:(NSString *)url success:(HttpSuccess)success failure:(HttpFailure)failure{
    
    [self requestPostWithBaseURL:url params:nil success:success failure:failure];
}

/** get 有参数请求 */
+(void)getWithBaseURL:(NSString *)url params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure{
    
    [self requestGetWithBaseURL:url params:params success:success failure:failure];
}
/** get 无参数请求 */
+(void)getWithBaseURL:(NSString *)url success:(HttpSuccess)success failure:(HttpFailure)failure{
    [self requestGetWithBaseURL:url params:nil success:success failure:failure];
}



+ (void)requestPostWithBaseURL:(NSString *)url params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure {
    
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    //创建字典
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json",@"text/plain", nil];
//    [manager.operationQueue cancelAllOperations];
    //中文转码，中文会转换为%E%D%EB这些，英文则不影响
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
    }];
}

+ (void)requestGetWithBaseURL:(NSString *)url params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure {
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    //创建字典
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json",@"text/plain", nil];
    manager.requestSerializer.timeoutInterval = 10;

    //中文转码，中文会转换为%E%D%EB这些，英文则不影响
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}


@end
