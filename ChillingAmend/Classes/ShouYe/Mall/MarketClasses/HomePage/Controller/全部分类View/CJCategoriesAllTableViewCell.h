//
//  CJCategoriesAllTableViewCell.h
//  MarketManage
//
//  Created by 赵春景 on 15-7-20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJAllCategoriesModel.h"
@interface CJCategoriesAllTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (nonatomic, strong) UIView *selectedBackgroundView;
@property (nonatomic, strong) UILabel *titleLable2;
@property (nonatomic, strong) UIImageView *iv ;

-(void)refreshUI:(CJAllCategoriesModel*)model;

@end
