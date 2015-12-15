//
//  NiceFoodSecondRootViewController.h
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/6/18.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "NiceFoodRootViewController.h"
#import "ShopAndCheapSegmentedControl.h"

@interface NiceFoodSecondRootViewController : NiceFoodRootViewController

@property (nonatomic, strong)UIView * sceondView; //第二View

@property (nonatomic, strong) BMKMapView *mapView;//地图
@property (nonatomic, strong) BMKLocationService* locService;//定位
@property (nonatomic, assign) NSInteger index;//大头针标记

@property (nonatomic, strong) ShopAndCheapSegmentedControl *seg;

@property (nonatomic, assign) int cheapIndex; //优惠检索页码
@property (nonatomic, strong) UIButton *mapBtn; //地图切换按钮



@property (nonatomic, copy) NSDictionary *cheapParameterDic; //优惠页面检索请求体




- (void)addSceondView;
- (void)segmentValueChange:(ShopAndCheapSegmentedControl *)seg;
//- (void)selectList;

@end
