//
//  ScreenButtonView.h
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/6/17.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenButton.h"
#import "ScreenListView.h"

@class AreaClassModel;
@class IndustryClassModel;


@interface ScreenButtonView : UIView

@property (nonatomic, strong) AreaClassModel *areaClassModel;           //商圈集合
@property (nonatomic, strong) IndustryClassModel *industryClassModel;   //行业分类

@property (nonatomic, strong)ScreenButton *area;        //商圈
@property (nonatomic, strong)ScreenButton *profession;  //行业
@property (nonatomic, strong)ScreenButton *screen;      //类型

@property (nonatomic, strong)ScreenButton *tempBtn;     //暂存

@property (nonatomic, strong)ScreenListView *backView;  //背景底色

@property (nonatomic, strong)UIView *back;              //点击返回的view



@property (nonatomic, copy) NSArray *areaArray;         //附近筛选数组
@property (nonatomic, copy) NSArray *areaSecondArray;   //附近二级筛选数组
@property (nonatomic, assign) NSInteger areaIndex;      //记录附近选中的行
@property (nonatomic, assign) NSInteger areaSecondIndex;//记录二级菜单选中的行

@property (nonatomic, copy) NSArray *classArray;        //分类筛选数组
@property (nonatomic, copy) NSArray *classSecondArray;  //分类二级筛选数组
@property (nonatomic, assign) NSInteger classIndex;     //记录分类选中的行
@property (nonatomic, assign) NSInteger classSecondIndex;//记录二级菜单选中的行

@property (nonatomic, copy) NSArray *typeArray;         //商户类型数组
@property (nonatomic, assign) NSInteger typeIndex;      //记录类型选中的行

- (void)buttonClick:(ScreenButton *)btn;

@end
