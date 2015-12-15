//
//  ScrollBoxItemView.m
//  LaoYiLao
//
//  Created by wzh on 15/11/2.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "ScrollBoxItemView.h"

@implementation ScrollBoxItemView

- (instancetype)init{
    if(self = [super init]){
        self = [[[NSBundle mainBundle]loadNibNamed:@"ScrollBoxItemView" owner:nil options:nil]lastObject];
        self.backgroundColor = [UIColor clearColor];
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

- (void)setModel:(DumplingInforListResultModel *)model{
    _model = model;
    _titleContentlab.text = [NSString stringWithFormat:@"%@",model.info];
    _dateLab.text = [NSString stringWithFormat:@"%@",model.createTime];
}
@end
