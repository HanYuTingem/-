//
//  ShopAndCheapSegmentedControl.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/6/16.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "ShopAndCheapSegmentedControl.h"

@implementation ShopAndCheapSegmentedControl

- (instancetype)initWithArray:(NSArray *)array{
    
    return [ShopAndCheapSegmentedControl setSegmentedWithArray:array];
    
}

+ (instancetype)setSegmentedWithArray:(NSArray *)array{
    
    ShopAndCheapSegmentedControl *seg = [[ShopAndCheapSegmentedControl alloc] initWithItems:array];
    
//        seg.frame                  = CGRectMake(0, 0, 0, 0);
        seg.tintColor              = [UIColor colorWithRed:237/255.0 green:84/255.0 blue:101/255.0 alpha:1];
        seg.selectedSegmentIndex   = 0;
        seg.center                 = CGPointMake(SCREEN_WIDTH/2, (NavigationH - 20)/2+20);

    return seg;

}

//    限定view大小
- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(160, TopMenuH);
    [super setFrame:frame];
}



@end
