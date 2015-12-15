//
//  LSYRecommendCollectionViewCell.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/13.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYRecommendCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "MarketAPI.h"
@interface LSYRecommendCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *goods_IMG;
@property (weak, nonatomic) IBOutlet UILabel *goods_Name;
@property (weak, nonatomic) IBOutlet UILabel *goods_Price;

@property (weak, nonatomic) IBOutlet UILabel *goods_Num;

@end

@implementation LSYRecommendCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setDic:(NSDictionary *)dic
{
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
    _dic=dic;
    self.goods_Num.text=[NSString stringWithFormat:@"已购买%@",[dic objectForKey:@"buy_nums"]];
    self.goods_Name.text=[dic objectForKey:@"name"];
    self.goods_Price.text=[NSString stringWithFormat:@"￥%@",[dic objectForKey:@"cash"]];
    self.goods_Price.text=[MarketAPI judgeCostTypeWithCashF:[dic objectForKey:@"cash"] andIntegral:[dic objectForKey:@"price"] withfreight:@"0" withWrap:YES];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",self.host,[dic objectForKey:@"img_url"]]);
    [self.goods_IMG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.host,[dic objectForKey:@"img_url"]]]placeholderImage:[UIImage imageNamed:@"defaultimg_8.png"]];
}
@end
