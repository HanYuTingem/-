//
//  ZXYOrderGoodsCell.h
//  MarketManage
//
//  Created by Rice on 15/1/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyUILabel.h"
#import "ZXYOrderDetailModel.h"
#import "UIImageView+WebCache.h"
#import "MarketAPI.h"
#import "ZXYOrderModell.h"

@interface ZXYOrderGoodsCell : UITableViewCell


/** 标头 支付总额 */
@property(nonatomic,strong)UILabel  *PayTitleAllMoney;

/** 商品总额现金标头 */
@property(nonatomic,strong)UILabel  *shopAllTitleMoney ;

/** 商品总额现金 */
@property(nonatomic,strong)UILabel  *shopAllMoneyLabel ;



/** 商品总额积分标头 */
@property(nonatomic,strong)UILabel  *shopIntegralTitleMoney ;

/** 商品总额积分 */
@property(nonatomic,strong)UILabel  *shopIntegralMoneyLabel ;


/** 运费 标头*/
@property(nonatomic,strong)UILabel *FreightTitleLabel;

/** 运费 */
@property(nonatomic,strong)UILabel *FreightLabel;

/** 收款标头 */
@property(nonatomic,strong)UILabel *getMoneyTitleLabel;


/** 收款 */
@property(nonatomic,strong)UILabel *getMoneyLabel;



/** 下单标头 */
@property(nonatomic,strong)UILabel  *timeTitleLable;
/** 下单时间 */
@property(nonatomic,strong)UILabel  *timeLable;

/** 自动确认收货时间 */
@property(nonatomic,strong)UILabel *AutomaticTime;

@property(nonatomic,strong) UIView *line  ;

@property(nonatomic,strong)UIView *lineTwo;


@property (strong, nonatomic) ZXYOrderModell *orderModel;
@property (strong, nonatomic) ZXYOrderDetailModel *detailModel;
-(void)setCellLayout;
-(void)setCellData;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andIden:(NSString *)iden andSpending_total:(NSString *)spending_total goodsCashAmout:(NSString *)goodsCashAmout;


@end
