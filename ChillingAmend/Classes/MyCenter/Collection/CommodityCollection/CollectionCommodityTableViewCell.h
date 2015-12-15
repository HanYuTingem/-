//  收藏商品cell
//  CollectionCommodityTableViewCell.h
//  ChillingAmend
//
//  Created by 许文波 on 15/1/12.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityModel.h"

@interface CollectionCommodityTableViewCell : UITableViewCell
{
@private
    UIImageView*	m_checkImageView; // 需要删除的商品选中的imageView
    BOOL			m_checked; // 是否选中
}

@property (weak, nonatomic) IBOutlet UIImageView *commodityImageView; // 收藏商品图片
@property (weak, nonatomic) IBOutlet UILabel *commodityNameLabel; // 收藏商品名称
@property (weak, nonatomic) IBOutlet UILabel *commoditySubLabel; // 收藏商品兑换
@property (weak, nonatomic) IBOutlet UIImageView *topLineView; // 上线条
@property (weak, nonatomic) IBOutlet UIImageView *bottomLineView; // 下线条

- (void) setChecked:(BOOL)checked;
- (void)commodityWithCollectionCommodityModel:(CommodityModel*)model andhostImageUrl:(NSString *)host;

@end
