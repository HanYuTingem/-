//
//  GDHBankModel.m
//  Wallet
//
//  Created by GDH on 15/10/31.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "GDHBankModel.h"

@implementation GDHBankModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self ;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
/** 截取后四位字符串 */
- (NSString *)cardSn{
    NSString *str = [NSString stringWithFormat:@"%@",_cardSn];
    NSRange range = NSMakeRange(str.length - 4, 4);
    return [str substringWithRange:range];
}
@end
