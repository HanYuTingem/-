//
//  PRJ_RecommendViewController.m
//  ChillingAmend
//
//  Created by svendson on 14-12-19.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "PRJ_RecommendViewController.h"
#import "PRJ_RuleViewController.h"
#import "ImagePlayerView.h"
#import "UITapGestureRecognizer+KTapGesture.h"
#import "PRJ_VideoListViewController.h"
#import "PRJ_VideoDetailViewController.h"
#import "PRJ_VideoListModel.h"
#import "PRJ_VideoShouYeBannerModel.h"
#import "TimeStringTransform.h"
#import "PRJ_VideoShouYeListTableViewCell.h"
#import "PRJ_BannerTableViewCell.h"
#import "LoginViewController.h"
@interface PRJ_RecommendViewController ()<UITableViewDelegate, UITableViewDataSource, ImagePlayerViewDelegate>

{
    NSMutableArray *listArray;  //推荐视图集合
    NSArray *detailArr;          //每天详细视屏
    int page ;       //上拉加载当前页数
}

/*
 *myTableView   展示列表
 *noSignalView   无网络页面
 *bannerViewsArray    轮播图集合
 *bannerModelsArray   轮播图信息
 *dateArr     不同时间下的视屏集合
 *timeArr     显示时间
 */
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIView *noSignalView;
@property (nonatomic, strong) NSMutableArray *bannerViewsArray;
@property (nonatomic, strong) NSMutableArray *bannerModelsArray;
@property (nonatomic, strong) NSMutableArray *dateArr;
@property (nonatomic, strong) NSMutableArray *timeArr;
@property (nonatomic, strong) PRJ_BannerTableViewCell *bannerCell;
@end

@implementation PRJ_RecommendViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.bannerModelsArray = [[NSMutableArray alloc] init];
    self.bannerViewsArray = [[NSMutableArray alloc] init];
    listArray = [[NSMutableArray alloc] init];
    self.dateArr = [[NSMutableArray alloc] init];
    self.timeArr = [[NSMutableArray alloc] init];
    
    int netType = [GCUtil getNetworkTypeFromStatusBar];
    if ( netType != 0 ) {
        [self.view addSubview: self.myTableView];
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI videoHomepageUserId:kkUserCenterId andSize:@"6" andPeriods:@"5"]];
        mainRequest.tag = 100;
        [self showMsg:nil];
    } else {
        [self.view addSubview: self.noSignalView];
        self.noSignalView.frame = CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64);
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadDataByClickedView:)];
    [self.noSignalView addGestureRecognizer:tap];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    if ( self.bannerCell) {
        [self.bannerCell.mainScrollView invalidateMyTimer];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"推荐视频"];
    
    UIColor *RightBtnTitleColor = [UIColor colorWithRed:61.0/255 green:66.0/255 blue:69.0/255 alpha:1.0];
    [self addRightBarButtonItemWithImageName:@"" andTargate:@selector(goToRuleVC:) andRightItemFrame:CGRectMake(SCREENWIDTH - 10 - 45, 31, 60, 23) andButtonTitle:@"规则" andTitleColor:RightBtnTitleColor];
    self.rightButton.titleLabel.font   = [UIFont systemFontOfSize:14.0];
    
    page = 1;
    
    //刷新加载
    [self addHeader];
    [self addFooter];
    
}

#pragma mark - 刷新
- (void)addHeader
{
    __unsafe_unretained PRJ_RecommendViewController *vc = self;
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
        listArray = [@[] mutableCopy];
        self.bannerModelsArray = [@[] mutableCopy];
        self.timeArr = [@[] mutableCopy];
        self.dateArr = [@[] mutableCopy];
        page = 1;
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI videoHomepageUserId:kkUserCenterId andSize:@"6" andPeriods:@"5"]];
        mainRequest.tag = 100;
        [self showMsg:nil];
    };
    _header = header;
}

- (void)addFooter
{
    __unsafe_unretained PRJ_RecommendViewController *vc = self;
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.myTableView;
    
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [vc performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
    };
    
    footer.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        page ++;
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI loadingMoreVideoUserId:kkUserCenterId andSize:@"6" andPeriods:@"5" andPage:[NSString stringWithFormat:@"%d",page]]];
        mainRequest.tag = 110;
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

//无网络状态下重新加载数据
- (void)reloadDataByClickedView:(UITapGestureRecognizer *)tap
{
    NSLog(@"------------重新加载");
    int netType = [GCUtil getNetworkTypeFromStatusBar];
    if ( netType == 0 ) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
        return;
    }
    [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI videoHomepageUserId:kkUserCenterId andSize:@"6" andPeriods:@"5"]];
    mainRequest.tag = 100;
    [self showMsg:nil];
}

//规则
- (void)goToRuleVC:(UIButton *)btn
{
    PRJ_RuleViewController *rule = [[PRJ_RuleViewController alloc] initWithNibName:@"PRJ_RuleViewController" bundle:nil];
    [self.navigationController pushViewController:rule animated:YES];
}

#pragma mark ---------------tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return listArray.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        if (listArray.count > 0) {
            NSArray *arr = listArray[section - 1];
            int remainder =  arr.count % 2;
            int integer =  (int)arr.count / 2;
            if (remainder == 1) {
                return integer + 1;
            } else {
                return integer;
            }
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section > 0) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 11, 320, 36)];
        bgView.backgroundColor = [UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1.0];
        
        //头视图背景
        UIImageView *ttView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 46)];
        ttView.image = [UIImage imageNamed:@"content_bg.png"];
        [bgView addSubview:ttView];
        
        UIImageView *topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, -0.5, 320, 1)];
        topLine.image = [UIImage imageNamed:@"content_line_shang.png"];
        [bgView addSubview:topLine];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 320, 1)];
        line.image = [UIImage imageNamed:@"content_line.png"];
        [bgView addSubview:line];
        
        
        UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 2, 14)];
        headImageView.image = [UIImage imageNamed:@"content_img.png"];
        [bgView addSubview:headImageView];
        
        UILabel *dateLabel  = [[UILabel alloc] initWithFrame:CGRectMake(17, 6, 150, 21)];
        dateLabel.font = [UIFont systemFontOfSize:15.0];
        if (self.timeArr.count > 0) {
            dateLabel.text  = self.timeArr[section];
        }
        //        dateLabel.textColor = [UIColor colorWithRed:184.0/255 green:6.0/255 blue:6.0/255 alpha:1.0];
        [bgView addSubview:dateLabel];
        
        if (listArray.count > 0) {
            detailArr = listArray[section - 1];
        }
        
        if (detailArr.count >= 6) {
            UIImageView *accView = [[UIImageView alloc] initWithFrame:CGRectMake(304, 13, 7, 10)];
            accView.image = [UIImage imageNamed:@"content_btn_right.png"];
            [bgView addSubview:accView];
            
            UILabel *moreLabel = [[UILabel alloc] initWithFrame:CGRectMake(278, 11, 24, 15)];
            moreLabel.font = [UIFont systemFontOfSize:12.0];
            moreLabel.textColor = [UIColor colorWithRed:184.0/255 green:6.0/255 blue:6.0/255 alpha:1.0];
            moreLabel.text = @"更多";
            [bgView addSubview:moreLabel];
            
            UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
            //去除多个button同事点击的效果
            [moreButton setExclusiveTouch:YES];
            moreButton.frame = CGRectMake(252, 0, 68, 34);
            [moreButton addTarget:self action:@selector(goToVideoListViewController:) forControlEvents:UIControlEventTouchUpInside];
            moreButton.backgroundColor = [UIColor clearColor];
            moreButton.tag = section;
            [bgView addSubview:moreButton];
        }
        
        return bgView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section > 0) {
        return 46;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    } else {
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.section == 0) {
        
        static NSString *CellIdentifier = @"bannerCell";
        BOOL nibsRegistered = NO;
        if (!nibsRegistered) {
            UINib *nib = [UINib nibWithNibName:@"PRJ_BannerTableViewCell" bundle:nil];
            [self.myTableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        }
        self.bannerCell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        [self setAndAddScrollViewWithCell:self.bannerCell];
        return self.bannerCell;
    } else {
        PRJ_VideoShouYeListTableViewCell *myCell;
        static NSString *CellIdentifier = @"HearTableViewCell";
        BOOL nibsRegistered = NO;
        if (!nibsRegistered) {
            UINib *nib = [UINib nibWithNibName:@"PRJ_VideoShouYeListTableViewCell" bundle:nil];
            [self.myTableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        }
        
        for (UIView *subview in myCell.subviews) {
            [subview removeFromSuperview];
        }
        
        myCell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        myCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        for (UIView *subview in myCell.cellView.subviews) {
            [subview removeFromSuperview];
        }
        
        myCell.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1];
        if (listArray.count > 0) {
            detailArr = listArray[indexPath.section - 1];
            if (detailArr.count > 0) {
                UIView * lanMuView = [self HearTableViewCelladdSubview:0 indexPath:indexPath String:@"4684664+"];
                [myCell.cellView addSubview:lanMuView];
                if (indexPath.row * 2 + 1 >= detailArr.count) {
                } else {
                    UIView * lanMuView = [self HearTableViewCelladdSubview:1 indexPath:indexPath String:@"256564165"];
                    [myCell.cellView addSubview:lanMuView];
                }
            }
        }
        return myCell;
    }
}

- (UIView *)HearTableViewCelladdSubview:(int)tag  indexPath:(NSIndexPath *)indexPath  String:(NSString *)getStr
{
    UIView *lanMuView;
    if (listArray.count > 0) {
        NSArray *details = listArray[indexPath.section - 1];
        PRJ_VideoListModel *model = details[indexPath.row * 2 + tag];
        
        lanMuView  = [[UIView alloc] initWithFrame:CGRectMake(10 + (tag % 2) * ( (300) / 2 +5),  0 , 145 , 115)];
        lanMuView.backgroundColor = [UIColor clearColor];
        [lanMuView setExclusiveTouch:YES];
        lanMuView.tag = tag;
        
        //视屏图片
        UIImageView *lanMuImageView = [[UIImageView alloc] init];
        //去除多个button同事点击的效果
        [lanMuImageView setExclusiveTouch:YES];
        lanMuImageView .contentMode =  UIViewContentModeScaleAspectFill;
        lanMuImageView.clipsToBounds  = YES;
        lanMuImageView.userInteractionEnabled = YES;
        [lanMuImageView setImageWithURL:[NSURL URLWithString:model.videoImage] placeholderImage:[UIImage imageNamed:@"defaultimgvideo_list_img1.png"]];
        lanMuImageView.frame = CGRectMake(0, 0, 145, 79);
        
        //底部黑色透明背景
        UIImageView *bootomBg = [[UIImageView alloc] init];
        bootomBg.image = [UIImage imageNamed:@"videohome_gallery_bg.png"];
        bootomBg.frame = CGRectMake(0, 62, 145, 17);
        
        //底部金钱图片
        UIImageView *moneyView = [[UIImageView alloc] init];
        moneyView.image = [UIImage imageNamed:@"videolist_list_ico.png"];
        moneyView.frame = CGRectMake(7, 66, 12, 10);
        
        //金币数量
        UILabel *mingChengLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 55, 75, 31)];
        mingChengLabel.textColor = [UIColor whiteColor];
        mingChengLabel.backgroundColor = [UIColor clearColor];
        mingChengLabel.font = [UIFont systemFontOfSize:10.0];
        mingChengLabel.text = model.videoJiFen;
        mingChengLabel.textAlignment = NSTextAlignmentLeft;
        
        //视屏时长
        UILabel *timeChengLabel = [[UILabel alloc] initWithFrame:CGRectMake(145 - 81, 55, 75, 31)];
        timeChengLabel.textColor = [UIColor whiteColor];
        timeChengLabel.backgroundColor = [UIColor clearColor];
        timeChengLabel.font = [UIFont systemFontOfSize:10.0];
        timeChengLabel.text = model.VideoDuration;
        timeChengLabel.textAlignment = NSTextAlignmentRight;
        
        // 文字简介
        UILabel *TitlelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 85, 145, 18)];
        TitlelLabel.numberOfLines = 0;
        TitlelLabel.backgroundColor = [UIColor clearColor];
        TitlelLabel.font = [UIFont systemFontOfSize:13.0];
        TitlelLabel.text = model.videoName;
        TitlelLabel.textAlignment = NSTextAlignmentLeft;
        
        // 副标题文字简介
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 101, 145, 18)];
        detailLabel.numberOfLines = 0;
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
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToVideodetaiViewController:)];
        tap.tag = [NSString stringWithFormat:@"%@",model.videoID];
        [lanMuImageView addGestureRecognizer:tap];
        
        [lanMuView addSubview:mingChengLabel];
        return lanMuView;
    }
    return lanMuView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.myTableView) {
        CGFloat sectionHeaderHeight = 60;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

//视屏列表页面
- (void)goToVideoListViewController:(UIButton *)button
{
    PRJ_VideoListViewController *detail = [[PRJ_VideoListViewController alloc] initWithNibName:@"PRJ_VideoListViewController" bundle:nil];
    if (self.timeArr.count > 0) {
        detail.videoTime = self.timeArr[button.tag];
    }
    [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
    [self.navigationController pushViewController:detail animated:YES];
}

//视屏详情页面
- (void)goToVideodetaiViewController:(UITapGestureRecognizer *)tap
{
    if ([kkUserId isEqual:@""] || !kkUserId) {
        //去登陆
        LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        login.viewControllerIndex = 4;
        [self.navigationController pushViewController:login animated:YES];
    } else {
        PRJ_VideoDetailViewController *detail = [[PRJ_VideoDetailViewController alloc] initWithNibName:@"PRJ_VideoDetailViewController" bundle:nil];
        detail.videoID = tap.tag;
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        [self.navigationController pushViewController:detail animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150;
    } else {
        return 125;
    }
}

#pragma mark  ----------顶部轮播图
- (void)setAndAddScrollViewWithCell:(PRJ_BannerTableViewCell *)cell
{
    if (self.bannerModelsArray.count > 0) {
        [cell.mainScrollView initWithCount:self.bannerModelsArray.count delegate:self];
        // adjust pageControl position
        // 修改小圆钮位置
        cell.mainScrollView.hidePageControl = NO;
        cell.mainScrollView.pageControlPosition = ICPageControlPosition_BottomRight;
        cell.mainScrollView.autoScroll = YES;
        NSMutableArray *details = [[NSMutableArray alloc] init];
        if (self.bannerModelsArray.count > 0) {
            for (int i = 0; i < self.bannerModelsArray.count; ++i) {
                PRJ_VideoShouYeBannerModel *model = self.bannerModelsArray[i];
                [details addObject:model.bannerName];
            }
            [cell.mainScrollView openThePageControllAndIsOpenImageDetails:YES andTheDetails:details andState:3] ;
        }
    }
}

#pragma mark - ImagePlayerViewDelegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    if (self.bannerModelsArray.count > 0) {
        NSLog(@"=---------%d",(int)index);
        if (index == 0) {
            PRJ_VideoShouYeBannerModel *model = self.bannerModelsArray[self.bannerModelsArray.count -1];
            [imageView setImageWithURL:[NSURL URLWithString:model.bannerImage] placeholderImage:[UIImage imageNamed:@"defaultimgmall_banner_bg_img.png"]];
        } else if (index == self.bannerModelsArray.count + 1) {
            PRJ_VideoShouYeBannerModel *model = self.bannerModelsArray[0];
            [imageView setImageWithURL:[NSURL URLWithString:model.bannerImage] placeholderImage:[UIImage imageNamed:@"defaultimgmall_banner_bg_img.png"]];
        } else {
            PRJ_VideoShouYeBannerModel *model = self.bannerModelsArray[index - 1];
            [imageView setImageWithURL:[NSURL URLWithString:model.bannerImage] placeholderImage:[UIImage imageNamed:@"defaultimgmall_banner_bg_img.png"]];
        }
    }
}

//轮播图点击事件
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSLog(@"=---------%d",(int)index);
    if ([kkUserId isEqual:@""] || !kkUserId) {
        //去登陆
        LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        login.viewControllerIndex = 4;
        [self.navigationController pushViewController:login animated:YES];
    } else {
        PRJ_VideoShouYeBannerModel *model;
        PRJ_VideoDetailViewController *detail = [[PRJ_VideoDetailViewController alloc] initWithNibName:@"PRJ_VideoDetailViewController" bundle:nil];
        
        if (self.bannerModelsArray.count == 1) {
            model = self.bannerModelsArray[0];
            NSLog(@"---------就一张图片，我只能点你了");
        } else {
            if (self.bannerModelsArray.count > 1) {
                if ((index > 0) && (index <= self.bannerModelsArray.count)) {
                    model = self.bannerModelsArray[index - 1];
                } else {
                    model = self.bannerModelsArray[0];
                }
            }
        }
        detail.videoID = model.bannerID;
        [self.navigationController pushViewController:detail animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    [self hide];
    NSString *compareString  = @"";
    NSLog(@"-------------%@",aString);
    NSDictionary *dic = [aString JSONValue];
    NSLog(@"-------------%@",dic);
    if (dic) {
        if (aRequest.tag == 100) {
            if ([dic[@"code"] integerValue] == 0) {
                [self.noSignalView removeFromSuperview];
                NSArray *adArr = dic[@"ljq_ad"];
                if (adArr.count > 0) {
                    for (NSDictionary *adDic in adArr) {
                        PRJ_VideoShouYeBannerModel *model = [PRJ_VideoShouYeBannerModel getActivityModelWithDic:adDic];
                        [self.bannerModelsArray addObject:model];
                    }
                }
                
                NSArray *lists = dic[@"look_video"];
                if (lists.count > 0) {
                    compareString = [lists[0] objectForKey:@"video_time"];
                    [self.timeArr addObject:compareString];
                    
                    for ( int i = 0; i < lists.count ; i ++) {
                        NSDictionary *listDic = lists[i];
                        PRJ_VideoListModel *model = [PRJ_VideoListModel getVideoListModelWithDic:listDic];
                        if ([compareString isEqual:model.videoTime]) {
                            compareString = model.videoTime;
                            [self.dateArr addObject:model];
                        } else {
                            [self.timeArr addObject:compareString];
                            compareString = model.videoTime;
                            [listArray addObject:self.dateArr];
                            self.dateArr = [@[] mutableCopy];
                            [self.dateArr addObject:model];
                        }
                        if (i == lists.count - 1) {
                            [listArray addObject:self.dateArr];
                            [self.timeArr addObject:compareString];
                        }
                    }
                }
                [self.myTableView reloadData];
                
            } else {
                [self showStringMsg:dic[@"message"] andYOffset:0];
            }
        }
        //加载更多
        if (aRequest.tag == 110) {
            if ([dic[@"code"] integerValue] == 0) {
                NSString *moreCompare = @"";
                NSArray *lists = dic[@"more_video"];
                moreCompare = [lists[0] objectForKey:@"video_time"];
                self.dateArr = [@[] mutableCopy];
                if (lists.count > 0) {
                    for ( int i = 0; i < lists.count ; i ++) {
                        NSDictionary *listDic = lists[i];
                        PRJ_VideoListModel *model = [PRJ_VideoListModel getVideoListModelWithDic:listDic];
                        NSLog(@"----------%@",model.videoTime);
                        
                        if ([moreCompare isEqual:model.videoTime]) {
                            moreCompare = model.videoTime;
                            [self.dateArr addObject:model];
                        } else {
                            [self.timeArr addObject:moreCompare];
                            [listArray addObject:self.dateArr];
                            self.dateArr = [@[] mutableCopy];
                            [self.dateArr addObject:model];
                            moreCompare = model.videoTime;
                        }
                        
                        if (i == lists.count - 1) {
                            [listArray addObject:self.dateArr];
                            [self.timeArr addObject:moreCompare];
                        }
                    }
                    
                }
                [self.myTableView reloadData];
            } else  if ([dic[@"code"] integerValue] == 1 ) {
                [self showStringMsg:@"没有更多视频了" andYOffset:0];
            } else {
                [self showStringMsg:dic[@"message"] andYOffset:0];
            }
        }
    } else {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    }
}

- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self hide];
    [self.view addSubview: self.noSignalView];
    self.noSignalView.frame = CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64);
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
