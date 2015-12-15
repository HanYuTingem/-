//
//  LYQCommodityTableViewCell.m
//  MarketManage
//
//  Created by 劳大大 on 15/4/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LYQCommodityTableViewCell.h"
#import "CrazyShoppingCartShopTool.h"
#import "MarketAPI.h"
#import "CrazyShoppingCartShopTool.h"

@implementation LYQCommodityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//获取商家对应的商品 是否是最后一行 状态的色值
-(void)setGoodsCrazyShoppingCartShopCommodityModel:(CrazyShoppingCartShopCommodityModel*)model cellStatu:(BOOL)lastCell lastCountPrice:(NSString*)countPrice  countFreight:(NSString*)freight

{
    if (lastCell){
        self.priceCountView.hidden = NO;

    }else{
        self.priceCountView.hidden = YES;
    }
    
    [self.goodsImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KKUserHostUrl,model.mImageUrl]] placeholderImage:[UIImage imageNamed:@"defaultimg_9.png"]];
    self.goodsNameLabel.text = model.mName;
    self.goodsPriceLabel.text = [CrazyShoppingCartShopTool CrazyShoppingCartShopToolShowPriceWithPrice:model.mPrice integral:model.mIntegral number:1];
    self.goodsNumsLabel.text  = [NSString stringWithFormat:@"x%d",model.mNumber] ;
    self.priceCountLabel.text =[NSString stringWithFormat:@"%@",countPrice];
    self.feightLabel.text     = [NSString stringWithFormat:@"运费: %@",freight];

}

/** 从商品详情进来的页面 */
- (void)setGoodsInfoModel:(LSYGoodsInfo*)info
{
    self.priceCountView.hidden = NO;

  [self.goodsImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",info.host,info._img_url]] placeholderImage:[UIImage imageNamed:@"defaultimg_9.png"]];
  self.goodsNameLabel.text = info.name;
  self.goodsNumsLabel.text  = [NSString stringWithFormat:@"x%d",info.nums] ;
    
    
    self.goodsPriceLabel.text=[[MarketAPI judgeCostTypeWithCash:[NSString stringWithFormat:@"%.2f",info.cash] andIntegral:[NSString stringWithFormat:@"%.0f",info.price]  withfreight:@""  withWrap:YES] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSString * tEndString = [info.countPrice stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
   self.priceCountLabel.text =[NSString stringWithFormat:@"小计:%@",tEndString];
    
    self.feightLabel.text     = [NSString stringWithFormat:@"运费: %@",info.countFreight];

    
}

- (void)getDictData:(NSDictionary*)dict freightPrice:(NSString*)price cellStatu:(BOOL)lastCell andGoods:(NSArray*)array;
{
    if (lastCell){
        self.priceCountView.hidden = NO;
        NSString *showPrice ;
    
        for (NSDictionary *sudD in array) {
          showPrice =  [CrazyShoppingCartShopTool CrazyShoppingCartShopToolShowTotalPriceWithPrice:sudD[@"cash"] integral:sudD[@"price"] number:[sudD[@"goods_num"] integerValue]];
        }
//        [CrazyShoppingCartShopTool CrazyShoppingCartShopToolReloadData];
        showPrice =  [CrazyShoppingCartShopTool CrazyShoppingCartShopToolShowTotalPriceWithPrice:price integral:0 number:1];
        [CrazyShoppingCartShopTool CrazyShoppingCartShopToolReloadData];

        self.priceCountLabel.text =[NSString stringWithFormat:@"小计:%@",showPrice];
        
    }else{
        self.priceCountView.hidden = YES;
    }
    
    
    [self.goodsImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KKUserHostUrl,dict[@"img_url"]]] placeholderImage:[UIImage imageNamed:@"defaultimg_9.png"]];
    self.goodsNameLabel.text = dict[@"name"];
    self.goodsNumsLabel.text  = [NSString stringWithFormat:@"x%@",dict[@"goods_num"]];
    
    self.goodsPriceLabel.text=[[MarketAPI judgeCostTypeWithCash:[NSString stringWithFormat:@"%.2f",[dict[@"cash"] floatValue]] andIntegral:[NSString stringWithFormat:@"%.0f",[dict[@"price"] floatValue]]  withfreight:@"0"  withWrap:YES] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    self.feightLabel.text     = [NSString stringWithFormat:@"运费: %.0f",[price floatValue]];
    

}

@end
