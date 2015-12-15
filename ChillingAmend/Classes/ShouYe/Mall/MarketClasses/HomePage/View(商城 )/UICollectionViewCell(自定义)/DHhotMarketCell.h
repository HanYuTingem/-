//
//  DHhotMarketCell.h
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModularListModel.h"
@interface DHhotMarketCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *infoLable;
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;


-(void)refreshThreeTwoUI:(ModularListModel *)model withUrl:(NSString *)url;


@end
