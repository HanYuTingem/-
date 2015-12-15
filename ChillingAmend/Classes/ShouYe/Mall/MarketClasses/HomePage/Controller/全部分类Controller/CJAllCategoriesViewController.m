//
//  CJAllCategoriesViewController.m
//  MarketManage
//
//  Created by 赵春景 on 15-7-20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CJAllCategoriesViewController.h"
#import "CJCategoriesAllTableViewCell.h"
#import "CJAllcatgoriesRightView.h" // 左侧collectionView的页面
#import "GCRequest.h"
#import "MarketAPI.h"
#import "CJAllCategoriesModel.h"

#import "CJAllCategoriesThreeModel.h"
#import "ZXYSearchHistroyView.h"//历史搜索
#import "ZXYClassifierListViewController.h"

/** cell的标识符 */
static NSString *ID = @"tableViewCell";

//边线的颜色
#define CellBorderColor [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1].CGColor

#define NavigationMaxY 64
#define TableViewWidth (80 * SP_WIDTH)
#define CellHeight (49 * SP_HEIGHT)



@interface CJAllCategoriesViewController () <UITableViewDataSource,UITableViewDelegate,GCRequestDelegate,UITextFieldDelegate>

{
    /** 左侧滑动的tableView */
    UITableView *_tableView;
    /** 接受数据的可变数组 (一级数组) */
    NSMutableArray *_arrayM;
    
    /** 全局的右侧 collectionView */
    CJAllcatgoriesRightView *_collectionView;
    
    /** 是否取消搜索 */
    BOOL isCancelSearch;
    
    ZXYSearchHistroyView *searchView;
}

/** 网络请求 */
@property (nonatomic, strong) GCRequest *cjMainRequest;
/** 接收二级分类数据的数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 图片的网络头 */
@property (nonatomic, copy) NSString *hostUrl;

/** 搜索 */
@property (nonatomic,strong) UITextField *search;

@end

@implementation CJAllCategoriesViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrayM = [NSMutableArray array];
    
    /**
     * 添加collectionView
     */
    [self makeCollectionView];
    
    /**
     * 添加搜索栏
     */
    [self addNavbarSearch];
    
    /**
     * 加载数据
     */
    [self loadData];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self cancelBttonActionCliked:nil];
}

#pragma mark - 添加搜索栏
/** 添加搜索栏 */
- (void)addNavbarSearch
{
    UIView * view                           = [[UIView alloc]initWithFrame:CGRectMake(56, 27, 200*SP_WIDTH, 30)];
    self.search                             = [[UITextField alloc]initWithFrame:CGRectMake(65,0, 140*SP_WIDTH, 30)];
    UIImageView  * searchViewImage          = [[UIImageView alloc]initWithFrame:CGRectMake(50,10, 10, 10)];
    searchViewImage.image                   = [UIImage imageNamed:@"zxy_shop_title_icon_search.png"];
    [view addSubview:searchViewImage];
    self.search.placeholder                 =   @"请输入关键词";
    [self.search setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.search.borderStyle                 = UITextBorderStyleNone;
    self.search.font                        = [UIFont systemFontOfSize:13];
    self.search.textColor                   = [UIColor blackColor];
    self.search.returnKeyType               = UIReturnKeySearch;
    self.search.contentVerticalAlignment    = UIControlContentVerticalAlignmentCenter;
    [view.layer setCornerRadius:4];
    [view.layer setMasksToBounds:YES];
    view.backgroundColor                    = [UIColor groupTableViewBackgroundColor];
    view.alpha                              = 0.6;
    self.search.clearButtonMode             = UITextFieldViewModeAlways;
    self.search.delegate                    = self;
    [view addSubview:self.search];
    [self.barCenterView addSubview:view];
    
}
#pragma mark - TextFiledDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqual:@"\n"]) {
        isCancelSearch = NO;
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.rightButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(cancelBttonActionCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.barCenterView addSubview:self.rightButton];
    //    self.maskView.hidden = NO;
    searchView.histroyAry = [NSMutableArray arrayWithArray:[MarketAPI loadsearchHistroy]];
    [searchView reloadData];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
//        self.maskView.hidden = YES;
    if (!isCancelSearch) {
        if (textField.text.length) {
            ZXYClassifierListViewController *classifierVC = [[ZXYClassifierListViewController alloc] initWithNibName:@"ZXYClassifierListViewController" bundle:nil];
            classifierVC.leftRow = 0;
            classifierVC.cat_id = @"0";
            classifierVC.cat_name = @"全部";
            classifierVC.searchName = textField.text;
            [self.navigationController pushViewController:classifierVC animated:YES];
        } else {
            [self showMsg:@"请输入搜索内容"];
        }
    }
}
-(void)cancelBttonActionCliked:(id)sender
{
    [self.rightButton removeFromSuperview];
    self.search.text = @"";
    isCancelSearch = YES;
    [self.search resignFirstResponder];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


/**
 * 添加collectionView
 */
- (void)makeCollectionView
{
    CJAllcatgoriesRightView *collectionView = [[CJAllcatgoriesRightView alloc] initWithFrame:CGRectMake(TableViewWidth  , NavigationMaxY, SCREENWIDTH - (TableViewWidth ) , SCREENHEIGHT - NavigationMaxY) controller:self];
//    collectionView.layer.borderWidth = 1;
//    collectionView.layer.borderColor = CellBorderColor;
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
}


/**
 * 添加tableView
 */
- (void)makeTableView
{
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationMaxY , TableViewWidth, CellHeight * _arrayM.count)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.showsVerticalScrollIndicator = NO;
//    [_tableView setSeparatorColor:[UIColor redColor]];
    
    if (CellHeight * _arrayM.count < ScreenHeight - 64) {
        _tableView.scrollEnabled = NO;
    } else {
        _tableView.scrollEnabled = YES;
        CGRect frame = _tableView.frame;
        frame.size.height = ScreenHeight - 64;
        _tableView.frame = frame;
//        _tableView.bounces = NO;
    }
    
    /**
     * 默认选中第一个cell
     */
    NSInteger selectedIndex = 0;
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [_tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    [self.view addSubview:_tableView];
//    
//    [_tableView registerNib:[UINib nibWithNibName:@"CJCategoriesAllTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
    
    NSLog(@"tableView.frame  ------- %@",NSStringFromCGRect(_tableView.frame));
}

#pragma mark tableView 的delegate实现

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *iden = [NSString stringWithFormat:@"iden%d",(int)indexPath.row];
    
    static NSString *iden = @"iden";
    CJCategoriesAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[CJCategoriesAllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    CJAllCategoriesModel *model = _arrayM[indexPath.row];
    
    [cell refreshUI:model];

    
    return cell;
    
}
#pragma 左侧选择栏的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** 计算超出屏幕那部分的高度是多少 */
    CGFloat outSize = tableView.contentSize.height - (SCREENHEIGHT - NavigationMaxY);
    /** 点击的cell Y值大小 */
    CGFloat clickCellY = CellHeight * indexPath.row;
    if (outSize > 0) {
        
        if (clickCellY <= outSize) {
            [UIView animateWithDuration:0.5 animations:^{
                tableView.contentOffset = CGPointMake(0.5, clickCellY);
            }];
        } else {
            [UIView animateWithDuration:1 animations:^{
                tableView.contentOffset = CGPointMake(0, outSize);
            }];
        }
    }
    
    //点击cell的时候加载二级界面
    CJAllCategoriesModel *model = _arrayM[indexPath.row];
    [self loadDataWithCate_id:[NSString stringWithFormat:@"%@",model.ID]];
    
}


#pragma mark - 网络请求

/**
 * 加载一级网络请求数据
 */
- (void)loadData
{
    [self startActivity];
    self.cjMainRequest = [MarketAPI requestAllCategories114WithController:self cate_id:@"0"];
    
}
/**
 * 加载二级网络请求数据 cate_id 为一级界面请求来的ID数据
 */
- (void)loadDataWithCate_id:(NSString *)cate_id
{
    [self startActivity];
    self.cjMainRequest = [MarketAPI requestAllCategories114WithController:self cate_id:cate_id];
}

- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    [self stopActivity];
    NSDictionary *dict = [aString JSONValue];
    if (aRequest.tag == 0) {//一级数据加载
        
            for (NSDictionary *dic in dict[@"index"]) {
                CJAllCategoriesModel *model = [[CJAllCategoriesModel alloc] initWithDict:dic];
                [_arrayM addObject:model];
            }
        
        [self reloadFirstData];
    } else {
        
        self.dataArray = [NSMutableArray array];
        self.hostUrl = dict[@"host"];
        for (NSDictionary *dic in dict[@"list"]) {
//            for (NSDictionary *dic in array) {
                CJAllCategoriesModel *model = [[CJAllCategoriesModel alloc] initWithDict:dic];
                
                if (dic[@"json"]) {
                    model.json = [NSMutableArray array];
                    for (NSDictionary *dictT in dic[@"json"]) {
                        CJAllCategoriesThreeModel *thModel = [CJAllCategoriesThreeModel modelWithDict:dictT];
                        [model.json addObject:thModel];
                    }
                }
                
                [self.dataArray addObject:model];
//            }
        }

        //刷新collectionView的数据
        _collectionView.hostUrl = self.hostUrl;
        _collectionView.dataArray = self.dataArray;
        [_collectionView upWithData];
    }
    
}
- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self stopActivity];
    [self showMsg:@"请求失败，请检查网路设置"];
}

/**
 * 界面即将出现的时候刷新默认的第一组数据
 */
- (void)reloadFirstData
{
    [self makeTableView];
    //刷新默认第一行的数据
    if (_arrayM.count != 0) {
        CJAllCategoriesModel *model = _arrayM[0];
        [self loadDataWithCate_id:[NSString stringWithFormat:@"%@",model.ID]];
    }
    
}

@end
