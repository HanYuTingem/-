//
//  LSYContentTableViewCell.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYContentTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "LSYStrikeLineLabel.h"
#import "MarketAPI.h"
#import "CrazyBasisFile.h"
@interface LSYContentTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *goods_img;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UILabel *goods_Price;
@property (weak, nonatomic) IBOutlet LSYStrikeLineLabel *goods_oldPrice;

@end
@implementation LSYContentTableViewCell

- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setGoodsDic:(NSDictionary *)goodsDic
{
    _goodsDic=goodsDic;
    self.goods_name.text= [_goodsDic objectForKey:@"name"];
    self.goods_Price.text=[NSString stringWithFormat:@"秒杀价%@元",[_goodsDic objectForKey:@"ms_price"]];
     self.goods_oldPrice.text=[MarketAPI judgeCostTypeWithCash:[NSString stringWithFormat:@"%@",[_goodsDic objectForKey:@"cash"]] andIntegral:[NSString stringWithFormat:@"%@",[_goodsDic objectForKey:@"price"]] withfreight:@"0" withWrap:NO];
    [self.goods_img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.host,[_goodsDic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"defaultimg_8.png"]];
    if ([[_goodsDic objectForKey:@"status"]intValue]==4) {
        self.noNumIMG.hidden=NO;
        self.noNumLabel.hidden=NO;
    }else{
        self.noNumIMG.hidden=YES;
        self.noNumLabel.hidden=YES;
    }
    _goods_img.layer.masksToBounds = YES;
    _goods_img.layer.borderWidth = 1;
    _goods_img.layer.borderColor = CrazyColor(230, 230, 230).CGColor;

}
-(void)setHost:(NSString *)host
{
    _host=host;
}

@end
