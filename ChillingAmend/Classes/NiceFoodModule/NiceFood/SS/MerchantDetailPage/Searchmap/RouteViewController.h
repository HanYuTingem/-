//
//  RouteViewController.h
//  HCheap
//
//  Created by dairuiquan on 14-12-12.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//
/*
 *  路线
 */
#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BaseController.h"
@interface RouteViewController : BaseController
@property (nonatomic, assign) NSInteger traficStyle;        //交通方式
@property (nonatomic, assign) NSInteger kindOfScheme;       //方案种类


//  开始位置
@property (nonatomic, assign) CLLocationCoordinate2D startLocation;
//  结束位置
@property (nonatomic, assign) CLLocationCoordinate2D stopLocation;

//  标题
@property (nonatomic, copy)   NSString *navTitle;

@end
