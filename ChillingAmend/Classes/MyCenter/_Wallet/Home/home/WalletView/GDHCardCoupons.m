//
//  GDHCardCoupons.m
//  Wallet
//
//  Created by GDH on 15/11/11.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "GDHCardCoupons.h"

@implementation GDHCardCoupons

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:12];
        self.text = @"我的卡券";
        self.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}
@end
