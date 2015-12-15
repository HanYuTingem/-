//
//  CollectionViewController.m
//  MyNiceFood
//
//  Created by sunsu on 15/8/3.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "SSCollectionViewController.h"
#import "MyCollectionCell.h"
#import "CollectionModel.h"
#import "ListTableViewController.h"

@interface SSCollectionViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    UITableView *_collectTableView;
    
    
    UILabel         * _tishiLabel;
    UIView          * _buttonView;//全选和删除按钮
    UIButton        * _allSelectButton;
    UIButton        * _deleteButton;
    
    BOOL b;         //编辑按钮被点击了
    BOOL c;
    
    
    MJRefreshHeaderView * _header;
    MJRefreshFooterView * _footer;
    int                   _totalPages;//订座总页数
    int                   _page;
    
}

@property(nonatomic,strong)UIView * bottomView;
@property(nonatomic,strong)NSMutableArray  * originListArray;
@property(nonatomic,strong)NSMutableArray  * dataArray;//存放收藏数据

@end
static NSString *identify = @"MYCOLLECTIONCELL";
@implementation SSCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _dataArray = [NSMutableArray arrayWithCapacity:1];
    _originListArray = [NSMutableArray arrayWithCapacity:1];
    
    titleButton.hidden = NO;
    [titleButton setTitle:@"我的收藏" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self initTabelView];
    
    [self.rightNavItem setImage:[UIImage imageNamed:@"public_title_btn_edit.png"] forState:UIControlStateNormal];
    [self.rightNavItem setImage:[UIImage imageNamed:@"public_title_btn_delete.png"] forState:UIControlStateSelected];
    [self.rightNavItem addTarget:self action:@selector(touristEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    _page = 1;
    
    
    [self initBottomButton];
    [self addFooter];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initData];
    [_collectTableView reloadData];
}


- (void)addFooter
{
    __unsafe_unretained SSCollectionViewController *vc = self;
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = _collectTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        _page++;
        if (_page <= _totalPages) {
            [self initData];
            [vc performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0];
        }else{
            [self showMsg:@"没有更多数据"];
            [self doneWithView:_footer];
        }
    };
    _footer = footer;
}




//刷新表格并且结束正在刷新状态
- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    [refreshView endRefreshing];
}




-(void)sendBtn:(id)sender{
    [UIView animateWithDuration:0.25 animations:^{
        _buttonView.frame=CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, _buttonView.frame.size.height);
        [self.view bringSubviewToFront:_buttonView];
    }];
}


-(void)initTabelView{
    _collectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _collectTableView.dataSource =self;
    _collectTableView.delegate = self;
    _collectTableView.backgroundView = nil;
    _collectTableView.backgroundColor = [UIColor clearColor];
    _collectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_collectTableView];
    [_collectTableView registerClass:[MyCollectionCell class] forCellReuseIdentifier:identify];
}

-(void)initData{
    [self showStartHud];
    NSString * str  = [NSString stringWithFormat:@"%@",NFM_URL];
    NSString * pageStr = [NSString stringWithFormat:@"%d",_page];
    NSDictionary *parameter =@{@"oId":UserId,@"page":pageStr,@"rows":@"10"};
    NSDictionary *dic = @{@"method":GET_MYCOLLECTIONLIST,@"json":[parameter JSONRepresentation]};
    
    __block SSCollectionViewController *myVC = self;
    [AFRequest GetRequestWithUrl:str parameters:dic andBlock:^(id Datas, NSError *error) {
        [self stopHud:nil];
        if (error == nil) {
            _totalPages = [[Datas objectForKey:@"count"]intValue];
            [_dataArray removeAllObjects];
            NSLog(@"%@",Datas);
            NSArray *collentionList = [Datas objectForKey:@"collentionList"];
            NSMutableArray * mutableArray = [[NSMutableArray alloc]initWithCapacity:1];
            for (NSDictionary * dic in collentionList) {
                CollectionModel *collectModel = [CollectionModel objectWithKeyValues:dic];
                collectModel.select = NO;
                [mutableArray addObject:collectModel];
            }
            NSMutableArray * returnArray = [mutableArray copy];//把接口返回的收藏列表数据保存
            
            if (returnArray.count>0) {
                if (_page == 1) {
                    [_originListArray removeAllObjects];
                }
                [_originListArray addObjectsFromArray:returnArray];
                _dataArray = [NSMutableArray arrayWithArray:_originListArray];
            }else{
                [myVC showMsg:@"没有收藏哦"];
            }
            
            if (!_tishiLabel) {
                _tishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2-20, SCREEN_WIDTH, 20)];
                _tishiLabel.text = @"暂无数据";
                _tishiLabel.textAlignment = NSTextAlignmentCenter;
                [self.view addSubview:_tishiLabel];
            }
            
            if (_dataArray.count==0) {
                _tishiLabel.hidden = NO;
            }else{
                _tishiLabel.hidden = YES;
            }
            [_collectTableView reloadData];
        }else{
            [self stopHud:@""];
            [self showMsg:@"请求失败"];
        }
    }];
}


-(void)initBottomButton{
    _buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 60)];
    [self.view addSubview:_buttonView];
    _allSelectButton = [[UIButton alloc]initWithFrame:CGRectMake(PADDING, PADDING, (SCREEN_WIDTH-4*PADDING)/2, 40)];
    [_allSelectButton setBackgroundImage:[UIImage imageNamed:@"mycoupon_function_btn_red_normal.png"] forState:UIControlStateNormal];
    [_allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
    _allSelectButton.layer.cornerRadius = 6.0f;
    [_allSelectButton addTarget:self action:@selector(allSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonView addSubview:_allSelectButton];
    
    _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_allSelectButton.frame)+2*PADDING, PADDING, (SCREEN_WIDTH-4*PADDING)/2, 40)];
    _deleteButton.backgroundColor = [UIColor lightGrayColor];
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    _deleteButton.layer.cornerRadius = 6.0f;
    [_deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonView addSubview:_deleteButton];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionCell * cell = [MyCollectionCell cellWithTableView:_collectTableView];
    CollectionModel * model = _dataArray[indexPath.row];
    [cell getCellWithModel:_dataArray[indexPath.row]];
    
    [cell.selectButton addTarget:self action:@selector(selectCellAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectButton.tag = indexPath.row;
    
    cell.selectButton.selected = model.select;
    
    if (c) {
        cell.bgView.left = 0;
    }else{
        cell.bgView.left = -30;
    }
    if (b) {
        [UIView animateWithDuration:0.3 animations:^{
            cell.bgView.left = 0;
            cell.selectButton.alpha = 1;
        } completion:^(BOOL finished) {
            c = YES;
        }];
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            cell.bgView.left = -30;
            cell.selectButton.alpha = 0;
        } completion:^(BOOL finished) {
            c = NO;
        }];
    }
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


//cell选中
- (void)selectCellAction:(UIButton *)button{
    button.selected = !button.selected;
    CollectionModel *model = [_dataArray objectAtIndex:button.tag];
    model.select = button.selected;
}

#pragma mark - 编辑按钮
- (void)touristEvent:(UIButton *)button{
    button.selected = !button.selected;
    b = button.selected;
    if (b) {
        if (_dataArray.count == 0) {
            [self.rightNavItem setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [self.rightNavItem setTitle:@"取消" forState:UIControlStateSelected];
            _allSelectButton.hidden = YES;
            _deleteButton.hidden = YES;
        }else{
            _collectTableView.height = _collectTableView.height-60;
            _allSelectButton.hidden = NO;
            _deleteButton.hidden = NO;
        }
    }else{
        _collectTableView.height = _collectTableView.height+60;
        _allSelectButton.hidden = YES;
        _deleteButton.hidden = YES;
        for (CollectionModel *model in _dataArray) {
            model.select = NO;
        }
        _allSelectButton.selected = NO;
    }
    [_collectTableView reloadData];
}



- (void)allSelectAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    if (button.selected) {
        for (CollectionModel *model in _dataArray) {
            model.select = YES;
        }
    }else{
        for (CollectionModel *model in _dataArray) {
            model.select = NO;
        }
    }
    [_collectTableView reloadData];
}

#pragma mark-  删除商家
- (void)deleteAction:(id)sender{
    NSMutableString *deleteStr = [[NSMutableString alloc] init];
    for (CollectionModel *model in _dataArray) {
        if (model.select) {
            [deleteStr appendFormat:@"%@,",model.ownerId];
        }
    }
    if (deleteStr.length==0) {
        if (_dataArray.count == 0) {
            [self showMsg:@"没有收藏可删除"];
        }else{
            [self showMsg:@"请选择要删除的商家"];
        }
        return;
    }else{
        
        if (_dataArray.count == 0) {
            [self showMsg:@"没有收藏可删除"];
        }else{
            [self showStartHud];
            
            NSString * str  = [NSString stringWithFormat:@"%@",NFM_URL];
            NSDictionary *parameter =@{@"oId":UserId,@"collectionId":deleteStr};
            NSDictionary *dic = @{@"method":DELETEMYCOLLECTION,@"json":[parameter JSONRepresentation]};
            
            [AFRequest GetRequestWithUrl:str parameters:dic andBlock:^(id Datas, NSError *error) {
                if (error == nil) {
                    [self stopHud:@""];
                    if ([[Datas objectForKey:@"rescode"]isEqualToString:@"0000"]) {
                        [self showMsg:@"删除收藏成功"];
                        _collectTableView.height = _collectTableView.height+60;
                        _allSelectButton.hidden = YES;
                        _deleteButton.hidden = YES;
                        _page = 1;
                        _dataArray = [NSMutableArray arrayWithObjects:nil];//_dataArray = @[];
                        [self initData];
                        [_collectTableView reloadData];
                    }
                }else{
                    [self stopHud:@""];
                    [self showMsg:@"请求失败"];
                }
            }];
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CollectionModel *model = [_dataArray objectAtIndex:indexPath.row];
    ListTableViewController *merchantDetailVC = [[ListTableViewController alloc] init];
    merchantDetailVC.ownerId =  [NSString stringWithFormat:@"%@",model.ownerId];
    merchantDetailVC.oId = [NSString stringWithFormat:@"%@",USER_ID];
    [self.navigationController pushViewController:merchantDetailVC animated:YES];
}

@end
