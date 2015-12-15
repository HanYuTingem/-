//
//  LSYContentTableViewCell.h
//  MarketManage
//
//  Created by liangsiyuan on 15/1/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSYGoodsInfo.h"
@interface LSYContentTableViewCell : UITableViewCell
@property(nonatomic,strong)NSDictionary * goodsDic;
@property (weak, nonatomic) IBOutlet UIImageView *noNumIMG;
@property (weak, nonatomic) IBOutlet UILabel *noNumLabel;
@property(nonatomic,copy)NSString * host;
@end
