//  奖品cell
//  PrizeTableViewCell.m
//  ChillingAmend
//
//  Created by 许文波 on 14/12/20.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "PrizeTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "BXAPI.h"

@implementation PrizeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)parseWithPrizeModel:(PrizeMessageModel*)model
{
    [_prizeImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", img_url, model.prizeImageUrl]] placeholderImage:[UIImage imageNamed:@"defaultimg_content_img"]];
    _prizeNameLabel.text = model.prizeName;
    [_prizeTimerLabel setText:[NSString stringWithFormat:@"有效期：%@ 至 %@",model.prizeBeginTime,model.prizeEndTime]];
    if ([model.prizeStatus isEqual:@"1"]) { // 未领取
        [_receiveStatusButton setTitle:@"未领取" forState:UIControlStateNormal];
    } else if ([model.prizeStatus isEqual:@"2"]) { // 已领取
        [_receiveStatusButton setTitle:@"已领取" forState:UIControlStateNormal];
    } else if ([model.prizeStatus isEqual:@"3"]) { // 领取中
        [_receiveStatusButton setTitle:@"领取中" forState:UIControlStateNormal];
    } else if ([model.prizeStatus isEqual:@"4"]) {
        [_receiveStatusButton setTitle:@"已过期" forState:UIControlStateNormal];
    }
}

@end
