//
//  DHConfirmOrderCell.h
//  MarketManage
//
//  Created by 许文波 on 15/7/28.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"

@interface DHConfirmOrderCell : UITableViewCell
/** 商品的图片 */
@property(nonatomic,strong) UIImageView *shopImageView;
/** 商品的名称 */
@property(nonatomic,strong) UILabel *shopName;
/** 商品的颜色 */
@property(nonatomic,strong) UILabel *colorLabel;
/** 现在的价钱 */
@property(nonatomic,strong) UILabel *nowLabel;
/** 原价 */
@property(nonatomic,strong) UILabel *agoLabel;

/** 商品的件数 */
@property(nonatomic,strong) UILabel *shopNum;

/** 配送方式 */
@property(nonatomic,strong) UILabel *wayLabel;
/** 注释方式 */
@property(nonatomic,strong) UILabel *ExpressLabel;
/** 快递方式 */
@property(nonatomic,strong) UIButton *ExpressBtn;
/** 快递方式的文本 */
@property (nonatomic,strong) UILabel *expressBtnLabel;

/** 发票 */
@property(nonatomic,strong)  UILabel *InvoiceInfoLabel;
/** 是否开发票 */
@property(nonatomic,strong) UILabel *Invoicing;
/** 选择是否开发票 */


@property(nonatomic,strong) UIButton *InvoicingBtn;

/** 发票的文字 */
@property(nonatomic,strong) UILabel *invoicingLableText;
/** 留言 */
@property(nonatomic,strong) UITextView *Message;
/** 留言文字 */
@property (nonatomic,strong) UILabel *messageLabel;
/** 用来存放 */
@property(nonatomic,strong) UIView *view;


/** 商品数量 */
@property(nonatomic,strong) UILabel *shopAllNum;
-(void)refreshUI:(NSArray *)arr;

-(void)refreshUIExpress:(NSDictionary *)dic;
@end
