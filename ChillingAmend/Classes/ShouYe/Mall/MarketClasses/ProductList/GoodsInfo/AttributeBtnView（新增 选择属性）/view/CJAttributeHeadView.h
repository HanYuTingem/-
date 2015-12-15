//
//  CJAttributeHeadView.h
//  MarketManage
//
//  Created by 赵春景 on 15-7-23.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSYGoodsInfo.h"

@interface CJAttributeHeadView : UIView

/** 添加照片的button */
//@property (weak, nonatomic) IBOutlet UIButton *btnIamge;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

/** 商品的名字 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 商品的价格 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

/** 商品详情 CJAttributeSelectController model进来的数据 */
@property (nonatomic,strong) LSYGoodsInfo * goods;

- (instancetype)initWithFrame:(CGRect)frame;

@end
