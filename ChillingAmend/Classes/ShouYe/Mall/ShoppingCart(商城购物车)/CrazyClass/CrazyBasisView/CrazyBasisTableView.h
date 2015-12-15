//
//  CrazyBasisTableView.h
//  MarketManage
//
//  Created by fielx on 15/4/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CrazyBasisTableView;
@protocol  CrazyBasisTableViewDelegate <NSObject>
-(void)crazyBasisTableViewReloadData:(CrazyBasisTableView *)tableView;
@end

@interface CrazyBasisTableView : UITableView

@property (strong,nonatomic) id<CrazyBasisTableViewDelegate>crazyDelegate;

@end
