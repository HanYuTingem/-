//
//  DHCleanButton.m
//  MarketManage
//
//  Created by 许文波 on 15/8/18.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHCleanButton.h"

@implementation DHCleanButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super init];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];
        self.frame = frame;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f] forState:UIControlStateNormal];
        [self setTitle:@"清空失效宝贝" forState:UIControlStateNormal];

        self.layer.borderWidth = 5;
        self.layer.borderColor =[[UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f] CGColor];

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
