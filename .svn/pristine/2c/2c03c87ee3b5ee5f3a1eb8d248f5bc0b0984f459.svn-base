//
//  CrazyBasisTabelViewController.m
//  MarketManage
//
//  Created by fielx on 15/4/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisTabelViewController.h"

#import "GCRequest.h"

@implementation CrazyBasisTabelViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self buildTableView];
}


-(void)buildTableView
{
    self.tableView = [[CrazyBasisTableView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.crazyDelegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.tag = 6666;
}

-(void)setMHaveFooter:(BOOL)mHaveFooter
{
    _mHaveFooter = mHaveFooter;
    if (_mHaveFooter) {
        [self addFooter];
    }
}

-(void)setMHaveHeader:(BOOL)mHaveHeader
{
    _mHaveHeader = mHaveHeader;
    if (_mHaveHeader) {
        [self addHeader];
    }
}



-(void)sendRequset
{
    
}


-(void)crazyBasisTableViewReloadData:(CrazyBasisTableView *)tableView
{
    if (_mHaveFooter) {
        [_footer endRefreshing];
    }
    
    if (_mHaveHeader) {
        [_header endRefreshing];
    }
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    jsonMyModel *model = self.mInfoArray[section];

    NSLog(@"%@",model.shop_name);
    NSLog(@" %ld     %ld",model.list.count,section  );
       return model.list.count;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myCell = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.mInfoArray.count;
}










#pragma mark 下拉刷新
- (void)addHeader
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        //  后台执行：
        //        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self headerRereshing];
        
        //        });
    };
    //    [header beginRefreshing];
    _header = header;
}


- (void)headerRereshing
{
   self.Indexpage = @"1";
   [self sendRequset];
    
    
}


-(void)showNoDataView
{
    if (self.mInfoArray.count == 0 && self.mNoDataView) {
        [self.view addSubview:self.mNoDataView];
        NSLog(@"%@",self.mNoDataView);
        
    }
    else if (self.mNoDataView && self.mInfoArray.count){
        [self.mNoDataView removeFromSuperview];
    }
}


#pragma mark 上啦加载
- (void)addFooter
{
    self.Indexpage = @"1";//下拉的时候页数设置为1
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        
        [self footerRereshing];
    };
    _footer = footer;
}

//上提加载的时候 获取对应的页数 数据
- (void)footerRereshing
{
    
    //加入我总的页数大过我上次加载的页数 你可以再去加载下一页 我还有数据 ～
    if ([self.countPage intValue]>[self.Indexpage intValue]){
        self.Indexpage =[NSString stringWithFormat:@"%d",[self.Indexpage intValue]+1];
    }else
    {
        [self showMsg:@"到底啦"];
        [_footer endRefreshing];
        return;
    }
    
    [self sendRequset];
}


@end
