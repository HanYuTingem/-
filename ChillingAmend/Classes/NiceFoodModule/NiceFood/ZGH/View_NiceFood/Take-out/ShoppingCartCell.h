//
//  ShoppingCartCell.h
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/22.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberDishView.h"
@class dishesList;

@interface ShoppingCartCell : UITableViewCell


@property (nonatomic, strong) dishesList *model;
@property (nonatomic, strong) NumberDishView *numberDishView;//加减器
@property (nonatomic, strong) UILabel *name;//菜名
@property (nonatomic, strong) UILabel *cost;//单价

+ (ShoppingCartCell *)cellWithTableView:(UITableView *)tabelView;

@end
