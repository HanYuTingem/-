//
//  DHCategoryCell.m
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHCategoryCell.h"

@implementation DHCategoryCell

-(void)refreshCateGoryUI:(cateModel *)model andImagViewURL:(NSString *)imagViewStr{


    [self.categoryImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imagViewStr,model.original_url]] placeholderImage:[UIImage imageNamed:@""]];
    self.categoryLabel.text = model.name;
}
@end
