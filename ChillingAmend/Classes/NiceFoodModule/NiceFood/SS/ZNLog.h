//
//  ZNLog.h
//  LightPole
//
//  Created by steven on 3/5/09.
//  Copyright 2009 LightPole. All rights reserved.
//

//#import <Cocoa/Cocoa.h>


@interface ZNLog : NSObject {}


+(void)file:(char*)sourceFile function:(char*)functionName lineNumber:(int)lineNumber format:(NSString*)format, ...;

#define ZNLog(s, ...) [ZNLog file:__FILE__ function: (char *)__FUNCTION__ lineNumber:__LINE__ format:(s),##__VA_ARGS__]

@end

