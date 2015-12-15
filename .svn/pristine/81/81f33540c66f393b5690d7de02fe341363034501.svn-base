//
//  BasisImageView.h
//  PRJ_NiceFoodModule
//
//  Created by sunsu on 15/6/16.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
static NSString * urlHost = nil;


@interface BasisImageView : UIImageView

//初始化
+ (instancetype)imageViewWithFrame:(CGRect)frame andImage:(NSString *)string;
- (instancetype)initWithImageViewFrame:(CGRect)frame andImage:(NSString *)string;


/****  网络请求   ****/
//加载图片
-(void)basisImageViewLoadUrlString:(NSString *)string placeholderString:(NSString *)imageString;
+(void)setUrlHost:(NSString *)urlHost;

//添加地址
-(void)basisImageViewLoadHostUrlString:(NSString *)string placeholderImageString:(NSString *)imageString;


@end
