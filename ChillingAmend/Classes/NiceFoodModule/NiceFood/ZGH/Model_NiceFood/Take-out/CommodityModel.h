//
//  CommodityModel.h
//  HCheap
//
//  Created by JianDan on 14/12/22.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//
/*
 *  商家商品详情列表
 *  商品Model
 */
#import <Foundation/Foundation.h>

@interface CommodityModel : NSObject

//  商品ID
@property (nonatomic, strong)NSString *contentId;
//  商品标示
@property (nonatomic, strong)NSString *contentLabel;
//  商品名称
@property (nonatomic, strong)NSString *contentName;
//  商品价格
@property (nonatomic, assign)double price;
//  份数
@property (nonatomic, assign)NSInteger copies;

//  价格/份数   (获取订单数据的时候用到)
@property (nonatomic, strong)NSString *contentDetail;

@end
