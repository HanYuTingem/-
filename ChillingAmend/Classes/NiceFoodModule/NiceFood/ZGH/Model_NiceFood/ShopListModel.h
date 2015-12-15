//
//  ShopListModel.h
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/6/26.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopListModel : NSObject


@property (nonatomic, copy) NSString *address;              //商户地址
@property (nonatomic, assign) long areaId;                  //区域id
@property (nonatomic, assign) long autoid;                  //商户id
@property (nonatomic, copy) NSString *city;                 //城市
@property (nonatomic, assign) long cityId;                  //城市id
@property (nonatomic, assign) long coord_type;
@property (nonatomic, assign) long long create_time;
@property (nonatomic, assign) long deleteFlag;
@property (nonatomic, assign) long distance;                //距离
@property (nonatomic, copy) NSString *district;             //地区
@property (nonatomic, assign) long geotable_id;             //地图id
@property (nonatomic, assign) long industryClassifyId;      //行业分类id
@property (nonatomic, assign) long industryClassifyIdChild;  //子行业分类id
@property (nonatomic, copy) NSString *industryClassifyIdChildName; //子行业分类名称
@property (nonatomic, assign) long industryId;              //行业id
@property (nonatomic, assign) long level;                   //评分
@property (nonatomic, copy) NSArray *location;              //经纬度
@property (nonatomic, assign) long long modify_time;        //修改时间
@property (nonatomic, copy) NSString *name;                 //商户名称
@property (nonatomic, copy) NSString *perConsumption;       //平均消费
@property (nonatomic, copy) NSString *phone;                //电话
@property (nonatomic, assign) NSString *provideServiceDiscount;  //是否有优惠券
@property (nonatomic, assign) BOOL provideServiceNo;        //没有提供服务
@property (nonatomic, assign) NSString *provideServiceOrder;     //订座
@property (nonatomic, assign) NSString *provideServiceTakeout;   //外卖
@property (nonatomic, copy) NSString *province;             //省
@property (nonatomic, assign) long provinceId;              //省id
@property (nonatomic, assign) long sendupPrices;
@property (nonatomic, copy) NSString *shopImageUrl;         //商户图片链接
@property (nonatomic, assign) long shopareaId;              //商圈id
@property (nonatomic, copy) NSString *shopareaName;         //商圈名称
@property (nonatomic, assign) long state;                   //国家
@property (nonatomic, copy) NSString *title;                //标题
@property (nonatomic, assign) long type;                    //类型
@property (nonatomic, assign) long uid;
@property (nonatomic, assign) long weight;
@property (nonatomic, copy) NSString *flag;
@property (nonatomic, copy) NSString *proIden;              //产品标识

+ (ShopListModel *)modelWithDic:(NSDictionary *)dic;
+ (ShopListModel *)modelWithCloudPOIInfo:(BMKCloudPOIInfo *)info;
@end
