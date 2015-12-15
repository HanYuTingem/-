//
//  MyCouponViewController.h
//  QQList
//
//  Created by sunsu on 15/7/2.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "BaseViewController.h"
@class DZNSegmentedControl;
@interface MyCouponViewController : BaseViewController
@property (nonatomic, strong) DZNSegmentedControl * control;
@property (nonatomic, strong) UIImageView       * foodImg;
typedef void(^locationlabelClick)(NSInteger index);
@property(nonatomic,copy)locationlabelClick locationlabelClickBlock;
@property (nonatomic,strong) NSString *oId;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *page;
@property (nonatomic,strong) NSString *rows;
@property (nonatomic,strong) UITableView *preferTabView;
@property (nonatomic,strong) NSString *proIden;
@end
