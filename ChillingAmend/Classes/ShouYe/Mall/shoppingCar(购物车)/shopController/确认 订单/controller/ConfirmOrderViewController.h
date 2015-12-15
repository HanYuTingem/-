//
//  ConfirmOrderViewController.h
//  MarketManage
//
//  Created by 许文波 on 15/7/28.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "L_BaseMallViewController.h"
#import "LSYGoodsInfo.h"                 //商品详情数据
#import "InvoiceViewController.h"        //发票信息界面
#import "CJAttributeModle.h"             //商品属性模型


@interface ConfirmOrderViewController : L_BaseMallViewController

@property(nonatomic,strong) NSMutableArray *shoppingCartArray;
@property(nonatomic,strong) NSString *buyShopingPriceCount;
/** 选择的商品穿过来的数据 */
@property(nonatomic,strong) NSMutableArray *shopCountArr;
//商品详情model进来的数据
@property (nonatomic,strong)LSYGoodsInfo * goods;
//秒杀Sign 请求参数
@property (nonatomic,copy)NSString * ms_sign;
//秒杀 判断是否秒杀 yes时请求提交订单参数增加ms_sign
@property (nonatomic,assign)BOOL isSeckilling;
//秒杀Sign 请求参数
@property (nonatomic,copy)NSString * my_sign;
/** 商品属性界面传过来的 确定的商品属性模型 */
@property (nonatomic, strong) CJAttributeModle *attributeModel;

@end