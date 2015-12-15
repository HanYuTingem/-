//  消息cell
//  MessageTableViewCell.h
//  ChillingAmend
//
//  Created by 许文波 on 14/12/22.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyUILabel.h"
#import "MessageModel.h"

@interface MessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView; // 背景图片
@property (weak, nonatomic) IBOutlet UIImageView *bottomLineImg; // 底部
@property (strong, nonatomic) IBOutlet UILabel *titleLabel; // 名称
@property (strong, nonatomic) IBOutlet UILabel *timeLabel; // 时间
@property (strong, nonatomic) IBOutlet MyUILabel *contentLabel; // 内容
@property (strong, nonatomic) IBOutlet UIButton *qukankanButton; // 去看看button

- (void)parWithMessage:(MessageModel*)model;
@end
