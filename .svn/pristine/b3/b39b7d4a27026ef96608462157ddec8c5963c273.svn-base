//
//  ZXYRecommendModel.m
//  MarketManage
//
//  Created by Rice on 15/1/25.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYRecommendModel.h"

@implementation ZXYRecommendModel

@synthesize goodsImage;    //商品图片
@synthesize goodsTitle;    //商品名称
@synthesize goodsCash;     //商品单价-现金
@synthesize goodsSpending; //商品单价-积分
@synthesize goodsId; //商品id

- (void)dealloc
{
    self.goodsImage = nil;    //商品图片
    self.goodsTitle = nil;    //商品名称
    self.goodsCash = nil;     //商品单价-现金
    self.goodsSpending = nil; //商品单价-积分
    self.goodsId = nil; //商品id
}

+(ZXYRecommendModel *)createObjWithDic:(NSDictionary *)subDict withImageHost:(NSString *)host
{
    ZXYRecommendModel * recommendModel = [[ZXYRecommendModel alloc]init];
    recommendModel.goodsImage          = [NSString stringWithFormat:@"%@%@",host,IfNullToString(subDict[@"img_url"])];    //自取地址ID
    recommendModel.goodsTitle          = IfNullToString(subDict[@"name"]);      //自取地址
    recommendModel.goodsCash           = IfNullToString(subDict[@"cash"]);  //联系人姓名
    recommendModel.goodsSpending       = IfNullToString(subDict[@"price"]);   //联系人电话
    recommendModel.goodsId             = IfNullToString(subDict[@"id"]);     //领取时间
    
    return recommendModel;
}



@end
