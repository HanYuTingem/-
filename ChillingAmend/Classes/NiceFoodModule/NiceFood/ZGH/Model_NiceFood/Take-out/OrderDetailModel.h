//
//  OrderDetailModel.h
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/29.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailModel : NSObject

@property (nonatomic, copy) NSMutableArray *dishesList; //菜品列表

@property (nonatomic, copy) NSString *actualPrice;      //实际价格
@property (nonatomic, copy) NSString *createTime;       //订单创建时间
@property (nonatomic, copy) NSString *invoiceDetail;    //发票信息
@property (nonatomic, copy) NSString *linkman;          //联系人姓
@property (nonatomic, copy) NSString *linkmanPhone;     //联系电话
@property (nonatomic, copy) NSString *linkmanSex;       //联系人性别
@property (nonatomic, copy) NSString *orderCode;        //订单号
@property (nonatomic, copy) NSString *orderId;          //订单id
@property (nonatomic, copy) NSString *orderPrice;       //订单总价
@property (nonatomic, copy) NSString *ownerName;        //商家名称
@property (nonatomic, copy) NSString *payMode;          //支付方式
@property (nonatomic, copy) NSString *payState;         //支付状态
@property (nonatomic, copy) NSString *remark;           //备注
@property (nonatomic, copy) NSString *rescode;          //返回标示
@property (nonatomic, copy) NSString *resdesc;          //返回标示说明
@property (nonatomic, copy) NSString *salePrice;        //优惠价格
@property (nonatomic, copy) NSString *sendAddr;         //送餐地址
@property (nonatomic, copy) NSString *sendPrice;        //送餐价格
@property (nonatomic, copy) NSString *tel;              //商家手机号
@property (nonatomic, copy) NSString *phone;            //商家固定电话
@property (nonatomic, copy) NSString *orderFinishState; //订单状态

@end
