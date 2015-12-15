//
//  Parameter.h
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/8.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AreaClassModel.h"
#import "IndustryClassModel.h"



@interface Parameter : NSObject


//百度云图附近检索
+ (id)getNearShopListWithAreaDatas:(AreaClassModel *)areaDatas      //商圈集合
                                    classDatas:(IndustryClassModel *)classDatas //分类集合
                                     areaIndex:(NSInteger)areaIdex              //商圈一级目录BMKCloudSearchInfo.h标记
                               areaSecondIndex:(NSInteger)areaSecondIndex       //商圈二级目录标记
                                    classIndex:(NSInteger)classIndex            //分类一级目录标记
                              classSecondIndex:(NSInteger)classSecondIndex      //分类二级目录标记
                                     typeIndex:(NSInteger)typeIndex             //商户类型标记
                                     pageIndex:(NSInteger)pageIndex;            //页码标记
//百度云图本地检索
+ (id)getLocationShopListWithAreaDatas:(AreaClassModel *)areaDatas
                                    classDatas:(IndustryClassModel *)classDatas
                                     areaIndex:(NSInteger)areaIdex
                               areaSecondIndex:(NSInteger)areaSecondIndex
                                    classIndex:(NSInteger)classIndex
                              classSecondIndex:(NSInteger)classSecondIndex
                                     typeIndex:(NSInteger)typeIndex
                                         pageIndex:(NSInteger)pageIndex;


//获取行业分类条件
+ (NSDictionary *)getIndustryClassifyList;

//获取商圈条件
+ (NSDictionary *)getAreaAndShopAreaWithCityId:(NSString *)cityId;

//获取外卖菜品分类及菜品列表
+ (NSDictionary *)getTakeoutListWithOwnerId:(NSString *)ownerId;

//获取城市id
+ (NSDictionary *)getCityinfoWithCity:(NSString *)city;

//获取外卖结算数据
+ (NSDictionary *)getTakeoutSettlementInfoWithOId:(NSString *)oId ownerId:(NSString *)ownerId totalprice:(NSString *)totalprice takeoutList:(NSArray *)takeoutList;

//获取外卖订单详情
+ (NSDictionary *)getOrderDetailWithOrderId:(NSString *)orderId;

//取消订单
+ (NSDictionary *)updateTakeOutWithTakeOutid:(NSString *)takeOutid;

//删除订单
+ (NSDictionary *)deleteTakeOutWithTakeOutid:(NSString *)takeOutid;

//提交订单
+ (NSDictionary *)saveOrderDataWithOwnerId:(NSString *)ownerId sendAddr:(NSString *)sendAddr linkman:(NSString *)linkman linkmanPhone:(NSString *)linkmanPhone linkmanSex:(NSString *)linkmanSex isInvoice:(NSString *)isInvoice invoiceDetail:(NSString *)invoiceDetail takeoutList:(NSArray *)takeoutList remark:(NSString *)remark couponState:(NSString *)couponState payMode:(NSString *)payMode couponId:(NSString *)couponId couponCodeId:(NSString *)couponCodeId deliveryPrice:(NSString *)deliveryPrice account:(NSString *)account actualPrice:(NSString *)actualPrice salePrice:(NSString *)salePrice;

//获取可用优惠券列表
+ (NSDictionary *)getCanUseCouponListWithOwnerId:(NSString *)ownerId;

//获取我的外卖列表
+ (NSDictionary *)getOrderTakeOutWithPage:(NSString *)page rows:(NSString *)rows;

//获取支付码
+ (NSDictionary *)payInfoSignWithPayType:(NSString *)payType orderCode:(NSString *)orderCode;

//通知服务器支付成功
+ (NSDictionary *)updatePayTypeWithTradeCode:(NSString *)tradeCode price:(NSString *)price payType:(NSString *)payType;

//清除取消和过期的外卖订单
+ (NSDictionary *)cancelTakeOut;

//根据优惠券返回订单价格
+ (NSDictionary *)getOrderPriceByCouponWithCouponId:(NSString *)couponId couponCodeId:(NSString *)couponCodeId orderPrice:(NSString *)orderPrice;
//获得验证码(完成)(修改手机号码)
+ (NSDictionary *)getVerificationCodeByPhoneNumber:(NSString *)phoneNumber;

//验证码后台校验
+ (NSDictionary *)getCheckTheAuthenticationCodeIsCorrectByPhoneNumber:(NSString *)phoneNumber andRandom:(NSString *)random;
@end
