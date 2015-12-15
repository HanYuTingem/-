//
//  DHHeadAdvert.h
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModularListModel.h"
@interface DHHeadAdvert : UICollectionReusableView


@property(nonatomic,strong) UIButton  *ImgButton;

-(void)refreshSelectMark:(ModularListModel *)model;
@end
