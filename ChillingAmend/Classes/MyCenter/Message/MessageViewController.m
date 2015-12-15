//  个人消息
//  MessageViewController.m
//  ChillingAmend
//
//  Created by 许文波 on 14/12/22.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "MessageModel.h"
#import "PrizeViewController.h"

@interface MessageViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray * _messageDataArray; // 消息的数组
    UILabel *messageLabel; // 没有消息
    MJRefreshHeaderView *_header; // 下拉刷新
    MJRefreshFooterView *_footer; // 上拉刷新
    NSInteger messagePageSize; // 页码
}

@property (weak, nonatomic) IBOutlet UITableView *messageTableView; // 消息列表

@end

@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _messageDataArray = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"消息"];
    _messageTableView.delegate = self;
    _messageTableView.dataSource = self;
    _messageTableView.backgroundColor = [UIColor clearColor];
    
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    } else {
        messagePageSize = 1;
        [self requestMessageData];
    }
    [self addHeader];
    [self addFooter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 刷新加载
// 上拉加载更多
- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = _messageTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        //  后台执行：
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            messagePageSize = messagePageSize + 1;
            [self requestMessageData];
        });
    };
    _footer = footer;
}

// 下拉刷新
- (void)addHeader
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = _messageTableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        //  后台执行：
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            messagePageSize = 1;
            [self requestMessageData];
        });
    };
//    [header beginRefreshing];
    _header = header;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

#pragma mark 等待界面消失
- (void)dismissWaitingView
{
    if (_header.refreshing) {
        [self doneWithView:_header];
    }
    if (_footer.refreshing) {
        [self doneWithView:_footer];
    }
}

#pragma mark 请求消息的方法
- (void)requestMessageData
{
    if (![GCUtil connectedToNetwork]) {
        [self dismissWaitingView];
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    } else {
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI personMessageUserId:kkUserId andPageSize:@"10" andPage:[NSString stringWithFormat:@"%ld", (long)messagePageSize]]];
        [self showMsg:nil];
    }
}

#pragma mark GCRequestDelegate
- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    NSLog(@"message = %@", aString);
    [self hide];
    [self dismissWaitingView];
    NSMutableDictionary *dict = [aString JSONValue];
    if ( !dict ) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
        return;
    }
    if ([[dict objectForKey:@"code"] isEqual:@"0"]) { // 成功
        if (_header.isRefreshing) {
            [_messageDataArray removeAllObjects];
        }
        if ([[dict objectForKey:@"list"]count ] != 0) {
            for (int i = 0 ; i < [[dict objectForKey:@"list"]count ]; i++) {
                MessageModel * model = [[MessageModel alloc] init];
                [model parse:[[dict objectForKey:@"list"] objectAtIndex:i]];
                [_messageDataArray addObject:model];
            }
            [_messageTableView reloadData];
        } else {
            if (_footer.isRefreshing) {
                [self showStringMsg:@"没有更多消息" andYOffset:0];
            } else [self showStringMsg:@"没有消息" andYOffset:0];
            
        }
    } else {
        [_messageDataArray removeAllObjects];
        [self showStringMsg:[dict valueForKey:@"message"] andYOffset:0];
    }
}

- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self hide];
    [self dismissWaitingView];
    NSLog(@"%@", aError);
    [self showStringMsg:@"网络连接失败！" andYOffset:0];
}

#pragma mark - TabelViewDelegate

/*返回行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messageDataArray.count;
}

/*返回行的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageModel * model = [_messageDataArray objectAtIndex:indexPath.row];
    // 最大尺寸
    CGSize size = CGSizeMake(302, MAXFLOAT);
    // 获取当前那本属性
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13.0f], NSFontAttributeName, nil];
    // 实际尺寸
    CGSize actualSize = [model.content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    if ([model.type isEqual:@"1"]) {
        return 75 + actualSize.height;
    }
    return 110 + actualSize.height;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * messageIndfier =@"messageIndfier";
    MessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:messageIndfier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell parWithMessage:[_messageDataArray objectAtIndex:indexPath.row]];
    [cell.qukankanButton addTarget:self action:@selector(pushMessageDetailView) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark 推出奖励的页面
- (void)pushMessageDetailView
{
    PrizeViewController *prizeView = [[PrizeViewController alloc] init];
    [self.navigationController pushViewController:prizeView animated:YES];
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
