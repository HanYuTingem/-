//
//  ZXYSearchHistroyView.h
//  MarketManage
//
//  Created by Rice on 15/1/21.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketAPI.h"

@protocol SelectHistroyDelegate <NSObject>

-(void)selectHistroyContent:(NSString *)content;

@end

@interface ZXYSearchHistroyView : UIView<UITableViewDataSource,UITableViewDelegate>

+(ZXYSearchHistroyView *)shanreInstance;

/**
 设置布局
 */
-(void)setLayout;
/**
 刷新数据
 */
-(void)reloadData;
/** 历史记录数据源 */
@property (strong, nonatomic) NSMutableArray *histroyAry;
/** 历史记录显示容器 */
@property (strong, nonatomic) UITableView *searchResultTableview;
/** 选择一条记录传值代理 */
@property (assign, nonatomic) id<SelectHistroyDelegate>histroydelegate;

@end
