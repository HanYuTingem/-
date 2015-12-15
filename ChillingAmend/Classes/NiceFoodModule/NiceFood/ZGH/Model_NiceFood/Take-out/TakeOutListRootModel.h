//
//  TakeOutListRootModel.h
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/15.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TakeOutListRootModel : NSObject

@property (nonatomic, copy) NSString *rescode;//响应码
@property (nonatomic, copy) NSString *resdesc;//响应码说明
@property (nonatomic, copy) NSString *status;//是否打烊
@property (nonatomic, copy) NSString *takeOutPrice;//起送价格
@property (nonatomic, copy) NSArray *takeOutList;//商品集合

@end
