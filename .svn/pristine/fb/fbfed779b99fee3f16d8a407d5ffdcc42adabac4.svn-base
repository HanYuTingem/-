//
//  FoodInfomationCell.h
//  QQList
//
//  Created by sunsu on 15/6/24.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
/**
 *  大家都在说cell
 */

#import <UIKit/UIKit.h>
#import "MerchantModel.h"

@protocol FoodInfomationCellDelegate <NSObject>
-(void)clickPerson;
@end

@interface FoodInfomationCell : UITableViewCell

@property(nonatomic,assign)id<FoodInfomationCellDelegate>delegate;

+(instancetype)cellWithTableView:(UITableView *)tableView;
- (void)reshTabelViewCell:(MerchantModel*)model;
@end
