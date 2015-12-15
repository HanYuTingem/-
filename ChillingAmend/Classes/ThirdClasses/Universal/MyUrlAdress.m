//
//  MyUrlAdress.m
//  ILoveTheInvention
//
//  Created by LY on 13-12-21.
//  Copyright (c) 2013年 qiaohongchao. All rights reserved.
//

#import "MyUrlAdress.h"
#import "UIDevice+IdentifierAddition.h"

@implementation MyUrlAdress


+ (NSString *)imei
{
    UIDevice * device = [[UIDevice alloc]init];
    
    return [device uniqueDeviceIdentifier];
}
+ (NSString *)getUrlAdressWithUrl:(NSString *)url andParameterArray:(NSArray *)key andValue:(NSArray *)value
{
    NSString * urlAdr = [NSString stringWithFormat:@"%@{",url];
    for (int i = 0; i < key.count; i++) {
        NSString * keyStr = [key objectAtIndex:i];
        NSString * valueStr = [value objectAtIndex:i];
        NSString * str = [NSString stringWithFormat:@"\"%@\":\"%@\"",keyStr,valueStr];
          if (i != key.count-1) {
            NSString * new = [NSString stringWithFormat:@"%@%@,",urlAdr,str];
            urlAdr = new;
        }
        if (i == key.count-1) {
            NSString * new = [NSString stringWithFormat:@"%@%@}",urlAdr,str];
            urlAdr = new;
        }
    }
    
    NSLog(@"----%@",urlAdr);
    return urlAdr;
}

@end
