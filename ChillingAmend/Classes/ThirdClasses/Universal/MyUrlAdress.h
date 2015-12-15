//
//  MyUrlAdress.h
//  ILoveTheInvention
//
//  Created by LY on 13-12-21.
//  Copyright (c) 2013年 qiaohongchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyUrlAdress : NSObject

+ (NSString *)imei;

+ (NSString *)getUrlAdressWithUrl:(NSString *)url andParameterArray:(NSArray *)key andValue:(NSArray *)value;

@end
