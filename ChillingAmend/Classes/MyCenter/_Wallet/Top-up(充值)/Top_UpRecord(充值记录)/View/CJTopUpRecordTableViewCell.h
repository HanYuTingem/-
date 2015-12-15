//
//  CJTopUpRecordTableViewCell.h
//  Wallet
//
//  Created by zhaochunjing on 15-10-22.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJTopUpModel.h"

@interface CJTopUpRecordTableViewCell : UITableViewCell
/** 支付类型 （提现 为银行名称） */
@property (weak, nonatomic) IBOutlet UILabel *payTypeLabel;
/** 时间label */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/** 现金label */
@property (weak, nonatomic) IBOutlet UILabel *cashLabel;
/** 支付状态label （成功，失败，处理中，已关闭） */
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
/** 外面传入的记录类型 0充值 1提现 */
@property (nonatomic, copy) NSString *recordType;

/** 提现／充值的数据模型 */
@property (nonatomic, strong) CJTopUpModel *topUpModel;

-(void)makeRefreshUIRowCell:(NSInteger)rowCell;
@end
