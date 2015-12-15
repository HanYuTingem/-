//
//  MessageTableViewCell.m
//  ChillingAmend
//
//  Created by 许文波 on 14/12/22.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "TimeStringTransform.h"
#import "JPCommonMacros.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)parWithMessage:(MessageModel*)model
{
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.timeLabel.text =  [TimeStringTransform getTimeString:model.createTime];
    // 最大尺寸
    CGSize size = CGSizeMake(302, MAXFLOAT);
    // 获取当前那本属性
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13.0f], NSFontAttributeName, nil];
    // 实际尺寸
    CGSize actualSize = [model.content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    self.contentLabel.verticalAlignment = VerticalAlignmentTop;
    self.contentLabel.frame = CGRectMake(self.contentLabel.frame.origin.x, self.contentLabel.frame.origin.y, self.contentLabel.bounds.size.width, actualSize.height);
    self.contentLabel.text = model.content;
    self.titleLabel.text = @"系统消息";
    if ([model.type isEqual:@"1"]) { // 系统消息
        self.qukankanButton.hidden = YES;
        self.bgView.frame = CGRectMake(0, 10, 320, 65 + actualSize.height);
    } else {
        self.qukankanButton.hidden = NO;
        self.bgView.frame = CGRectMake(0, 10, 320, 100 + actualSize.height);
    }
    self.bottomLineImg.frame = CGRectMake(ORIGIN_X(self.bottomLineImg), CGRectGetHeight(self.bgView.frame) - 1, CGRectGetWidth(self.bottomLineImg.frame), CGRectGetHeight(self.bottomLineImg.frame));
}

@end
