//
//  CrazyShoppingCartShopTool.m
//  MarketManage
//
//  Created by fielx on 15/4/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyShoppingCartShopTool.h"
#import "MarketAPI.h"
static float totalPrice;
static float totalIntegral;


@implementation CrazyShoppingCartShopTool

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.mTotalPrice = 0;
//        self.mTotalIntegral = 0;
    }
    return self;
}

+(float)mTotalPrice
{
    return totalPrice;
}

+(float)mTotalIntegral
{
    return totalIntegral;
}


+(NSString *)CrazyShoppingCartShopToolShowPriceWithPrice:(NSString *)price  integral:(NSString *)integral
                                                  number:(int)number
{
    NSMutableString *showPrice = [NSMutableString stringWithCapacity:0];
    //价格
    float p = [price floatValue] * number;
    
    //积分
    float i = [integral floatValue] *number;
    
    
    if (p) {
        [showPrice appendString:[NSString stringWithFormat:@"￥%.2f",p]];
    }
    
    if (i) {
        if ([showPrice length]) {
            [showPrice appendString:[NSString stringWithFormat:@"+ %.0f %@ ",i,INTERGRAL_NAME]];
        }
        else
        {
            [showPrice appendString:[NSString stringWithFormat:@"%.0f %@",i,INTERGRAL_NAME]];
        }
    }
    
    return showPrice;
}

+(void)CrazyShoppingCartShopToolReloadData
{
    totalPrice = 0;
    totalIntegral = 0;
}


+(NSString *)CrazyShoppingCartShopToolShowTotalPriceWithPrice:(NSString *)price  integral:(NSString *)integral
                                                       number:(int)number
{
    
    NSMutableString *showPrice = [NSMutableString stringWithCapacity:0];
    //价格
    totalPrice += [price floatValue] * number;
    
    //积分
    totalIntegral += [integral floatValue] *number;
    
    if (totalPrice) {
        [showPrice appendString:[NSString stringWithFormat:@"￥%.2f",totalPrice]];
    }
    
    if (totalIntegral) {
        if ([showPrice length]) {
            [showPrice appendString:[NSString stringWithFormat:@"+ %@ %.0f",INTERGRAL_NAME,totalIntegral]];
        }
        else
        {
            [showPrice appendString:[NSString stringWithFormat:@"%@ %.0f",INTERGRAL_NAME,totalIntegral]];
        }
    }

   
    
    return showPrice;
    
    
}





@end
