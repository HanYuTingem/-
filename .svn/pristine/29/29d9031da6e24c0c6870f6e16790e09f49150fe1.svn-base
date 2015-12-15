//
//  OtherShopListTableViewCell.m
//  HCheap
//
//  Created by 杨 玉龙 on 14/12/12.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//

#import "OtherShopListTableViewCell.h"

@implementation OtherShopListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)clickTel:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickPhone:cell:)]) {
        [self.delegate clickPhone:sender cell:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
