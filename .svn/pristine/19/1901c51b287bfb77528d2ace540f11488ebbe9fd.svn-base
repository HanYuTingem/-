//
//  MerchantModel.h
//  MyNiceFood
//
//  Created by sunsu on 15/7/8.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  ImageUrl = "http://wifiportal.sinosns.cn/image/business/42ddfc62-3d2f-401f-8c20-49dc2e3a5b7a.png";
 address = "\U701a\U6d77\U82b1\U56ed\U5927\U53a6\U4e8c\U5c42";
 businessDesc = "\U4fe1\U8bfa\U5496\U5561\U5385\Uff08Sino-coffee\Uff09\Uff0c\U5728\U4e3a\U60a8\U63d0\U4f9b\U7cbe\U9009\U5496\U5561\U8c46\U5236\U4f5c\U7684\U9187\U7f8e\U5496\U5561\U7684\U540c\U65f6\Uff0c\U4e5f\U4f5c\U4e3a\";
 commentImageList =     (
 );
 createTime = "05-28 15:51";
 customerId = 298327;
 customerName = "157****2844";
 deleteFlag = 0;
 haveMicroPortal = 1;
 hourstime = "\U5468\U4e00\U81f3\U5468\U65e5  8:00-23:55";
 icon = "http://wifiportal.sinosns.cn//image/icon/298327/1422929362920_myPersonPic.jpg";
 industryClassifyIdChildName = "\U5496\U5561\U5385";
 lat = "39.874817";
 lng = "116.380266";
 merchantPrefix = "http://wifiportal.sinosns.cn/";
 name = SinoCoffee;
 ownerCommentId = 418;
 perConsumption = 50;
 phone = "";
 praiseState = 1;
 provideServiceOrder = 0;
 provideServiceTakeout = 0;
 rescode = 0000;
 resdesc = "\U67e5\U8be2\U5546\U6237\U4fe1\U606f\U6210\U529f";
 shopAreaName = "\U5f00\U9633\U91cc";
 ucenterId = 164436;
 */

@interface MerchantModel : NSObject
/* 商户信息model */

@property(nonatomic,strong)NSString *imageUrl;//商家图片
@property(nonatomic,strong)NSString *address;//商家地址
@property(nonatomic,strong)NSString *businessDesc;//商家详情
@property(nonatomic,strong)NSString *hourstime;//营业时间
@property(nonatomic,strong)NSString *lat;//纬度
@property(nonatomic,strong)NSString *lng;//经度
@property(nonatomic,strong)NSString *name;//商家名称
@property(nonatomic,strong)NSString *phone;//商家电话
@property(nonatomic,strong)NSString *perConsumption;//人均消费
@property(nonatomic,strong)NSString *sendMoney;


@property(nonatomic,assign)NSInteger provideServiceOrder;//是否提供订座。0：提供，1：不提供
@property(nonatomic,assign)NSInteger provideServiceTakeout;//是否提供外卖。0：提供，1：不提供
@property(nonatomic,assign)NSInteger    totalNum;//优惠券总条数
@property(nonatomic,strong)NSArray  * couponList;//优惠券数组
@property(nonatomic,strong)NSString * collectStatus;//收藏状态
@property(nonatomic,strong)NSString * status;//打烊状态  0没打烊 1打烊
@property(nonatomic,strong)NSString * shopAreaName;//商圈名称


//评论暂时不做
@property(nonatomic,strong)NSDictionary *comment;//商家评论
@property(nonatomic,strong)NSString *commentContent;//评论内容
@property(nonatomic,strong)NSString *createTime;//评论时间
@property(nonatomic,strong)NSString *customerId;//评论人id
@property(nonatomic,strong)NSString *customerName;//评论人名称
@property(nonatomic,strong)NSString *ucenterId;//用户中心ID
@property(nonatomic,strong)NSString *icon;

@end

