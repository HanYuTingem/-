//
//  MyBookSeatMgCell.h
//  QQList
//
//  Created by sunsu on 15/7/1.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookSeatModel.h"
@interface MyBookSeatMgCell : UITableViewCell

@property(nonatomic,strong)BookSeatModel  * bookSeatModel;
@property(nonatomic,strong)UILabel *LVLevel;
@property(nonatomic,strong)UILabel *phoneNumLabel;
+(instancetype)cellWithTableView:(UITableView *)tableView;
-(void)reshTabelViewCell:(BookSeatModel *)model;

@end
