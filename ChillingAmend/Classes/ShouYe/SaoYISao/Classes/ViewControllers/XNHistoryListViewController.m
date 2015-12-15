//
//  XNHistoryListViewController.m
//  Saoyisao
//
//  Created by 宋鑫鑫 on 14-8-22.
//  Copyright (c) 2014年 pipixia. All rights reserved.
//

#import "XNHistoryListViewController.h"
#import "HistoryObject.h"
#import "WebHistoryCell.h"
#import "TextHistoryCell.h"
#import "TextInfoViewController.h"
#import "WebPreviewViewController.h"
#import "MJRefresh.h"
#import "SingNoUtils.h"
#import "JPCommonMacros.h"
#import "YXSqliteHeader.h"
@interface XNHistoryListViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

/*
 *_pageCount        当前页面是第几页
 *_footer           刷新时 显示的底部样式
 *naviView          自定义navigationBar
 *SAHOlabel         无闪光灯提示语
 */
{
    int _pageCount;
    MJRefreshFooterView *_footer;
    UIView *naviView;
    UILabel *SAHOlabel;
}

/*
 *historyArr             历史记录数据
 *historyTableView       显示历史数据的tableView
 */
@property (nonatomic, strong) NSMutableArray *historyArr;
@property (nonatomic, strong) UITableView *historyTableView;

@end

@implementation XNHistoryListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
        if (naviView) {
        [naviView removeFromSuperview];
    }
    
    [self setNavigationBarWithState:2 andIsHideLeftBtn:NO andTitle:@"历史记录"];
//    [backImageView setImage:[UIImage imageNamed:@"videodetails_title_btn_back.png"]];
//    backImageView.frame = CGRectMake(10, 33, 10, 18);
    [self.leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self setHistoryViewNavigationBar];
   
    UIButton* deleButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - 60, IOS7_HEGHT_27 - 20, 60, 60)];
    //去除多个button同事点击的效果
    [deleButton setExclusiveTouch:YES];
    [self.bar addSubview:deleButton];
    [deleButton setImage:[UIImage imageNamed:@" deleHistoryImage.png"] forState:UIControlStateNormal];
    [deleButton addTarget:self action:@selector(deleHistoryInfo:) forControlEvents:UIControlEventTouchUpInside];
//
    UIImageView *deleteimageView = [[UIImageView alloc]init];
    deleteimageView.frame = CGRectMake(SCREENWIDTH - 32, IOS7_HEGHT_27 + 6, 17, 20);
    deleteimageView.image = [UIImage imageNamed:@"richscan_title_btn_delete2.png"];
    [self.bar addSubview:deleteimageView];
    [super viewWillAppear:YES];
}

//自定义navigationBar
-(void)setHistoryViewNavigationBar
{
    naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, IOS7_HEGHT)];
    [self.view addSubview:naviView];
    naviView.backgroundColor = [UIColor colorWithRed:(float) 234 / 255 green:(float) 96 / 255 blue:(float) 96 / 255 alpha:1];
    naviView.userInteractionEnabled = YES;
    
    //自定义navigationBar的背景图片
//    UIImageView *naviImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bar_bac.png"]];
//    [naviView addSubview:naviImageView];
//    naviImageView.frame = CGRectMake(0, 20, 320, IOS7_HEGHT - 19);
    
    UIImageView *BtnimageView = [[UIImageView alloc]init];
    BtnimageView.frame = CGRectMake(0, 20, 45, 45);
    BtnimageView.image = [UIImage imageNamed:@"返回按钮-IOS.png"];
   
    UIButton* backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, IOS7_HEGHT)];
    [naviView addSubview:backButton];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(dismissOverlayViewInHistoryView:) forControlEvents:UIControlEventTouchUpInside];
    [backButton addSubview:BtnimageView];
    
    UIButton* deleButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - 60, IOS7_HEGHT_27 - 20, 60, 60)];
    [naviView addSubview:deleButton];
    [deleButton setImage:[UIImage imageNamed:@" deleHistoryImage.png"] forState:UIControlStateNormal];
    [deleButton addTarget:self action:@selector(deleHistoryInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *deleteimageView = [[UIImageView alloc]init];
    deleteimageView.frame = CGRectMake(SCREENWIDTH - 35, IOS7_HEGHT_27 + 4, 15, 20);
    deleteimageView.image = [UIImage imageNamed:@"deleHistoryImage.png"];
    [naviView addSubview:deleteimageView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, IOS7_HEGHT_27, 100, 25)];
    titleLabel.center = CGPointMake(self.view.center.x, IOS7_HEGHT_27 + 10 + 5)  ;
    [naviView addSubview:titleLabel];
    titleLabel.text = @"历史记录";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:19.0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.historyArr = nil;
    self.historyArr = [NSMutableArray array];

    self.historyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, IOS7_HEGHT, SCREENWIDTH, SCREENHEIGHT - IOS7_HEGHT)];

    self.historyTableView.delegate = self;
    self.historyTableView.dataSource = self;
    [self.view addSubview:self.historyTableView];
    self.historyTableView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    self.historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.historyTableView registerNib:[UINib nibWithNibName:@"WebHistoryCell" bundle:Nil] forCellReuseIdentifier:@"webCell"];
    [self.historyTableView registerNib:[UINib nibWithNibName:@"TextHistoryCell" bundle:Nil] forCellReuseIdentifier:@"textCell"];
    
    FMDatabase* database=[FMDatabase databaseWithPath:[self databasePath]];
    if ([database open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@",TABLE_NAME];
        sql = [sql stringByAppendingFormat:@" order by %@ desc limit %d,%d", TABLE_DATE, _pageCount, 5];
        FMResultSet * rs = [database executeQuery:sql];
        while ([rs next]) {
            int type = [rs intForColumn:TABLE_TYPE];
            NSString * title = [rs stringForColumn:TABLE_TITLE];
            NSString * content = [rs stringForColumn:TABLE_CONTENT];
            NSString *date = [rs stringForColumn:TABLE_DATE];
            NSLog(@"id = %d, type = %d, title = %@, content = %@, date = %@", [rs intForColumn:@"id"], type, title, content, date);
            
            HistoryObject *history = [[HistoryObject alloc]init];
            history.title = title;
            NSLog(@"----%@",title);
            history.content = content;
            history.type = type;
            history.saoDate = date;
            
            [self.historyArr addObject:history];
        }
        [database close];
    }
    
    if (self.historyArr.count <= 0) {
        SAHOlabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 120, 120, 40)];
        SAHOlabel.center = CGPointMake(SCREENWIDTH / 2, SCREENHEIGHT / 2);
        SAHOlabel.backgroundColor = [UIColor clearColor];
        SAHOlabel.text = @"没有扫描记录";
        SAHOlabel.font = [UIFont systemFontOfSize:17.0];
        SAHOlabel.textColor = [UIColor colorWithRed: 180 / 255.0 green: 180 / 255.0 blue: 180 / 255.0 alpha: 1.0];
        SAHOlabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:SAHOlabel];
    } else {
        [self.historyTableView reloadData];
        [self addFooter];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

//添加下拉刷新
- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.historyTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        FMDatabase* database=[FMDatabase databaseWithPath:[self databasePath]];
        if ([database open]) {
            FMResultSet *rs = [database executeQuery:[NSString stringWithFormat:@"SELECT COUNT(*) as 'count' FROM %@", TABLE_NAME]];
            while ([rs next]) {
                NSLog(@"数据库中数据的个数:%d",[rs intForColumn:@"count"]);
                if ([rs intForColumn:@"count"] > 5) {
                    NSString * sql = [NSString stringWithFormat:
                                      @"SELECT * FROM %@",TABLE_NAME];
                    NSLog(@"_pageCount:%d", _pageCount);
                    NSLog(@"historyArr.count:%lu", (unsigned long)self.historyArr.count);
                    if ([rs intForColumn:@"count"] - self.historyArr.count > 0) {
                        _pageCount += 1;
                    } else {
                        [self performSelector:@selector(noDataNotice) withObject:nil afterDelay:2.5];
                    }
                     sql = [sql stringByAppendingFormat:@" order by %@ desc limit %lu,%d", TABLE_DATE, (unsigned long)self.historyArr.count, 5];
                    
                    FMResultSet * rs = [database executeQuery:sql];
                    while ([rs next]) {
                        int type = [rs intForColumn:TABLE_TYPE];
                        NSString *title = [rs stringForColumn:TABLE_TITLE];
                        NSString *content = [rs stringForColumn:TABLE_CONTENT];
                        NSString *date = [rs stringForColumn:TABLE_DATE];
                        NSLog(@"id = %d, type = %d, title = %@, content = %@, date = %@", [rs intForColumn:@"id"], type, title, content, date);
                        
                        HistoryObject *history = [[HistoryObject alloc]init];
                        history.title = title;
                        history.content = content;
                        history.type = type;
                        history.saoDate = date;
                        [self.historyArr addObject:history];
                    }
                } else {
                    [self performSelector:@selector(noDataNotice) withObject:nil afterDelay:2.5];
                }
            }
            [database close];
        }
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
    };
    _footer = footer;
}

//无数据时的提示
-(void)noDataNotice
{
//    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
//	[self.view addSubview:hud];
// 	hud.mode = MBProgressHUDModeCustomView;
// 	hud.labelText = @"没有更多信息";
//	[hud show:YES];
//	[hud hide:YES afterDelay:1.5];
//    hud = nil;
 }

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
    [self.historyTableView reloadData];
}

//返回上一页面
- (void)dismissOverlayViewInHistoryView:(UIButton *)btn
{
    if (naviView) {
        [naviView removeFromSuperview];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//删除提示
- (void)deleHistoryInfo:(UIButton *)deleBtn
{
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否要删除历史记录?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [av show]; 
}

//删除操作
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        FMDatabase* database=[FMDatabase databaseWithPath:[self databasePath]];
        if ([database open]) {
            NSString *deleteSql = [NSString stringWithFormat:
                                   @"delete from %@",
                                   TABLE_NAME];
            BOOL res = [database executeUpdate:deleteSql];
            if (!res) {
                NSLog(@"error when delete db table");
            } else {
                NSLog(@"success to delete db table");
                
                self.historyArr = nil;
                [self.historyTableView reloadData];
                self.historyTableView.hidden = YES;

                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 120, 120, 40)];
                label.center = CGPointMake(SCREENWIDTH / 2, SCREENHEIGHT / 2);
                label.backgroundColor = [UIColor clearColor];
                label.text = @"没有扫描记录";
                label.font = [UIFont systemFontOfSize:17.0];
                label.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0];
                label.textAlignment = NSTextAlignmentCenter;
                label.center = self.view.center;
                [self.view addSubview:label];
                [SAHOlabel removeFromSuperview];
            }
            [database close];
        }
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.historyArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryObject * historyObject = [self.historyArr objectAtIndex:indexPath.row];
    
    if (historyObject.type == 1) {
        static NSString *CellIdentifier = @"webCell";
        WebHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.webAddrLabel.text = historyObject.content;
        cell.dateLabel.text = [SingNoUtils compareCurrentTime:[NSDate dateWithTimeIntervalSince1970:[historyObject.saoDate longLongValue]/1000]];
        return cell;
    }
    if (historyObject.type == 2) {
        static NSString *CellIdentifier = @"textCell";
        TextHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentLabel.text = historyObject.content;
        cell.dateLabel.text = [SingNoUtils compareCurrentTime:[NSDate dateWithTimeIntervalSince1970:[historyObject.saoDate longLongValue]/1000]];
        return cell;
    }
    return Nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryObject * historyObject = [self.historyArr objectAtIndex:indexPath.row];
    if (historyObject.type == 1) {
        return 103;
    } else {
        return 160;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryObject * historyObject = [self.historyArr objectAtIndex:indexPath.row];
    
    if (historyObject.type == 1) {
        WebPreviewViewController *webVC = [[WebPreviewViewController alloc]initWithNibName:@"WebPreviewViewController" bundle:nil];
        webVC.historyObject = historyObject;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    if (historyObject.type == 2) {
        TextInfoViewController *textVC = [[TextInfoViewController alloc]initWithNibName:@"TextInfoViewController" bundle:nil];
        textVC.historyObject = historyObject;
        [self.navigationController pushViewController:textVC animated:YES];
    }
    if (naviView) {
        [naviView removeFromSuperview];
    }
}

-(NSString* )databasePath
{
    NSString* path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* dbPath=[path stringByAppendingPathComponent:DATABASE_NAME];
    return dbPath;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

@end
