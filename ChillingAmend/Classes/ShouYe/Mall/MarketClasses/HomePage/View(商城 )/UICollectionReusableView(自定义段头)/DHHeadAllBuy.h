//
//  DHHeadAllBuy.h
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHHeadAllBuy : UICollectionReusableView


@property(nonatomic,strong)UILabel *titleName;
@property(nonatomic,strong) UIImageView *leftLineImageView;

@property(nonatomic,strong)UIImageView *rightLineImageView;

@property(nonatomic,strong) UIImageView *centerArrowImageView;

@property(nonatomic,strong)UILabel *titleLable;

-(void)refreshAllBuy:(NSString *)name;
@end
