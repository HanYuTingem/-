//
//  CrazyPurchaseQuantityView.h
//  MarketManage
//
//  Created by fielx on 15/4/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CrazyBasisFile.h"


typedef NS_ENUM(int, CrazyPurchaseQuantityViewType)
{
    CrazyPurchaseQuantityViewTypeAdd = 1,
    CrazyPurchaseQuantityViewTypeRemove = -1
};


@class CrazyPurchaseQuantityView;
@protocol CrazyPurchaseQuantityViewDelegate <NSObject>
-(void)crazyPurchaseQuantityView:(CrazyPurchaseQuantityView *)qView currentNumber:(int)currentNumber;
@end

/**
 *  超出库存上限
 */
#define PurchaseQuantityViewNotification @"PurchaseQuantityViewNotification"


/**
 *  用户选择数量视图  通知传送字典  参数为BIG  YES为用户选择数量超过最大值
 */
@interface CrazyPurchaseQuantityView : UIImageView

/**
 *  增加数量BUTTON
 */
@property (weak,nonatomic) UIButton *mAddButton;

/**
 *  减少数量BUTTON
 */
@property (weak,nonatomic) UIButton *mReduceButton;

/**
 *  最大数量 默认 无穷
 */
@property (assign,nonatomic) int mMaxNumber;


/**
 *  限购
 */
@property (assign,nonatomic) int mMaxRestrictionmNumber;

/**
 *  用户可购买数量
 */
@property (assign,nonatomic) int mAvailable;

/**
 *  最小数量 默认 为1
 */
@property (assign,nonatomic) int mMinNumber;

/**
 *  当前数量 默认 为1
 */
@property (assign,nonatomic) int mCurrentNumber;

/**
 *  展示Label
 */
@property (weak,nonatomic) UILabel *mShowLabel;

/**
 *  用户点击加 还是减
 */
@property (assign,nonatomic) CrazyPurchaseQuantityViewType mType;

/**
 *  代理
 */
@property (retain,nonatomic) id<CrazyPurchaseQuantityViewDelegate>delegate;

-(void)CrazyPurchaseQuantityViewReload;


@end
