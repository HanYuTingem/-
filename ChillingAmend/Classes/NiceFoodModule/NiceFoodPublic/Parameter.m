//
//  Parameter.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/8.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "Parameter.h"


@interface Parameter()


@end

@implementation Parameter


+ (id)getNearShopListWithAreaDatas:(AreaClassModel *)areaDatas
                                    classDatas:(IndustryClassModel *)classDatas
                                     areaIndex:(NSInteger)areaIdex
                               areaSecondIndex:(NSInteger)areaSecondIndex
                                    classIndex:(NSInteger)classIndex
                              classSecondIndex:(NSInteger)classSecondIndex
                                     typeIndex:(NSInteger)typeIndex
                                     pageIndex:(NSInteger)pageIndex{
    
    BMKCloudNearbySearchInfo *cloudSearInfo = [[BMKCloudNearbySearchInfo alloc] init];
    cloudSearInfo.ak = BD_AK;
    cloudSearInfo.geoTableId = [MAPID intValue];
    cloudSearInfo.location = [NSString stringWithFormat:@"%.6f,%.6f", LONGITUDE, LATITUDE];
   
    NSArray *radiusArr = @[@"5000", @"500", @"1000", @"2000", @"5000"];
    cloudSearInfo.radius = [radiusArr[areaSecondIndex] intValue];
    cloudSearInfo.pageIndex = pageIndex;
//    cloudSearInfo.pageSize = 10;
    cloudSearInfo.sortby = @"distance:1";
    cloudSearInfo.keyword = CityName;
    
    
//    NSString *page = [NSString stringWithFormat:@"%d",pageIndex];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
//    [dic setObject:BD_AK forKey:@"ak"];//百度key
//    [dic setObject:MAPID forKey:@"geotable_id"];//云检索地图key
    
//    NSString *location = [NSString stringWithFormat:@"%.6f,%.6f", LONGITUDE, LATITUDE];
    
//    [dic setObject:location forKey:@"location"];//经纬度
//    [dic setObject:page forKey:@"page_index"];  //页标记
//    [dic setObject:@"20" forKey:@"page_size"];  //页大小
//    [dic setObject:@"distance:1" forKey:@"sortby"]; //排序方式
    
    
//    NSArray *radiusArr = @[@"5000", @"500", @"1000", @"2000", @"5000"];
    

//    [dic setObject:radiusArr[areaSecondIndex] forKey:@"radius"];

    
    
    NSMutableString *classStr = [NSMutableString string];
    
    if (classIndex > 0) {
        if (classSecondIndex == 0) {
            classStr = [NSMutableString stringWithFormat:@"industryClassifyId:%@",classDatas.industryClassifyList[classIndex-1][@"industryClassifyId"]];
            
        } else {
            classStr = [NSMutableString stringWithFormat:@"industryClassifyId:%@|industryClassifyIdChild:%@", classDatas.industryClassifyList[classIndex-1][@"industryClassifyId"], classDatas.industryClassifyList[classIndex-1][@"childList"][classSecondIndex - 1][@"industryClassifyId"]];
            
        }
    }
    
    

    
    NSString *typeStr = [NSString string];
    if (typeIndex == 0) {
        
    } else if (typeIndex == 1) {
        typeStr = [NSString stringWithFormat:@"provideServiceOrder:0"];
    } else if (typeIndex == 2) {
        typeStr = [NSString stringWithFormat:@"provideServiceTakeout:0"];
    }
    
    NSMutableString *filter = [[NSMutableString alloc] init];
    
 
    if (classStr > 0) {
        filter = [NSMutableString stringWithFormat:@"%@%@", filter, classStr];
//        [filter stringByAppendingString:classStr];
     
    }
  
    
    
    if (typeStr.length > 0) {
        if (classStr.length > 0){
            filter = [NSMutableString stringWithFormat:@"%@%@", filter, @"|"];
            
        }
        
        filter = [NSMutableString stringWithFormat:@"%@%@", filter, typeStr];
    }
    
    filter = [NSMutableString stringWithFormat:@"%@%@", filter, @"|deleteFlag:0|state:1"];

    if (filter.length > 0) {
//        [dic setObject:filter forKey:@"filter"];
        cloudSearInfo.filter = filter;
    }
    

//    NSDictionary *baiduPar =@{@"ak": BD_AK, @"geotable_id": @"89546", @"location": @"116.374105,39.868234", @"page_index":page};
    //        _areaClassModel.areaList[0][@"shopareaList"][0][@"shopareaName"]
    NSLog(@"%@", filter);
 
    return cloudSearInfo;
//    return (NSDictionary *)dic;
}


+ (id)getLocationShopListWithAreaDatas:(AreaClassModel *)areaDatas
                                        classDatas:(IndustryClassModel *)classDatas
                                         areaIndex:(NSInteger)areaIdex
                                   areaSecondIndex:(NSInteger)areaSecondIndex
                                        classIndex:(NSInteger)classIndex
                                  classSecondIndex:(NSInteger)classSecondIndex
                                         typeIndex:(NSInteger)typeIndex
                                         pageIndex:(NSInteger)pageIndex{
    
    
    BMKCloudLocalSearchInfo *cloudSearInfo = [[BMKCloudLocalSearchInfo alloc] init];
    cloudSearInfo.ak = BD_AK;
    cloudSearInfo.geoTableId = [MAPID intValue];
    cloudSearInfo.region = areaDatas.city;
    cloudSearInfo.pageIndex = pageIndex;
    cloudSearInfo.sortby = @"distance:1";
    cloudSearInfo.keyword = CityName;

    
//    NSString *page = [NSString stringWithFormat:@"%ld",(long)pageIndex];
    //    NSString *location = [NSString stringWithFormat:@"%f,%f", LONGITUDE, LATITUDE];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
//    [dic setObject:BD_AK forKey:@"ak"];//百度地图key
//    [dic setObject:MAPID forKey:@"geotable_id"];//地图id
//    [dic setObject:page forKey:@"page_index"];//页码
//    [dic setObject:@"20" forKey:@"page_size"];//单页条目
//    [dic setObject:@"distance:1" forKey:@"sortby"];//按距离排序 1表示升序
    
//    [dic setObject:areaDatas.city forKey:@"region"];//城市
    
    
//    商圈筛选条件
    NSMutableString *areaStr = [NSMutableString string];
    
    if (areaIdex == 1) {
        
        areaStr = [NSMutableString stringWithFormat:@"cityId:%@|areaId:%@|shopareaId:%@", areaDatas.cityId, areaDatas.hostShopareaList[areaSecondIndex][@"parentareId"], areaDatas.hostShopareaList[areaSecondIndex][@"shopareaId"]];
        
    } else if (areaIdex > 1){
        
        if (areaSecondIndex == 0) {
            areaStr = [NSMutableString stringWithFormat:@"cityId:%@|areaId:%@", areaDatas.cityId, areaDatas.data[areaIdex - 2][@"areaId"]];
        } else {
            areaStr = [NSMutableString stringWithFormat:@"cityId:%@|areaId:%@|shopareaId:%@", areaDatas.cityId, areaDatas.data[areaIdex - 2][@"areaId"], areaDatas.data[areaIdex - 2][@"shopareaList"][areaSecondIndex - 1][@"shopareaId"]];
        }
    }
    
    
//    分类筛选条件
    NSMutableString *classStr = [NSMutableString string];
    
    if (classIndex > 0) {
        if (classSecondIndex == 0) {
            classStr = [NSMutableString stringWithFormat:@"industryClassifyId:%@",classDatas.industryClassifyList[classIndex - 1][@"industryClassifyId"]];
            
        } else {
            classStr = [NSMutableString stringWithFormat:@"industryClassifyId:%@|industryClassifyIdChild:%@", classDatas.industryClassifyList[classIndex - 1][@"industryClassifyId"], classDatas.industryClassifyList[classIndex - 1][@"childList"][classSecondIndex - 1][@"industryClassifyId"]];
            
        }
    }
    

    
//    类型筛选条件
    NSString *typeStr = [NSString string];
    if (typeIndex == 0) {
        
    } else if (typeIndex == 1) {
        typeStr = [NSString stringWithFormat:@"provideServiceOrder:0"];
    } else if (typeIndex == 2) {
        typeStr = [NSString stringWithFormat:@"provideServiceTakeout:0"];
    }
    
    NSMutableString *filter = [[NSMutableString alloc] init];
    
    
    if (areaStr > 0) {
        filter = [NSMutableString stringWithFormat:@"%@%@", filter, areaStr];
    }
    
    
    if (classStr > 0) {
        if (filter.length > 0){
            filter = [NSMutableString stringWithFormat:@"%@%@", filter, @"|"];
        }
        filter = [NSMutableString stringWithFormat:@"%@%@", filter, classStr];
    }
  
    
    
 
    
    if (typeStr.length > 0) {
        if (filter.length > 0){
            filter = [NSMutableString stringWithFormat:@"%@%@", filter, @"|"];
        }
        filter = [NSMutableString stringWithFormat:@"%@%@", filter, typeStr];
    }
    
    
    filter = [NSMutableString stringWithFormat:@"%@%@", filter, @"|deleteFlag:0|state:1"];
    
    if (filter.length > 0) {
//        [dic setObject:filter forKey:@"filter"];
        cloudSearInfo.filter = filter;
    }
    
    
    //    NSDictionary *baiduPar =@{@"ak": BD_AK, @"geotable_id": @"89546", @"location": @"116.374105,39.868234", @"page_index":page};
    //        _areaClassModel.areaList[0][@"shopareaList"][0][@"shopareaName"]
    NSLog(@"%@", filter);
    return cloudSearInfo;
//    return (NSDictionary *)dic;

}

//获取商圈列表
+ (NSDictionary *)getAreaAndShopAreaWithCityId:(NSString *)cityId{
    
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:cityId forKey:@"cityId"];
    NSString *str = [temp JSONRepresentation];

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:FOOD_CHANGE_AREA forKey:@"method"];
    [dic setObject:str forKey:@"json"];
    
    return dic;
}

//获取行业分类
+ (NSDictionary *)getIndustryClassifyList{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    [dic setObject:FOOD_CHANGE_industry forKey:@"method"];    
    return dic;
}

//获取外卖菜品分类及菜品列表
+ (NSDictionary *)getTakeoutListWithOwnerId:(NSString *)ownerId{
    
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:ownerId forKey:@"ownerId"];
    
    NSString *str = [temp JSONRepresentation];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:NiceFood_TakeOutList forKey:@"method"];
    [dic setObject:str forKey:@"json"];
    
    return dic;
}

//获取城市id
+ (NSDictionary *)getCityinfoWithCity:(NSString *)city{
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:city forKey:@"cityName"];
    
    NSString *str = [temp JSONRepresentation];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:NiceFood_CityID forKey:@"method"];
    [dic setObject:str forKey:@"json"];
    
    return dic;
}

//获取外卖结算数据
+ (NSDictionary *)getTakeoutSettlementInfoWithOId:(NSString *)oId ownerId:(NSString *)ownerId totalprice:(NSString *)totalprice takeoutList:(NSArray *)takeoutList{
    
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:oId forKey:@"oId"];
    [temp setObject:ownerId forKey:@"ownerId"];
    [temp setObject:totalprice forKey:@"totalprice"];
    [temp setObject:takeoutList forKey:@"takeoutList"];
    
    NSString *str = [temp JSONRepresentation];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:NiceFood_TakeoutSettlement forKey:@"method"];
    [dic setObject:str forKey:@"json"];
    
    return dic;
}

//获取外卖订单详情
+ (NSDictionary *)getOrderDetailWithOrderId:(NSString *)orderId{
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:orderId forKey:@"orderId"];
    [temp setObject:ProIden forKey:@"proIden"];
    
    NSString *str = [temp JSONRepresentation];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:NiceFood_OrderDetail forKey:@"method"];
    [dic setObject:str forKey:@"json"];
    
    return dic;
}

//取消订单
+ (NSDictionary *)updateTakeOutWithTakeOutid:(NSString *)takeOutid{
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:HUserId forKey:@"oId"];
    [temp setObject:takeOutid forKey:@"takeOutid"];
    [temp setObject:ProIden forKey:@"proIden"];
    
    NSString *str = [temp JSONRepresentation];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:NiceFood_UpdateTakeOut forKey:@"method"];
    [dic setObject:str forKey:@"json"];
    
    return dic;
}

//删除订单
+ (NSDictionary *)deleteTakeOutWithTakeOutid:(NSString *)takeOutid{
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:HUserId forKey:@"oId"];
    [temp setObject:takeOutid forKey:@"takeOutid"];
    [temp setObject:ProIden forKey:@"proIden"];
    
    NSString *str = [temp JSONRepresentation];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:NiceFood_DeleteTakeOut forKey:@"method"];
    [dic setObject:str forKey:@"json"];
    
    return dic;
}

//提交订单
+ (NSDictionary *)saveOrderDataWithOwnerId:(NSString *)ownerId sendAddr:(NSString *)sendAddr linkman:(NSString *)linkman linkmanPhone:(NSString *)linkmanPhone linkmanSex:(NSString *)linkmanSex isInvoice:(NSString *)isInvoice invoiceDetail:(NSString *)invoiceDetail takeoutList:(NSArray *)takeoutList remark:(NSString *)remark couponState:(NSString *)couponState payMode:(NSString *)payMode couponId:(NSString *)couponId couponCodeId:(NSString *)couponCodeId deliveryPrice:(NSString *)deliveryPrice account:(NSString *)account actualPrice:(NSString *)actualPrice salePrice:(NSString *)salePrice{
    
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:HUserId forKey:@"oId"];
    [temp setObject:ProIden forKey:@"proIden"];
    [temp setObject:ownerId forKey:@"ownerId"];
    [temp setObject:sendAddr forKey:@"sendAddr"];
    [temp setObject:linkman forKey:@"linkman"];
    [temp setObject:linkmanPhone forKey:@"linkmanPhone"];
    [temp setObject:linkmanSex forKey:@"linkmanSex"];
    [temp setObject:isInvoice forKey:@"isInvoice"];
    [temp setObject:invoiceDetail forKey:@"invoiceDetail"];
    [temp setObject:takeoutList forKey:@"takeoutList"];
    [temp setObject:remark forKey:@"remark"];
    [temp setObject:couponState forKey:@"couponState"];
    [temp setObject:payMode forKey:@"payMode"];
    [temp setObject:couponId forKey:@"couponId"];
    [temp setObject:couponCodeId forKey:@"couponCodeId"];
    [temp setObject:deliveryPrice forKey:@"deliveryPrice"];
    [temp setObject:account forKey:@"account"];
    [temp setObject:actualPrice forKey:@"actualPrice"];
    [temp setObject:salePrice forKey:@"salePrice"];
    
    
    NSString *str = [temp JSONRepresentation];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:NiceFood_SaveOrderData forKey:@"method"];
    [dic setObject:str forKey:@"json"];
    
    return dic;
}

//获取可用优惠券列表
+ (NSDictionary *)getCanUseCouponListWithOwnerId:(NSString *)ownerId{

    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:HUserId forKey:@"oId"];
    [temp setObject:ownerId forKey:@"ownerId"];
    [temp setObject:ProIden forKey:@"proIden"];
    
    NSString *str = [temp JSONRepresentation];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:NiceFood_GetCanUseCouponList forKey:@"method"];
    [dic setObject:str forKey:@"json"];
    
    return dic;
}

//获取我的外卖列表
+ (NSDictionary *)getOrderTakeOutWithPage:(NSString *)page rows:(NSString *)rows{
    
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:HUserId forKey:@"oId"];
    [temp setObject:ProIden forKey:@"proIden"];
    [temp setObject:page forKey:@"page"];
    [temp setObject:rows forKey:@"rows"];
    
    NSString *str = [temp JSONRepresentation];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:NiceFood_GetOrderTakeOut forKey:@"method"];
    [dic setObject:str forKey:@"json"];
    
    return dic;
}

//获取支付码
+ (NSDictionary *)payInfoSignWithPayType:(NSString *)payType orderCode:(NSString *)orderCode{

    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:payType forKey:@"payType"];
    [temp setObject:orderCode forKey:@"orderCode"];
    
    NSString *str = [temp JSONRepresentation];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:NiceFood_PayInfoSign forKey:@"method"];
    [dic setObject:str forKey:@"json"];
    
    return dic;

}

//通知服务器支付成功
+ (NSDictionary *)updatePayTypeWithTradeCode:(NSString *)tradeCode price:(NSString *)price payType:(NSString *)payType{
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:tradeCode forKey:@"tradeCode"];
    [temp setObject:price forKey:@"price"];
    [temp setObject:payType forKey:@"payType"];
    
    NSString *str = [temp JSONRepresentation];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:NiceFood_UpdatePayType forKey:@"method"];
    [dic setObject:str forKey:@"json"];
    
    return dic;
}

//清除取消和过期的外卖订单
+ (NSDictionary *)cancelTakeOut{
    
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:HUserId forKey:@"oId"];
    [temp setObject:ProIden forKey:@"proIden"];

    NSString *str = [temp JSONRepresentation];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:NiceFood_CancelTakeOut forKey:@"method"];
    [dic setObject:str forKey:@"json"];
    
    return dic;
}

//根据优惠券返回订单价格
+ (NSDictionary *)getOrderPriceByCouponWithCouponId:(NSString *)couponId couponCodeId:(NSString *)couponCodeId orderPrice:(NSString *)orderPrice{
    
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:couponId forKey:@"couponId"];
    [temp setObject:couponCodeId forKey:@"couponCodeId"];
    [temp setObject:orderPrice forKey:@"orderPrice"];
    
    NSString *str = [temp JSONRepresentation];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:NiceFood_GetOrderPriceByCoupon forKey:@"method"];
    [dic setObject:str forKey:@"json"];
    
    return dic;
}

//获得验证码(完成)(修改手机号码)
+ (NSDictionary *)getVerificationCodeByPhoneNumber:(NSString *)phoneNumber{
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:phoneNumber forKey:@"phone"];
    NSString *str = [temp JSONRepresentation];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:kVerification_Code forKey:@"method"];
    [dic setObject:str forKey:@"json"];
    
    return dic;
}
//验证码后台校验
+ (NSDictionary *)getCheckTheAuthenticationCodeIsCorrectByPhoneNumber:(NSString *)phoneNumber andRandom:(NSString *)random{
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:phoneNumber forKey:@"phone"];
    [temp setObject:random forKey:@"random"];
    NSString *str = [temp JSONRepresentation];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:kCheck_The_Authentication_code forKey:@"method"];
    [dic setObject:str forKey:@"json"];
    
    return dic;
}
@end
