//
//  ZXYOrderNumCell.h
//  MarketManage
//
//  Created by Rice on 15/1/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXYOrderDetailModel.h"
#import "MarketAPI.h"
#import "ZXYOrderModell.h"
@interface ZXYOrderNumCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderCreateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatuLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderValidLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bottonLineImage;
@property (weak, nonatomic) IBOutlet UILabel *orderValidheadLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyDateLabel;
/** 订单时间 */
@property (weak, nonatomic) IBOutlet UILabel *orderDataTimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *linetwoImage;
@property (strong, nonatomic) ZXYOrderDetailModel *detailModel;
@property (strong, nonatomic) ZXYOrderModell *orderModel;
-(void)setCellLayout;
-(void)setCellData;

@end
