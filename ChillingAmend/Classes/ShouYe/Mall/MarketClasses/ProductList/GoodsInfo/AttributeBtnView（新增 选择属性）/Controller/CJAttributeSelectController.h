//
//  CJAttributeSelectController.h
//  MarketManage
//
//  Created by 赵春景 on 15-7-23.
//  Copyright (c) 2015年 Rice. All rights reserved.
//
//  本界面 默认== 是(添加)和(立即购买) 两个按钮界面，AttributeSelectAdd == 是确认添加（就一个按钮的页面）AttributeSelectBuyNow == 立即购买（就一个按钮的页面）
//  要是添加秒杀属性的话还需要修改网络接口 将属性提交上去

#import "L_BaseMallViewController.h"
#import "LSYGoodsInfo.h"                 //商品详情数据

@class CJAttributeModle;

typedef NS_ENUM(NSInteger, AttributeSelect)
{
    /** 确认添加（就一个按钮的页面） */
    AttributeSelectAdd = 1,
    /** 立即购买（就一个按钮的页面） */
    AttributeSelectBuyNow
};

@interface CJAttributeSelectController : L_BaseMallViewController

@property (nonatomic, assign) int restriction;
/** 商品详情model进来的数据 */
@property (nonatomic,strong) LSYGoodsInfo * goods;
/** 秒杀 判断是否秒杀 yes时请求提交订单参数增加ms_sign */
@property (nonatomic,assign) BOOL isSeckilling;
/** 活动ID （属性） */
@property (nonatomic,copy) NSString *hd_id;
/** 购买限制 （属性） */
@property (nonatomic,copy) NSString *bugWarring;
/** 判断是否请求成功 （属性） */
@property (nonatomic,assign) BOOL alreadySubmit;

/** 秒杀Sign 请求参数（属性） */
@property (nonatomic,copy)NSString * ms_sign;
/** 秒杀Sign 请求参数（属性） */
@property (nonatomic,copy)NSString * my_sign;
/** 分类（属性） */
//@property (copy, nonatomic) NSString *goods_id;


/** 左边的添加到购物车按钮 */
@property (nonatomic, strong) UIButton *addShoppingCartBtn;
/** 右边的立即购买按钮 */
@property (nonatomic, strong) UIButton *buyNowBtn;

/** 判断是否是选择属性页 默认== 是添加 和 立即购买 两个按钮界面，AttributeSelectAdd == 是确认添加（就一个按钮的页面）AttributeSelectBuyNow == 立即购买（就一个按钮的页面） */
@property (nonatomic, assign) AttributeSelect attributeSelect;
/** 用来接收上级页面传过来的 已选择商品模型 */
@property (nonatomic, strong) CJAttributeModle *getAttributeModel;
/** 用来接收上级页面传来的 已选择商品数量 */
@property (nonatomic, copy) NSString *getAttributeGoodsNums;

/** “isupdate”：***；  //是否重置购物车商品数量 1、是；0、否；*/
@property (nonatomic) BOOL isupdate;


/** 加入购物车的block回调 CJAttributeModle 是最后确定的模型 NSString 是购买的数量 */
@property (nonatomic, strong) void(^blockAttribute)(CJAttributeModle *,NSString *);


@end
