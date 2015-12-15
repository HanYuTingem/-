//
//  ShoppingCarCell.h
//  MarketManage
//
//  Created by 许文波 on 15/7/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "jsonMyModel.h"
#import "ListModel.h"
#import "CrazyPurchaseQuantityView.h"
@interface ShoppingCarCell : UITableViewCell<CrazyPurchaseQuantityViewDelegate>

@property(nonatomic,strong)ZHButton *selectBtn;//选择按钮

@property(nonatomic,strong)UIImageView *shopImageView;//商品图片

@property(nonatomic,strong)UILabel *shopTitle;//商品标题

@property(nonatomic,strong)UIView *showView;//此View 用来显示隐藏是编辑还是可以修改的

@property(nonatomic,strong)UIView *editView;//可以编辑的View

@property(nonatomic,strong)UILabel *colorLabel;//商品颜色

@property(nonatomic,strong) UILabel *nowMoneyLabel;//商品现价

@property(nonatomic,strong) UILabel *agoMoneylabel;//商品原价


@property(nonatomic,strong) UILabel *editViewMoneyLabel;//可以编辑上面的钱
@property(nonatomic,strong) UIButton *reduceBtn;//减少按钮
@property(nonatomic,strong) UILabel *shopCountLabel;//商品的数量
@property(nonatomic,strong) UIButton *addBtn;//添加按钮

/** 商品个数 */
@property (nonatomic,strong) UILabel *shopCount;


/** 失效 */
@property (nonatomic,strong) UILabel *invaildLabel;

/** 失效原因 */
@property (nonatomic,strong) UILabel *captionLabel ;
/**
 *  数量视图
 */
@property (weak,nonatomic) CrazyPurchaseQuantityView *mQuantityView;


/** 传过来的ListModel */
@property (nonatomic,strong) ListModel *listModel;


/** 选择按钮 */
-(void)refreshShoppingCarUI:(BOOL)isSelect;
/** 是否是编辑 */
-(void)refreshCellShowViewOrEditView:(BOOL)isEdit;

/** 刷新数据 */
-(void)refreshUI:(ListModel *)model;

- (void)CrazyShoppingCartListCellViewReload;

@end
