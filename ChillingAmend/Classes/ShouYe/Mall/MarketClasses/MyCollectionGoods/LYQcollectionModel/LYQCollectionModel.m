//
//  LYQCollectionModel.m
//  Chiliring
//
//  Created by nsstring on 14-9-29.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "LYQCollectionModel.h"

@implementation LYQCollectionModel

@synthesize goodsImgaeurl =_goodsImgaeurl;
@synthesize goodsName = _goodsName;
@synthesize goods_nums = _goods_nums;
@synthesize goodsspending = _goodsspending;
@synthesize goodsId = _goodsId;
@synthesize orderCreateTime = _orderCreateTime;
@synthesize orderId= _orderId;
@synthesize goodscash = _goodscash;

-(void)dealloc
{
    self.goodsImgaeurl =nil;
    self.goodsName =nil;
    self.goods_nums =nil;
    self.goodsspending =nil;
    self.goodsId =nil;
    self.orderCreateTime =nil;
    self.orderId =nil;
    self.goodscash = nil;
    
}
@end
