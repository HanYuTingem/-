//
//  CrazyBasisTabelViewController.h
//  MarketManage
//
//  Created by fielx on 15/4/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisViewController.h"

#import "MJRefreshFooterView.h"

#import "MJRefreshHeaderView.h"

#import "CrazyBasisTableView.h"

#import "CrazyBasisTableNoDataView.h"

#import "jsonMyModel.h"
/**
 *  基础table父类
 */
@interface CrazyBasisTabelViewController : CrazyBasisViewController <UITableViewDataSource,UITableViewDelegate,CrazyBasisTableViewDelegate>

{
    /**
     *  上啦加载
     */
    MJRefreshFooterView *_footer;
    
    /**
     *  下拉加载
     */
    MJRefreshHeaderView *_header;
}


/**
 *  刚开始第一 设置为1
 */
@property (retain,nonatomic) NSString * Indexpage;

/**
 *   请求回来查看总的页数
 */
@property (retain,nonatomic) NSString * countPage;

/**
 *  添加 下拉刷新
 */
@property (assign,nonatomic) BOOL mHaveHeader;

/**
 *  添加 上啦加载
 */
@property (assign,nonatomic) BOOL mHaveFooter;

@property (retain,nonatomic) CrazyBasisTableView *tableView;


/**
 *
 */
@property (retain,nonatomic) CrazyBasisTableNoDataView *mNoDataView;

/**
 *  发送与接收请求
 */
-(void)sendRequset;

-(void)showNoDataView;
@end
