//
//  ListCell.m
//  animationView
//
//  Created by Rice on 14/12/3.
//  Copyright (c) 2014年 Rice. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setCellLeftValue:(NSDictionary *)dataDic
{
    self.leftBigImageH.constant = 145 *SP_WIDTH;
    self.leftBuyTitleH.constant = 125 * SP_WIDTH;
    self.leftLabelY.constant = 3 *SP_WIDTH;
    self.leftLineLabel.font = [UIFont systemFontOfSize:13 * SP_WIDTH];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.imageHostUrl,IfNullToString(dataDic[@"img_url"])];
    [self.leftImage setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"defaultimg_9"]];
    
    self.leftTitle.text = IfNullToString(dataDic[@"name"]);
    
    self.leftConverCount.text = [NSString stringWithFormat:@"已购买 %@",IfNullToString(dataDic[@"bum_convert"])];
    
    self.leftCost.text = [MarketAPI judgeCostTypeWithCash:dataDic[@"cash"] andIntegral:dataDic[@"price"] withfreight:@"0" withWrap:YES];
}

-(void)setCellRightValue:(NSDictionary *)dataDic
{
    self.rightBigImageH.constant = 145 * SP_WIDTH;
    self.rightBuyTitleH.constant = 125 * SP_WIDTH;
    self.rightLabelY.constant = 3 *SP_WIDTH;
    self.rightLineLabel.font = [UIFont systemFontOfSize:13 * SP_WIDTH];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.imageHostUrl,IfNullToString(dataDic[@"img_url"])];
    [self.rightImage setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"defaultimg_9"]];
    
    self.rightTitle.text = IfNullToString(dataDic[@"name"]);
    
    self.rightConverCount.text = [NSString stringWithFormat:@"已购买 %@",IfNullToString(dataDic[@"bum_convert"])];
    
    self.rightCost.text = [MarketAPI judgeCostTypeWithCash:dataDic[@"cash"] andIntegral:dataDic[@"price"] withfreight:@"0" withWrap:YES];
}

@end
