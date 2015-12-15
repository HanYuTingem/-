//
//  DHOrderDetailBtn.m
//  MarketManage
//
//  Created by 许文波 on 15/8/11.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHOrderDetailBtn.h"

@implementation DHOrderDetailBtn
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

-(void)setIfShow:(BOOL)ifShow{
     if (ifShow== NO) {
        [self setImage:[UIImage imageNamed:@"jts"] forState:UIControlStateNormal];
        [self setTitle:@"收起" forState:UIControlStateNormal];
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -80);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    }else
    {
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -100);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        [self setTitle:[NSString stringWithFormat:@"还有%d件",(int)(self.goodsCount.count-2)] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"jtx"] forState:UIControlStateNormal];
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
