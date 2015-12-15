//
//  DHhotMarketTwoCell.m
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHhotMarketTwoCell.h"

@implementation DHhotMarketTwoCell





-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.shopName = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, 60, 18)];
        self.shopName.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.shopName];
        
        
        self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.shopName.frame.origin.x, CGRectGetMaxY(self.shopName.frame)-3, 60, 18)];
        self.infoLabel.font = [UIFont systemFontOfSize:10];
        self.infoLabel.textColor = [UIColor colorWithRed:0.69f green:0.69f blue:0.69f alpha:1.00f];
        [self.contentView addSubview:self.infoLabel];
        
        
        self.shopImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(self.shopName.frame.origin.x, CGRectGetMaxY(self.infoLabel.frame), 64, 45)];
        [self.contentView addSubview:self.shopImageView];
        
        
        UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-0.5, 0, 0.5, self.frame.size.height)];
        rightLine.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [self addSubview:rightLine];
        

        UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5)];
        underLine.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [self addSubview:underLine];
    }
    return self;
}

-(void)refreshElevenOneUI:(ModularListModel *)model withUrl:(NSString *)url{
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *url2  = [NSString stringWithFormat:@"%@%@",url,model.img];
    
    self.shopName.text = model.title;
    self.infoLabel.text = model.sub_title;
    [self.shopImageView setImageWithURL:[NSURL URLWithString:url2] placeholderImage:[UIImage imageNamed:@""]] ;
}
@end
