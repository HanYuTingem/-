//
//  countView.h
//  MarketManage
//
//  Created by 许文波 on 15/7/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface countView : UIView
/** 全选按钮 */
@property(nonatomic,strong)ZHButton *selectAllBtn;

/** 合计 */
@property  (nonatomic,strong) UILabel *TotalLabel;

/** 钱数 */
@property(nonatomic,strong) UILabel *moneyLabel;

/** 结算图片 */
@property(nonatomic,strong)UIImageView *countImageView;

/**  结算钱数 */
@property(nonatomic,strong) UILabel *countLabel;

/** 去结算按钮 */
@property(nonatomic,strong) UIButton *countMoney ;

/** 用费 */
@property (nonatomic,strong) UILabel *fareLabel;

/** 判断是否是显示结算还是删除 */
@property (nonatomic,strong) UIView *CountOrDel;

/** 删除按钮 */
@property (nonatomic,strong) UIButton *delButton;


-(void)refreshFrame:(NSString *)allMoney;

@end
