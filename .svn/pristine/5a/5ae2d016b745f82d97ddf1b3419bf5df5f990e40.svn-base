//
//  PRJ_ActivityViewController.m
//  ChillingAmend
//
//  Created by svendson on 14-12-19.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "PRJ_ActivityViewController.h"
#import "ActivityDetailViewController.h"
#import "LoginViewController.h"
#import "ActivityListTableViewCell.h"
#import "ActivityListModel.h"

@interface PRJ_ActivityViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet    UITableView     *myTableView;
@property (nonatomic, strong)           NSMutableArray  *activityArray; // 活动数组

@end

@implementation PRJ_ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationBarWithState:1 andIsHideLeftBtn:YES andTitle:@"椒点活动"];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _activityArray = [[NSMutableArray alloc] init];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //设置底部toolBar的显示
    [self.appDelegate.homeTabBarController showTabBarAnimated:YES];
    //加载网址
    [self dataRequest];
}

/*页面即将消失的时候进入的方法
 */
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}
#pragma mark dataRequest
- (void) dataRequest
{
    [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI activityList]];
    [self showMsg:nil];
}

#pragma mark GCRequestDelegate
- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    [self hide];
    NSMutableDictionary *dict = [aString JSONValue];
    NSLog(@"activityList = %@", aString);
    if ( !dict ) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
        return;
    }
    if ([[dict objectForKey:@"code"]isEqual:@"0"]) {
        [_activityArray removeAllObjects];
        NSArray *activityList = dict[@"list"];
        if (activityList.count > 0) {
            for (NSDictionary *activityDic in activityList) {
                ActivityListModel *activityModel = [ActivityListModel getActivityListModelWithDic:activityDic];
                [self.activityArray addObject:activityModel];
            }

            [self.myTableView reloadData];
        }
    } else {
        [self showStringMsg:[dict valueForKey:@"message"] andYOffset:0];
    }
}

- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
     [self hide];
     NSLog(@"%@", aError);
     [self showStringMsg:@"网络连接失败！" andYOffset:0];
}
#pragma mark tableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count = %d", self.activityArray.count);
    return self.activityArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * collectionIndfier = @"collectionIndfier";
    ActivityListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:collectionIndfier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ActivityListTableViewCell" owner:self options:nil] lastObject];
    }
    [cell parseActivityModel:[self.activityArray objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([kkUserId isEqual:@""] || !kkUserId) {
        //去登陆
        LoginViewController *login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        login.viewControllerIndex = 4;
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        [self.navigationController pushViewController:login animated:YES];
    } else {
        // 跳转活动详情页面
        ActivityDetailViewController *activityDetail = [[ActivityDetailViewController alloc] initWithNibName:@"ActivityDetailViewController" bundle:nil];
        ActivityListModel *model = [self.activityArray objectAtIndex:indexPath.row];
        activityDetail.activityUrl = model.activityUrl;
        activityDetail.share_url = model.shareUrl;
        activityDetail.share_content = model.activitySharecontent;
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        [self.navigationController pushViewController:activityDetail animated:YES];
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
