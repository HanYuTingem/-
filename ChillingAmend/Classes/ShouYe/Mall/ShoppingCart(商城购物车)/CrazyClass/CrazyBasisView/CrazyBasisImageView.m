//
//  CrazyBasisImageView.m
//  MarketManage
//
//  Created by fielx on 15/4/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisImageView.h"



@implementation CrazyBasisImageView


-(void)crazyBasisImageViewLoadUrlString:(NSString *)string placeholderImageString:(NSString *)imageString
{
    [self setImageWithURL:[NSURL URLWithString:string] placeholderImage:[UIImage imageNamed:imageString]];
}

+(void)CrazySetUrlHost:(NSString *)urlHost
{
    CrazyUrlHost = urlHost;
}

-(void)crazyBasisImageViewLoadHostUrlString:(NSString *)string placeholderImageString:(NSString *)imageString
{
    NSAssert(CrazyUrlHost != nil, @"图片缺少头地址");
    [self setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CrazyUrlHost,string]] placeholderImage:[UIImage imageNamed:imageString]];
}




@end
