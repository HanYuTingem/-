//
//  DHOrderDetailMessageView.m
//  MarketManage
//
//  Created by 许文波 on 15/8/11.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHOrderDetailMessageView.h"

@implementation DHOrderDetailMessageView
-(instancetype)initWithFrame:(CGRect)frame controller:(id)controller andNote:(NSString *)note {
    self = [super initWithFrame:frame];
    if (self) {
        /** 最下面的视图 */
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
        
        backView.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.96f alpha:1.00f];
        UIView *orderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
        orderView.backgroundColor = [UIColor whiteColor];
        [backView addSubview:orderView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, .5)];
        lineView.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [orderView addSubview:lineView];
        
        UIImageView *message = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13.5, 14, 14)];
        message.image = [UIImage imageNamed:@"mall_list_ico_message"];
        message.backgroundColor = [UIColor whiteColor];
        [orderView addSubview:message];
        
    
        UILabel *textViewLabel = [[UILabel alloc] initWithFrame:CGRectMake( CGRectGetMaxX(message.frame)+10, 10, SCREENWIDTH - 40, 20)];
        textViewLabel.text = [NSString stringWithFormat:@"留言:%@",note];
        textViewLabel.textColor = CrazyColor(37, 37, 37);
        textViewLabel.font = [UIFont systemFontOfSize:14];
        [orderView addSubview:textViewLabel];
        
        
        UIView *lineTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREENWIDTH, .5)];
        lineTwo.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [orderView addSubview:lineTwo];
        [self addSubview:backView];
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
