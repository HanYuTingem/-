//
//  LYQGoodsImageTableViewCell.m
//  MarketManage
//
//  Created by 劳大大 on 15/4/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LYQGoodsImageTableViewCell.h"
#import "CrazyBasisFile.h"
@implementation LYQGoodsImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData
{
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",KKUserHostUrl,self.detailModel.goodImg_url]);
    [self.goodImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KKUserHostUrl,self.detailModel.goodImg_url]] placeholderImage:[UIImage imageNamed:@"defaultimg_10"]];
    self.goodsNameLabel.text  =self.detailModel.goodName;
    
    self.goodsPriceLabel.text = [MarketAPI judgeCostTypeWithCash:[NSString stringWithFormat:@"%f",[self.detailModel.cash_spend doubleValue]] andIntegral:[NSString stringWithFormat:@"%.0f",[self.detailModel.spending doubleValue]] withfreight:@"0" withWrap:NO];
    NSMutableString *attributeKey = [NSMutableString stringWithCapacity:0];

    
    for(int i = 0; i< self.detailModel.spec_id.count ; i++ ){
        
        NSString *goodskey = ((ZXYOrderDetailModel *)self.detailModel.spec_id[i]).key;
        NSString *goodsValue = ((ZXYOrderDetailModel *)self.detailModel.spec_id[i]).value;
        

        if (i == self.detailModel.spec_id.count-1) {
            [attributeKey appendFormat:@"%@:%@",goodskey,goodsValue];
        }else{
            [attributeKey appendFormat:@"%@:%@,",goodskey,goodsValue];
        }
        
    }
    NSLog(@"%@",attributeKey);
    self.goodsAttributeLabel.text = attributeKey;
    self.goodsCountLabel.text = [NSString stringWithFormat:@"x%@",self.detailModel.goods_nums];
    self.goodImageView.layer.masksToBounds = YES;
    self.goodImageView.layer.borderWidth = 1;
    self.goodImageView.layer.borderColor = CrazyColor(230, 230, 230).CGColor;

}
@end
