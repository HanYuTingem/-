//
//  ActitvityListModel.m
//  MarketManage
//
//  Created by 许文波 on 15/8/25.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ActitvityListModel.h"

@implementation ActitvityListModel
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}


-(void)setStart_time:(NSString *)start_time{
    
    _start_time = start_time;
    
    
    
    
    
    
}
//-(NSString *)end_time{
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(start_time:) name:@"stat_time" object:nil];
//    
//    
//    return @"";
//}

-(void)start_time:(NSNotification *)doc{
    
    NSLog(@"%@",doc);
}
@end
