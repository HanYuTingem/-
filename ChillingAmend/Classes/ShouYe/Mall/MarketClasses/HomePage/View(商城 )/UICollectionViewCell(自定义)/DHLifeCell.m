//
//  DHLifeCell.m
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHLifeCell.h"

@implementation DHLifeCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10*SP_WIDTH, 22*SP_HEIGHT, 80*SP_WIDTH, 14*SP_HEIGHT)];
        self.titleLable.textColor = [UIColor colorWithRed:0.05f green:0.05f blue:0.05f alpha:1.00f];
        self.titleLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.titleLable];
        
        

        self.sub_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*SP_WIDTH, CGRectGetMaxY(self.titleLable.frame), 80*SP_WIDTH, 20*SP_HEIGHT)];
        self.sub_titleLabel.textColor = [UIColor colorWithRed:0.61f green:0.61f blue:0.61f alpha:1.00f];
        self.sub_titleLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.sub_titleLabel];
        
        
        self.shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width-60 *SP_WIDTH, 6*SP_HEIGHT, 53*SP_WIDTH, 53*SP_HEIGHT)];
        [self.contentView addSubview:self.shopImageView];
        
        UIView *viewWidth = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 0.5, self.contentView.frame.size.width, .5)];
        viewWidth.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [self.contentView addSubview:viewWidth];

        
        UIView *viewHeight = [[UIView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width-0.5, 0, 0.5, self.contentView.frame.size.height)];
        viewHeight.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [self.contentView addSubview:viewHeight];
        
    }
    return self;
}



-(void)refreshLifeUI:(ModularListModel *)modularListModel withUrl:(NSString *)url{
    
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
//    NSString *imgViewHost = [user objectForKey:@"host"];
    NSString *imgViewHost = url;
    self.titleLable.text = modularListModel.title;
    self.sub_titleLabel.text = modularListModel.sub_title;
    
    [self.shopImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgViewHost,modularListModel.img]] placeholderImage:[UIImage imageNamed:@"defaultimg_5.png"]];
}
@end
