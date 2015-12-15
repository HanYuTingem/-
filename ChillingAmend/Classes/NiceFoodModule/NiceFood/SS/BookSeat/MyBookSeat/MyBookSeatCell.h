//
//  MyBookSeatCell.h
//  QQList
//
//  Created by sunsu on 15/7/1.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookSeatModel.h"
@interface MyBookSeatCell : UITableViewCell
@property(nonatomic,strong)NSString  * customerPhone;

-(void)getCellWithModel:(BookSeatModel * )model;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
