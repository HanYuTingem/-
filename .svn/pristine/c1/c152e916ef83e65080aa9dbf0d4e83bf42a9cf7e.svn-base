//
//  NiceFoodRootViewController.h
//  PRJ_NiceFoodModule
//
//  Created by 张恭豪 on 15/6/15.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicViewController.h"
#import "ShopAndCheapTableView.h"
#import "ScreenListView.h"
#import "ScreenButtonView.h"
#import "ShopListModel.h"
#import "AreaClassModel.h"
#import "IndustryClassModel.h"
#import "MJRefresh.h"



@interface NiceFoodRootViewController :PublicViewController <BMKCloudSearchDelegate>

@property (nonatomic, strong)BMKCloudSearch *cloudSearch;

@property (nonatomic, strong) UIView *animationView;    //控制动画范围的View

@property (nonatomic, strong) UIView *firstView;        //
@property (nonatomic, strong) UITableView *tableView;   //

@property (nonatomic, strong) ScreenButtonView * screen;//筛选栏


@property (nonatomic, copy) NSMutableArray *areaArray;          //商圈筛选数组
@property (nonatomic, copy) NSMutableArray *areaSecondArray;    //商圈二级筛选数组
@property (nonatomic, assign) NSInteger areaIndex;              //记录商圈选中的行

@property (nonatomic, copy) NSMutableArray *classArray;         //分类筛选数组
@property (nonatomic, copy) NSMutableArray *classSecondArray;   //分类二级筛选数组
@property (nonatomic, assign) NSInteger classIndex;             //记录分类选中的行

@property (nonatomic, copy) NSArray *typeArray;         //商户类型数组
@property (nonatomic, assign) NSInteger typeIndex;      //记录类型选中的行

@property (nonatomic, assign) NSInteger pageIndex;                 //地图检索的页码


@property (nonatomic, copy) NSMutableArray *showData;               //正在展示的数据

@property (nonatomic, strong) AreaClassModel *areaClassModel;           //商圈集合
@property (nonatomic, strong) IndustryClassModel *industryClassModel;   //行业分类

@property (nonatomic, strong) BMKCloudNearbySearchInfo *searchInfo; //附近检索条件
@property (nonatomic, strong) BMKCloudLocalSearchInfo *locationInfo; //本地检索条件

@property (nonatomic, strong) NSString *cityId; //城市id



- (void)addAnimationView;//动画背景view

- (void)getNearNotification:(NSNotification *)notification;//解析附近检索通知
- (void)getLocationNotification:(NSNotification *)notification;//解析本地检索通知


- (void)reloadList;

//拉下刷新
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView;
- (void)doneWithView:(MJRefreshBaseView *)refreshView;
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView;
- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state;


- (void)close;
- (void)open;

- (void)chrysanthemumWithBOOL:(BOOL)reg;

@end
