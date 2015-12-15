//
//  GDHMyWalletModel.m
//  Wallet
//
//  Created by GDH on 15/10/24.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "GDHMyWalletModel.h"

@implementation GDHMyWalletModel


- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self ;
}
@end
