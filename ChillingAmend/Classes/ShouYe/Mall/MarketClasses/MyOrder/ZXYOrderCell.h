//
//  ZXYOrderCell.h
//  MarketManage
//
//  Created by Rice on 15/1/13.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXYOrderModell.h"
#import "UIImageView+WebCache.h"
#import "myUILabel.h"


@protocol OrderStatuDelegate <NSObject>

-(void)orderStatuWithButton:(id)sender andCellTag:(NSInteger)tag;
//点击c对应的cell
- (void)didSelectCellTag:(NSInteger)tag;

@end

@interface ZXYOrderCell : UITableViewCell

@property (assign, nonatomic) NSInteger cellTag;
//下单时间
@property (weak, nonatomic) IBOutlet UILabel     *creatTimeLabel;
//订单状态
@property (weak, nonatomic) IBOutlet UILabel     *statuLabel;
//商品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
//商品名称
@property (weak, nonatomic) IBOutlet MyUILabel   *goodsNameLabel;
//商品单价
@property (weak, nonatomic) IBOutlet UILabel     *goodsPriceLabel;
//购买数量
@property (weak, nonatomic) IBOutlet UILabel     *goodsCountLabel;
//运费
@property (weak, nonatomic) IBOutlet UILabel     *FreightLabel;
//更多商品的时候展示的view
@property (weak, nonatomic) IBOutlet UIView *moreGoodView;
//更多商品展示的时候的scrollview
@property (weak, nonatomic) IBOutlet UIScrollView *moreGoodScrollView;
//购买总价
@property (weak, nonatomic) IBOutlet UILabel     *goodsAmoutLabel;
//有效期和自动确认收货时间
@property (weak, nonatomic) IBOutlet UILabel     *validAndconfirmTimeLabel;
//取消订单/申请退款
@property (weak, nonatomic) IBOutlet UIButton    *cancelOrderBtn;
//多功能按钮:删除订单/支付/确认收货/申请退款/评价
@property (weak, nonatomic) IBOutlet UIButton    *functionBtn;
//对于评价的商品的显示
@property (weak, nonatomic) IBOutlet UIButton *cancelEvalutionOrderBtn;
/** 商品单价 */
@property (weak, nonatomic) IBOutlet UILabel *shopSingleMoney;
/** 商品数量 */
@property (weak, nonatomic) IBOutlet UILabel *shopNum;
/** 商店名称 */
@property (weak, nonatomic) IBOutlet UILabel *storeName;
/** 显示颜色 */
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *allShopNumLabel;

//取消订单
@property (weak, nonatomic) IBOutlet UIView *bgview;

@property (assign, nonatomic) id <OrderStatuDelegate> delegate;

-(void)setCellWithModel:(ZXYOrderModell *)orderModel;

@end
