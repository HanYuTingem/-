//
//  ZXYOrderTransportCell.m
//  MarketManage
//
//  Created by Rice on 15/1/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYOrderTransportCell.h"

@implementation ZXYOrderTransportCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setCellLayout
{
            self.expNameHeadLabel.hidden = NO;
            self.expNameLabel.hidden = NO;
            self.expNumHeadLabel.hidden = NO;
            self.expNumLabel.hidden = NO;
            self.line_1.hidden = NO;
            self.line_2.hidden = NO;
            [self.bgview setFrame:CGRectMake(ORIGIN_X(self.bgview), ORIGIN_Y(self.bgview), FRAMNE_W(self.bgview), 180)];
            [self.line_bottom setFrame:CGRectMake(0, FRAMNE_H(self.bgview) - 1, 320, 1)];
    
}

-(void)setCellData
{
            self.trpTypeLabel.text = [NSString stringWithFormat:@"快递 %@元",self.detailModel.orderFreight];
            self.expBillMsgLabel.text =[self.detailModel.expressBillMsg stringByReplacingOccurrencesOfString:@" " withString:@""];
    
            if ([self.expBillMsgLabel.text isEqual:@""]) {
                self.expBillMsgLabel.text = @"暂无";
            }
    
            if ([self.detailModel.expressName isEqual:@""]) {
                self.expNameLabel.text = @"暂无";
                self.expNumLabel.text = @"暂无";
            }else{
                self.expNameLabel.text = self.detailModel.expressName;
                self.expNumLabel.text = self.detailModel.expressBillNum;
            }

}


@end
