//
//  LSYGoodsInfoViewController.h
//  MarketManage
//
//  Created by liangsiyuan on 15/1/13.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSYGoodsInfo.h"
#import "L_BaseMallViewController.h"

#import "CrazyShoppingAddorRemoveModel.h"

@interface LSYGoodsInfoViewController : L_BaseMallViewController
/** 分类 */
@property (copy, nonatomic) NSString * goods_id;
/** 是否是秒杀 */
@property (assign,nonatomic) BOOL isSeckilling;
/** 活动ID */
@property (nonatomic,copy)NSString * hd_id;

/** 正在加载的view的显示 */
@property (weak, nonatomic) IBOutlet UIView *showWaiting;
/** 加入购物车 */
@property (weak, nonatomic) IBOutlet UIButton *addShoppingCartBtn;

/** 购物车（现已为分享） */
@property (weak, nonatomic) IBOutlet UIButton *shoppingCartBtn;
/** 购物车的文字（现已为分享） */
@property (weak, nonatomic) IBOutlet UILabel *shoppingLabel;
/** 购物车的图片（现已为分享） */
@property (weak, nonatomic) IBOutlet UIButton *shoppingImageView;
/** 立即购买 */
@property (weak, nonatomic) IBOutlet UIButton *buyNow;
/** 是否需要返回rootController */
@property (assign,nonatomic) BOOL needsPoPtoRoot;
/** 活动促销view */
@property (strong, nonatomic) IBOutlet UIView *activityPromotionView;
/** 促销view的高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *salesViewHeight;
/** 促销view */
@property (weak, nonatomic) IBOutlet UIView *SalesView;
/** 服务view */
@property (weak, nonatomic) IBOutlet UIView *serviceView;

/** 商家名称Label */
@property (weak, nonatomic) IBOutlet UILabel *goodsShopName;
/** 商品是否包邮Label */
@property (weak, nonatomic) IBOutlet UILabel *goodsPostage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *equalwidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonwidth;

/** “isupdate”：***；  //是否重置购物车商品数量 1、是；0、否；*/
@property (nonatomic) BOOL isupdate;


//@property (nonatomic) BOOL isInvalid;
@end
