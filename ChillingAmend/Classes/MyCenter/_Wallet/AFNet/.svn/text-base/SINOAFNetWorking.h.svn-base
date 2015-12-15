//
//  SINOAFNetWorking.h
//  AFNetWorking
//
//  Created by 许文波 on 15/10/14.
//  Copyright (c) 2015年 GDH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface SINOAFNetWorking : NSObject


typedef void(^HttpSuccess)(id json);
typedef void(^HttpFailure)(NSError *error);
typedef void(^HttpNoNet)(void);



#pragma mark - 解析Json数据 有网络判断
/** 
 *  post 无参数请求 判断是否有网络
 *  @param url            地址链接
 *  @param controller     基于GCViewController
 *  @param success        成功回调
 *  @param failure        失败回调
 *  @param noNet          没有网络回调
 */
+(void)postWithBaseURL:(NSString *)url controller:(UIViewController *)controller success:(HttpSuccess)success failure:(HttpFailure)failure noNet:(HttpNoNet)noNet;


/**
 *  post 有参数请求 判断是否有网络
 *  @param url            地址链接
 *  @param controller     基于GCViewController
 *  @param params         参数
 *  @param success        成功回调
 *  @param failure        失败回调
 *  @param noNet          没有网络回调
 */
+(void)postWithBaseURL:(NSString *)url controller:(UIViewController *)controller params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure noNet:(HttpNoNet)noNet;

/**
 *  get 有参数请求 判断是否有网络
 *  @param url            地址链接
 *  @param controller     基于GCViewController
 *  @param params         参数
 *  @param success        成功回调
 *  @param failure        失败回调
 *  @param noNet          没有网络回调
 */
+(void)getWithBaseURL:(NSString *)url controller:(UIViewController *)controller params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure noNet:(HttpNoNet)noNet;

/**
 *  get 无参数请求 判断是否有网络
 *  @param url            地址链接
 *  @param controller     基于GCViewController
 *  @param success        成功回调
 *  @param failure        失败回调
 *  @param noNet          没有网络回调
 */
+(void)getWithBaseURL:(NSString *)url controller:(UIViewController *)controller success:(HttpSuccess)success failure:(HttpFailure)failure noNet:(HttpNoNet)noNet;

/** 取消所有的网络请求 */
+ (void)cancelAllRequest;


/** post 无参数请求 判断是否有网络 */
+(AFHTTPRequestOperation *)ApostWithBaseURL:(NSString *)url controller:(UIViewController *)controller success:(HttpSuccess)success failure:(HttpFailure)failure noNet:(HttpNoNet)noNet;


@end
