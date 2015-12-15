//
//  JKGroupModel.h
//  QQList
//
//  Created by CarolWang on 14/11/21.
//  Copyright (c) 2014年 CarolWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKGroupModel : NSObject

@property(nonatomic,strong)NSArray      * channelList;//商品类型
@property(nonatomic,strong)NSString     * channelId;//商品类型id
@property(nonatomic,strong)NSString     * channelName;//商品类型名称价格
@property(nonatomic,strong)NSString     * channelUnit;//商品类型单位 份
@property(nonatomic,strong)NSArray      * channelContentList;//商品类型下商品

@property (nonatomic, assign) BOOL isOpen;

@end
