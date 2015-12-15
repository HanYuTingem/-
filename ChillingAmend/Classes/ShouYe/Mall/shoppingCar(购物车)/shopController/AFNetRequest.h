//
//  AFNetRequest.h
//  AFNetWorking
//
//  Created by 李维昌 on 15/6/4.
//  Copyright (c) 2015年 GDH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AFNetRequest : NSObject



typedef void(^HttpSuccess)(id json);
typedef void(^HttpFailure)(NSError *error);




#pragma mark 解析Json数据
+ (void)postWithBaseURL:(NSString *)url success:(HttpSuccess)success failure:(HttpFailure)failure;


#pragma mark 上传参数
+(void)UploadWithUrl:(NSString *)url success:(HttpSuccess)success failure:(HttpFailure)failure;


@end
