//
//  ZXYPaySuccessViewController.h
//  MarketManage
//
//  Created by Rice on 15/1/17.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketAPI.h"
#import "ZXYOrderListViewController.h"
#import "ZXYRecommendView.h"
#import "LSYGoodsInfo.h"

#import "L_BaseMallViewController.h"

@interface ZXYPaySuccessViewController : L_BaseMallViewController <DidSelectProductDelegate>

//自取有效期xx天
@property (copy, nonatomic) NSString *validTime;

@property (strong, nonatomic) LSYGoodsInfo *goodsInfo;


@end
