//
//  ZXYOrderDetailModel.m
//  MarketManage
//
//  Created by Rice on 15/1/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYOrderDetailModel.h"

@implementation ZXYOrderDetailModel

@synthesize goodsImage;          //商品图片
@synthesize goodsName;           //商品名称
@synthesize goodsCount;          //购买数量
@synthesize goodsSpending;       //商品单价-积分
@synthesize goodsCash;           //商品单价-现金
@synthesize goodsSpendingAmount; //商品总价-积分
@synthesize goodsCashAmout;      //商品总价-现金
@synthesize goodsId;             //商品ID

@synthesize orderNote;           //订单留言
@synthesize orderValidTime;      //订单有效期
@synthesize orderConfirmTime;    //自动确认收货时间
@synthesize orderDrawType;       //订单类型 1自取 2快递
@synthesize orderNum;            //订单号
@synthesize orderId;             //订单ID
@synthesize orderFreight;        //订单运费
@synthesize orderCreatTime;      //订单生成日期
@synthesize orderStatu;          //订单状态

@synthesize expressBillNum;      //运单编号
@synthesize expressName;         //快递公司
@synthesize expressTrpType;      //配送方式
@synthesize expressBillMsg;      //发票信息
@synthesize connectName;         //收件人
@synthesize connectTel;          //联系电话
@synthesize connectAdd;          //收件地址
@synthesize invoice_category;
@synthesize end_receipt;

@synthesize fetchAdd;            //自取地址
@synthesize fetchTime;           //自取时间
@synthesize fetchMan;            //自取联系人
@synthesize fetchTel;            //自取电话
@synthesize fetchNote;           //自取备注
@synthesize nums;


@synthesize key;
@synthesize value;


- (void)dealloc
{
    self.goodsImage = nil;          //商品图片
    self.goodsName = nil;           //商品名称
    self.goodsCount = nil;          //购买数量
    self.goodsSpending = nil;       //商品单价-积分
    self.goodsCash = nil;           //商品单价-现金
    self.goodsSpendingAmount = nil; //商品总价-积分
    self.goodsCashAmout = nil;      //商品总价-现金
    self.goodsId = nil;             //商品ID
    
    self.orderNote = nil;           //订单留言
    self.orderValidTime = nil;      //订单有效期
    self.orderConfirmTime = nil;    //自动确认收货时间
    self.orderDrawType = nil;       //订单类型 1自取 2快递
    self.orderNum = nil;            //订单号
    self.orderId = nil;             //订单ID
    self.orderFreight = nil;        //订单运费
    self.orderCreatTime = nil;      //订单生成日期
    self.orderStatu = nil;          //订单状态
    
    self.expressBillNum = nil;      //运单编号
    self.expressName = nil;         //快递公司
    self.expressTrpType = nil;      //配送方式
    self.expressBillMsg = nil;      //发票信息
    self.connectName = nil;         //收件人
    self.connectTel = nil;          //联系电话
    self.connectAdd = nil;          //收件地址
    self.invoice_category = nil;
    self.end_receipt = nil;
    
    self.fetchAdd = nil;            //自取地址
    self.fetchTime = nil;           //自取时间
    self.fetchMan = nil;            //自取联系人
    self.fetchTel = nil;            //自取电话
    self.fetchNote = nil;           //自取备注
    
    self.nums = nil;
    self.key = nil;
    self.value = nil;
}

+(ZXYOrderDetailModel *)createObjWithDic:(NSDictionary *)subDict WithAry:(NSDictionary *)fetchDic
{
    ZXYOrderDetailModel * orderDetailModel = [[ZXYOrderDetailModel alloc]init];
    
    
    orderDetailModel.cat_ID          = IfNullToString(subDict[@"is_act"]);  //支付id
    orderDetailModel.goodsImage       = IfNullToString(subDict[@"img_url"]);           //商品图片
    orderDetailModel.goodsName        = IfNullToString(subDict[@"goods_name"]);        //商品名称
    orderDetailModel.goodsCount       = IfNullToString(subDict[@"goods_nums"]);        //商品个数
    orderDetailModel.goodsId          = IfNullToString(subDict[@"goods_id"]);          //商品id
    orderDetailModel.goodsSpending    = IfNullToString(subDict[@"spending"]);          //商品的单价积分
    orderDetailModel.goodsCash        = IfNullToString(subDict[@"cash_spend"]);              //商品的单价现金
    orderDetailModel.goodsSpendingAmount = IfNullToString(subDict[@"spending_total"]); //商品的总价积分
    orderDetailModel.goodsCashAmout   = IfNullToString(subDict[@"cash_pay_total"]);    //商品的总价现金
    
     orderDetailModel.end_receipt   = IfNullToString(subDict[@"end_receipt"]);    //自动确认收货时间
    orderDetailModel.orderNote        = IfNullToString(subDict[@"note"]);              //订单留言
    orderDetailModel.orderNum         = IfNullToString(subDict[@"order_num"]);         //订单号
    orderDetailModel.orderDrawType    = IfNullToString(subDict[@"draw_type"]);         //订单类型 1 自取 2快递

    orderDetailModel.orderStatu       = IfNullToString(subDict[@"status"]);            //订单状态
    orderDetailModel.orderCreatTime   = IfNullToString(subDict[@"create_time"]);       //订单生成日期
    orderDetailModel.orderId          = IfNullToString(subDict[@"id"]);                //订单ID
    orderDetailModel.orderValidTime   = IfNullToString(subDict[@"end_receipt"]);       //订单有效期
    orderDetailModel.orderFreight     = IfNullToString(subDict[@"freight"]);           //订单运费
    orderDetailModel.orderConfirmTime = IfNullToString(subDict[@"end_receipt"]);       //自动确认收货时间
    
    orderDetailModel.expressBillNum   = IfNullToString(subDict[@"waybill_num"]);       //运单编号
    orderDetailModel.expressName      = IfNullToString(subDict[@"express_name"]);      //快递公司
    orderDetailModel.expressTrpType   = IfNullToString(subDict[@""]); //配送方式
    orderDetailModel.expressBillMsg   = IfNullToString(subDict[@"invoice"][@"invoice_title"]);     //发票信息
    
    orderDetailModel.invoice_category     = IfNullToString(subDict[@"invoice"][@"invoice_category"]);
    
    
    orderDetailModel.connectName      = IfNullToString(subDict[@"connect_name"]);      //收件人
    orderDetailModel.connectTel       = IfNullToString(subDict[@"connect"]);           //联系电话
    orderDetailModel.connectAdd       = IfNullToString(subDict[@"address"]);           //收件地址

    
    orderDetailModel.fetchAdd         = IfNullToString(fetchDic[@"address"]);          //自取地址
    orderDetailModel.fetchTime        = IfNullToString(fetchDic[@"draw_time"]);        //自取时间
    orderDetailModel.fetchMan         = IfNullToString(fetchDic[@"connect_name"]);     //自取联系人
    orderDetailModel.fetchTel         = IfNullToString(fetchDic[@"connect_tel"]);      //自取电话
    orderDetailModel.fetchNote        = IfNullToString(fetchDic[@"note"]);             //自取备注
    
   
    NSMutableArray  * dataA = [[NSMutableArray alloc]init];
    for (NSDictionary  * dict in subDict[@"goods"]){
        
        ZXYOrderDetailModel * orderSubDetailModel = [[ZXYOrderDetailModel alloc]init];
        orderSubDetailModel.cash_spend       = IfNullToString(dict[@"cash_spend"]);
        orderSubDetailModel.goods_id         = IfNullToString(dict[@"goods_id"]);
        orderSubDetailModel.goodName         = IfNullToString(dict[@"name"]);
        orderSubDetailModel.goodImg_url      = IfNullToString(dict[@"img_url"]);
        orderSubDetailModel.status           = IfNullToString(dict[@"status"]);
        orderSubDetailModel.goods_nums       = IfNullToString(dict[@"goods_nums"]);
        orderSubDetailModel.spending            = [NSString stringWithFormat:@"%@",dict[@"spending"]];
        orderSubDetailModel.nums       =  IfNullToString(dict[@"nums"]);
     

        NSMutableArray *AttributeArray = [[NSMutableArray alloc] init];
        for (NSDictionary *attributeDict in dict[@"spec_id"]) {
            
            
            ZXYOrderDetailModel * attributeModel = [[ZXYOrderDetailModel alloc]init];
            
            attributeModel.key = IfNullToString(attributeDict[@"key"]);
            attributeModel.value = IfNullToString(attributeDict[@"value"]);
            
            [AttributeArray addObject:attributeModel];
        }
        
        
        orderSubDetailModel.spec_id = AttributeArray;
        
        
        
        
        [dataA addObject:orderSubDetailModel];
    }
    orderDetailModel.goodsArray = dataA;
    

       return orderDetailModel;
}

@end
