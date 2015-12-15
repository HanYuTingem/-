//
//  shoppingCarHeadView.m
//  MarketManage
//
//  Created by 许文波 on 15/7/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "shoppingCarHeadView.h"

@implementation shoppingCarHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.upLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.5)];
        self.upLineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.upLineView];
        /** 选择按钮 */
        self.selectBtn = [ZHButton buttonWithType:UIButtonTypeCustom];
        self.selectBtn.frame = CGRectMake(0, 1, 36, 36);
        [self addSubview:self.selectBtn];
        
    /** 图片 */
        self.shopImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.selectBtn.frame), 13, 14, 14)];
        [self addSubview:self.shopImage];
        self.shopImage.image = [UIImage imageNamed:@"mall_list_ico_shop"];
        /** 商品的店名 */
        self.shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.shopImage.frame)+10, 10, (SCREENWIDTH-80)*SP_WIDTH, 20)];
        self.shopNameLabel.font = [UIFont systemFontOfSize:12];
        self.shopNameLabel.textColor = [UIColor colorWithRed:0.06f green:0.06f blue:0.06f alpha:1.00f];
//        self.shopNameLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:self.shopNameLabel];
    }
    return self;
}
-(void)refreshUI:(ListModel *)model{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
