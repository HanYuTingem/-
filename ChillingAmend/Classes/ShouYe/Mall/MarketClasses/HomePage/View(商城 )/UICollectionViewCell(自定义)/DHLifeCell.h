//
//  DHLifeCell.h
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModularListModel.h"
@interface DHLifeCell : UICollectionViewCell


//@property (weak, nonatomic) IBOutlet UILabel *titleLable;
//
//@property (weak, nonatomic) IBOutlet UILabel *sub_titleLabel;
//
//@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;


@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *sub_titleLabel;
@property(nonatomic,strong)UIImageView *shopImageView;



-(void)refreshLifeUI:(ModularListModel *)modularListModel withUrl:(NSString *)url;

@end
