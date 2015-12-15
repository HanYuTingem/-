//
//  TakeoutViewController.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/15.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "TakeoutViewController.h"
#import "TakeOutListRootModel.h"
#import "takeOutList.h"
#import "dishesList.h"
#import "DishesListCell.h"
#import "TakeOutClassCell.h"
#import "ShoppingCartView.h"
#import "AccountViewController.h"
#import "OrderInformationViewController.h"

@interface TakeoutViewController()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *list;  //外卖分类列表
@property (nonatomic, strong) UITableView *childList; //二级列表
@property (nonatomic, strong) TakeOutListRootModel *takeOutListRootModel; //外卖模型

@property (nonatomic, copy) NSArray *listArray; //分类列表集合
@property (nonatomic, copy) NSArray *childListArray; //二级列表集合

@property (nonatomic, assign) NSInteger listIndex;//分类选择标记
@property (nonatomic, assign) NSInteger childIndex;//菜品选择标记

@property (nonatomic, assign) CGFloat money;        //商品总价
@property (nonatomic, strong) UILabel *moneyLabel; //金额标记
@property (nonatomic, strong) UIButton *settlement; //结算按钮

@property (nonatomic, copy) NSMutableArray *countIndexArray; //分类列表显示的数量
@property (nonatomic, assign) NSInteger sumCount;  //商品总数总数
@property (nonatomic, strong) UIButton *sum;        //商品总数的标记按钮

@property (nonatomic, strong) NSMutableArray *shoppingCartArray; //保存购物车页面数组
@property (nonatomic, strong) ShoppingCartView *shoppingCartView;//购物车view
@property (nonatomic, strong) UIButton *shoppingCart; //购物车按钮

@end

@implementation TakeoutViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    _countIndexArray = [[NSMutableArray alloc] init];
    _shoppingCartArray = [[NSMutableArray alloc] init];
    _listIndex = 0;
    _sumCount = 0;
    
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSetupNotification:) name:@"setup" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAddNotification:) name:@"add" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSubNotification:) name:@"sub" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getRemoveNotification:) name:@"remove" object:nil];
    
}




#pragma mark -- 刷新左边列表红点消息的方法
// 遍历每个类中的每个商品 跟已选择商品的数组中元素逐一比较 相同则给当前类别累计份数
- (void)changeCountIndexArrayWithModel:(dishesList *)model{
    NSMutableArray *listnum = [[NSMutableArray alloc] init];
    for (int i = 0; i < _takeOutListRootModel.takeOutList.count; i++) {
        
        NSDictionary *dic = _takeOutListRootModel.takeOutList[i];
        NSArray *arr = dic[@"dishesList"];
        
        NSInteger index = 0;
        for (int j = 0; j < arr.count; j++) {
            NSDictionary *dic2 = arr[j];
            for (int k = 0; k < _shoppingCartArray.count; k++) {
                dishesList *temp = _shoppingCartArray[k];
                if ([temp.contentName isEqualToString:dic2[@"contentName"]]) {
                    index += temp.copies;
                }
            }
        }
        [listnum addObject:[NSString stringWithFormat:@"%d", index]];
    }
    _countIndexArray = listnum;
    [_list reloadData];
}

#pragma mark -- remove通知响应方法
- (void)getRemoveNotification:(NSNotification *)notification{
    dishesList *model = (dishesList *)notification.userInfo;
    
    for (int i = 0; i < _shoppingCartArray.count; i++) {
        
        dishesList *temp = _shoppingCartArray[i];
        if ([temp.contentName isEqualToString:model.contentName]) {
            [_shoppingCartArray removeObject:temp];
        }
    }
    [self changeCountIndexArrayWithModel:model];
    [self changeSumCount];
    [_list selectRowAtIndexPath:[NSIndexPath indexPathForItem:_listIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    if (_shoppingCartArray.count == 0) {
        _shoppingCart.selected = NO;
        [_shoppingCartView removeFromSuperview];
    }
}

#pragma mark -- sub通知响应方法
- (void)getSubNotification:(NSNotification *)notification{
    dishesList *model = (dishesList *)notification.userInfo;
    
    for (int i = 0; i < _shoppingCartArray.count; i++) {
        
        dishesList *temp = _shoppingCartArray[i];
        if ([temp.contentName isEqualToString:model.contentName]) {
            [_shoppingCartArray replaceObjectAtIndex:i withObject:model];
        }
    }
    [self changeCountIndexArrayWithModel:model];
    [self changeSumCount];
    [_list selectRowAtIndexPath:[NSIndexPath indexPathForItem:_listIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark -- add通知响应方法
- (void)getAddNotification:(NSNotification *)notification{
    dishesList *model = (dishesList *)notification.userInfo;
    
    for (int i = 0; i < _shoppingCartArray.count; i++) {
        
        dishesList *temp = _shoppingCartArray[i];
        if ([temp.contentName isEqualToString:model.contentName]) {
            [_shoppingCartArray replaceObjectAtIndex:i withObject:model];
        }
    }
    [self changeCountIndexArrayWithModel:model];
    [self changeSumCount];
    [_list selectRowAtIndexPath:[NSIndexPath indexPathForItem:_listIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark -- setup通知响应方法
- (void)getSetupNotification:(NSNotification *)notification{
    
    dishesList *model = (dishesList *)notification.userInfo;
    [_shoppingCartArray addObject:model];
    [self changeCountIndexArrayWithModel:model];
    [self changeSumCount];
    [_list selectRowAtIndexPath:[NSIndexPath indexPathForItem:_listIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark -- 刷新UI
- (void)changeSumCount{
//    购物车的数量统计
    NSInteger num = 0;
    for (NSString *str in _countIndexArray) {
        num += [str intValue];
    }
    _sumCount = num;
    
    if (_sumCount > 99) {
        [_sum setTitle:@"n+" forState:UIControlStateNormal];
    } else {
        [_sum setTitle:[NSString stringWithFormat:@"%d", _sumCount] forState:UIControlStateNormal];

    }
        if (_sumCount == 0) {
        _sum.hidden = YES;
    } else {
        _sum.hidden = NO;
    }
    
//  金额统计
    CGFloat num2 = 0.0;
    for (int i = 0; i < _shoppingCartArray.count; i++) {
        dishesList *temp = _shoppingCartArray[i];
        num2 += [temp.price floatValue] * temp.copies;
    }
    _money = num2;
    
//   金额Label
    if ([_takeOutListRootModel.status intValue] == 0) {
        [_moneyLabel setText:[NSString stringWithFormat:@"¥ %.2f", _money]];
    }
    
//    结算按钮
    if ([_takeOutListRootModel.takeOutPrice floatValue] > _money) {
        
        [_settlement setBackgroundColor:RGBACOLOR(196, 196, 196, 1)];
        CGFloat price = [_takeOutListRootModel.takeOutPrice floatValue];
        NSString *str = [NSString stringWithFormat:@"亲，还差%.2f元起送哦", price - _money];
        [_settlement setTitle:str forState:UIControlStateNormal];
        _settlement.userInteractionEnabled = NO;
        
    } else {
        [_settlement setBackgroundColor:RGBACOLOR(230, 60, 82, 1)];
        [_settlement setTitle:@"搞定啦~" forState:UIControlStateNormal];
        _settlement.userInteractionEnabled = YES;
    }
    
    [_shoppingCartView.tableView reloadData];
    [_childList reloadData];
    
}

#define mark -- 添加UI
- (void)addUI{
    titleButton.hidden = NO;
    [titleButton setTitle:_name forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _list = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationH, SCREEN_WIDTH * ListScale, SCREEN_HEIGHT - NavigationH - 49) style:UITableViewStylePlain];
    _list.tag = 201;
    [self.view addSubview:_list];
    [_list setBackgroundColor:RGBACOLOR(235, 235, 235, 1)];
    _list.tableFooterView = [[UIView alloc] init];
    _list.delegate = self;
    _list.dataSource = self;
    _list.bounces = NO;
    _list.showsVerticalScrollIndicator = NO;
    
    if (_takeOutListRootModel.takeOutList.count > 0) {
        [_list selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    
    _childList = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * ListScale, NavigationH, SCREEN_WIDTH * (1.0 - ListScale), SCREEN_HEIGHT - NavigationH - 49) style:UITableViewStylePlain];
    _childList.tag = 202;
    [self.view addSubview:_childList];
    _childList.delegate = self;
    _childList.dataSource = self;
    _childList.tableFooterView = [[UIView alloc] init];
    _childList.bounces = NO;
    _childList.showsVerticalScrollIndicator = NO;
    
    //    cell间分隔线对齐到顶端
    if ([_list respondsToSelector:@selector(setSeparatorInset:)]){
        [_list setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_list respondsToSelector:@selector(setLayoutMargins:)]){
        [_list setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([_childList respondsToSelector:@selector(setSeparatorInset:)]){
        [_childList setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_childList respondsToSelector:@selector(setLayoutMargins:)]){
        [_childList setLayoutMargins:UIEdgeInsetsZero];
    }
    
//    最底部view
    UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
    [bottom setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bottom];
    
//    底部view的分割线
    UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49 -3, SCREEN_WIDTH, 3)];
    [bottomLine setImage:[UIImage imageNamed:@"programme_list_abg"]];
    [bottomLine setAlpha:0.2];
    [self.view addSubview:bottomLine];
    
//    购物车按钮
    _shoppingCart = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, 40, 40)];
    [_shoppingCart setImage:[UIImage imageNamed:@"wm_icon_gwc"] forState:UIControlStateNormal];
    [bottom addSubview:_shoppingCart];
    [_shoppingCart addTarget:self action:@selector(clickShoppingCartButton:) forControlEvents:UIControlEventTouchUpInside];

//      购物车按钮上的红点
    _sum = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, 15, 15)];
    [_sum setBackgroundImage:[UIImage imageNamed:@"wm_icon_bg"] forState:UIControlStateNormal];
    [_sum.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_shoppingCart addSubview:_sum];
    _sum.hidden = YES;
    
//    金额和购物车之间的分割线
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_shoppingCart.frame) + 10, 5, 2, 49 - 10)];
    [line setImage:[UIImage imageNamed:@"activity_content_img_line"]];
    [bottom addSubview:line];
    
//    金额
    _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line.frame) + 10, 10, 100, 49 - 20)];
    
    if ([_takeOutListRootModel.status intValue] == 0) {
        [_moneyLabel setText:[NSString stringWithFormat:@"¥ %@", @"0"]];
    } else {
        [_moneyLabel setText:@"商家已打烊"];
    }
    
    [_moneyLabel setTextColor: RGBACOLOR(230, 60, 82, 1)];
    [_moneyLabel setFont:[UIFont systemFontOfSize:18]];
    [bottom addSubview:_moneyLabel];
    
//    结算按钮
    _settlement = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 150, 8, 150, 49 - 16)];
    _settlement.layer.cornerRadius = 4;
    [_settlement setBackgroundColor:RGBACOLOR(196, 196, 196, 1)];
    
    NSString *str = [NSString stringWithFormat:@"亲，%@元起送哦~",_takeOutListRootModel.takeOutPrice];
    
    [_settlement setTitle:str forState:UIControlStateNormal];
    [_settlement.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [bottom addSubview:_settlement];
    [_settlement addTarget:self action:@selector(clickSettlementButton:) forControlEvents:UIControlEventTouchUpInside];
    _settlement.userInteractionEnabled = NO;
    
}

#pragma mark -- 结算按钮点击事件
- (void)clickSettlementButton:(UIButton *)button{
    if ([_takeOutListRootModel.status intValue] == 0) {
        
        AccountViewController *accountVC = [[AccountViewController alloc] init];
        
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (int i = 0; i < _shoppingCartArray.count; i++) {
            dishesList *model = _shoppingCartArray[i];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:model.contentId forKey:@"contentId"];
            [dic setObject:model.contentName forKey:@"contentName"];
            [dic setObject:model.industryClassifyName forKey:@"industryClassifyName"];
            [dic setObject:[NSString stringWithFormat:@"%.2f", [model.price floatValue] * model.copies] forKey:@"price"];
            [dic setObject:[NSString stringWithFormat:@"%ld",(long)model.copies] forKey:@"contentCount"];
            [temp addObject:dic];
        }
        
        accountVC.name = _name;
        accountVC.shoppingCartArray = temp;
        accountVC.ownerId = _ownerId;
        accountVC.totalprice = [NSString stringWithFormat:@"%.2f", _money];
        
        [self.navigationController pushViewController:accountVC animated:YES];
        
    } else {
        [self showMsg:@"商家已打烊"];
    }
}

#pragma mark -- 购物车按钮点击事件
- (void)clickShoppingCartButton:(UIButton *)button{
    if (_shoppingCartArray.count > 0) {
        if (button.selected == NO) {
            button.selected = YES;
            _shoppingCartView = [[ShoppingCartView alloc] initWithFrame:CGRectMake(0, NavigationH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationH - 49)];
            _shoppingCartView.Data = _shoppingCartArray;
            [self.view addSubview:_shoppingCartView];
        } else {
            button.selected = NO;
            [_shoppingCartView removeFromSuperview];
        }
    }
}

#pragma mark -- 加载数据
- (void)requestData{
    
    NSDictionary *par = [Parameter getTakeoutListWithOwnerId:_ownerId];
    
    AFHTTPRequestOperationManager *request=[AFHTTPRequestOperationManager manager];
    request.responseSerializer = [AFJSONResponseSerializer serializer];
    request.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json", @"text/javascript", nil];
    
    [request GET:NiceFood_Url parameters:par success:^(AFHTTPRequestOperation * operation, NSDictionary *responseObject) {
     
//        第一层模型
        _takeOutListRootModel = [TakeOutListRootModel objectWithKeyValues:responseObject];
        
//        第二层模型
        for (NSMutableDictionary *dic in _takeOutListRootModel.takeOutList) {
            NSString *str = [NSString stringWithFormat:@"%d", 0];
            [_countIndexArray addObject:str];
        }
        
        
        
        [self addUI];
        [self chrysanthemumClosed];
        [self open];
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@", error);
        [self chrysanthemumClosed];
        [self open];
        [self showMsg:@"加载失败"];
    }];
}

#pragma mark -- tableView的delegate方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView.tag == 201) {
        _listIndex = indexPath.row;
        [_childList reloadData];
    } else {
        _childIndex = indexPath.row;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 201) {
        return 0;
    } else {
        return 35;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (tableView.tag == 202 && _takeOutListRootModel.takeOutList.count > 0) {
        NSString *str = [NSString stringWithFormat:@"  %@", _takeOutListRootModel.takeOutList[_listIndex][@"industryClassifyName"]];
        return str;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView.tag == 201) {
        
        TakeOutClassCell *cell = [TakeOutClassCell cellWithTableView:tableView];
        NSDictionary *dic = _takeOutListRootModel.takeOutList[indexPath.row];
        takeOutList *model = [takeOutList objectWithKeyValues:dic];
        cell.model = model;
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        cell.index = _countIndexArray[indexPath.row];
        
        return cell;
        
    } else {
        
        DishesListCell * cell = [DishesListCell cellWithTableView:tableView];
        NSDictionary * dic = _takeOutListRootModel.takeOutList[_listIndex][@"dishesList"][indexPath.row];
        dishesList *model = [dishesList objectWithKeyValues:dic];
        
        for (int i = 0; i < _shoppingCartArray.count; i++) {
            
            dishesList *temp = _shoppingCartArray[i];
            if ([temp.contentName isEqualToString:model.contentName]) {
                model = temp;
            }
        }
        
        cell.model = model;

        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 201) {
        return 45;
    } else {
    
        return 80;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 201) {
        return _takeOutListRootModel.takeOutList.count;
    } else {
        if (_takeOutListRootModel.takeOutList.count > 0) {
            NSArray *temp = [NSArray arrayWithArray:_takeOutListRootModel.takeOutList[_listIndex][@"dishesList"]];
            return temp.count;
        }
        return 0;
    }
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_takeOutListRootModel == nil) {
        [self chrysanthemumOpen];
        [self close];
    }
}

@end
