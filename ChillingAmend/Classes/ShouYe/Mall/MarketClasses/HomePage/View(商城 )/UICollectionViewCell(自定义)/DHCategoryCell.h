//
//  DHCategoryCell.h
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cateModel.h"
@interface DHCategoryCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *categoryImage;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

-(void)refreshCateGoryUI:(cateModel *)model andImagViewURL:(NSString *)imagViewStr;

@end
