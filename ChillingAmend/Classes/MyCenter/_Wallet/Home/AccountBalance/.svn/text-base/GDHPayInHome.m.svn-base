//
//  GDHPayInHome.m
//  Wallet
//
//  Created by GDH on 15/10/22.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "GDHPayInHome.h"

@interface GDHPayInHome (){
    UIButton *_pay;

    UIButton *_Inhome;
}
@end
@implementation GDHPayInHome

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _pay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _pay.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 2);
        [_pay setTitle:@"支出" forState:UIControlStateNormal];
        [_pay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_pay addTarget:self action:@selector(payDown:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_pay];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height / 2 -0.5, self.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
        _Inhome = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _Inhome.frame = CGRectMake(0, self.frame.size.height/2, self.frame.size.width, self.frame.size.height / 2);
        [_Inhome setTitle:@"收入" forState:UIControlStateNormal];
        [_Inhome setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_Inhome addTarget:self action:@selector(inHomeDown:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_Inhome];
    }
    return self;
}
/** 支出 */
-(void)payDown:(UIButton *)sender{
    [_pay setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//    [_Inhome setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    self.payBlock(sender);
}
/** 收入 */
-(void)inHomeDown:(UIButton *)sender{
    
    [_Inhome setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//    [_pay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.inHomeBlock(sender);
}


@end
