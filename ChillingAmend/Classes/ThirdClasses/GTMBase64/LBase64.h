//
//  LBase64.h
//  黑土
//
//  Created by 李自力 on 14-1-20.
//  Copyright (c) 2014年 purplepeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBase64 : NSObject
+ (NSString*)encodeBase64String:(NSString*)input;

+ (NSString*)decodeBase64String:(NSString*)input;

+ (NSString*)encodeBase64Data:(NSData*)data;

+ (NSString*)decodeBase64Data:(NSData*)data;
@end
