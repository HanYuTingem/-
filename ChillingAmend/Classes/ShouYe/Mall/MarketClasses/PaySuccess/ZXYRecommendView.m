//
//  ZXYRecommendView.m
//  MarketManage
//
//  Created by Rice on 15/1/19.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYRecommendView.h"

@implementation ZXYRecommendView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"ZXYRecommendView" owner:self options:nil][0];
    }
    return self;
}

-(void)setData
{
    self.goodsNameLabel.text = self.recommendModel.goodsTitle;
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",IfNullToString(self.imageHostUrl),self.recommendModel.goodsImage];
    [self.goodsImgeView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"defaultimg_9"]];
    self.goodsPriceLabel.text = [MarketAPI judgeCostTypeWithCash:self.recommendModel.goodsCash andIntegral:self.recommendModel.goodsSpending withfreight:@"0" withWrap:YES];
}

- (IBAction)toProductDetailVC:(id)sender {
    [self.delegate didSelectProductWithId:self.recommendModel.goodsId];
}

@end
