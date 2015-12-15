//
//  BasisImageView.m
//  PRJ_NiceFoodModule
//
//  Created by sunsu on 15/6/16.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "BasisImageView.h"

@implementation BasisImageView

+ (instancetype)imageViewWithFrame:(CGRect)frame andImage:(NSString *)string{
    return [[[self class] alloc]initWithImageViewFrame:frame andImage:string];
}

- (instancetype)initWithImageViewFrame:(CGRect)frame andImage:(NSString *)string{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:string];
    }
    return self;
}



-(void)basisImageViewLoadUrlString:(NSString *)string placeholderString:(NSString *)imageString{
    [self setImageWithURL:[NSURL URLWithString:string] placeholderImage:[UIImage imageNamed:imageString]];
}

+(void)setUrlHost:(NSString *)urlHost{
    self.urlHost = urlHost;
}

-(void)basisImageViewLoadHostUrlString:(NSString *)string placeholderImageString:(NSString *)imageString{
    NSAssert(urlHost != nil, @"图片缺少头地址");
    [self setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urlHost,string]] placeholderImage:[UIImage imageNamed:imageString]];
}

@end
