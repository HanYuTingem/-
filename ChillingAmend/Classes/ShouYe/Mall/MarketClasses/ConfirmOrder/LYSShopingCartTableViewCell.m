//
//  LYSShopingCartTableViewCell.m
//  MarketManage
//
//  Created by 劳大大 on 15/4/17.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LYSShopingCartTableViewCell.h"
#import "MarketAPI.h"
#import "UIImageView+WebCache.h"
#import "CrazyShoppingCartShopModel.h"
#import "CrazyShoppingCartShopCommodityModel.h"



/** 后来更换的模型 */
#import "ListModel.h"
@implementation LYSShopingCartTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setGoods:(LSYGoodsInfo *)goods
{

    [self addGestureRecognizer];
    
    self.goodsScrollView.hidden = YES;
    _goods = goods;
    self.goodNameLabel.text=_goods.name;
    self.goodPriceLabel.text=[MarketAPI judgeCostTypeWithCash:[NSString stringWithFormat:@"%.2f",_goods.cash] andIntegral:[NSString stringWithFormat:@"%.0f",_goods.price]  withfreight:@"0"  withWrap:NO];
    [self.oneImageView setImageWithURL:
     [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",_goods.host,_goods._img_url]] placeholderImage:[UIImage imageNamed:@"defaultimg_9.png"]];
    
}

- (void)setGoodsArray:(NSArray *)goodsArray{
    
    
    [self addGestureRecognizer];
    
    int Index = 0;
    
    for (ListModel * model in goodsArray){
            Index = (int )goodsArray.count + Index;
    }
    
    if(Index <=1){
        self.goodsScrollView.hidden = YES;
        for (ListModel * subModel in goodsArray){
            
            [self.oneImageView  setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KKUserHostUrl,subModel.goods_imgurl]] placeholderImage:[UIImage imageNamed:@"defaultimg_10"]];
            self.goodNameLabel.text=subModel.goods_name;
            
            self.goodPriceLabel.text=[CrazyShoppingCartShopTool CrazyShoppingCartShopToolShowPriceWithPrice:subModel.goods_cash integral:subModel.goods_price number:1];
            self.goodsNumber.text = [NSString stringWithFormat:@"x%d",subModel.goods_nums];
            _oneImageView.layer.masksToBounds = YES;
            _oneImageView.layer.borderWidth = 1;
            _oneImageView.layer.borderColor = CrazyColor(230, 230, 230).CGColor;
            
        }

        }else{
        self.goodsScrollView.hidden = NO;
        int i = 0 ;
        int k = 0 ;
        int GoodsNum = 0;
            for (ListModel * subModel in goodsArray){
                if(i <= 2){
                    //多张图片的时候
                    UIImageView  *  goodImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10+i*10+60*i, 10, 60, 60)];
                    [goodImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KKUserHostUrl,subModel.goods_imgurl]] placeholderImage:[UIImage imageNamed:@"defaultimg_10"]];
                    [self.goodsScrollView addSubview:goodImageView];
                    k = k + 1;
                    
                    goodImageView.layer.masksToBounds = YES;
                    goodImageView.layer.borderWidth = 1;
                    goodImageView.layer.borderColor = CrazyColor(230, 230, 230).CGColor;

                }
                GoodsNum+=subModel.goods_nums;
                NSLog(@"GoodsNum    ------%d",GoodsNum);
                i = i + 1;
            }
            NSLog(@"GoodsNum++++++++ +       %d",GoodsNum);
        
        self.moreLastView.frame =  CGRectMake(60 * (k+1) + (k+1)*10 + 10, 12, 98, 55);
        self.moreCountLabel.text = [NSString stringWithFormat:@"共%d件商品",GoodsNum];

    }
    
    
   }

- (void)addGestureRecognizer
{
    UITapGestureRecognizer * tapSingle = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapImageScrollView:)];
    tapSingle.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapSingle];

}
////手势的会跳
- (void)TapImageScrollView:(UITapGestureRecognizer*)tap
{
    [self.delegate didSelectGoodsScrollView];
}
@end
