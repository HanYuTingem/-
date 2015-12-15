//
//  shopManView.m
//  MarketManage
//
//  Created by 许文波 on 15/7/28.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "shopManView.h"

@implementation shopManView

-(instancetype)initWithFrame:(CGRect)frame arrowImageView:(NSString *)Address userName:(NSString *)name userTel:(NSString *)tel userAdress:(NSString *)adress arrow:(NSString *)arrow{
    self = [super initWithFrame:frame];
    if (self) {
        
        
//        self.layer.borderWidth = 2.0f;
////        self.layer.borderColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f].CGColor;
//        self.layer.borderColor = [UIColor redColor].CGColor;
//        self.backgroundColor =CrazyColor(240, 242, 245);
        
        
        self.noAdress = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 82)];
        self.noAdress.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.noAdress];
        
        self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 30, 15, 20)];
        self.leftImageView.image = [UIImage imageNamed:Address];
        [self.noAdress addSubview:self.leftImageView];
        
        self.userName = [[UILabel alloc] initWithFrame:CGRectMake(37, 15, 150*SP_WIDTH, 20)];
        [self.noAdress addSubview:self.userName];
        self.userName.text = name;
        self.userName.textColor = CrazyColor(37, 37, 37);
        self.userName.font = [UIFont systemFontOfSize:14];
        
        self.userTel  = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH- 10 - 150 *SP_WIDTH, 15, 150*SP_WIDTH, 20)];
        self.userTel.font = [UIFont systemFontOfSize:14];
        self.userTel.textColor= CrazyColor(37, 37, 37);
        self.userTel.textAlignment = NSTextAlignmentRight;
        self.userTel.textColor = CrazyColor(37, 37, 37);
//        self.userTel.backgroundColor = [UIColor yellowColor];
        self.userTel.text = tel;
        [self.noAdress addSubview:self.userTel];
        
        self.userAdress = [[UILabel alloc] initWithFrame:CGRectMake(37, 32, 270*SP_WIDTH, 40)];
        self.userAdress.numberOfLines = 0;
        self.userAdress.font = [UIFont systemFontOfSize:13];
        self.userAdress.text = adress;
        self.userAdress.textColor = CrazyColor(37, 37, 37);
//        self.userAdress.backgroundColor = [UIColor redColor];
        [self.noAdress addSubview:self.userAdress];
        
        self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-30, 40, 10, 10)];
        self.arrowImageView.image = [UIImage imageNamed:arrow];
        [self.noAdress addSubview:self.arrowImageView];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height -0.5, SCREENWIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [self addSubview:line];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
