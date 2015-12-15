//
//  Url_NiceFood.h
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/2.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#ifndef PRJ_NiceFoodModule_Url_NiceFood_h
#define PRJ_NiceFoodModule_Url_NiceFood_h
//1104996522   fLQqwcFnOaY026fi
//#define BDUrl_near @"http://api.map.baidu.com/geosearch/v3/nearby"
//#define BDUrl_location @"http://api.map.baidu.com/geosearch/v3/local"
//#define SHANGCHENG_url  @"http://hpyuserapp.sinosns.cn/"

////86接口
//#define NiceFood_Url @"http://192.168.10.86:9015/o2o/webservice"
//#define NiceFood_ImageUrl @"http://192.168.10.86:9015/"
//#define Http @"http://192.168.10.86:9015/o2o/share/"

////172接口
//#define NiceFood_Url @"http://192.168.10.172:8080/o2o/webservice"
//#define NiceFood_ImageUrl @"http://192.168.10.172:8080/"
//#define Http @"http://192.168.10.172:8080/o2o/share/"

////线上测试地址
//#define NiceFood_Url @"http://java.test.sinosns.cn/o2o/webservice"
//#define NiceFood_ImageUrl @"http://img.sinosns.cn/o2o_img/"
//#define Http @"http://java.test.sinosns.cn/o2o/share/"

//线上地址
#define NiceFood_Url @"http://o2o.sinosns.cn/o2o/webservice"
#define NiceFood_ImageUrl @"http://img.sinosns.cn/o2o_img/"
#define Http @"http://o2o.sinosns.cn/o2o/share/"

//#define NiceFood_Url @"http://192.168.100.112:8080/o2o/webservice"
//#define NiceFood_ImageUrl @"http://192.168.100.112:8080"






#define YoumengAppKey @"565d3d56e0f55a169f0004c3"


#define HPY_URL  SHANGCHENG_url
#define NFM_URL  NiceFood_Url

#define PROIDEN ProIden





/**   订座相关接口    */

//收藏商家、取消收藏
#define SAVEORUPDATECOLLECTION @"saveOrUpdateCollection"

//获取商户信息
#define  GET_BUSINESSINFO      @"queryBusinessInfo"

//获取商家收藏的状态
#define GET_COLLENTIONBYCUSTOMERID @"getcollentionByCustomerId"

//获取我的收藏列表
#define GET_MYCOLLECTIONLIST @"getCollectinoByCustomer"

//删除我的收藏
#define DELETEMYCOLLECTION @"updateCollectoinById"

//  提交订座订单
#define SUBMITRESERVATION       @"saveSeatOrderByCustomerId"

//  修改定做订单
#define MODIFYRESERVATION       @"updateSeatOrderByCustomerById"

//清除过期订座
#define MY_BOOK_CLEAROVERTIME   @"deleteEmptyBySeat"

//我的订座
#define MY_BOOK_SEAT            @"getSeatOrderByCustomer"

//我的订座详情
#define MY_BOOK_SEAT_DETAIL     @"getSeatOrderbySeatId"

//获取商户商品类型及商品
#define GET_CHANNELANDCONTENT   @"getChannelAndContent"

//根据商家查询是否有商品
#define GET_DISHESBYBUSINESSID    @"getDishesByBusinessId"

//  取消订座
#define CANCELRESERVATION       @"updateSeatOrderCancelById"

//获取优惠劵详情
#define GETCOUPONDETAIL         @"getCouponDetail"

//领取优惠券
#define SAVEUSERCOUPON         @"saveUserCoupon"

//获取我的优惠劵列表
#define GETUSERCOUPONLIST     @"getUserCouponList"


//获取商圈
#define FOOD_CHANGE_AREA @"getAreaAndShopArea"
//获取行业
#define FOOD_CHANGE_industry @"getIndustryClassifyList"


//外卖列表
#define NiceFood_TakeOutList @"getTakeoutList"

//外卖结算
#define NiceFood_TakeoutSettlement @"getTakeoutSettlementInfo"

//城市id
#define NiceFood_CityID @"getCityinfo"

//外卖订单详情
#define NiceFood_OrderDetail @"getOrderDetail"

//取消订单
#define NiceFood_UpdateTakeOut @"updateTakeOut"

//删除外卖订单
#define NiceFood_DeleteTakeOut @"DeleteTakeOut"

//生成外卖订单
#define NiceFood_SaveOrderData @"saveOrderData"

//清除取消和过期的外卖订单
#define NiceFood_CancelTakeOut @"cancelTakeOut"

//获取我的外卖订单
#define NiceFood_GetOrderTakeOut @"getOrderTakeOut"

//获取可用优惠券
#define NiceFood_GetCanUseCouponList @"getCanUseCouponList"

//根据优惠券返回订单价格
#define NiceFood_GetOrderPriceByCoupon @"getOrderPriceByCoupon"

//获取支付码
#define NiceFood_PayInfoSign @"payInfoSign"

//通知服务器支付成功
#define NiceFood_UpdatePayType @"updatePayType"

//获得验证码(完成)(修改手机号码)
#define kVerification_Code    @"getRandom"

//验证码后台校验
#define kCheck_The_Authentication_code     @"getCode"
#endif
