//
//  LBase64.m
//  辣椒圈
//
//  Created by 李自力 on 14-1-20.
//  Copyright (c) 2014年 purplepeng. All rights reserved.
//

#import "LBase64.h"
#import "GTMBase64.h"

@implementation LBase64
+ (NSString*)encodeBase64String:(NSString* )input {
    
    NSData*data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString * base64String = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
    return base64String;
    
}

+ (NSString*)decodeBase64String:(NSString* )input {
    
    NSData*data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    NSString*base64String = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
    return base64String;
    
}

+ (NSString*)encodeBase64Data:(NSData*)data {
    
    data = [GTMBase64 encodeData:data];
    NSString*base64String = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
    return base64String;
    
}

+ (NSString*)decodeBase64Data:(NSData*)data {
    
    data = [GTMBase64 decodeData:data];
    NSString*base64String = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
    return base64String;
    
}
@end
