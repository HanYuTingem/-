//  个人奖品
//  PrizeViewController.m
//  ChillingAmend
//
//  Created by 许文波 on 14/12/20.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "PrizeViewController.h"
#import "PrizeTableViewCell.h"
#import "PrizePhoneCheckViewController.h"
#import "PrizeDetailMessageViewController.h"

#define kYOffset 0

@interface PrizeViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray * _prizeDataArray; // 奖品数组
    NSInteger codeTag; // 奖品id
    UILabel *messageLabel; // 没有奖品提示
}

@property (weak, nonatomic) IBOutlet UITableView *tableView; // 奖品列表
@end

@implementation PrizeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 导航栏
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"奖品"];
    // 获取奖品
    [self requestPrizeData];
    // table相关操作
    _prizeDataArray = [[NSMutableArray alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
}

#pragma mark 获取奖品列表
- (void)requestPrizeData
{
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    } else {
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI prizeListUserId:kkUserId]];
        mainRequest.tag = 100;
        [self showMsg:nil];
    }
}

#pragma mark 手机验证
- (void)requestPrizePhoneCheck
{
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    } else {
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI phoneIsValidationUserId:kkUserId]];
        mainRequest.tag = 101;
        [self showMsg:nil];
    }
}

#pragma mark GCRequestDelegate
- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    [self hide];
    NSMutableDictionary *dict = [aString JSONValue];
    if ( !dict ) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
        return;
    }
    switch (mainRequest.tag) {
        case 100: // 奖品信息
            if ([[dict objectForKey:@"code"]isEqual:@"0"]) {
                [_prizeDataArray removeAllObjects];
                if ([[dict objectForKey:@"list"] count] != 0) {
                    for (int i = 0 ; i < [[dict objectForKey:@"list"] count]; i++) {
                        PrizeMessageModel *prizeModel  = [[PrizeMessageModel alloc] init];
                        [prizeModel parse:[[[aString JSONValue] objectForKey:@"list"] objectAtIndex:i]];
                        [_prizeDataArray addObject:prizeModel];
                    }
                    [_tableView reloadData];
                } else {
                    // 奖品为0
                    [self showStringMsg:@"没有奖品" andYOffset:kYOffset];
                }
            } else {
                [self showStringMsg:[dict objectForKey:@"message"] andYOffset:kYOffset];
            }
            break;
        case 101: // 手机验证
            if ([dict[@"code"] isEqual:@"0"]) { // 手机未验证
                PrizePhoneCheckViewController *phoneCheck = [[PrizePhoneCheckViewController alloc] init];
                phoneCheck.prizeId = [[_prizeDataArray objectAtIndex:codeTag] prizeId];
                [self.navigationController pushViewController:phoneCheck animated:YES];
            } else {
                // 跳转奖品详情
                PrizeDetailMessageViewController *prizeDetail = [[PrizeDetailMessageViewController alloc] init];
                prizeDetail.prizeId = [[_prizeDataArray objectAtIndex:codeTag] prizeId];
                [self.navigationController pushViewController:prizeDetail animated:YES];
            }
            break;
        default:
            break;
    }
}

- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self hide];
    NSLog(@"%@", aError);
    [self showStringMsg:@"网络连接失败！" andYOffset:kYOffset];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _prizeDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * prizeIndfier = @"prizeIndfier";
    
    PrizeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:prizeIndfier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PrizeTableViewCell" owner:self options:nil] lastObject];
    }
    [cell parseWithPrizeModel:[_prizeDataArray objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 109;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 手机验证
//    [self requestPrizePhoneCheck];
    codeTag = indexPath.row;
    // 跳转奖品详情
    PrizeDetailMessageViewController *prizeDetail = [[PrizeDetailMessageViewController alloc] init];
    prizeDetail.prizeId = [[_prizeDataArray objectAtIndex:codeTag] prizeId];
    [self.navigationController pushViewController:prizeDetail animated:YES];
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
