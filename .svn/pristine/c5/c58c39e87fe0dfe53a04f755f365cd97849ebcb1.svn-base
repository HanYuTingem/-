//
//  DHCleanView.m
//  MarketManage
//
//  Created by 许文波 on 15/8/18.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHCleanView.h"

@implementation DHCleanView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *invaild = [[UIView alloc] initWithFrame:frame];
        UIButton *invaildBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        invaild.backgroundColor = [UIColor whiteColor];
        invaildBtn.frame = CGRectMake(SCREENWIDTH/2 - 50, 7, 100, 26);
        invaildBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [invaildBtn addTarget:self action:@selector(invaildBtnDown) forControlEvents:UIControlEventTouchUpInside];
        [invaildBtn setTitleColor:[UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f] forState:UIControlStateNormal];
        [invaildBtn setTitle:@"清空失效宝贝" forState:UIControlStateNormal];
        [invaildBtn setBackgroundImage:[UIImage imageNamed:@"buyCarClean"]  forState:UIControlStateNormal];
        [invaild addSubview:invaildBtn];

//        invaildBtn.layer.borderWidth = 1;
//        invaildBtn.layer.borderColor = [[UIColor colorWithRed:0.73f green:0.29f blue:0.27f alpha:1.00f] CGColor];
        [self addSubview:invaild];
    }
    return self;
}

//-(DHCleanView *)DHCleanView{
//    
//    return [[DHCleanView alloc] init];
//}
-(void)invaildBtnDown{
    
    if ([self.delegate respondsToSelector:@selector(cleanInvaildBtnDown)]) {
        [self.delegate cleanInvaildBtnDown];
    }
}
@end
