//
//  ZXYOrderCell.m
//  MarketManage
//
//  Created by Rice on 15/1/13.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYOrderCell.h"
#import "CrazyBasisFile.h"
#import "ZXYOrderDetailModel.h"
@implementation ZXYOrderCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setCellWithModel:(ZXYOrderModell *)orderModel
{
    
     NSString *goodsPriceStr = [MarketAPI judgeCostTypeWithCash:[NSString stringWithFormat:@"%f",[orderModel.goodsCash doubleValue]] andIntegral:[NSString stringWithFormat:@"%.0f",[orderModel.goodsSpending doubleValue]] withfreight:@"0" withWrap:NO];
    
//    self.shopSingleMoney.text =[MarketAPI judgeCostTypeWithCash:[NSString stringWithFormat:@"%@",orderModel.goodsCashAmout] andIntegral:[NSString stringWithFormat:@"%.0f",[orderModel.goodsSpendingAmount floatValue]] withfreight:orderModel.orderFreight withWrap:NO];
    
    
//    self.shopNum.text = [NSString stringWithFormat:@"x%@",orderModel.goodsCount];
    
    
    self.storeName.text = orderModel.merchantsName;
    NSString *goodsAmountStr = [MarketAPI judgeCostTypeWithCash: [NSString stringWithFormat:@"%f",[orderModel.goodsCashAmout doubleValue]]  andIntegral:[NSString stringWithFormat:@"%.0f",[orderModel.goodsSpendingAmount doubleValue]]  withfreight:orderModel.orderFreight withWrap:NO];
    
    self.creatTimeLabel.text = [NSString stringWithFormat:@"下单时间: %@",[MarketAPI getTimesSubtamp:orderModel.orderCreatTime]];
    self.goodsNameLabel.verticalAlignment = VerticalAlignmentTop;
    
    self.goodsPriceLabel.text = [NSString stringWithFormat:@"单价: %@",goodsPriceStr];
    self.goodsCountLabel.text = [NSString stringWithFormat:@"数量: x%@",orderModel.goodsCount];
    self.statuLabel.text = [self judgStatuLabelText:orderModel];
    
//    //一张图片的时候
    if(orderModel.goodsImageArray.count<=1&&orderModel.goodsImageArray.count>0){
        self.allShopNumLabel.hidden = YES;
        self.moreGoodView.hidden = YES;

        [self.goodsImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KKUserHostUrl,[orderModel.goodsImageArray[0] goodImg_url]]] placeholderImage:[UIImage imageNamed:@"defaultimg_10"]];
        self.goodsNameLabel.text = [orderModel.goodsImageArray[0] goodName];

        
        self.goodsImageView.layer.masksToBounds = YES;
        self.goodsImageView.layer.borderWidth = 1;
        self.goodsImageView.layer.borderColor = CrazyColor(230, 230, 230).CGColor;
        self.shopNum.text =[NSString stringWithFormat:@"x%@", ((ZXYOrderDetailModel *)orderModel.goodsImageArray[0]).nums];
    }else{
        
            UITapGestureRecognizer * tapSingle = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapmoreGoodScrollView:)];
            tapSingle.numberOfTouchesRequired = 1;
            [self.moreGoodScrollView addGestureRecognizer:tapSingle];
        
//        self.shopSingleMoney.hidden = YES;
//        self.shopNum.hidden = YES;
        self.colorLabel.hidden = YES;
        //多张图片的时候
        self.moreGoodView.hidden = NO;
        self.allShopNumLabel.hidden = NO;
        self.allShopNumLabel.text = [NSString stringWithFormat:@"共%ld件商品 >",orderModel.goodsImageArray.count];

//        self.moreGoodScrollView.contentSize = CGSizeMake(76* orderModel.goodsImageArray.count+10* orderModel.goodsImageArray.count +20,96);
        for (int i = 0 ; i < orderModel.goodsImageArray.count ; i++){
            if (i < 3) {
                UIImageView  *  goodImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10+76*i, 8, 70, 70)];
                [goodImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KKUserHostUrl,[orderModel.goodsImageArray[i] goodImg_url]]] placeholderImage:[UIImage imageNamed:@"defaultimg_10"]];
                goodImageView.backgroundColor = [UIColor orangeColor];
                [self.moreGoodScrollView addSubview:goodImageView];
                goodImageView.layer.masksToBounds = YES;
                goodImageView.layer.borderWidth = 1;
                goodImageView.layer.borderColor = CrazyColor(230, 230, 230).CGColor;
            }
        }
    }

    self.goodsAmoutLabel.text = [NSString stringWithFormat:@"合计: %@",goodsAmountStr];
    
    if ([orderModel.orderDrawType isEqual:@"2"]) {
        self.FreightLabel.hidden = NO;
        self.FreightLabel.text = [NSString stringWithFormat:@"运费:%@元",orderModel.orderFreight];
    }else{
        self.FreightLabel.hidden = YES;
    }
    
    if ([orderModel.orderStatu isEqual:@"3"]) {//待收货
        self.validAndconfirmTimeLabel.text = [NSString stringWithFormat:@"自动确认收货时间:\n%@",orderModel.orderConfirmTime];
        self.validAndconfirmTimeLabel.hidden = NO;
    }else if ([orderModel.orderStatu isEqual:@"2"] && [orderModel.orderDrawType isEqual:@"1"]) {//自取 未领取
        self.validAndconfirmTimeLabel.hidden = NO;
        self.validAndconfirmTimeLabel.text = [NSString stringWithFormat:@"有效期至:%@",orderModel.validTime];
    }else{
        self.validAndconfirmTimeLabel.hidden = YES;
    }
    
    /*
     判断虚拟商品有效期 若为空 隐藏显示
     */
    if ([orderModel.type isEqual:@"2"]) {//虚拟商品
        
        if ([orderModel.useStatrTime isEqual:@"0000-00-00 00:00:00"]) {
            self.validAndconfirmTimeLabel.hidden = YES;
        }else{
            self.validAndconfirmTimeLabel.hidden = NO;
            NSString *startTime = [MarketAPI changeTimeFormat:orderModel.useStatrTime andFormat1:@"YYYY-MM-dd HH:mm:ss" andFormat2:@"YYYY-MM-dd"];
            NSString *endTime = [MarketAPI changeTimeFormat:orderModel.useEndTime andFormat1:@"YYYY-MM-dd HH:mm:ss" andFormat2:@"YYYY-MM-dd"];
            self.validAndconfirmTimeLabel.text = [NSString stringWithFormat:@"有效期:\n%@至%@",startTime,endTime];
        }
    }
    
    /*
     判断按钮状态
     */
    [self judgStatuForButtons:orderModel];

}

- (IBAction)orderListFunctionButtonAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(orderStatuWithButton:andCellTag:)]) {
        [self.delegate orderStatuWithButton:sender andCellTag:self.cellTag];
    }
}

- (void)TapmoreGoodScrollView:(UITapGestureRecognizer*)tap
{
    if([self.delegate respondsToSelector:@selector(didSelectCellTag:)]){
        [self.delegate didSelectCellTag:self.cellTag];
    }
}
-(NSString *)judgStatuLabelText:(ZXYOrderModell *)orderModel
{

    //快递
    NSArray *statuAry_2 = [NSArray arrayWithObjects:@"",@"待付款",@"待发货",@"待收货",@"待评价",@"已完成",@"已关闭",@"",@"已关闭", nil];

    NSInteger index = [orderModel.orderStatu integerValue];
    return statuAry_2[index];

}

-(void)judgStatuForButtons:(ZXYOrderModell *)orderModel
{
   
    [MarketAPI setRedButton:self.functionBtn];
    self.cancelEvalutionOrderBtn.hidden= YES;

    switch ([orderModel.orderStatu integerValue]) {
        case 1://待付款
        {
            self.cancelOrderBtn.hidden = NO;
            [MarketAPI setGrayButton:self.cancelOrderBtn];
            [self.cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.functionBtn setTitle:@"支付" forState:UIControlStateNormal];
            break;
        }
        case 2://未领取/待发货/未使用
        {
            self.cancelOrderBtn.hidden = YES;
            [self.functionBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            break;
        }
        case 3://待收货
        {
            self.cancelOrderBtn.hidden = NO;
            [MarketAPI setRedButton:self.cancelOrderBtn];
            [self.cancelOrderBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            [self.functionBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            break;
        }
        case 4://待评价/已领取/已使用
        {
            self.cancelOrderBtn.hidden = NO;
            self.cancelEvalutionOrderBtn.hidden= NO;
            [MarketAPI setGrayButton:self.cancelOrderBtn];
            [MarketAPI setRedButton:self.functionBtn];
            [MarketAPI setGrayButton:self.cancelEvalutionOrderBtn];

            [self.cancelOrderBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            [self.functionBtn setTitle:@"评价" forState:UIControlStateNormal];

//            [self.cancelEvalutionOrderBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [self.cancelEvalutionOrderBtn setTitle:@"申请售后" forState:UIControlStateNormal];
            break;
        }
        case 5://已完成
        {
            self.cancelOrderBtn.hidden = NO;
//            [MarketAPI setRedButton:self.cancelOrderBtn];
            [MarketAPI setGrayButton:self.cancelOrderBtn];
            [self.cancelOrderBtn setTitle:@"申请售后" forState:UIControlStateNormal];
            [self.functionBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            break;
        }
        case 6://已取消(显示已关闭)
        {
            self.cancelOrderBtn.hidden = YES;
            [self.functionBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            break;
        }
        case 7://已过期
        {
            self.cancelOrderBtn.hidden = NO;
            [MarketAPI setRedButton:self.cancelOrderBtn];
            [self.cancelOrderBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            [self.functionBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            break;
        }
        case 8://已关闭
        {
            self.cancelOrderBtn.hidden = YES;
            [self.functionBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
}


@end
