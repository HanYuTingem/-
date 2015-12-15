//
//  DHHeadBrandsTJ.h
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHHeadBrandsTJ : UICollectionReusableView

@property (nonatomic,strong) UILabel *titleName;// 品牌推荐
@property(nonatomic,strong) UIImageView *upLineIamgeView;
@property(nonatomic,strong) UIImageView *downLineImageView;

-(void)refreshBrandsTJ:(NSString *)bransTJ;
@end
