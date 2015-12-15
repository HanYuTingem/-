//
//  ZXYOrderNumCell.m
//  MarketManage
//
//  Created by Rice on 15/1/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYOrderNumCell.h"

@implementation ZXYOrderNumCell

- (void)awakeFromNib {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setCellLayout
{
//    self.backgroundColor = CrazyColor(75, 87, 114);
    self.orderValidheadLabel.hidden = YES;
    self.orderValidLabel.hidden = YES;
    self.bottonLineImage.hidden = YES;
    self.orderCreateTimeLabel.hidden = YES;
    self.buyDateLabel.hidden = YES;
    self.linetwoImage.hidden = YES;
    self.orderDataTimeLabel.text = [NSString stringWithFormat:@"%@",[MarketAPI getTimestamp:self.detailModel.orderCreatTime]];
//    [self.bgview setFrame:CGRectMake(ORIGIN_X(self.bgview), ORIGIN_Y(self.bgview), FRAMNE_W(self.bgview), 45)];

//    if (![_orderModel.orderStatu isEqual:@"1"]) {//待收货
//        [self.bgview setFrame:CGRectMake(ORIGIN_X(self.bgview), ORIGIN_Y(self.bgview), FRAMNE_W(self.bgview), 90)];
//        self.orderValidLabel.text = [NSString stringWithFormat:@"%@",_orderModel.orderConfirmTime];
//        self.orderValidheadLabel.hidden = NO;
//        self.orderValidLabel.hidden = NO;
//
//    }else{
//        [self.bgview setFrame:CGRectMake(ORIGIN_X(self.bgview), ORIGIN_Y(self.bgview), FRAMNE_W(self.bgview), 45)];
//        self.orderDataTimeLabel.hidden = YES;
//    }
}

-(void)setCellData
{
    NSArray *statuAry_2 = [NSArray arrayWithObjects:@"",@"待付款",@"待发货",@"待收货",@"待评价",@"已完成",@"已关闭",@"",@"已关闭", nil];
    
    NSInteger index = [self.detailModel.orderStatu integerValue];
    
    self.orderStatuLabel.text = statuAry_2[index];
    self.orderNumLabel.text = self.detailModel.orderNum;
    self.orderCreateTimeLabel.text = [MarketAPI getTimestamp:self.detailModel.orderCreatTime];
    
    
}

@end
