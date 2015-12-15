//
//  LSYMenuScrollView.h
//  MarketManage
//
//  Created by liangsiyuan on 15/1/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BUTTONITEMWIDTH   106
@protocol LSYMenuScrollViewDelegate <NSObject>
@optional
-(void)didSelectAtIndex:(int)index;

@end

@interface LSYMenuScrollView : UIScrollView
//数据数组
@property (strong,nonatomic) NSArray * array;
//控件数组
@property (strong,nonatomic) NSMutableArray * itemsArray;
//服务器时间
@property(nonatomic,copy)NSString * serverTime;
@property (strong,nonatomic) UIView * currentView;
@property (weak,nonatomic) id delegate;
-(void)changeColorsByTag:(int)tag;

@end
