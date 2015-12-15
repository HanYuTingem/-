//
//  CrazyShoppingCartListCellView.h
//  MarketManage
//
//  Created by fielx on 15/4/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisCell.h"

#import "CrazyPurchaseQuantityView.h"

#import "CrazyShoppingCartShopCommodityModel.h"

#import "CrazyShoppingCartViewFile.h"

/**
 *  发送通知改变商品数量
 */
#define CrazyShoppingCartListCellViewChangeGoodsNumber @"CrazyShoppingCartListCellViewChangeGoodsNumber"

@class CrazyShoppingCartListCellView;
@protocol CrazyShoppingCartListCellViewDelegate <NSObject>
/**
 *  点击选中被选中
 */
-(void)crazyShoppingCartListCellView:(CrazyShoppingCartListCellView *)view isSelect:(BOOL)isSelect;
/**
 *  改变数量
 */
-(void)crazyShoppingCartListCellViewchangeNumber:(CrazyShoppingCartListCellView *)view;
@end

/**
 *  每个商品
 */
@interface CrazyShoppingCartListCellView : CrazyBasisCell<CrazyPurchaseQuantityViewDelegate>


/**
 *  代理
 */
@property (retain,nonatomic) id<CrazyShoppingCartListCellViewDelegate>delegate;

/**
 *  数量视图
 */
@property (weak,nonatomic) CrazyPurchaseQuantityView *mQuantityView;


/**
 *  当前显示信息
 */
@property (retain,nonatomic) CrazyShoppingCartShopCommodityModel *mModel;


/**
 *  限购数量
 */
@property (retain,nonatomic) CrazyBasisLabel  *mRestrictionmLabel;




#pragma mark  后来添加
/** 未编辑显示的view */

@property (nonatomic,strong) UIView *showView;

/** 显示颜色的label */
@property(nonatomic,strong) UILabel *colorLabel;

/** 现价 */
@property (nonatomic,strong)UILabel *nowLabel;

/** 原来的价钱 */
@property(nonatomic,strong) UILabel *agoLabel;

/** 编辑的View */

@property (nonatomic,strong) UIView *editView;

/** 选择某一个商店的 */
@property (nonatomic,strong) UIButton *selectBtn;

/** 商店的图片 */
@property (nonatomic,strong) UIImageView *shopImageView;

/** 商品店名 */
@property (nonatomic,strong) UILabel *shopLabelName;


/** 段头 */

@property (nonatomic,strong) UIView *sectionView;

@property (assign ,nonatomic) BOOL isShowOrEdit;

/**  是否向上移动  */
@property (assign ,nonatomic) BOOL ifUpMove;

-(void)CrazyShoppingCartListCellViewReload;


@end
