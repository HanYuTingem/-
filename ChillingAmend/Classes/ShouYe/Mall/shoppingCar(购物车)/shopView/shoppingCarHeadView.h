//
//  shoppingCarHeadView.h
//  MarketManage
//
//  Created by 许文波 on 15/7/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"
@interface shoppingCarHeadView : UIView

/** 上面的线 */
@property(nonatomic,strong) UIView *upLineView;
/** 选择按钮 */
@property(nonatomic,strong) ZHButton *selectBtn;

/** 图片 */
@property(nonatomic,strong) UIImageView *shopImage;

/** 商店的名称 */
@property(nonatomic,strong) UILabel *shopNameLabel;


-(void)refreshUI:(ListModel *)model;

@end
