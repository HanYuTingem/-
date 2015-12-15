//
//  ZXYCommentListViewController.h
//  Chiliring
//
//  Created by Rice on 14-9-11.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import <UIKit/UIKit.h>

//Tool
#import "MJRefresh.h"
#import "MarketAPI.h"

//View
#import "ZXYCommentListCell.h"  //评论列表cell

#import "L_BaseMallViewController.h"

@interface ZXYCommentListViewController : L_BaseMallViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSString *productId; //产品id

@end
