//
//  ZXYOrderDetailModel.h
//  MarketManage
//
//  Created by Rice on 15/1/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarketAPI.h"

@interface ZXYOrderDetailModel : NSObject

@property (copy, nonatomic) NSString *goodsImage;          //商品图片
@property (copy, nonatomic) NSString *goodsName;           //商品名称
@property (copy, nonatomic) NSString *goodsCount;          //购买数量
@property (copy, nonatomic) NSString *goodsSpending;       //商品单价-积分
@property (copy, nonatomic) NSString *goodsCash;           //商品单价-现金
@property (copy, nonatomic) NSString *goodsSpendingAmount; //商品总价-积分
@property (copy, nonatomic) NSString *goodsCashAmout;      //商品总价-现金
@property (copy, nonatomic) NSString *goodsId;             //商品ID

@property (copy, nonatomic) NSString *orderNote;           //订单留言
@property (copy, nonatomic) NSString *orderValidTime;      //订单有效期
@property (copy, nonatomic) NSString *orderConfirmTime;    //自动确认收货时间
@property (copy, nonatomic) NSString *orderDrawType;       //订单类型 1自取 2快递
@property (copy, nonatomic) NSString *orderNum;            //订单号
@property (copy, nonatomic) NSString *orderId;             //订单ID
@property (copy, nonatomic) NSString *orderFreight;        //订单运费
@property (copy, nonatomic) NSString *orderCreatTime;      //订单生成日期
@property (copy, nonatomic) NSString *orderStatu;          //订单状态

//快递
@property (copy, nonatomic) NSString *expressBillNum;      //运单编号
@property (copy, nonatomic) NSString *expressName;         //快递公司
@property (copy, nonatomic) NSString *expressTrpType;      //配送方式
@property (copy, nonatomic) NSString *expressBillMsg;      //发票信息
@property (copy, nonatomic) NSString *connectName;         //收件人
@property (copy, nonatomic) NSString *connectTel;          //联系电话
@property (copy, nonatomic) NSString *connectAdd;          //收件地址

/** GDH 添加 8.28 */
@property (nonatomic,copy) NSString *invoice_category;
/** 自动确认收货时间 */
@property (nonatomic,copy) NSString *end_receipt;



//自取
@property (copy, nonatomic) NSString *fetchAdd;            //自取地址
@property (copy, nonatomic) NSString *fetchTime;           //自取时间
@property (copy, nonatomic) NSString *fetchMan;            //自取联系人
@property (copy, nonatomic) NSString *fetchTel;            //自取电话
@property (copy, nonatomic) NSString *fetchNote;           //自取备注
@property (copy, nonatomic) NSString *cat_ID   ;           //支付的id



//商品的信息数据
@property (copy, nonatomic) NSMutableArray  * goodsArray;
@property (copy, nonatomic) NSString        * cash_spend;//商品现金
@property (copy, nonatomic)  NSString       * spending;
@property (copy, nonatomic) NSString        * goods_id;//商品ID
@property (copy, nonatomic) NSString        * goodName;//商品名
@property (copy, nonatomic) NSString        * goodImg_url;//商品图片的url
@property (copy, nonatomic) NSString        * status;//商品的状态
@property (copy, nonatomic) NSString        * goods_nums;  //购买商品数量

/** 8.31 添加  商品数量 */
@property (nonatomic,copy) NSString *nums;

/** 9.9 号添加订单详情的属性 */
@property(nonatomic,copy)NSMutableArray *spec_id;
@property (nonatomic,copy) NSString *key;
@property (nonatomic,copy) NSString *value;


+(ZXYOrderDetailModel *)createObjWithDic:(NSDictionary *)subDict WithAry:(NSDictionary *)fetchDic;


@end
