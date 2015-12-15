//
//  ZXYOrderModell.h
//  MarketManage
//
//  Created by Rice on 15/1/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarketAPI.h"

@interface ZXYOrderModell : NSObject

@property (copy, nonatomic) NSString *orderStatu;          //订单状态
@property (copy, nonatomic) NSString *orderNum;            //订单号
@property (copy, nonatomic) NSString *orderCreatTime;      //订单生成日期
@property (copy, nonatomic) NSString *goodsSpendingAmount; //商品总价-积分
@property (copy, nonatomic) NSString *goodsCashAmout;      //商品总价-现金
@property (copy, nonatomic) NSString *merchantsName;       //商家名称




@property (copy, nonatomic) NSString *goodsImage;          //商品图片
@property (copy, nonatomic) NSString *goodsCount;          //购买数量
@property (copy, nonatomic) NSString *goodsSpending;       //商品单价-积分
@property (copy, nonatomic) NSString *goodsCash;           //商品单价-现金
@property (copy, nonatomic) NSString *goodsId;             //商品ID
@property (copy, nonatomic) NSString *goodsName;           //商品名称

@property (copy, nonatomic) NSString *orderValidTime;      //订单有效期
@property (copy, nonatomic) NSString *validTime;           //订单有效期
@property (copy, nonatomic) NSString *orderConfirmTime;    //自动确认收货时间
@property (copy, nonatomic) NSString *orderDrawType;       //订单类型 1自取 2快递
@property (copy, nonatomic) NSString *orderId;             //订单ID
@property (copy, nonatomic) NSString *orderFreight;        //订单运费
@property (copy, nonatomic) NSString *type;                //虚拟商品为2
@property (copy, nonatomic) NSString *useStatrTime;        //虚拟商品使用开始时间
@property (copy, nonatomic) NSString *useEndTime;          //虚拟商品使用结束时间

//地址列表请求参数
@property (copy, nonatomic) NSString *p_id;
@property (copy, nonatomic) NSString *shop_id;
@property (copy, nonatomic) NSString *goods_id;

@property (nonatomic,copy)  NSString   * cat_ID;

//商品的信息数据
@property (copy, nonatomic) NSMutableArray  * goodsImageArray;   //商品的图片地址数组
@property (copy, nonatomic) NSString        * cash_spend;//商品现金
@property (copy, nonatomic) NSString        * goodsud_id;//商品ID
@property (copy, nonatomic) NSString        * goodName;//商品名
@property (copy, nonatomic) NSString        * goodImg_url;//商品图片的url
@property (copy, nonatomic) NSString        * status;//商品的状态
@property (copy, nonatomic) NSString        * goods_nums;  //购买商品数量


+(ZXYOrderModell *)createObjWithDic:(NSDictionary *)subDict;

@end
