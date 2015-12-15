//
//  CrazyShoppingCartFootView.h
//  MarketManage
//
//  Created by fielx on 15/4/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisView.h"

#import "CrazyShoppingCartViewFile.h"

@class CrazyShoppingCartFootView;
@class CrazyBasisButton;
@protocol CrazyShoppingCartFootViewDelegate <NSObject>
-(void)crazyShoppingCartFootView:(CrazyShoppingCartFootView *)footView didSelectDeleteButton:(CrazyBasisButton *)button;
-(void)crazyShoppingCartFootView:(CrazyShoppingCartFootView *)footView didSelectClearButton:(CrazyBasisButton *)button;
@end




typedef NS_ENUM(int, CrazyShoppingCartFootViewState)
{
    CrazyShoppingCartFootViewStateSelect = 0,
    CrazyShoppingCartFootViewStateDelete = 1
};


#define CrazyShoppingCartFootViewTotalSelect @"CrazyShoppingCartFootViewTotalSelect"




/**
 *  购物车底部视图
 */
@interface CrazyShoppingCartFootView : CrazyBasisView

/**
 *  代理
 */
@property (retain,nonatomic) id<CrazyShoppingCartFootViewDelegate>delegate;

/**
 *  用户选中数量
 */
@property (assign,nonatomic) int mNumger;

/**
 *  删除或者 挑选状态
 */
@property (assign,nonatomic) CrazyShoppingCartFootViewState mState;

/**
 *  全选按钮
 */
@property (retain,nonatomic) CrazyBasisButton *mSelectButton;


/**
 *  结账按钮
 */
@property (retain,nonatomic) CrazyBasisButton *mClearButton;

/**
 *  删除按钮
 */
@property (retain,nonatomic) CrazyBasisButton *mDeleteLabel;

/**
 *  总计
 */
@property (retain,nonatomic) CrazyBasisLabel *mShowPriceLabel;

/**
 *  提示Label
 */
@property (retain,nonatomic) CrazyBasisLabel *mPromptLabel;





/**
 *  失效 按钮
 */
//@property (retain,nonatomic) NSString *

@end
