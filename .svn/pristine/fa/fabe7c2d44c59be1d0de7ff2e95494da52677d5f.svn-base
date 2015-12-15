//
//  RouteListView.h
//  HCheap
//
//  Created by dairuiquan on 14-12-12.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RouteListViewDelegate <NSObject>

- (void)routeListTap;
- (void)routeListPan:(UIPanGestureRecognizer *)pan;


@end



@interface RouteListView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIImageView *_backImageView;
    
    BOOL         _flag;
}


@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, weak)   id<RouteListViewDelegate> delegate;

@end
