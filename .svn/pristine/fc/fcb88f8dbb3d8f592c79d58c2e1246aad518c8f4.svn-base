//
//  ZXYCommitOrderRequestModel.h
//  MarketManage
//
//  Created by Rice on 15/1/22.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarketAPI.h"

@interface ZXYCommitOrderRequestModel : NSObject
//    "por" : "202",   //请求接口
//    “proIden”:“”，  //产品标识
//    " user_id" : "",   //用户id
//    " user_name" : "",   //用户名

//    “goods_id”:“”，  //商品id
//    “goods_nums”:“”；  //购买商品数
//    "draw_type " : "***",   //领取方式1自取，2快递
//    "pay_type":1支付宝支付，2 积分支付， 3网银支付，4..
//    "address" : "***",   //地址
//    "connect_name" : "***",   //联系人
//    "connect" : "***",   //联系方式
//    "note" : "***",   //备注(可以为空)
//    "order_time" : "***",   //订单时间（时间戳）
//    “rsa_yunfei”:  //107接口返回的密文，没有运费则传0
//    string	type   ：” 纸质” // 发票类型:纸质/电子等
//    invoice_title :”个人/xxx公司”//发票抬头：个人/某单位
//invoice_category:”电子/生活/..”//发票分类：电子/生活等
//    "sign":"***",   //加密后数据，通过公钥和摘要生成的秘文


//@property (copy, nonatomic) NSString *goods_id;
/** 购买商品数 */
@property (copy, nonatomic) NSString *goods_nums;
//@property (copy, nonatomic) NSString *draw_type;//1自取 2快递
/** 1现金 2积分 */
@property (copy, nonatomic) NSString *pay_type;
@property (copy, nonatomic) NSString *area;
/** 地址 */
@property (copy, nonatomic) NSString *address;
/** 联系人 */
@property (copy, nonatomic) NSString *connect_name;
/** 联系方式 */
@property (copy, nonatomic) NSString *connect;
/** 备注(可以为空) */
@property (copy, nonatomic) NSString *note;
/** 订单时间（时间戳） */
@property (copy, nonatomic) NSString *order_time;
/** 107接口返回的密文，没有运费则传0 */
@property (copy, nonatomic) NSString *rsa_yunfei;
@property (copy, nonatomic) NSString *invoice_type;
/** 发票抬头：个人/某单位 */
@property (copy, nonatomic) NSString *invoice_title;
/** 发票分类：电子/生活等 */
@property (copy, nonatomic) NSString *invoice_category;
@property (copy, nonatomic) NSString *sign;
//@property (copy, nonatomic) NSString *transportType;//配送方式显示信息
//@property (copy, nonatomic) NSString *transportCode;//配送方式获取
/** 运费 */
@property (copy, nonatomic) NSString *freight;
/** 订单号 */
@property (copy, nonatomic) NSString *orderNum;
//@property (copy, nonatomic) NSString *type;//1实物 2虚拟
//@property (copy, nonatomic) NSString *validTime;//储存自取有效期 天数
/** 储存支付宝回调结果 */
@property (copy, nonatomic) NSString *payStatu;
/** 储存支付宝支付页面，判断返回处理 Market:商城 */
@property (copy, nonatomic) NSString *payView;
/** 积分总花费 */
@property (copy, nonatomic) NSString * spending;
/** 现金总消费 */
@property (copy, nonatomic) NSString * cash_apend;
/** 支付的id */
@property (nonatomic,copy)  NSString  * cat_ID;
/** 默认地址的id */
@property (nonatomic,copy)  NSString  * addressId;

+(ZXYCommitOrderRequestModel *)shareInstance;

- (void)setobject:(NSDictionary*)dic;
@end
