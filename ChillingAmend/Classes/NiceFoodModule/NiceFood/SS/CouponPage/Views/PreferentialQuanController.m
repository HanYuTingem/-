//
//  PreferentialQuanController.m
//  MyNiceFood
//
//  Created by liujinhe on 15-7-15.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "PreferentialQuanController.h"
#import "FoodInfoBaseView.h"
#import "CouponDetailViewController.h"
#import "ProMoreViewCell.h"
#import "PreferNiceViewCell.h"
#import "ProtiketModel.h"
#import "PreTicketOneCell.h"
@interface PreferentialQuanController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *preferTabView;
@end

@implementation PreferentialQuanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatTableView];
    self.preferTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)creatTableView
{
//    self.navigationItem.title = @"更多优惠";
    titleButton.hidden = NO;
    [titleButton setTitle:@"更多优惠" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    _preferTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _preferTabView.delegate = self;
    _preferTabView.dataSource = self;
    [_preferTabView registerClass:[PreTicketOneCell class] forCellReuseIdentifier:@"PreTicketOneCell"];
    [self.view addSubview:_preferTabView];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _tem;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"PreTicketOneCell";
    
    PreTicketOneCell *cell = [tableView dequeueReusableCellWithIdentifier:
                              identifier];
    if (cell == nil) {
        cell = [[PreTicketOneCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:identifier];
    }
    ProtiketModel *model = [[ProtiketModel  alloc] initWithDic:_couponListArray[indexPath.section]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell reshCellMode:model andName:_nameShop];
    
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    PreferenTicktcoController * couponVC = [[PreferenTicktcoController alloc]init];
    //                CouponModel *model = _dataArr[indexPath.row];
    //                couponVC.couponId = [NSString stringWithFormat:@"%ld",model.couponId];
    //                couponVC.proIden = _proIden;
    //                NSString *valideTime = [NSString stringWithFormat:@"有效日期:%@至%@",model.validBeginTime,model.validEndTime];
    //                couponVC.valideTime = valideTime;
    //                couponVC.shopName = model.merchantName;
    //                couponVC.oId = _oId;
    CouponDetailViewController * couponVC = [[CouponDetailViewController alloc]init];
    ProtiketModel *model = [[ProtiketModel  alloc] initWithDic:_couponListArray[indexPath.section]];
    couponVC.couponId = model.couponId;
    couponVC.proIden = _proIden;
    couponVC.shopName = _nameShop;
    couponVC.oId = _oId;
    couponVC.couponName = model.couponName;
    couponVC.ownerId = self.ownerId;
//    couponVC.transPhone = PhoneNumber;
    /*NSDictionary *parameter = @{@"oId":UserId,@"couponId":_couponId,@"phone":PhoneNumber,@"ownerId":self.ownerId};*/
    
    
    
    [self.navigationController pushViewController:couponVC animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1; // you can have your own choice, of course

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor lightGrayColor];
    return headerView;
}





@end
