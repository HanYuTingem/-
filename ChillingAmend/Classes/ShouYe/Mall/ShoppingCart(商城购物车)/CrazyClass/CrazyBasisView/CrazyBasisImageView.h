//
//  CrazyBasisImageView.h
//  MarketManage
//
//  Created by fielx on 15/4/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *CrazyUrlHost = nil;
#import "UIImageView+WebCache.h"

/**
 *  基础ImageView
 */
@interface CrazyBasisImageView : UIImageView

/**
 *  加载图片
 */
-(void)crazyBasisImageViewLoadUrlString:(NSString *)string placeholderImageString:(NSString *)imageString;


+(void)CrazySetUrlHost:(NSString *)urlHost;

/**
 *  添加地址
 */
-(void)crazyBasisImageViewLoadHostUrlString:(NSString *)string placeholderImageString:(NSString *)imageString;



@end
