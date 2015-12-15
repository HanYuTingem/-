//
//  LSYImageDetailsViewController.h
//  MarketManage
//
//  Created by liangsiyuan on 15/1/22.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "L_BaseMallViewController.h"

@interface LSYImageDetailsViewController : L_BaseMallViewController
//商品介绍
@property (nonatomic,strong)NSDictionary * goodsInfoDic;
//厂家街上
@property (nonatomic,strong)NSDictionary * changShangInfoDic;
@end
