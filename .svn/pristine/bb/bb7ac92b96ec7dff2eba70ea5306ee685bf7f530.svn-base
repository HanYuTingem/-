//
//  MyActionInfor.m
//  LANSING
//
//  Created by yll on 15/7/21.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "MyActionInfor.h"

@implementation MyActionInfor
+(id)initWithActionModelInforActionCountWithJSONDic:(NSDictionary *)dicInfor
{
    MyActionInfor *myActionData = [[MyActionInfor alloc]init];
    if (dicInfor == nil ||
        dicInfor.count < 1) {
        return myActionData;
    }
    [myActionData setApply_count:[dicInfor objectForKey:@"apply_count"]];
    [myActionData setCollect_count:[dicInfor objectForKey:@"collect_count"]];
    return myActionData;
}
@end
