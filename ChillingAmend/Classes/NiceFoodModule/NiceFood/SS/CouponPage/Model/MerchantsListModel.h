//
//  merchantsListModel.h
//  MyNiceFood
//
//  Created by liujinhe on 15/7/29.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchantsListModel : NSObject

@property(nonatomic,strong)NSString  *address;//商户地址
@property(nonatomic,strong)NSString  *merchantName; //商户名称
@property(nonatomic,strong)NSString  *ownerId;//商家id
@property(nonatomic,strong)NSString  *phone;//商户电话
@property(nonatomic,strong)NSString  *merchantUrl;//商家图片
@property(nonatomic,strong)NSString  *businessDesc;//商家描述
@property(nonatomic,strong)NSString  *lat;//纬度
@property(nonatomic,strong)NSString  *lng;//经度

@end
