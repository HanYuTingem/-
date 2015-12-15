//
//  LuckilyGordenTableViewController.m
//  ChillingAmend
//
//  Created by svendson on 14-12-19.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "LuckilyGordenTableViewController.h"
#import "LucklyGordenTableViewCell.h"
#import "LoginViewController.h"
#import "ZHGuaGuaLeViewController.h"
#import "BLuckyguyViewController.h"
#import "YaoYiYaoViewController.h"
#import "YNLittleBirdViewController.h"
#import "YNAcceptGoldViewController.h"
#import "MJRefresh.h"

@interface LuckilyGordenTableViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    NSArray *gameNames;    //游戏名称
    NSArray *gameIntroduces;    //游戏简介
    NSInteger isCheck; // 是否审核
    
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}
/*
 *myTableView    列表
 *headImages     游戏展示图片
 */
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSArray *headImages;

@end

@implementation LuckilyGordenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    isCheck = 0;
    self.headImages = [NSArray arrayWithObjects:@"game-list-icon-default1.png",@"game-list-icon-default2.png",@"game-list-icon-default3.png",@"game-list-icon-default4.png",@"game-list-icon-default5.png", nil];
    gameNames = [NSArray arrayWithObjects:@"幸运转盘",@"刮刮乐",@"摇一摇",@"小鸟快飞",@"接金币", nil];
    [self setNavigationBarWithState:1 andIsHideLeftBtn:YES andTitle:@"幸运乐园"];
    gameIntroduces = [NSArray arrayWithObjects:@"幸运转盘，惊喜连连",@"好运多多，机会多多，拼手气赢大奖",@"关注精彩节目，积极参与有奖互动",@"挑战自我，让你的小鸟飞的更高!",@"土豪！快来接住你的钱啊！", nil];
    
    //注册cell
    [self.myTableView registerNib:[UINib nibWithNibName:@"LucklyGordenTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    // 列表请求
    [self requestGameData];
    
    // 3.集成刷新控件
    // 3.1.下拉刷新
    [self addHeader];
    
//    // 3.2.上拉加载更多
//    [self addFooter];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    if (mainRequest) {
        [mainRequest cancelRequest];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    //设置底部toolBar的显示
    [self.appDelegate.homeTabBarController showTabBarAnimated:YES];
    [super viewWillAppear:YES];

    // 列表请求
    [self requestGameData];
}

- (void)addFooter
{

    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.myTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        if (![GCUtil connectedToNetwork]) {
            
            [self hide];
            [self showStringMsg:@"网络连接失败" andYOffset:0];
        }
        else {
            [self requestGameData];
        }
        [refreshView endRefreshing];
    };
    _footer = footer;
}

- (void)addHeader
{
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.myTableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        
        // 进入刷新状态就会回调这个Block
        if (![GCUtil connectedToNetwork]) {
            
            [self showStringMsg:@"网络连接失败" andYOffset:0];
            [refreshView endRefreshing];
        }
        else {
            [self requestGameData];
        }
        //        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        // 刷新完毕就会回调这个Block
        //        NSLog(@"%@----刷新完毕", refreshView.class);
    };
    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        // 控件的刷新状态切换了就会调用这个block
        switch (state) {
            case MJRefreshStateNormal:
                //                NSLog(@"%@----切换到：普通状态", refreshView.class);
                break;
                
            case MJRefreshStatePulling:
                //                NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
                break;
                
            case MJRefreshStateRefreshing:
                //                NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
                break;
            default:
                break;
        }
    };
    [header beginRefreshing];
    _header = header;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 接口请求
- (void) requestGameData
{
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    } else {
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI gameList]];
    }
}

#pragma mark GCRequestDelegate
- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    NSLog(@"gameList = %@", aString);
    [self hide];
    NSMutableDictionary *dict = [aString JSONValue];
    if ( !dict ) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
        return;
    }
    
    NSString *status = [dict objectForKey:@"status"];
    NSLog(@"status = %@", status);
    if ([status intValue] == 1) { // 审核中。。
        isCheck = 3;
    } else {
        isCheck = 5;
    }
    [self.myTableView reloadData];
    [_header endRefreshing];
}

- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self hide];
    NSLog(@"%@", aError);
    [self showStringMsg:@"网络连接失败！" andYOffset:0];
    [_header endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return isCheck;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LucklyGordenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (!cell) {
        cell = [[LucklyGordenTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.headImageView.image = [UIImage imageNamed:[self.headImages objectAtIndex:indexPath.row]];
    cell.gameNameLabel.text = gameNames[indexPath.row];
    cell.introduceLabel.text = gameIntroduces[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    [mainRequest cancelRequest];
    
    if ([kkUserId isEqual:@""] || !kkUserId) { // 登录
        // 去登陆
        LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        login.viewControllerIndex = 4;
        [self.navigationController pushViewController:login animated:YES];
    } else {
        switch (indexPath.row) {
            case 0:
            {
                BLuckyguyViewController *BLuckyguyVC = [[BLuckyguyViewController alloc] initWithNibName:@"BLuckyguyViewController" bundle:nil];
                [self.navigationController pushViewController:BLuckyguyVC animated:YES];
            }
                break;
            case 1:
            {
                ZHGuaGuaLeViewController * scratchViewControl = [[ZHGuaGuaLeViewController alloc] initWithNibName:@"ZHGuaGuaLeViewController" bundle:nil];
                [self.navigationController pushViewController:scratchViewControl animated:YES];
            }
                break;
            case 2:
            {
                YaoYiYaoViewController * waveViewControl = [[YaoYiYaoViewController alloc] initWithNibName:@"YaoYiYaoViewController" bundle:nil];
                [self.navigationController pushViewController:waveViewControl animated:YES];
            }
                break;
            case 3:
            {
              // 小鸟
                YNLittleBirdViewController *littleBird  = [[YNLittleBirdViewController alloc] initWithNibName:@"YNLittleBirdViewController" bundle:nil];
                [self.navigationController pushViewController:littleBird animated:YES];
            }
                break;
            case 4:
            {
              // 接金币
                YNAcceptGoldViewController *acceptGold = [[YNAcceptGoldViewController alloc] initWithNibName:@"YNAcceptGoldViewController" bundle:nil];
                [self.navigationController pushViewController:acceptGold animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
    [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
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
