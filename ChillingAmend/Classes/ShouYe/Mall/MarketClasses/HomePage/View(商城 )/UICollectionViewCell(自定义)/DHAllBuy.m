//
//  DHAllBuy.m
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHAllBuy.h"

@implementation DHAllBuy

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = CrazyColor(240, 242, 245);
        self.view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 145*SP_WIDTH, 214 )];
        self.view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.view];
        
        self.shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 145)];
        [self.view addSubview:self.shopImageView];
      

        
        self.buyCountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shopImageView.frame)-18, self.shopImageView.frame.size.width, 17)];
        self.buyCountImageView.backgroundColor = [UIColor colorWithRed:0.55f green:0.55f blue:0.55f alpha:1.00f];
        [self.view addSubview:self.buyCountImageView];
        self.buyCountImageView.alpha = 0.8;
        
        self.buyCount = [[UILabel alloc] initWithFrame:CGRectMake(self.buyCountImageView.frame.origin.x +10, 0, self.buyCountImageView.bounds.size.width, self.buyCountImageView.bounds.size.height)];
        self.buyCount.textColor = [UIColor whiteColor];
        self.buyCount.font = [UIFont systemFontOfSize:11];
        [self.buyCountImageView addSubview:self.buyCount];
        
        
        self.titleInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.shopImageView.frame), 120*SP_WIDTH, 42)];
        self.titleInfo.numberOfLines = 0;
//        self.titleInfo.backgroundColor = [UIColor yellowColor];
        self.titleInfo.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:self.titleInfo];
        
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleInfo.frame), 140 *SP_WIDTH, 0.5)];
        line.image = [UIImage imageNamed:@"home_list_line"];
        [self.view addSubview:line];
        
        self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(line.frame), 120*SP_WIDTH, 27)];
        self.moneyLabel.font = [UIFont systemFontOfSize:14];
        self.moneyLabel.textColor = [UIColor colorWithRed:0.75f green:0.13f blue:0.12f alpha:1.00f];
//        self.moneyLabel.backgroundColor = [UIColor greenColor];
        [self.view addSubview:self.moneyLabel];

    }
    return self;
}
-(void)refreshBuyUI:(RecommendModel *)recommendModel withUrl:(NSString *)url{
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *imgStr = [user objectForKey:@"host"];
    NSString *imgStr = url;
    
    [self.shopImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgStr,recommendModel.img_url2]] placeholderImage:[UIImage imageNamed:@"defaultimg_8.png"]];
    self.buyCount.text = [NSString stringWithFormat:@"已购买 %@",recommendModel.buy_nums];
    self.titleInfo.text = recommendModel.name;
    //现金为0 积分不为0
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",imgStr,recommendModel.img_url2]);
    
    
    
    if ([recommendModel.cash isEqualToString:@"0.00"] && ![recommendModel.price isEqualToString:@"0"]) {
          
           NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@积分",recommendModel.price]];
           
           [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(str.length-2,2)];
           self.moneyLabel.attributedText = str;
    }
       else if (![recommendModel.cash isEqualToString:@"0.00"] && [recommendModel.price isEqualToString:@"0"]){
           
           NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",recommendModel.cash]];
           
           [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0,1)];
           self.moneyLabel.attributedText = str;
           
       }
       else if(![recommendModel.cash isEqualToString:@""] && ![recommendModel.price isEqualToString:@"0"]){
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@+%@积分",recommendModel.cash,recommendModel.price]];
        
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(str.length-2,2)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0,1)];
        
        self.moneyLabel.attributedText = str;
    }
    
   
}
@end
