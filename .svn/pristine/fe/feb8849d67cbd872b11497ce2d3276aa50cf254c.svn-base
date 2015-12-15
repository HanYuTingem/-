//
//  LYQGoodsEvalutionViewCell.m
//  MarketManage
//
//  Created by 劳大大 on 15/4/21.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LYQGoodsEvalutionViewCell.h"

@implementation LYQGoodsEvalutionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//列表的方法
- (void)getOrderModel:(ZXYOrderDetailModel*)mdeol content:(NSString*)content num:(NSString*)numstr
{
    
    self.evalutionTextView.tag = _Index;
    
    //商品图片
    [self.goodsImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KKUserHostUrl,mdeol.goodImg_url]] placeholderImage:[UIImage imageNamed:@"defaultimg_10"]];
    
    //商品名称
    self.goodsNameLabel.text = mdeol.goodName;
    
    //商品评价
    self.evalutionTextView.text = content;
    
    //输入最大的数字
    self.maxNumberLabel.text = numstr;
    
}


@end
