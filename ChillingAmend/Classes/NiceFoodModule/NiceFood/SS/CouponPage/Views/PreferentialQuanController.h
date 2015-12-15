//
//  PreferentialQuanController.h
//  MyNiceFood
//
//  Created by liujinhe on 15-7-15.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface PreferentialQuanController : BaseViewController

@property (nonatomic,assign) NSInteger tem;
@property(nonatomic,strong)NSArray * couponListArray;
@property(nonatomic,strong)NSString *nameShop;
@property (nonatomic,strong) NSString *proIden;
@property (nonatomic,strong) NSString *oId;
@property (nonatomic,strong) NSString *ownerId;//商家ID

@end
