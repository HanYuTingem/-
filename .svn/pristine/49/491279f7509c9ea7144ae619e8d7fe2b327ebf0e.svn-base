//
//  ZXYOrderConnectCell.m
//  MarketManage
//
//  Created by Rice on 15/1/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYOrderConnectCell.h"

@implementation ZXYOrderConnectCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setCellLayout
{

    self.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.96f alpha:1.00f];
    self.connectAddLabel.verticalAlignment = VerticalAlignmentTop;
    CGFloat addHeigh = [MarketAPI labelAutoCalculateRectWith:self.detailModel.connectAdd FontSize:14. MaxSize:CGSizeMake(235, MAXFLOAT)].height;
    [self.connectAddLabel setFrame:CGRectMake(ORIGIN_X(self.connectAddLabel), ORIGIN_Y(self.connectAddLabel), FRAMNE_W(self.connectAddLabel), addHeigh)];
//    self.bgView.backgroundColor = [UIColor redColor];
//    [self.bgView setFrame:CGRectMake(ORIGIN_X(self.bgView), ORIGIN_Y(self.bgView), FRAMNE_W(self.bgView), 133)];
}

//-(void)setCellData
//{
//    self.connectManLabel.text = self.detailModel.connectName;
//    self.connectTelLabel.text = self.detailModel.expressBillMsg;
//    self.connectAddLabel.text = self.detailModel.expressBillMsg;
//
//}
-(void)setCellData
{
    //connectTelLabel
    NSLog(@"%@",self.detailModel.invoice_category);
    NSLog(@"%@",self.detailModel.expressBillMsg);
    self.connectTelLabel.text =[self.detailModel.expressBillMsg stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.connectAddLabel.text = [self.detailModel.invoice_category stringByReplacingOccurrencesOfString:@" " withString:@""];
//    
//    if ([self.connectTelLabel.text isEqual:@""]) {
//        self.connectTelLabel.text = @"暂无";
//    }
//    
//    if ([self.detailModel.expressName isEqual:@""]) {
//        self.connectAddLabel.text = @"暂无";
//        self.connectAddLabel.text = @"暂无";
//    }else{
//        //self.detailModel.expressName  self.detailModel.expressBillNum
//        self.connectAddLabel.text = self.detailModel.expressBillNum;
//        self.connectAddLabel.text = self.detailModel.expressName;
//    }
//    
}


@end
