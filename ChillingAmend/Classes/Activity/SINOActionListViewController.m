//
//  SINOActionListViewController.m
//  LANSING
//
//  Created by yll on 15/7/20.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "SINOActionListViewController.h"
#import "SINOActionListTableViewCell.h"
#import "SINOActionDetailViewController.h"
#import "CommomListModel.h"
#import "ActionListModel.h"
#import "LoginViewController.h"
//#import "NavViewController.h"
#import "MJRefresh.h"
#import "HTTPClientAPI.h"

@interface SINOActionListViewController ()
{
    __weak IBOutlet UILabel *navLineLabel;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}

@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic, strong) ActionListModel *actionListModel;
@property (nonatomic, assign) NSInteger  currentPage;//判断当前页数
@property (nonatomic, strong) NSMutableArray *listArray; //数组


@end

@implementation SINOActionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listArray = [[NSMutableArray alloc]initWithCapacity:1];
//    [self.bar addSubview:navLineLabel];
    
    // Do any additional setup after loading the view from its nib.
//    titleButton.frame = CGRectMake((KProjectScreenWidth - titleButton.width)/2, titleButton.top, titleButton.width, titleButton.height);
//    [titleButton setTitle:@"活动列表" forState:UIControlStateNormal];
    [self setNavigationBarWithState:1 andIsHideLeftBtn:YES andTitle:@"活动列表"];
    self.listTableView.frame = CGRectMake(0, self.bar.frame.size.height, ScreenWidth, ScreenHeight - self.bar.frame.size.height);
    
#pragma mark==============********//userId: 用户id，对应各自项目中存的,自行替换
    NSString *userId;
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:usernameMessageJava];
    userId = [dic objectForKey:@"id"];
   
    self.currentPage = 1;
    [mainRequest requestHttpWithPost:[NSString stringWithFormat:@"%@%@",Http,SINOALlActionList] withDict:[HTTPClientAPI getAllListOfAllActivitiesFormsize:ActionSize page:[NSString stringWithFormat:@"%ld",(long)self.currentPage]]];
    
    // 3.集成刷新控件
    // 3.1.下拉刷新
    [self addHeader];
    
    // 3.2.上拉加载更多
    [self addFooter];
    
    //孙瑞 2015.9.9 增加风火轮
    
    [self showMsg:nil];
    
    //代码结束
}

- (void)addFooter
{
    __unsafe_unretained SINOActionListViewController *vc = self;
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.listTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        vc.currentPage++;
        if (![GCUtil connectedToNetwork]) {
            
            [self hide];
            [self showStringMsg:@"网络连接失败" andYOffset:0];
            [vc doneWithView:_footer];
        }
        else if (vc.currentPage <= [vc.actionListModel.pageCount integerValue]) {
            NSLog(@"===========%ld",(long)vc.currentPage);
            [mainRequest requestHttpWithPost:[NSString stringWithFormat:@"%@%@",Http,SINOALlActionList] withDict:[HTTPClientAPI getAllListOfAllActivitiesFormsize:ActionSize page:[NSString stringWithFormat:@"%ld",(long)vc.currentPage]]];
            [vc performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0];
        }else{
//            [vc showMsg:@"没有更多数据"];
            [vc showStringMsg:@"没有更多数据" andYOffset:0];
            [vc doneWithView:_footer];
        }
        
    };
    _footer = footer;
}

- (void)addHeader
{
    __unsafe_unretained SINOActionListViewController *vc = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.listTableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        self.currentPage = 1;
        
        if (![GCUtil connectedToNetwork]) {
        
            [self showStringMsg:@"网络连接失败" andYOffset:0];
            
        }
        // 进入刷新状态就会回调这个Block
        [mainRequest requestHttpWithPost:[NSString stringWithFormat:@"%@%@",Http,SINOALlActionList] withDict:[HTTPClientAPI getAllListOfAllActivitiesFormsize:ActionSize page:[NSString stringWithFormat:@"%ld",(long)self.currentPage]]];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [vc performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0.1];
        
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

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
//    // 刷新表格
//    [self.listTableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

-(void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    aString = [aString stringByReplacingOccurrencesOfString:@"null"withString:@"\"\""];
    NSMutableDictionary *dict=[aString JSONValue];
    [self hide];
    if (dict) {
        if ([[dict objectForKey:@"code"] intValue] == 0) {
            self.actionListModel = [ActionListModel initWithMyActionListModelInforActionListWithJSONDic:dict];
            if (self.currentPage == 1) {
                [self.listArray removeAllObjects];
//                [self doneWithView:_header];
            }else if (self.currentPage > 1){
//                [self doneWithView:_footer];
            }
            [self.listArray addObjectsFromArray:self.actionListModel.listArray];
            // 刷新表格
            [self.listTableView reloadData];

        }else{
            switch ([[dict objectForKey:@"code"] intValue]) {
                case 100:{
                    [self showStringMsg:@"用户名不存在!" andYOffset:0];
                    break;
                }
                case 102:{
                    [self showStringMsg:@"密码错误!" andYOffset:0];
                    break;
                }
                case 103:{
                    [self showStringMsg:@"没有登录平台权限!" andYOffset:0];
                    break;
                }
                case 203:{
                    [self showStringMsg:@"系统异常!" andYOffset:0];
                    break;
                }
                case 2:{

                    [self showStringMsg:@"用户锁定!" andYOffset:0];
                    break;
                }
                    
                default:{
                    [self showStringMsg:[dict objectForKey:@"message"] andYOffset:0];
                    break;
                }
            }
            if (self.currentPage > 1){
                self.currentPage--;
            }
            
        }
    }else{
        [self showStringMsg:@"服务器去月球了!" andYOffset:0];
        if (self.currentPage > 1){
            self.currentPage--;
        }
    }
    
}

-(void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
//    [self showMsg:@"亲，网络不顺畅!"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"listCell";
    SINOActionListTableViewCell *listCell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if(listCell == nil){
        listCell = [[[NSBundle mainBundle] loadNibNamed:@"SINOActionListTableViewCell" owner:nil options:nil] lastObject];
    }
    CommomListModel *commomModel = self.listArray[indexPath.row];
    [listCell.actionListImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.actionListModel.img_urlToList,commomModel.list_url]]placeholderImage:[UIImage imageNamed:@""]];
    listCell.listTitleLable.text = [NSString stringWithFormat:@" %@",commomModel.name];
    if ([commomModel.active_status integerValue] == 3) {
//        [self initActionEndViewToView:listCell];
        listCell.bgView.hidden = NO;
//        listCell.userInteractionEnabled = NO;
        listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        listCell.bgView.hidden = YES;
        listCell.userInteractionEnabled = YES;
    }
    return listCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 212;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommomListModel *commomModel = self.listArray[indexPath.row];
    if ([commomModel.active_status integerValue] == 3) {
        [self showStringMsg:@"活动已结束" andYOffset:0];
    }else{
        NSDictionary *dic = APPLICATION == 1?kkNickDicJava:kkNickDicPHP;
        if ([[dic objectForKey:@"id"] intValue] < 2) {
            LoginViewController *loginPublic = [[LoginViewController alloc]init];
            loginPublic.viewControllerIndex = 3;
            [self.navigationController pushViewController:loginPublic animated:YES];
        }else{
            SINOActionDetailViewController *detailVC = [[SINOActionDetailViewController alloc]init];
            
            
#pragma mark==============********//userId: 用户id，对应各自项目中存的,自行替换
            NSString *userId,*userName;
            NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:usernameMessagePHP];
            userId = [dic objectForKey:@"id"];
            userName = [dic objectForKey:@"user_name"];
            
            
            NSString *actionId = commomModel.actionId;
            
            detailVC.imageUrl = [NSString stringWithFormat:@"%@%@",self.actionListModel.img_urlToList,commomModel.list_url];
            detailVC.urlStr = [NSString stringWithFormat:@"%@?product_id=%@&id=%@&user_name=%@&user_id=%@",self.actionListModel.active_url,LOGOAction,actionId,userName,userId];
            detailVC.shareContent = commomModel.share_content;
            detailVC.shareTitle = commomModel.name;
            detailVC.actionId = commomModel.actionId;
            detailVC.type = commomModel.type;
            [self.navigationController pushViewController:detailVC animated:YES];
            
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

////活动结束提醒View
//- (void) initActionEndViewToView:(SINOActionListTableViewCell *)cell{
//    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, cell.width -20, cell.height-10)];
//    bgView.backgroundColor = [KOneFourNineColor colorWithAlphaComponent:0.6];
//    CAShapeLayer *styleLayer = [CAShapeLayer layer];
//    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)cornerRadii:CGSizeMake(5.0, 5.0)];
//    styleLayer.path = shadowPath.CGPath;
//    bgView.layer.mask = styleLayer;
//    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(bgView.width-36, 0, 36, 36)];
//    imageV.image = [UIImage imageNamed:@"圆角矩形 412 拷贝 3.png"];
//    [bgView addSubview:imageV];
//    [cell addSubview:bgView];
//}
////
//- (void)removeEndView{
//    
//}

- (void)viewWillAppear:(BOOL)animated
{
    //设置底部toolBar的显示
    [self.appDelegate.homeTabBarController showTabBarAnimated:YES];
    [self.appDelegate.homeTabBarController.homeTabBar onKnowledgeButtonClicked:nil];
    
    if (![GCUtil connectedToNetwork]) {
        
        [self hide];
        [self showStringMsg:@"网络连接失败" andYOffset:0];
        
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
