//
//  ZXYPurchaseConsultViewController.h
//  LiaoNing
//
//  Created by Rice on 14/11/27.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MarketAPI.h"
#import "MJRefresh.h"

#import "ZXYPurchaseConsultCell.h"
#import "ZXYPublishConsultViewController.h" //发表评论

#import "L_BaseMallViewController.h"

@interface ZXYPurchaseConsultViewController : L_BaseMallViewController<UITableViewDataSource,UITableViewDelegate>
//商品id
@property (nonatomic, copy) NSString *productId;

@end
