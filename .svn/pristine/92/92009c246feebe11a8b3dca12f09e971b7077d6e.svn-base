//
//  CrazyNavigationController.m
//  MarketManage
//
//  Created by fielx on 15/4/24.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyNavigationController.h"

@implementation CrazyNavigationController


-(void)setBackNumber:(int)backNumber
{
    NSMutableArray *dic = [self.viewControllers mutableCopy];
    //  NSLog(@"%d",dic.count);
    
    for (int i = 0; i<backNumber; i++) {
        if (dic.count < 3) {
            return;
        }
        [dic removeObjectAtIndex:dic.count - 2];
    }
    self.viewControllers = dic;
    _backNumber = backNumber;
}



@end
