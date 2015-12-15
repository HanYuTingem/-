//
//  CJCashTableViewCell.m
//  Wallet
//
//  Created by zhaochunjing on 15-10-23.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "CJCashTableViewCell.h"

@implementation CJCashTableViewCell

- (void)setBankModel:(GDHBankModel *)bankModel
{
    _bankModel = bankModel;
    self.bankCardNameLabel.text = [NSString stringWithFormat:@"%@ (尾号%@)",_bankModel.bankName,_bankModel.cardSn];
}

@end
