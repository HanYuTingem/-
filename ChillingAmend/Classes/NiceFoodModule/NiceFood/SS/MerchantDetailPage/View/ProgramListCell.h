//
//  ProgramListCell.h
//  QQList
//
//  Created by sunsu on 15/6/25.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgramListCell : UITableViewCell

@property(nonatomic,strong)UIImageView  * backImgView;
@property(nonatomic,strong)UILabel      * nameAndTimeLabel;
@property(nonatomic,strong)UIImageView  * maskImgView;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
