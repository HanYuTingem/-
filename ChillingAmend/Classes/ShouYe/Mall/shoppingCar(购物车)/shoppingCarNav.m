//
//  shoppingCarNav.m
//  MarketManage
//
//  Created by 许文波 on 15/7/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "shoppingCarNav.h"

@implementation shoppingCarNav
-(instancetype)initWithFrame:(CGRect)frame andBackBtn:(NSString *)backBtn andSEL:(SEL)selector andID:(id)target andTitleName:(NSString *)titleName andeditBtn:(NSString *)editBtn andEditSEL:(SEL)editSelector andTarget:(id)editTarget{
    self = [super initWithFrame:frame];
    if (self) {
        /** 返回按钮 */
        UIButton  *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, 0, 44, 44);
        [leftBtn setImage:[UIImage imageNamed:backBtn] forState:UIControlStateNormal];
        [leftBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBtn];
        /** title */
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-30, 5, 60, 30)];
        label.text = titleName;
        label.font = [UIFont systemFontOfSize:18];
        [self addSubview:label];
        
        
        /** 编辑按钮 */
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(SCREENWIDTH-54, 0, 44, 44);
        [rightBtn setTitle:editBtn forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightBtn addTarget:editTarget action:editSelector forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        
        
        /** 线 */
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, SCREENWIDTH, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineView];
        
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
