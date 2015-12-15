//
//  LYSShopingCartTableViewCell.h
//  MarketManage
//
//  Created by 劳大大 on 15/4/17.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSYGoodsInfo.h"

@protocol  ShopingCartTableViewCellDelegate <NSObject>

//点击scrollview的代理方法
- (void)didSelectGoodsScrollView;

@end
@interface LYSShopingCartTableViewCell : UITableViewCell
/** 一个商品的时候显示的图片 */
@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;
/** 一个商品的时候显示的商品名称 */
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;
/** 一个商品的时候显示的商品的价格 */
@property (weak, nonatomic) IBOutlet UILabel *goodPriceLabel;
/** 多张图片的显示展示 */
@property (weak, nonatomic) IBOutlet UIScrollView *goodsScrollView;
/** 代理方法 */
@property (nonatomic,assign) id<ShopingCartTableViewCellDelegate>delegate;
/** 商品Model */
@property (nonatomic,strong)LSYGoodsInfo * goods;
/** 商品的数组 */
@property (nonatomic,strong) NSArray     * goodsArray;
/** 商品的。。。view */
@property (weak, nonatomic) IBOutlet UIView *moreLastView;
/** 商品总共多少件 */
@property (weak, nonatomic) IBOutlet UILabel *moreCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumber;

/** 选择的个数 */
@property (nonatomic,strong) NSArray *selectArrCount;

@end
