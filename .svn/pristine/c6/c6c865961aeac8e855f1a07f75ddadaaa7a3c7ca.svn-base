//
//  LSYMenuCollectionViewCell.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/12.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYMenuCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "MarketAPI.h"
@implementation LSYMenuCollectionViewCell

- (void)awakeFromNib {
//    CGFloat hue = ( arc4random() % 256 / 256.0 );
//    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
//    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
//    self.backgroundColor= [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

-(void)setDic:(NSDictionary *)dic
{
    self.menuName.text=[dic objectForKey:@"name"];

    if (![[dic objectForKey:@"id"]isEqualToString:@"0"]) {
        [self.menuBtnIMG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.host,[dic objectForKey:@"original_url"]]]placeholderImage:[UIImage imageNamed:@"defaultimg_1.png"]];
    }else{
        [self.menuBtnIMG setImage:[UIImage imageNamed:@"mall_home_btn_default1.png" ]];
    }
}

@end
