//
//  PRJ_VideoDetailViewController.m
//  ChillingAmend
//
//  Created by svendson on 14-12-23.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "PRJ_VideoListViewController.h"
#import "PRJ_VideoListTableViewCell.h"
#import "UITapGestureRecognizer+KTapGesture.h"
#import "PRJ_VideoDetailViewController.h"
#import "PRJ_VideoListModel.h"
#import "TimeStringTransform.h"
#import "LoginViewController.h"

@interface PRJ_VideoListViewController ()<UITableViewDataSource , UITableViewDelegate>
{
    int page ;
}
/*
 *myTableView  列表展示
 *listArray    列表内容
 */
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation PRJ_VideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"推荐视频"];
    
    self.listArray = [[NSMutableArray alloc]init];
    
    //注册cell
    [self.myTableView registerNib:[UINib nibWithNibName:@"PRJ_VideoListTableViewCell" bundle:nil] forCellReuseIdentifier:@"detail"];
    
    page = 1;
    
    [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI videoListUserId:kkUserCenterId andSize:@"10" andDay:self.videoTime andpage:[NSString stringWithFormat:@"%d",page]]];
    [self showMsg:nil];
    
    //刷新加载
    [self addHeader];
    [self addFooter];
}

#pragma mark - 刷新
- (void)addHeader
{
    __unsafe_unretained PRJ_VideoListViewController *vc = self;
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.myTableView;
    
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 进入刷新状态就会回调这个Block
        //        isEndLoadData = NO;
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [vc performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
    };
    
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        page = 1;
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI videoListUserId:kkUserCenterId andSize:@"10" andDay:self.videoTime andpage:[NSString stringWithFormat:@"%d",page]]];
        [self showMsg:nil];
        
    };
    _header = header;
}

- (void)addFooter
{
    __unsafe_unretained PRJ_VideoListViewController *vc = self;
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.myTableView;
    
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [vc performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
    };
    
    footer.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        page ++;
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI videoListUserId:kkUserCenterId andSize:@"10" andDay:self.videoTime andpage:[NSString stringWithFormat:@"%d",page]]];
        [self showMsg:nil];
        
    };
    _footer = footer;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

#pragma mark ---------------tableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"PRJ_VideoListTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"detail"];
    }
    
    PRJ_VideoListTableViewCell *myCell = [self.myTableView dequeueReusableCellWithIdentifier:@"detail"];
    myCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    myCell.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1];
    
    for (UIView *subview in myCell.cellView.subviews) {
        [subview removeFromSuperview];
    }
    
    myCell.dateLabel.text = self.videoTime;
    
    for ( int i = 0 ; i < self.listArray.count ; i++ ) {
        
        PRJ_VideoListModel *model = self.listArray[i];
        
        UIView *lanMuView = [[UIView alloc]initWithFrame:CGRectMake(10 + (i % 2) * ( (300) / 2 + 5),  10 + (i / 2) * 130, 300 / 2 , 120)];
        lanMuView.userInteractionEnabled = YES;
        [lanMuView setExclusiveTouch:YES];
        lanMuView.tag = i;
        
        //视屏图片
        UIImageView *lanMuImageView = [[UIImageView alloc]init];
        //去除多个button同事点击的效果
        [lanMuImageView setExclusiveTouch:YES];
        lanMuImageView .contentMode =  UIViewContentModeScaleAspectFill;
        lanMuImageView.clipsToBounds  = YES;
        lanMuImageView.userInteractionEnabled = YES;
        [lanMuImageView setImageWithURL:[NSURL URLWithString:model.videoImage] placeholderImage:[UIImage imageNamed:@"defaultimgvideo_list_img1.png"]];
        
        lanMuImageView.frame = CGRectMake(0, 0, 145, 79);
        
        //底部黑色透明背景
        UIImageView *bootomBg = [[UIImageView alloc]init];
        bootomBg.image = [UIImage imageNamed:@"videohome_gallery_bg.png"];
        bootomBg.frame = CGRectMake(0, 64, 145, 15);
        
        //底部金钱图片
        UIImageView *moneyView = [[UIImageView alloc]init];
        moneyView.image = [UIImage imageNamed:@"videolist_list_ico.png"];
        moneyView.frame = CGRectMake(7, 67, 12, 10);
        
        //金币数量
        UILabel *mingChengLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, 64, 75, 15)];
        mingChengLabel.textColor = [UIColor whiteColor];
        mingChengLabel.backgroundColor = [UIColor clearColor];
        mingChengLabel.font = [UIFont systemFontOfSize:10.0];
        
        mingChengLabel.text = model.videoJiFen;
        mingChengLabel.textAlignment = NSTextAlignmentLeft;
        
        //视屏时长
        UILabel *timeChengLabel = [[UILabel alloc]initWithFrame:CGRectMake(145 - 81, 64, 75, 15)];
        timeChengLabel.textColor = [UIColor whiteColor];
        timeChengLabel.backgroundColor = [UIColor clearColor];
        timeChengLabel.font = [UIFont systemFontOfSize:10.0];
        
//        NSString *time = [TimeStringTransform getTimeString:model.VideoDuration];
//        NSArray *timeARR = [time componentsSeparatedByString:@" "];
        timeChengLabel.text = model.VideoDuration;
        timeChengLabel.textAlignment = NSTextAlignmentRight;
        
        // 文字简介
        UILabel *TitlelLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 85, 145, 18)];
        TitlelLabel.backgroundColor = [UIColor clearColor];
        TitlelLabel.font = [UIFont systemFontOfSize:13.0];
        TitlelLabel.text = model.videoName;
        TitlelLabel.textAlignment = NSTextAlignmentLeft;
        
        // 副标题文字简介
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 101, 145, 18)];
        detailLabel.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.font = [UIFont systemFontOfSize:11.0];
        detailLabel.text = model.videosubTitle;
        detailLabel.textAlignment = NSTextAlignmentLeft;
        
        [lanMuView addSubview:lanMuImageView];
        [lanMuView addSubview:bootomBg];
        [lanMuView addSubview:moneyView];
        [lanMuView addSubview:timeChengLabel];
        [lanMuView addSubview:TitlelLabel];
        [lanMuView addSubview:detailLabel];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToVideodetaiViewController:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        tap.tag = model.videoID;
        [lanMuImageView addGestureRecognizer:tap];
        
        [lanMuView addSubview:mingChengLabel];
        [myCell.cellView addSubview:lanMuView];
        
        [self setCellBagImageHeightAndCellViewHeightWithCell:myCell];
        
    }
    return myCell;
}

- (void)setCellBagImageHeightAndCellViewHeightWithCell:(PRJ_VideoListTableViewCell *)myCell
{
//    if (self.listArray.count % 2 == 0) {
//            myCell.cellView.frame = CGRectMake(myCell.cellView.frame.origin.x, myCell.cellView.frame.origin.y, myCell.cellView.frame.size.width,  self.listArray.count / 2 * 133 + (self.listArray.count / 2 ) * 10);
//            myCell.cellBgImageView.frame = CGRectMake(myCell.cellBgImageView.frame.origin.x, myCell.cellBgImageView.frame.origin.y, myCell.cellBgImageView.frame.size.width, self.listArray.count / 2 * 160 + (self.listArray.count / 2 ) * 10 + 34);
//    } else {
//            myCell.cellView.frame = CGRectMake(myCell.cellView.frame.origin.x, myCell.cellView.frame.origin.y, myCell.cellView.frame.size.width,  (self.listArray.count  / 2 + 1) * 133 + (self.listArray.count / 2 ) * 10);
//            myCell.cellBgImageView.frame = CGRectMake(myCell.cellBgImageView.frame.origin.x, myCell.cellBgImageView.frame.origin.y, myCell.cellBgImageView.frame.size.width, (self.listArray.count  / 2 + 1) * 160 + (self.listArray.count / 2 ) * 10 + 34);
//    }
}

- (void)goToVideodetaiViewController:(UITapGestureRecognizer *)tap
{
    if ([kkUserId isEqual:@""] || !kkUserId) {
        //去登陆
        LoginViewController *login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        login.viewControllerIndex = 4;
        [self.navigationController pushViewController:login animated:YES];
    } else {
        PRJ_VideoDetailViewController *detail = [[PRJ_VideoDetailViewController alloc]initWithNibName:@"PRJ_VideoDetailViewController" bundle:nil];
        detail.videoID = tap.tag;
        [self.navigationController pushViewController:detail animated:YES];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listArray.count % 2 == 0) {
        float height = self.listArray.count / 2 * 140 + (self.listArray.count / 2 ) * 10;
        if (height > (SCREENHEIGHT - 64)) {
            return height - 5 ;
        } else {
            return (SCREENHEIGHT - 64) - 5;
        }
    } else {
        float height = (self.listArray.count  / 2 + 1) * 135 + (self.listArray.count / 2 + 1) * 10;
        if (height > (SCREENHEIGHT - 64)) {
            return height - 5 ;
        } else {
            return (SCREENHEIGHT - 64) - 5;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    [self hide];
    
    NSDictionary *dic = [aString JSONValue];
    
    NSLog(@"-------------%@",aString);
    if (dic) {
        if ([dic[@"code"] integerValue] == 0) {
            NSArray *lists = dic[@"result"];
            if (page == 1) {
                [self.listArray removeAllObjects];
            }
            if (lists.count > 0) {
                for (NSDictionary *listDic in lists) {
                    PRJ_VideoListModel *model = [PRJ_VideoListModel getVideoListModelWithDic:listDic];
                    [self.listArray addObject:model];
                }
            }
            [self.myTableView reloadData];
        } else  if([dic[@"code"] integerValue] == 1) {
            [self showStringMsg:@"没有更多视频了" andYOffset:0];
        } else {
            [self showStringMsg:dic[@"message"] andYOffset:0];
        }
    } else {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    }
}

- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self hide];
    [self showStringMsg:@"网络连接失败" andYOffset:0];
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
