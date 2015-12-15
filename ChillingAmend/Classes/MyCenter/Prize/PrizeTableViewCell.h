//  奖品cell
//  PrizeTableViewCell.h
//  ChillingAmend
//
//  Created by 许文波 on 14/12/20.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrizeMessageModel.h"

@interface PrizeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *prizeImageView; // 图片
@property (weak, nonatomic) IBOutlet UILabel *prizeNameLabel; // 名称
@property (weak, nonatomic) IBOutlet UILabel *prizeTimerLabel; // 时间
@property (weak, nonatomic) IBOutlet UIButton *receiveStatusButton; // 状态

- (void)parseWithPrizeModel:(PrizeMessageModel*)model;
@end
