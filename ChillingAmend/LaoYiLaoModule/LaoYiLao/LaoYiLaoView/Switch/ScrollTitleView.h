//
//  ScrollTitleView.h
//  LaoYiLao
//
//  Created by wzh on 15/11/20.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollTitleView : UIView

@property (nonatomic, assign) int defaultIndex;
@property (nonatomic, strong) NSArray *itemsArray;
@property (nonatomic, copy) void(^selectIndexWithBlock)(int selectIndex);
- (void)createItem:(NSArray *)itemsArray;

- (void)rollingBackViewWithIndex:(int)selectIndex;
@end
