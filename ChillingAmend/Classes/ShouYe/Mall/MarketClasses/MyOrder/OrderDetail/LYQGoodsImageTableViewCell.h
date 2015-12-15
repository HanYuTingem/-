//
//  LYQGoodsImageTableViewCell.h
//  MarketManage
//
//  Created by 劳大大 on 15/4/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyUILabel.h"
#import "ZXYOrderDetailModel.h"
#import "MarketAPI.h"
#import "UIImageView+WebCache.h"
@interface LYQGoodsImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;

//商品名称
@property (weak, nonatomic) IBOutlet MyUILabel *goodsNameLabel;
//商品价格
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
//商品数量
@property (weak, nonatomic) IBOutlet UILabel *goodsCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsAttributeLabel;

@property (strong, nonatomic) ZXYOrderDetailModel *detailModel;

-(void)setCellData;

@end
