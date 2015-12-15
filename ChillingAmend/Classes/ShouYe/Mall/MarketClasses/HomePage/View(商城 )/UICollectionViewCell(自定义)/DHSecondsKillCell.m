//
//  DHSecondsKillCell.m
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHSecondsKillCell.h"

@implementation DHSecondsKillCell
-(void)refreshKillUI:(ActitvityListModel *)modularList withUrl:(NSString *)url{
    
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *url = [user objectForKey:@"host"];

    [self.shopImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,modularList.img]] placeholderImage:[UIImage imageNamed:@"defaultimg_2"]];
    
//    self.nowMoneyLabel.text = modularList.name;
    
}
@end
