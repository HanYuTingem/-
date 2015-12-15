//
//  DHHeadWonderfulTJ.h
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHHeadWonderfulTJ : UICollectionReusableView
@property (nonatomic,strong) UILabel *titleName;//精选市场
@property(nonatomic,strong) UIImageView *upLineIamgeView;
@property(nonatomic,strong) UIImageView *downLineImageView;
-(void)refreshWonderfulTJ:(NSString *)name;
@end
