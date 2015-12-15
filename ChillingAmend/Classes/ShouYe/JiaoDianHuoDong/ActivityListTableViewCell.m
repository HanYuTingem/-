//
//  ActivityListTableViewCell.m
//  ChillingAmend
//
//  Created by 许文波 on 15/4/2.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import "ActivityListTableViewCell.h"
//#import "UIImageView+MJWebCache.h"
#import "UIImageView+WebCache.h"
#import "JPCommonMacros.h"

@implementation ActivityListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)parseActivityModel:(ActivityListModel*)model
{
    [self.activityImageView setImageWithURL:[NSURL URLWithString:model.activityImage] placeholderImage:[UIImage imageNamed:@"defaultimg_activity_list_img1.png"]];
    self.activityNameLabel.text = model.activityName;
    self.activityPersonLabel.text = model.activityPerson;
    CGSize boundSize = CGSizeMake(MAXFLOAT, CGRectGetHeight(self.activityPersonLabel.frame));
    CGSize personLabelSize = [self.activityPersonLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:boundSize lineBreakMode:NSLineBreakByWordWrapping];
    self.activityPersonLabel.frame = CGRectMake(SCREENWIDTH - 10 - personLabelSize.width, ORIGIN_Y(self.activityPersonLabel), personLabelSize.width, FRAMNE_H(self.activityPersonLabel));
    self.activityPersonImageView.frame = CGRectMake(ORIGIN_X(self.activityPersonLabel) - 15, ORIGIN_Y(self.activityPersonImageView), FRAMNE_W(self.activityPersonImageView), FRAMNE_H(self.activityPersonImageView));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
