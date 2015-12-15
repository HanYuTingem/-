//
//  AFNetRequest.m
//  AFNetWorking
//
//  Created by 李维昌 on 15/6/4.
//  Copyright (c) 2015年 GDH. All rights reserved.
//

#import "AFNetRequest.h"

@implementation AFNetRequest

#pragma  mark 解析数据
+(void)postWithBaseURL:(NSString *)url  success:(HttpSuccess)success failure:(HttpFailure)failure
{
    [self requestWithBaseURL:url success:success failure:failure];
}

#pragma mark 上传参数 注册 登陆
+(void)UploadWithUrl:(NSString *)url success:(HttpSuccess)success failure:(HttpFailure)failure
{
    
    [self UpLoadUrl:url success:success failure:failure];
}

#pragma 上传参数
+ (void)UpLoadUrl:(NSString *)url success:(HttpSuccess)success failure:(HttpFailure)failure
{   
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    //创建字典
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json",@"text/plain", nil];
    //中文转码，中文会转换为%E%D%EB这些，英文则不影响
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        NSLog(@"请求成功~~%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败~~%@",error);
        
        failure(error);
    }];
}


+ (void)requestWithBaseURL:(NSString *)url success:(HttpSuccess)success failure:(HttpFailure)failure
{
    
    NSURL *url2 = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url2];
    // 创建operation对象
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",operation.responseString);
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        // 注意:这里一定要判断block是否为空,不判断的话可能会报错.
        if (success) {
            success(json);
        }
        //
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
        NSLog(@"%@",error);
    }];
    
    [operation start];
    
}


@end
