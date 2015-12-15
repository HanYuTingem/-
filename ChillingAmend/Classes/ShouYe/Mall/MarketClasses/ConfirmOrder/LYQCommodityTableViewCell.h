//
//  LYQCommodityTableViewCell.h
//  MarketManage
//
//  Created by 劳大大 on 15/4/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyUILabel.h"
#import "CrazyShoppingCartShopCommodityModel.h"
#import "UIImageView+WebCache.h"
#import "LSYGoodsInfo.h"

@interface LYQCommodityTableViewCell : UITableViewCell
/** 商品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
/** 商品名称 */
@property (weak, nonatomic) IBOutlet MyUILabel *goodsNameLabel;
/** 商品价格 */
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
/** 商品数量 */
@property (weak, nonatomic) IBOutlet UILabel *goodsNumsLabel;
/** 商品的小技的view */
@property (weak, nonatomic) IBOutlet UIView *priceCountView;
/** 商品的价格 */
@property (weak, nonatomic) IBOutlet UILabel *priceCountLabel;
/** 背景的view */
@property (weak, nonatomic) IBOutlet UIView *backgroudView;
/** 运费 */
@property (weak, nonatomic) IBOutlet UILabel *feightLabel;


/** 获取商家对应的商品 是否是最后一行 状态的色值 */
- (void)getDictData:(NSDictionary*)dict freightPrice:(NSString*)price cellStatu:(BOOL)lastCell andGoods:(NSArray*)array;


@end
