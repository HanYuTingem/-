//
//  CJCashTableViewCell.h
//  Wallet
//
//  Created by zhaochunjing on 15-10-23.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDHBankModel.h"

@interface CJCashTableViewCell : UITableViewCell
/** 银行卡的名称 */
@property (weak, nonatomic) IBOutlet UILabel *bankCardNameLabel;
/** 选中图片 开始的时候是隐藏的 */
@property (weak, nonatomic) IBOutlet UIImageView *selecteImageView;
/** 银行卡信息模型 */
@property (nonatomic, strong) GDHBankModel *bankModel;

@end
