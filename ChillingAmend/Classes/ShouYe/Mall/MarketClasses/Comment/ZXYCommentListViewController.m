//
//  ZXYCommentListViewController.m
//  Chiliring
//
//  Created by Rice on 14-9-11.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "ZXYCommentListViewController.h"
#import "BSaveMessage.h"


@interface ZXYCommentListViewController ()
{
    NSInteger Z_limit1; //请求参数limit1
    ASIFormDataRequest *mRequest;
    MJRefreshFooterView *_footer; // 上拉刷新
}

@property (strong, nonatomic) NSMutableArray *dataAry;                    //评论数据源

@property (weak, nonatomic) IBOutlet UITableView *commentListTabelview; //评论列表
@property (weak, nonatomic) IBOutlet UIView *noCommentView;

@end

@implementation ZXYCommentListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        Z_limit1 = 0;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBarStyle];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self commentRequestWithLimit1:Z_limit1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Request
#pragma mark - 评论列表请求 
/*
    limit1;    请求从第limit1条开始的评论
    limit2;    请求limit2条数据
    productId; 商品id
 */
-(void)commentRequestWithLimit1:(NSInteger)limit1
{
    [self startActivity];
    mRequest = [MarketAPI requestCommentList104WithController:self productId:self.productId limit:limit1 type:@"1"];
}
- (void)requestFinished:(ASIHTTPRequest *)request;
{
    [_footer endRefreshing];
    [self stopActivity];
    NSString *tEndString=[[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    tEndString = [tEndString stringByReplacingOccurrencesOfString:@"\n" withString:@"\n"];
    NSDictionary * dict = [tEndString JSONValue];
    NSLog(@"%@",dict);
    if (!dict){
        NSLog(@"接口错误");
        return;
    }
    if ([dict[@"code"] integerValue] == 0 && dict[@"code"] != nil) {
        
        if (Z_limit1 == 0) {
            _dataAry = [[NSMutableArray alloc] initWithArray:dict[@"json"]];
        }else{
            [_dataAry addObjectsFromArray:dict[@"json"]];
        }
        if (_dataAry.count == 0) {
            self.noCommentView.hidden =NO;
        }else{
            self.noCommentView.hidden =YES;
            [self.commentListTabelview reloadData];
        }
        if ([dict[@"json"] count] < 10) {
            Z_limit1 = -1;
        }
    }else{
        [self showMsg:dict[@"message"]];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request;
{
    [_footer endRefreshing];
    [self stopActivity];
    [self showMsg:@"请求失败，请检查网路设置"];
}
#pragma mark - Init
-(void)initData
{
//    [self.commentListTabelview setFrame:CGRectMake(0, 44, 320, [[UIScreen mainScreen] bounds].size.height)];

    self.commentListTabelview.tableFooterView = [[UIView alloc] init];
    [self addFooter];
}

-(void)setNavigationBarStyle
{
 
    self.mallTitleLabel.text = @"评价";
}


#pragma mark - 刷新加载
// 上拉加载更多
- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.commentListTabelview;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        //  后台执行：
            [self footerRereshing];
    };
    _footer = footer;
}

- (void)footerRereshing
{
    if (Z_limit1 == -1) {
        [_footer endRefreshing];
        [self showMsg:@"没有更多评论啦"];
    }else{
        Z_limit1 += 10;
        [self commentRequestWithLimit1:Z_limit1];
    }
}

#pragma mark - UITableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identifier = @"commentListCell";
    ZXYCommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZXYCommentListCell" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_dataAry.count != 0) {
        cell.nickNameLabel.text = IfNullToString(_dataAry[indexPath.row][@"nike_name"]);
        NSString *timeStr       = IfNullToString(_dataAry[indexPath.row][@"create_time"]);
        cell.dateLabel.text     = [MarketAPI changeTimeFormat:timeStr andFormat1:@"YYYY-MM-dd HH:mm:ss" andFormat2:@"YYYY-MM-dd"];
        //对评论内容进行解码显示 避免因系统表情产生乱码
        NSString *contentStr    = [IfNullToString(_dataAry[indexPath.row][@"message"]) stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        CGRect frameTime = cell.dateLabel.frame;
        frameTime.origin.x = SCREENWIDTH - CGRectGetWidth(cell.dateLabel.frame) - 10;
        cell.dateLabel.frame = frameTime;
        
        CGRect frameLabel = cell.contentLabel.frame;
        frameLabel.size.width = SCREENWIDTH - 20;
        cell.contentLabel.frame = frameLabel;
        
        CGRect frameLine = cell.imageLine.frame;
        frameLine.size.width = SCREENWIDTH;
        cell.imageLine.frame = frameLine;
        
        //计算评论高度 若超过40 返回超出高度
        CGSize size = [MarketAPI labelAutoCalculateRectWith:contentStr FontSize:14 MaxSize:CGSizeMake(SCREENWIDTH - 20, MAXFLOAT)];
        if (size.height + 40 > 80) {
            [cell.contentLabel setFrame:CGRectMake(10, 34, SCREENWIDTH - 20, size.height)];
            cell.contentLabel.verticalAlignment = VerticalAlignmentTop;
        }
        cell.contentLabel.text = contentStr;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //对评论内容进行解码显示 避免因系统表情产生乱码
    NSString *contentStr    = [IfNullToString(_dataAry[indexPath.row][@"message"]) stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //计算评论高度 若超过40 返回超出高度
     CGSize size = [MarketAPI labelAutoCalculateRectWith:contentStr FontSize:14 MaxSize:CGSizeMake(300, MAXFLOAT)];
    if (size.height + 40 > 80) {
        return size.height + 40;
    }
    return 80;
}

@end
