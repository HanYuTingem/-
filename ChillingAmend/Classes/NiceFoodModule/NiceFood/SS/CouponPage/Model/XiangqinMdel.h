//
//  XiangqinMdel.h
//  MyNiceFood
//
//  Created by liujinhe on 15/7/29.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XiangqinMdel : NSObject
@property(nonatomic,strong)NSString  *rescode;//响应码
@property(nonatomic,strong)NSString  *resdesc;//响应码说明
@property(nonatomic,strong)NSString  *couponUrl;//优惠券领取二维码图片
@property(nonatomic,strong)NSString  *couponDesc;//优惠券描述
@property(nonatomic,strong)NSString  *couponId;//优惠券Id
@property(nonatomic,strong)NSString  *createOwnerId;//创建商家Id
@property(nonatomic,strong)NSArray   *merchantsList;

@property(nonatomic,strong)NSString  *couponCode;
@property(nonatomic,strong)NSString  *couponName;//优惠券名称
@property(nonatomic,strong)NSString  *mainCorner;//总店角标(用于分享时取出集合中的数据)
@property(nonatomic,strong)NSString  *isHave;//是否领取过优惠券  0已领取 1未领取
@property(nonatomic,strong)NSString  *state;//1过期0未过期
@property(nonatomic,strong)NSString  *haveDraw;//1被领取完   0没有被领取完
@end
