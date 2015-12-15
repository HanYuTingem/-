//
//  DHhotMarketCell.m
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHhotMarketCell.h"

@implementation DHhotMarketCell
-(void)refreshThreeTwoUI:(ModularListModel *)model withUrl:(NSString *)url{
 
    NSString *url2  = [NSString stringWithFormat:@"%@%@",url,model.img];
    
    self.titleName.text = model.title;
    self.infoLable.text = model.sub_title;
    [self.shopImageView setImageWithURL:[NSURL URLWithString:url2] placeholderImage:[UIImage imageNamed:@"list_placeholder"]];
}

@end
