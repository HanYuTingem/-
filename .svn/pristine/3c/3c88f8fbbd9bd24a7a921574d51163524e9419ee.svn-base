//
//  CouponViewController.m
//  PRJ_NiceFoodModule
//
//  Created by 张恭豪 on 15/8/2.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "CouponViewController.h"
#import "CouponTableViewCell.h"
#import "ZGHCouponModel.h"

@interface CouponViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *couponList;

@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _couponList = [[NSMutableArray alloc] init];
    
    titleButton.hidden = NO;
    [titleButton setTitle:@"可用优惠券" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
//    [self addUI];
    [self requestData];
    
}

- (void)requestData{
    NSDictionary *par = [Parameter getCanUseCouponListWithOwnerId:_ownerId];
    
    [AFRequest GetRequestWithUrl:NiceFood_Url parameters:par andBlock:^(NSDictionary *Datas, NSError *error) {
        if (error == nil) {
            NSArray *arr = [Datas objectForKey:@"couponList"];
            
            for (NSDictionary *dic in arr) {
                ZGHCouponModel *model = [ZGHCouponModel objectWithKeyValues:dic];
                [_couponList addObject:model];
            }
            [self addUI];
        }
    }];
}

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
}


#pragma mark -- tableView的代理

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击事件
    
    ZGHCouponModel *model = _couponList[indexPath.row];
    
    CGFloat money = 0;
    if (model.price) {
        money = [model.price floatValue];
    }
    
    if (money <= [_totalprice floatValue]) {
        [self chrysanthemumOpen];
        [self close];
        NSDictionary *par = [Parameter getOrderPriceByCouponWithCouponId:model.couponId couponCodeId:model.couponCodeId orderPrice:_totalprice];
        
        [AFRequest GetRequestWithUrl:NiceFood_Url parameters:par andBlock:^(NSDictionary *Datas, NSError *error) {
            if (error == nil) {
                
                [self chrysanthemumClosed];
                [self open];
                
                NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
                [temp setObject:model.couponId forKey:@"couponId"];
                [temp setObject:model.couponCodeId forKey:@"couponCodeId"];
                [temp setObject:Datas[@"actualPrice"] forKey:@"actualPrice"];
                [temp setObject:Datas[@"salePrice"] forKey:@"salePrice"];
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"UseCoupon" object:nil userInfo:temp];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    } else {
        [self showMsg:@"订单金额不符合使用条件"];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CouponTableViewCell *cell = [CouponTableViewCell cellWithTableView:tableView];
    ZGHCouponModel *model = _couponList[indexPath.row];
    cell.model = model;
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _couponList.count;//数组count
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;//cell高度
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
