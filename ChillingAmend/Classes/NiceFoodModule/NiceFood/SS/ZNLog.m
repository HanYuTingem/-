//
//  ZNLog.m
//  LightPole
//
//  Created by steven on 3/5/09.
//  Copyright 2009 LightPole. All rights reserved.
//

#import "ZNLog.h"


@implementation ZNLog

+ (void)file:(char*)sourceFile function:(char*)functionName lineNumber:(int)lineNumber format:(NSString*)format, ...
{
#ifdef TARGET_IPHONE_DEBUG
    //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    va_list ap;
    NSString *print, *file, *function;
    va_start(ap,format);
    file = [[NSString alloc] initWithBytes: sourceFile length: strlen(sourceFile) encoding: NSUTF8StringEncoding];
    
    function = [NSString stringWithCString:functionName encoding:NSUTF8StringEncoding];
    print = [[NSString alloc] initWithFormat: format arguments: ap];
    va_end(ap);
    NSLog(@"%@:%d %@; %@\n\n", [file lastPathComponent], lineNumber, function, print);
//    [print release];
//    [file release];
//    [pool release];
#endif
}

@end