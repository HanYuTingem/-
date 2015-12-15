//
//  ZXYPurchaseConsultViewController.m
//  LiaoNing
//
//  Created by Rice on 14/11/27.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "ZXYPurchaseConsultViewController.h"
#import "BSaveMessage.h"


@interface ZXYPurchaseConsultViewController ()
{
    int limit1; //请求条数定位，从第limit1条开始
    ASIFormDataRequest * mRequest;
    
    MJRefreshFooterView *_footer; // 上拉刷新
}

@property (weak, nonatomic) IBOutlet UITableView    *consultTableView; //咨询列表
@property (weak, nonatomic) IBOutlet UIView         *noConsultView;    //无人咨询
@property (strong,nonatomic)         NSMutableArray *listDataAry;      //咨询列表数据源

@end

@implementation ZXYPurchaseConsultViewController

#pragma mark - lifeCycle


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self requestConsult];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavStyle];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [mRequest cancel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Init
-(void)setNavStyle
{
    
    self.mallTitleLabel.text = @"购买咨询";
    [self.rightButton setTitle:@"发表咨询" forState:UIControlStateNormal];
    self.rightButton.frame = CGRectMake(self.rightButton.frame.origin.x-36, self.rightButton.frame.origin.y, 80, self.rightButton.frame.size.height);
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    //    self.rightButton.backgroundColor = [UIColor redColor];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}



-(void)rightBackCliked:(UIButton *)sender
{
    if (kkUserCenterId && ![kkUserCenterId isEqual:@""]) {
        ZXYPublishConsultViewController *publishVC = [[ZXYPublishConsultViewController alloc] initWithNibName:@"ZXYPublishConsultViewController" bundle:nil];
        publishVC.productId = self.productId;
        [self.navigationController pushViewController:publishVC animated:YES];
    }else{
        
        //劳燕子
        
        //调转登陆页面
        [MarketAPI jumLoginControllerWithNavPush:self.navigationController];
        
    }
}

-(void)initData
{
    limit1 = 0;
    self.listDataAry = [[NSMutableArray alloc] init];
    self.consultTableView.tableFooterView = [[UIView alloc] init];
    if ([self.consultTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.consultTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.consultTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.consultTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [self addFooter];
}

#pragma mark - UITableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.listDataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifer = @"consultCell";
    ZXYPurchaseConsultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (cell ==  nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZXYPurchaseConsultCell" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSMutableDictionary *cellDic = self.listDataAry[indexPath.row];
    NSString *timeStr      = IfNullToString(cellDic[@"create_time"]);
    CGFloat answerHeight   = [self heighWithStr:cellDic[@"reply"]];
    CGFloat questionHeight = [self heighWithStr:cellDic[@"message"]];
    CGFloat labelWigth = SCREENWIDTH - 35 - 10;
    cell.answerLabel.text      = cellDic[@"reply"];
    cell.questionLabel.text    = cellDic[@"message"];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",cellDic[@"nike_name"]];
    cell.timeLabel.text = [MarketAPI changeTimeFormat:timeStr andFormat1:@"YYYY-MM-dd HH:mm:ss" andFormat2:@"YYYY-MM-dd"];
    cell.questionLabel.verticalAlignment = VerticalAlignmentTop;
    cell.answerLabel.verticalAlignment   = VerticalAlignmentTop;
    
    CGRect frameTime = cell.timeLabel.frame;
    frameTime.origin.x = SCREENWIDTH - CGRectGetWidth(cell.timeLabel.frame) - 10;
    cell.timeLabel.frame = frameTime;
    
    [cell.questionLabel setFrame:CGRectMake(35, 32, labelWigth, questionHeight)];
    [cell.answerLabel   setFrame:CGRectMake(35, 32 + questionHeight + 10, labelWigth, answerHeight)];
    [cell.bgView        setFrame:CGRectMake(0, 0, SCREENWIDTH, 50 + answerHeight + questionHeight)];
    [cell.answerImage   setFrame:CGRectMake(10, cell.answerLabel.frame.origin.y, 15, 15)];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableViefw heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *cellDic = self.listDataAry[indexPath.row];
    
    return 50 + [self heighWithStr:cellDic[@"reply"]] + [self heighWithStr:cellDic[@"message"]];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - 刷新加载
// 上拉加载更多
- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.consultTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        //  后台执行：
        //        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self footerRereshing];
        //        });
    };
    _footer = footer;
}

- (void)footerRereshing
{
    if (limit1 == -1) {
        [_footer endRefreshing];
        [self showMsg:@"没有更多咨询啦"];
    }else{
        limit1+=10;
        [self requestConsult];
    }
}


#pragma mark - Request
/*
 "por" : "300",     //请求接口
 “proIden”:“”，  //产品标识
 “goods_id”:   2,    //商品id
 “pageSize”:10   //每页显示的条数
 “page”: 0       //当前的页码，从0开始
 “type”: 1    //评论类型：1=售前咨询，2=售后评论
 */

-(void)requestConsult
{
    [self startActivity];
    mRequest = [MarketAPI requestCommentList104WithController:self productId:self.productId limit:limit1 type:@"2"];
}


- (void)requestFinished:(ASIHTTPRequest *)request;
{
    [self stopActivity];
    NSString *tEndString=[[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    tEndString = [tEndString stringByReplacingOccurrencesOfString:@"\n" withString:@"\n"];
    NSLog(@"GC requestFinished --- (%@",tEndString);
    [_footer endRefreshing];
    NSMutableDictionary *dict = [tEndString JSONValue];
    NSLog(@"%@",dict);
    if (dict == nil) {
        NSLog(@"json错误");
    }else{
        NSLog(@"咨询列表请求成功");
        if (dict[@"code"] != nil && [dict[@"code"] integerValue] == 0) {
            if (limit1 == 0) {
                self.listDataAry = [[NSMutableArray alloc] initWithArray:dict[@"json"]];
            }else{
                [self.listDataAry addObjectsFromArray:dict[@"json"]];
            }
            if (self.listDataAry.count == 0) {
                self.noConsultView.hidden = NO;
                self.consultTableView.hidden = YES;
            }else{
                self.noConsultView.hidden = YES;
                self.consultTableView.hidden = NO;
                [self.consultTableView reloadData];
            }
            if ([dict[@"json"] count] < 10) {
                limit1 = -1;
            }
        }else {
            [self showMsg:dict[@"message"]];
        }
        
    }
    
}
- (void)requestFailed:(ASIHTTPRequest *)request;
{
    [_footer endRefreshing];
    [self stopActivity];
    [self showMsg:@"请求失败，请检查网路设置"];
}

#pragma mark - Tool
-(CGFloat)heighWithStr:(NSString *)str
{
    CGSize size = [MarketAPI labelAutoCalculateRectWith:str FontSize:14. MaxSize:CGSizeMake(SCREENWIDTH - 48, MAXFLOAT)];
    return size.height;
}

@end
