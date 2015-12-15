//
//  ZXYCommitOrderRequestModel.m
//  MarketManage
//
//  Created by Rice on 15/1/22.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYCommitOrderRequestModel.h"

@implementation ZXYCommitOrderRequestModel

+(ZXYCommitOrderRequestModel *)shareInstance
{
    static ZXYCommitOrderRequestModel *commitModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        commitModel = [[ZXYCommitOrderRequestModel alloc] init];
    });
    return commitModel;
}

- (void)setobject:(NSDictionary*)dic
{
    if(!dic){
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970]*1000;
        NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
        
        self.goods_nums       = @"1";
        self.invoice_type     = @"纸质";
        self.invoice_title    = @"个人";
        self.invoice_category = @"不开发票";
        self.note             = @"";
        self.freight          = @"0";
        self.rsa_yunfei       = @"";
        self.area             = @"";
        self.address          = @"";
        self.connect_name     = @"";
        self.connect          = @"";
        self.addressId        = @"";
        self.order_time       = timeString;

  
    }else{
        self.area           = IfNullToString(dic[@"area"]) ;
        self.address        = IfNullToString(dic[@"address"]) ;
        self.connect_name   = IfNullToString(dic[@"connect_name"]);
        self.connect        = IfNullToString(dic[@"connect_tel"]);
        self.addressId      = IfNullToString(dic[@"id"]);

    }
    
}

@end
