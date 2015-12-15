//
//  MyTakeoutOrderViewController.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/8/3.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "MyTakeoutOrderViewController.h"
#import "MyTakeoutOrderTableViewCell.h"
#import "MyTakeoutOrderModel.h"
#import "MJRefresh.h"
#import "OrderInformationViewController.h"
#import "MyTakeOutView.h"

@interface MyTakeoutOrderViewController ()<UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *OrderData;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) MJRefreshFooterView *footer;//下拉刷新
@property (nonatomic, strong) MJRefreshHeaderView *header;//下拉刷新
@end

@implementation MyTakeoutOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _OrderData = [[NSMutableArray alloc] init];
    _page = 1;
    
    
    titleButton.hidden = NO;
    [titleButton setTitle:@"我的外卖" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self addUI];
    [self addRefresh];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeOrder) name:@"changeOrder" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelOrder) name:@"cancelOrder" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lookOrder:) name:@"order" object:nil];
}

- (void)lookOrder:(NSNotification *)obj{
    OrderInformationViewController *vc = [[OrderInformationViewController alloc] init];
    vc.orderId = obj.userInfo[@"orderId"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma Refresh
- (void)addRefresh{
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = self.tableView;
    _footer.delegate = self;
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = self.tableView;
    _header.delegate = self;
}


//清除过期订单的响应方法
- (void)cancelOrder{
    [self chrysanthemumOpen];
    [self close];
    
    NSDictionary *par = [Parameter cancelTakeOut];
    [AFRequest GetRequestWithUrl:NiceFood_Url parameters:par andBlock:^(id Datas, NSError *error) {
        if (error == nil && [Datas[@"rescode"] isEqualToString:@"0000"]) {
            [self chrysanthemumClosed];
            [self open];
//            [self showMsg:@"清除成功"];
            [GCUtil showInfoAlert:@"订单清除成功"];
            
            [self requestData];
            
        } else if (error == nil && [Datas[@"rescode"] isEqualToString:@"0011"]) {
            [self chrysanthemumClosed];
            [self open];
            [self showMsg:Datas[@"resdesc"]];
        } else {
            [self chrysanthemumClosed];
            [self open];
            [self showMsg:@"清除失败"];
        }
        
    }];
}

//订单发生变化的响应方法
- (void)changeOrder{
    [_OrderData removeAllObjects];
}


//数据请求
- (void)requestData{
    
    NSLog(@"我的外卖--请求数据");
    
    NSDictionary *par  = [Parameter getOrderTakeOutWithPage:[NSString stringWithFormat:@"%ld", (long)_page] rows:@"10"];
    
    [AFRequest GetRequestWithUrl:NiceFood_Url parameters:par andBlock:^(NSDictionary *Datas, NSError *error) {
        if (error == nil) {
            
            NSArray *arr = Datas[@"orderList"];
            for (int i = 0; i < arr.count; i++) {
                NSDictionary *temp = arr[i];
                MyTakeoutOrderModel *model = [MyTakeoutOrderModel objectWithKeyValues:temp];
                [_OrderData addObject:model];
            }
            [_tableView reloadData];
        }
        [self chrysanthemumClosed];
        [self open];
    }];  
}

#pragma mark 开始刷新数据
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _footer) {
        _page++;
    }
    else {
        _page = 1;
        [_OrderData removeAllObjects];
    }
    
    [self requestData];
    
    [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:1.5];
}

#pragma mark 刷新表格并且结束正在刷新状态
- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _footer) {
        [_footer endRefreshing];
    }else {
        [_header endRefreshing];
    }
}

//加载ui
- (void)addUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationH) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]){
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]){
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 44, 20, 44, 44)];
    [leftButton setImage:[UIImage imageNamed:@"public_title_btn_more_normal"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:leftButton];
    
}

- (void)clickLeftButton{
    MyTakeOutView *view = [[MyTakeOutView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:view];
}

#pragma mark -- tableView的代理

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击事件
    
    OrderInformationViewController *vc = [[OrderInformationViewController alloc] init];
    MyTakeoutOrderModel *model = _OrderData[indexPath.row];
    vc.orderId = model.orderId;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyTakeoutOrderTableViewCell *cell = [MyTakeoutOrderTableViewCell cellWithTableView:tableView];
    MyTakeoutOrderModel *model = _OrderData[indexPath.row];
    cell.model = model;
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _OrderData.count;//数组count
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;//cell高度
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;//Section组
}

//让cell分割线左对齐的方法
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]){
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    if (_OrderData.count <= 0) {
        [self requestData];
        [self chrysanthemumOpen];
        [self close];
    }
}

-(void)backButtonClick{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeOrder" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cancelOrder" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"order" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeOrder" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cancelOrder" object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
