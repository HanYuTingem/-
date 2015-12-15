//
//  ScreenListView.h
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/6/23.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^myblock)(NSInteger firstIndex, NSInteger secondIndex);


@interface ScreenListView : UIView



//一级菜单
@property (nonatomic, strong)UITableView *firstTableView;
//二级菜单
@property (nonatomic, strong)UITableView *secondTableView;



@property (nonatomic, assign)NSInteger firstIndex;  //一级菜单的选中标记
@property (nonatomic, assign)NSInteger secondIndex; //二级菜单的选中标记

// 一级菜单的数组
@property (nonatomic, strong) NSArray *firstDatas;
// 二级菜单的数组
@property (nonatomic, strong) NSArray *secondDatas;


//返回选中的字符串
@property (nonatomic, strong) NSString *secondString;

//临时数组，用来保存二级菜单中的子数组
@property (nonatomic, copy) NSArray *tempArray;

// 点击行数标识
@property (nonatomic, assign) NSInteger flag;


- (instancetype)initWithFirstDatas:(NSArray *)firstArray secondDatas:(NSArray *)secondArray firstIndex:(NSInteger)firstIndex andBlock:(myblock)returnBlock;




@end
