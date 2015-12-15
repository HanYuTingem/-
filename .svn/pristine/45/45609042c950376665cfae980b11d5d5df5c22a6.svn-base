//
//  LSYConfirmOrderViewController.h
//  MarketManage
//
//  Created by liangsiyuan on 15/1/19.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXYCommitOrderRequestModel.h"   //提交订单请求数据
#import "LSYGoodsInfo.h"                 //商品详情数据
#import "LSYVirtualGoodsTableViewCell.h" //商品详情
#import "LYSShopingCartTableViewCell.h"  //商品详情购物车
#import "LSYRealGoodsTableViewCell.h"    //配送方式 发票信息 留言
#import "LSYUserAdressTableViewCell.h"   //快递地址
#import "LYQManageAddressController.h"   //管理地址界面
#import "InvoiceViewController.h"        //发票信息界面
#import "LSYPayViewController.h"         //支付界面
#import "ASIHTTPRequest.h"
#import "MarketAPI.h"
#import "ZXYIndicatorView.h"

#import "L_BaseMallViewController.h"
#import "CJAttributeModle.h"             //商品属性模型

typedef NS_ENUM(NSInteger, ConfirmRow) {
    ConfirmRowNone,
    ConfirmRowOne,
    ConfirmRowTwo,
};

@interface LSYConfirmOrderViewController : L_BaseMallViewController

/** 商品详情model进来的数据 */
@property (nonatomic,strong)LSYGoodsInfo * goods;
/** 购物车的数据 */
@property (nonatomic,strong) NSMutableArray  * shoppingCartArray;
/** 购物车的总价格 */
@property (nonatomic,strong)  NSString       *buyShopingPriceCount;
/** 秒杀Sign 请求参数 */
@property (nonatomic,copy)NSString * ms_sign;
/** 秒杀 判断是否秒杀 yes时请求提交订单参数增加ms_sign */
@property (nonatomic,assign)BOOL isSeckilling;
/** 秒杀Sign 请求参数 */
@property (nonatomic,copy)NSString * my_sign;

/** 用来接受传过来的数据 */
@property(nonatomic,strong) NSMutableArray *shopCountArr;


/** 商品属性界面传过来的 确定的商品属性模型 */
@property (nonatomic, strong) CJAttributeModle *attributeModel;
/** 商品属性界面传过来的 确定的商品属性购买个数 */
@property (nonatomic, copy) NSString *attributeGoodsNums;

@end
