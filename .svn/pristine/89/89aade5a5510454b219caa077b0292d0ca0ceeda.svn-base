//
//  ZXYOrderModell.m
//  MarketManage
//
//  Created by Rice on 15/1/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYOrderModell.h"
#import "ZXYOrderDetailModel.h"

@implementation ZXYOrderModell


@synthesize orderStatu;
@synthesize orderNum;
@synthesize orderCreatTime;
@synthesize goodsSpendingAmount;
@synthesize goodsCashAmout;
@synthesize merchantsName;
@synthesize goodsImageArray;


//@synthesize goodsImage;          //商品图片
//@synthesize goodsName;           //商品名称
//@synthesize goodsCount;          //购买数量
//@synthesize goodsSpending;       //商品单价-积分
//@synthesize goodsCash;           //商品单价-现金
//@synthesize goodsSpendingAmount; //商品总价-积分
//@synthesize goodsCashAmout;      //商品总价-现金
//@synthesize goodsId;             //商品ID
//
//@synthesize orderValidTime;      //订单有效期
//@synthesize orderConfirmTime;    //自动确认收货时间
//@synthesize orderNum;            //订单号
//@synthesize orderDrawType;       //订单类型 1自取 2快递
//@synthesize orderId;             //订单ID
//@synthesize orderFreight;        //订单运费
//@synthesize orderCreatTime;      //订单生成日期
//@synthesize orderStatu;          //订单状态
//@synthesize type;                //虚拟商品为2
//
//@synthesize useStatrTime;        //虚拟商品使用开始时间
//@synthesize useEndTime;          //虚拟商品使用结束时间
//
//@synthesize validTime;           //订单有效期

//地址列表请求参数
@synthesize p_id;
@synthesize shop_id;
@synthesize goods_id;


- (void)dealloc
{
//    self.goodsImage = nil;          //商品图片
//    self.goodsName = nil;           //商品名称
//    self.goodsCount = nil;          //购买数量
//    self.goodsSpending = nil;       //商品单价-积分
//    self.goodsCash = nil;           //商品单价-现金
//    self.goodsSpendingAmount = nil; //商品总价-积分
//    self.goodsCashAmout = nil;      //商品总价-现金
//    self.goodsId = nil;             //商品ID
//    
//    self.orderValidTime = nil;      //订单有效期
//    self.orderConfirmTime = nil;    //自动确认收货时间
//    self.orderNum = nil;            //订单号
//    self.orderDrawType = nil;       //订单类型 1自取 2快递
//    self.orderId = nil;             //订单ID
//    self.orderFreight = nil;        //订单运费
//    self.orderCreatTime = nil;      //订单生成日期
//    self.orderStatu = nil;          //订单状态
//    self.type = nil;                //虚拟商品为1
//    self.useEndTime = nil;          //虚拟商品使用结束时间
//    self.useStatrTime = nil;        //虚拟商品使用开始时间
//    self.validTime = nil;           //订单有效期
  
    self.orderStatu = nil;
    self.orderNum = nil;
    self.orderCreatTime = nil;
    self.goodsSpendingAmount = nil;
    self.goodsCashAmout = nil;
    self.merchantsName = nil;
    self.goodsImageArray = nil;
    self.p_id = nil;
    self.shop_id = nil;
    self.goods_id = nil;
}

+(ZXYOrderModell *)createObjWithDic:(NSDictionary *)subDict
{
    ZXYOrderModell * orderModel = [[ZXYOrderModell alloc]init];
    
    
    orderModel.orderStatu = IfNullToString(subDict[@"status"]);            //订单状态;
    orderModel.orderNum = IfNullToString(subDict[@"order_num"]);         //订单号
;
    orderModel.orderCreatTime   = IfNullToString(subDict[@"create_time"]);       //订单生成日期
    orderModel.goodsSpendingAmount = IfNullToString(subDict[@"spending_total"]); //商品的总价积分
    orderModel.goodsCashAmout   = IfNullToString(subDict[@"cash_pay_total"]);    //商品的总价现金
    orderModel.merchantsName = IfNullToString(subDict[@"name"]);//商家名称
    orderModel.p_id             = IfNullToString(subDict[@"p_id"]);
    orderModel.goods_id         = IfNullToString(subDict[@"goods_id"]);
    orderModel.shop_id          = IfNullToString(subDict[@"shop_id"]);
    
    orderModel.cat_ID           = IfNullToString(subDict[@"is_act"]);
    
    
    orderModel.goodsImage       = IfNullToString(subDict[@"img_url"]);           //商品图片
    orderModel.goodsName        = IfNullToString(subDict[@"goods_name"]);        //商品名称
    orderModel.goodsCount       = IfNullToString(subDict[@"goods_nums"]);        //商品个数
    orderModel.goodsId          = IfNullToString(subDict[@"goods_id"]);          //商品id
    orderModel.goodsSpending    = IfNullToString(subDict[@"price_pay"]);         //商品的单价积分
    orderModel.goodsCash        = IfNullToString(subDict[@"cash_pay"]);          //商品的单价现金
    orderModel.goodsSpendingAmount = IfNullToString(subDict[@"spending_total"]); //商品的总价积分
    orderModel.goodsCashAmout   = IfNullToString(subDict[@"cash_pay_total"]);    //商品的总价现金
    orderModel.orderNum         = IfNullToString(subDict[@"order_num"]);         //订单号
//    orderModel.orderDrawType    = IfNullToString(subDict[@"draw_type"]);         //订单类型 1 自取 2快递
    orderModel.orderDrawType    = @"2";                                             //订单类型 1 自取 2快递

    orderModel.orderStatu       = IfNullToString(subDict[@"status"]);            //订单状态
    orderModel.orderCreatTime   = IfNullToString(subDict[@"create_time"]);       //订单生成日期
    orderModel.orderId          = IfNullToString(subDict[@"id"]);                //订单ID
    orderModel.validTime        = IfNullToString(subDict[@"invite"]);            //订单有效期
    orderModel.orderFreight     = IfNullToString(subDict[@"freight"]);           //订单运费
    orderModel.orderConfirmTime = IfNullToString(subDict[@"end_receipt"]);       //自动确认收货时间
    
    orderModel.type             = IfNullToString(subDict[@"type"]);              //虚拟商品为1
    orderModel.useStatrTime     = IfNullToString(subDict[@"use_start_time"]);    //虚拟商品使用开始时间
    orderModel.useEndTime       = IfNullToString(subDict[@"use_end_time"]);      //虚拟商品使用结束时间
    
    orderModel.p_id             = IfNullToString(subDict[@"p_id"]);
    orderModel.goods_id         = IfNullToString(subDict[@"goods_id"]);
    orderModel.shop_id          = IfNullToString(subDict[@"shop_id"]);

    NSMutableArray  * dataA = [[NSMutableArray alloc]init];
//    NSArray *goodsArr = subDict[@"goods"];
    for (NSDictionary  * dict in subDict[@"goods"]){
//        if (goodsArr.count > 0) {
//            
            ZXYOrderDetailModel * orderSubDetailModel = [[ZXYOrderDetailModel alloc]init];
            orderSubDetailModel.cash_spend       = IfNullToString(dict[@"cash_spend"]);
            orderSubDetailModel.goods_id         = IfNullToString(dict[@"goods_id"]);
            orderSubDetailModel.goodName         = IfNullToString(dict[@"name"]);
            orderSubDetailModel.goodImg_url      = IfNullToString(dict[@"img_url"]);
            orderSubDetailModel.status           = IfNullToString(dict[@"status"]);
            orderSubDetailModel.goods_nums       = IfNullToString(dict[@"goods_nums"]);

        orderSubDetailModel.nums = IfNullToString(dict[@"nums"]);
            [dataA addObject:orderSubDetailModel];
//        }
      
    }
    orderModel.goodsImageArray = dataA;

    
    return orderModel;
}


@end
