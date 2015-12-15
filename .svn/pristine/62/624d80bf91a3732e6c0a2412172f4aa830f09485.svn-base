//
//  HeaderView.h
//  QQList
//
//  Created by CarolWang on 14/11/22.
//  Copyright (c) 2014年 CarolWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKGroupModel.h"
/**
 *  点击headerView展开商品列表
 */
@protocol HeaderViewDelegate <NSObject>
@optional
- (void)clickView;
@end


@interface HeaderView : UITableViewHeaderFooterView
@property (nonatomic, assign) id<HeaderViewDelegate> delegate;

@property (nonatomic, strong) JKGroupModel *groupModel;

+ (instancetype)headerView:(UITableView *)tableView;
@end
