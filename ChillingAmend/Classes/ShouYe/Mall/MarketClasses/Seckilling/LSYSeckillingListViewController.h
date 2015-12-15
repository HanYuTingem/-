//
//  LSYSeckillingListViewController.h
//  MarketManage
//
//  Created by liangsiyuan on 15/1/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSYMenuScrollView.h"
#import "L_BaseMallViewController.h"

@interface LSYSeckillingListViewController : L_BaseMallViewController<UIScrollViewDelegate,LSYMenuScrollViewDelegate>
@property(nonatomic,copy)NSString * miaoShaID;
@property(nonatomic,copy)NSString * childMiaoShaID;
@end
