//
//  NdUncaughtExceptionHandler.h
//  Text_Bug
//
//  Created by pipixia on 15/1/19.
//  Copyright (c) 2015年 pipixia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

@interface NdUncaughtExceptionHandler : NSObject<ASIHTTPRequestDelegate>

+ (void)setDefaultHandler;
+ (NSUncaughtExceptionHandler*)getHandler;
- (void)sethttpBug;
+(id) Instence;

@end
