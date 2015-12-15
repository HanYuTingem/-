//
//  ZXYInvoiceModel.m
//  MarketManage
//
//  Created by Rice on 15/1/26.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYInvoiceModel.h"

@implementation ZXYInvoiceModel

+(ZXYInvoiceModel *)shareInstance
{
    static ZXYInvoiceModel *invoiceModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        invoiceModel = [[ZXYInvoiceModel alloc] init];
        [invoiceModel setInvoiceType];
    });
    return invoiceModel;
}
/** 设置发票 */
- (void)setInvoiceType
{
    self.invoiceType = @"纸质";
    self.invoiceTitle = @"个人";
    self.invoiceContent = @"不开发票";

}
@end
