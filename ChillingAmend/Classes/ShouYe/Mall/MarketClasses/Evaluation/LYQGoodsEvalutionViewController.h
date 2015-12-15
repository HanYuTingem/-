//
//  LYQGoodsEvalutionViewController.h
//  MarketManage
//
//  Created by 劳大大 on 15/4/21.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "L_BaseMallViewController.h"

#import "ZXYOrderDetailModel.h"

@interface LYQGoodsEvalutionViewController : L_BaseMallViewController

@property (nonatomic,strong) NSMutableArray      * orderGoodsArray;

@property (nonatomic,strong) NSString             * submitOderNum;
@end
