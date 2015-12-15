//
//  MyBookSeatViewController.m
//  QQList
//
//  Created by sunsu on 15/7/1.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "MyBookSeatViewController.h"
#import "CustomActionSheet.h"
#import "MyBookSeatCell.h"
#import "MyBookSeatMgCell.h"
#import "BookSeatModel.h"

#import "ListTableViewController.h"
#import "MyBookSeatMessageViewController.h"
#import "BookSeatDetailViewController.h"


@interface MyBookSeatViewController ()<CustomActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,BookSeatDetailViewControllerDelegate,UIAlertViewDelegate,MJRefreshBaseViewDelegate>{
    
    CustomActionSheet   * _sheet;//我的外面清除过期和取消的订单窗口
    NSString            * _level;//等级
    
    
    UITableView         * _bookSeatTableView;
    BookSeatModel       * _bookSeatModel;
    
    NSDictionary        * _receveDictionary;
    
    MJRefreshHeaderView * _header;
    MJRefreshFooterView * _footer;
    int                   _totalPages;//订座总页数
    BOOL                  _refresh;//控制刷新
    int                   _page;//页
    
}
@property(nonatomic,strong)NSMutableArray * seatOrderListArray;//保存订座数据
@property(nonatomic,strong)NSMutableArray * originListArray;
@property (nonatomic, strong) MJRefreshFooterView *footer;//下拉刷新
@property (nonatomic, strong) MJRefreshHeaderView *header;//下拉刷新

@end


@implementation MyBookSeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    titleButton.hidden = NO;
    [titleButton setTitle:@"我的订座" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.rightNavItem setImage:[UIImage imageNamed:@"dz_more.png"] forState:UIControlStateNormal];
    [self.rightNavItem setImageEdgeInsets:UIEdgeInsetsMake(8, 10, 8, 10)];
    self.view.backgroundColor = RGBCOLOR(238, 238, 238);
    
    _receveDictionary = [NSDictionary dictionary];
    _originListArray = [[NSMutableArray alloc] initWithCapacity:1];
    _seatOrderListArray = [[NSMutableArray alloc] initWithCapacity:1];
    _page = 1;
    
    //[self startDownLoad];
    if (!HUserId) {
        [self startDownLoad];
    }
    
    [self createUI];
    [self addFooter];
    [self addHeader];
}

- (void)addFooter
{
    __unsafe_unretained MyBookSeatViewController *vc = self;
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = _bookSeatTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        _page++;
        if (_page <= _totalPages) {
            [self startDownLoad];
            [vc performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0];
        }else{
            [self showMsg:@"没有更多数据"];
            [self doneWithView:_footer];
        }
        
    };
    _footer = footer;
}

- (void)addHeader
{
    __unsafe_unretained MyBookSeatViewController *vc = self;
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = _bookSeatTableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        _page = 1;
        if (_page <= _totalPages) {
            [self startDownLoad];
            [vc performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0];
        }else{
            [self showMsg:@"更新成功"];
            [self doneWithView:_header];
        }
        
    };
    _header = header;
}




//刷新表格并且结束正在刷新状态
- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _footer) {
        [_footer endRefreshing];
    }else {
        [_header endRefreshing];
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startDownLoad];
    [_bookSeatTableView reloadData];
}

#pragma mark  下载数据
- (void)startDownLoad
{
    [self showStartHud];
    NSString * str  = [NSString stringWithFormat:@"%@",NFM_URL];
    NSDictionary *parameter = @{@"oId":HUserId,@"page":[NSString stringWithFormat:@"%d",_page],@"rows":@"10",@"proIden":PROIDEN};
    NSDictionary *dic = @{@"method":MY_BOOK_SEAT,@"json":[parameter JSONRepresentation]};
    
    __block MyBookSeatViewController *myVC = self;
    [AFRequest GetRequestWithUrl:str parameters:dic andBlock:^(id Datas, NSError *error) {
        
        if (error == nil) {
            [self stopHud:@""];
            _totalPages = [[Datas objectForKey:@"count"]intValue];
            _phoneStr = [Datas objectForKey:@"customPhone"];
            _receveDictionary = Datas;
            
            [_seatOrderListArray removeAllObjects];
            NSArray * seatArray = [Datas objectForKey:@"seatOrderList"];
            NSMutableArray * tempMutableArray = [NSMutableArray arrayWithCapacity:0];
            
            for (NSDictionary * dic in seatArray) {
                BookSeatModel * bookSeatModel = [BookSeatModel objectWithKeyValues:dic];
                [tempMutableArray addObject:bookSeatModel];
            }
            
            if (seatArray.count > 0) {
                if (_page == 1) {
                    [_originListArray removeAllObjects];
                }
                [_originListArray addObjectsFromArray:tempMutableArray];
                _seatOrderListArray = [NSMutableArray arrayWithArray:_originListArray];
            }else{
                [myVC showMsg:@"没有订座哦"];
                [self doneWithViewTo:_footer];
            }
            [_bookSeatTableView reloadData];          
        }else{
            [self stopHud:@""];
            [self showMsg:@"请求失败"];
        }
    }];
}

- (void)doneWithViewTo:(MJRefreshBaseView *)refreshView
{
    [refreshView endRefreshing];
}


- (void)creatLabel{
    if (self.seatOrderListArray.count == 0) {
        UILabel *labeRit = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2+15, 100, 30 )];
        labeRit.text = @"暂无数据";
        labeRit.backgroundColor = [UIColor lightGrayColor];
        [labeRit setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:labeRit];
    }
    
}

-(void)viewDidLayoutSubviews
{
    if (Version >= 7.0 && Version < 8.0)
    {
        
    }else
    {
        if ([_bookSeatTableView respondsToSelector:@selector(setLayoutMargins:)])
        {
            [_bookSeatTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        }
    }
}
#pragma mark -initUI
-(void)createUI{
    CGRect bookSeatTableViewFrame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    _bookSeatTableView = [[UITableView alloc]initWithFrame:bookSeatTableViewFrame];
    _bookSeatTableView.delegate = self;
    _bookSeatTableView.dataSource = self;
    _bookSeatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_bookSeatTableView];
}



#pragma mark--导航栏几个方法

-(void)backButtonClick{
    //    if (self.formShang) {
    //        for (UIViewController *temp in self.navigationController.viewControllers) {
    //            if ([temp isKindOfClass:[ListTableViewController class]]) {
    //                [self.navigationController popToViewController:temp animated:YES];
    //            }
    //        }
    //    }else{
    //        [self.navigationController popViewControllerAnimated:YES];
    //    }
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)sendBtn:(id)sender{
    if (_sheet == nil)
    {
        _sheet = [[CustomActionSheet alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_sheet.clearBtn setTitle:@"清除过期和取消的订单" forState:UIControlStateNormal];
        _sheet.delegate           = self;
        [self.view addSubview:_sheet];
    }
}

#pragma mark - actionSheetDelegate
- (void)customActionSheetButtonIndex:(NSInteger)index
{
    if (index == 101)
    {
        if (self.seatOrderListArray.count == 0) {
            [self showMsg:@"没有可清除的过期或已取消的订单"];
        }else{
            
            UIAlertView  *alertView = [[UIAlertView alloc]initWithTitle:@"确定要清除过期的订单吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
        }
        
    }
    if(index == 102)
    {
    }
    _sheet = nil;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self clearOverTimeDownLoad];
    }else{
        
    }
}

#pragma mark 清除过期的信息
- (void)clearOverTimeDownLoad
{
    if (self.seatOrderListArray.count == 0) {
        [self showMsg:@"没有可清除的过期或已取消的订单"];
    }else{
        //        //把过期和取消的订单ID加入字符串
        //        NSMutableString *str = [[NSMutableString alloc] initWithString:@""];
        //        for (BookSeatModel *model in self.seatOrderListArray)
        //        {
        //            if ([model.operationState isEqualToString:@"2"] || [model.operationState isEqualToString:@"3"]|| [model.operationState isEqualToString:@"5"])
        //            {
        //                [str appendFormat:@"%@,",model.seatId];
        //            }
        //        }
        
        
        //        if (![str isEqualToString:@""])
        //        {
        //[self showStartHud];
        
        NSString * urlStr  = [NSString stringWithFormat:@"%@",NFM_URL];
        NSDictionary *parameter = @{@"oId":USER_ID,@"proIden":PROIDEN};
        NSDictionary *dic = @{@"method":MY_BOOK_CLEAROVERTIME,@"json":[parameter JSONRepresentation]};
        [AFRequest GetRequestWithUrl:urlStr parameters:dic andBlock:^(id Datas, NSError *error) {
            ZNLog(@"clear rescode=%@",Datas[@"rescode"]);
            if (error == nil) {
                //[self stopHud:nil];
                
                if ([Datas[@"rescode"] isEqualToString:@"0000"])
                {
                    //_refresh = YES;
                    [self.seatOrderListArray removeAllObjects];
                    [self startDownLoad];
                    [_bookSeatTableView reloadData];
                }else if ([Datas[@"rescode"] isEqualToString:@"0011"])
                {
                    [self showMsg:Datas[@"resdesc"]];
                }else{
                    [self showMsg:@"未能清除订单"];
                }
                
            }else{
                //[self stopHud:@""];
                [self showMsg:@"请求失败"];
            }
        }];
        
        //        }else{
        //            [self showMsg:@"未能清除成功"];
        //        }
    }
}


#pragma mark - TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    
    if (section == 1){
        return self.seatOrderListArray.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 40;
    }
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * cellID = @"MYBOOKSEATMGCELL";
        [_bookSeatTableView registerClass:[MyBookSeatMgCell class] forCellReuseIdentifier:cellID];
        MyBookSeatMgCell * cell = [MyBookSeatMgCell cellWithTableView:_bookSeatTableView];
        //        cell.phoneNumLabel.text = _phoneStr;
        //        NSLog(@"phoneStr=%@",_phoneStr);
        //        cell.phoneNumLabel.text = [_receveDictionary objectForKey:@"customerPhone"];
        //BookSeatModel * model = [BookSeatModel objectWithKeyValues:_receveDictionary];
        //[cell reshTabelViewCell:model];
        cell.phoneNumLabel.text = PhoneNumber;
        return cell;
    }else{
        static NSString * cellID = @"MYBOOKSEATCELL";
        [_bookSeatTableView registerClass:[MyBookSeatCell class] forCellReuseIdentifier:cellID];
        MyBookSeatCell * cell = [MyBookSeatCell cellWithTableView:_bookSeatTableView];
        BookSeatModel *model = self.seatOrderListArray[indexPath.row];
        [cell getCellWithModel:model];
        return cell;
    }
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        //        MyBookSeatMessageViewController * myBookSeatMessageVC = [[MyBookSeatMessageViewController alloc]init];
        //        myBookSeatMessageVC.phoneNum =  [_receveDictionary objectForKey:@"customerPhone"];
        //        [self.navigationController pushViewController:myBookSeatMessageVC animated:YES];
    }else{
        BookSeatDetailViewController *book = [[BookSeatDetailViewController alloc] init];
        book.delegate = self;
        
        BookSeatModel *model = _seatOrderListArray[indexPath.row];
        int status;//是否显示删除订单 1为不显示 0为显示
        if ([model.seatState isEqualToString:@"2"])
        {
            status = 1;
        }
        if ([model.seatState isEqualToString:@"0"])
        {
            status = 1;
            
        }else if ([model.seatState isEqualToString:@"1"])
        {
            status = 1;
            
        }else
        {
            status = 0;
        }
        
        //传值  后期用model传
        book.oId        = HUserId;//USER_ID
        book.seatId     = model.seatId;
        book.status     = status;
        book.ownerId    = model.ownerId;
        //        book.shopName   = model.ownerName;
        //        book.time       = model.seatTime;//[GCUtil timeToMyTime:model.seatTime];
        //        book.customName = model.userName;
        //        book.phoneNum   = model.phone;
        //        book.peopleNum  = model.seatPeople;
        //        book.sex        = [NSString stringWithFormat:@"%@",model.sex];
        //        book.note       = model.note;
        //        book.ownerDeleteFlag = [model.ownerDeleteFlag intValue];
        
        
        book.operationState = model.operationState;
        if ([book.operationState intValue]==2){
            [self showMsg:@"已到店订座不能查看详情"];
        }else if ([book.operationState intValue]==6){
            [self showMsg:@"订座已过期"];
        }else{
            [self.navigationController pushViewController:book animated:YES];
        }
    }
}

- (void)bookSeatStatusChange
{
    _refresh = YES;
    [self startDownLoad];
    //    [_bookSeatTableView reloadData];
    //    NSIndexSet * nd=[[NSIndexSet alloc]initWithIndex:1];//刷新第二个section
    //    [_bookSeatTableView reloadSections:nd withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
