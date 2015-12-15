//
//  NumberDishView.h
//  HCheap
//
//  Created by Apple on 14/12/11.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//
/*
 * 数量修改View
 */
#import <UIKit/UIKit.h>
#import "CommodityModel.h"
#import "dishesList.h"
@interface NumberDishView : UIView
{
    UIButton *_selectDishBtn;
    
    UIButton *_rightAddBtn;
    UIButton *_leftLessBtn;
    UIImageView *_numberImageBgView;
    UILabel *_numberLabel;
}

@property (nonatomic, strong)dishesList *model;

//  根据份数刷新界面
- (void)reloadCopiesNumber;
@end
