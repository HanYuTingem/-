//
//  LSYGoodsInfo.h
//  MarketManage
//
//  Created by liangsiyuan on 15/1/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSYGoodsInfo : NSObject
/** 商品名称 */
@property(nonatomic,copy)NSString * name;
/** Banner图 */
@property(strong,nonatomic)NSArray * images;
/** host */
@property(copy,nonatomic)NSString * host;
/** 价格 */
@property(nonatomic,assign)float  price;
/** 普通商品是否包邮 */
@property (nonatomic,copy) NSString * is_shipping;
/** 商家名称 */
@property(copy,nonatomic)NSString * shop_name;
/** 商家id */
@property(nonatomic,copy)NSString *  shop_id;
/** 产品 Pid */
@property(nonatomic,copy)NSString *  p_id;
/** 产品id */
@property(nonatomic,copy)NSString *  goods_id;
/** 数量 */
@property(nonatomic,assign)int  nums;
/** 支付方式 */
@property(nonatomic,assign)int  pay_type;
/** 商品简介 */
@property(nonatomic,copy)NSString * introduce;
/** 商品描述 */
@property(nonatomic,copy)NSString * details;
/** 厂商介绍 */
@property(nonatomic,copy)NSString * shop_introduce;
/** 商家电话（需要关联） */
@property(nonatomic,copy)NSString * shop_tel;
///** 列表图 */
@property(nonatomic,copy)NSString * _img_url;
/** 是否快递 */
@property(nonatomic,assign)int  is_express;
/** 是否自取 */
@property(nonatomic,assign)BOOL  is_self;
/** 商品状态1=代售|2=预售|3=在售|4=售罄|5=过期 */
@property(nonatomic,assign)int  state;
/** 4商品已下架 */
@property(nonatomic,assign)int  status;
/** 虚假兑换数 */
@property(nonatomic,copy)NSString * bum_convert;
/** 商品类型：1=实物，2=虚拟商品 */
@property(nonatomic,assign)int type;
/** 现金价格 */
@property(nonatomic,assign)float cash;
/** 限购数量 0-~~ */
@property(nonatomic,assign)int  restriction;
/** 运送方式：1快递，2EMS，3平邮 100自取 */
@property(nonatomic,strong)NSArray *  ys_type;
/** 运费0-~~ */
@property(nonatomic,assign)float freight;
/** 是否可购买，1是，0否 */
@property(nonatomic,assign)int flag;
/** 可购买数量，不限购或不知道用户id则为-1 */
@property(nonatomic,assign)int available;
/** 虚拟物品开始时间 */
@property(nonatomic,copy)NSString * use_start_time;
/** 虚拟物品结束时间 */
@property(nonatomic,copy)NSString * use_end_time;
/** 秒杀价格 */
@property(nonatomic,copy)NSString * ms_price;
/** 商家地址 */
@property (nonatomic,copy)NSString * shop_addr;
/** 商家电话 */
@property (nonatomic,copy)NSString * shopo_phone;
/** 秒杀活动结束 倒计时时间 */
@property (nonatomic,copy)NSString * end_time;
/** 秒杀 */
@property (nonatomic,assign)BOOL  isSeckilling;
/** 总价格 */
@property (nonatomic,retain) NSString  * countPrice;

/** 商品是否包邮 */
@property (retain, nonatomic) NSString *goodsPostage;

/** 是否存在活动 */
@property (nonatomic,retain) NSString * activity_type;

/** 是否是是否全场包邮 */
@property (nonatomic,retain) NSString * freeShip;
/** 运费 */
@property (nonatomic,retain) NSString  * countFreight;
/** 活动的id时候是 */
@property (nonatomic,retain)NSString * is_actID;

/** 购物车综述 */
@property (nonatomic,copy) NSString  * goodCardNum;

@property (nonatomic,retain) NSString  * act_id;

/** 商品属性数组  2015.07添加 */
@property (nonatomic, strong) NSMutableArray *attr_spec;


/** 新的 商品现金价格 */
@property (nonatomic,assign) float  goods_cashNew;
//
///** 商品积分价格 */
//@property (nonatomic,assign) int goods_price;


+(instancetype)goodsWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;
@end
