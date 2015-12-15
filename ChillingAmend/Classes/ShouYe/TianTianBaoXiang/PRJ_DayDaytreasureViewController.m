//
//  PRJ_DayDaytreasureViewController.m
//  ChillingAmend
//
//  Created by svendson on 14-12-18.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "PRJ_DayDaytreasureViewController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "DayDayTreasureWinnerListModel.h"
#import "LoginViewController.h"
#import "DXAlertView.h"
#import "TimeStringTransform.h"
#import "DayDayRuleViewController.h"

@interface PRJ_DayDaytreasureViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UILabel *noGetPrizeLabel; // 无人获奖label
    int mTotalCellsVisible;
}

/*
 *jianPinImageBgView     奖品展示背景View
 *enjoyNumberPeople      参加人数
 *baoxiangImageView      宝箱
 *openSerprizeBtn        开宝箱按钮
 *peopleListView         中奖人员名单列表
 *jiangPinImages         奖品图片集合
 *winnerList             获奖名单
 *timerInt               滚动获奖者下标
 *timer                  滚动获奖者线程
 */
@property (weak, nonatomic) IBOutlet UIScrollView *jianPinImageBgView;
@property (weak, nonatomic) IBOutlet UIImageView *jiangPinBgImageView;
@property (weak, nonatomic) IBOutlet UILabel *enjoyNumberPeople;
@property (weak, nonatomic) IBOutlet UIImageView *baoxiangImageView;
@property (weak, nonatomic) IBOutlet UIButton *openSerprizeBtn;
@property (weak, nonatomic) IBOutlet UITableView *peopleListView;

@property (nonatomic, strong) NSMutableArray *jiangPinImages;

@property (nonatomic, strong ) NSMutableArray *winnerList;
@property (nonatomic, assign) int timerInt;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation PRJ_DayDaytreasureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    mTotalCellsVisible = self.peopleListView.frame.size.height / self.peopleListView.rowHeight;
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"天天宝箱"];
    
    self.jiangPinImages = [[NSMutableArray alloc] init];
    self.winnerList = [[NSMutableArray alloc] init];
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
        return;
    }
    self.peopleListView.showsVerticalScrollIndicator = NO;
    // 获取宝箱信息
    [self openChestMessageRequest];
    
    //去除多个button同事点击的效果
    [self.openSerprizeBtn setExclusiveTouch:YES];
    
    UIColor *RightBtnTitleColor = [UIColor colorWithRed:61.0/255 green:66.0/255 blue:69.0/255 alpha:1.0];
    [self addRightBarButtonItemWithImageName:@"" andTargate:@selector(goToRuleVC:) andRightItemFrame:CGRectMake(SCREENWIDTH - 10 - 45, 31, 60, 23) andButtonTitle:@"规则" andTitleColor:RightBtnTitleColor];
    self.rightButton.titleLabel.font   = [UIFont systemFontOfSize:14.0];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

//规则
- (void)goToRuleVC:(UIButton *)btn
{
    DayDayRuleViewController *rule = [[DayDayRuleViewController alloc] initWithNibName:@"DayDayRuleViewController" bundle:nil];
    [self.navigationController pushViewController:rule animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.winnerList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    DayDayTreasureWinnerListModel *model;
    if (self.winnerList.count > 0) {
        model = self.winnerList[indexPath.row];
    }
    
//    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:model.awardName];
    
    // 设置基本字体
//    UIFont *baseFont = [UIFont systemFontOfSize:fontSize];
//    [attrString addAttribute:NSFontAttributeName value:baseFont
//                       range:NSMakeRange(0, length)];
//
    for (UIView *subViews in cell.contentView.subviews) {
        [subViews removeFromSuperview];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 30, 21)];
    label.text = @"恭喜";
    label.font = [UIFont systemFontOfSize:13.0];
    label.textColor = [UIColor colorWithRed:141.0/255 green:141.0/255 blue:141.0/255 alpha:1.0];
    [cell.contentView addSubview:label];
    
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 2, 90, 21)];
    userLabel.text = model.winner;
    userLabel.font = [UIFont systemFontOfSize:13.0f];
    userLabel.textAlignment = NSTextAlignmentCenter;
    userLabel.textColor = [UIColor colorWithRed:141.0/255 green:141.0/255 blue:141.0/255 alpha:1.0];
    CGRect frame = [GCUtil changeLabelFrame:userLabel andSize:CGSizeMake(MAXFLOAT, 21) andFontSize:userLabel.font];
    userLabel.frame = CGRectMake(40, 2, CGRectGetWidth(frame), 21);
    [cell.contentView addSubview:userLabel];
    
    UILabel *HuoDeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(userLabel) + CGRectGetWidth(userLabel.frame) + 5, 2, 30, 21)];
    HuoDeLabel.text = @"获得";
    HuoDeLabel.font = [UIFont systemFontOfSize:13.0];
    HuoDeLabel.textColor = [UIColor colorWithRed:141.0/255 green:141.0/255 blue:141.0/255 alpha:1.0];
    [cell.contentView addSubview:HuoDeLabel];
    
    UILabel *awardName = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(HuoDeLabel) + CGRectGetWidth(HuoDeLabel.frame) + 5, 2, 80, 21)];
    awardName.text = model.awardName;
    awardName.font = [UIFont systemFontOfSize:13.0];
    awardName.textColor = [UIColor colorWithRed:184.0/255 green:6.0/255 blue:6.0/255 alpha:1.0];
    [cell.contentView addSubview:awardName];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - 90, 2, 80, 21)];
    timeLabel.text = [TimeStringTransform getTimeString:model.ceatTime];
    NSArray *timeARR = [timeLabel.text componentsSeparatedByString:@" "];
    timeLabel.text = [timeARR firstObject];
    timeLabel.font = [UIFont systemFontOfSize:12.0];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.textColor = [UIColor colorWithRed:141.0/255 green:141.0/255 blue:141.0/255 alpha:1.0];
    [cell.contentView addSubview:timeLabel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 23.5;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int number = scrollView.contentOffset.y / 23.5;
    self.timerInt = number;
//    [self resetContentOffsetIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 开启宝箱
- (IBAction)openTheBox:(UIButton *)sender {
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    } else {
        [self openChestRequest];
    }
}


- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    [self hide];
    NSLog(@"chest = %@",aString);
    NSDictionary *dic = [aString JSONValue];
    
    if (dic) {
        // 是否能开宝箱 1=可以开、2=不能
        if ([[dic objectForKey:@"open_status"] intValue] == 2) {
            self.openSerprizeBtn.userInteractionEnabled = NO;
            self.openSerprizeBtn.selected = YES;
        } else {
            self.openSerprizeBtn.userInteractionEnabled = YES;
            self.openSerprizeBtn.selected = NO;
        }
        
        // 宝箱首页
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            if (aRequest.tag == 1100) {
                if (noGetPrizeLabel) {
                    [noGetPrizeLabel removeFromSuperview];
                    noGetPrizeLabel = nil;
                }
                self.enjoyNumberPeople.text = [NSString stringWithFormat:@"今日已有%@位用户开启宝箱", dic[@"chest_num"]];
                self.jiangPinImages = dic[@"img"];
                [self showTheJiangPinImages];
                
                NSArray *winnerArr = dic[@"prize"];
                if (winnerArr.count > 0) { // 获奖名单不为空
                    [self.winnerList removeAllObjects];
                    self.peopleListView.hidden = NO;
                    NSMutableArray *tempWinnerList = [[NSMutableArray alloc] init];
                    for (NSDictionary *winnerDic in winnerArr) {
                        DayDayTreasureWinnerListModel *model = [DayDayTreasureWinnerListModel getAwardListModelWithDic:winnerDic];
                        [tempWinnerList addObject:model];
                    }
                    
                    for (int i = 0; i < 100; i++) {
                        for (DayDayTreasureWinnerListModel *model in tempWinnerList) {
                            [self.winnerList addObject:model];
                        }
                    }
                    
                    [self.peopleListView reloadData];
                    // 开启滚动
                    if (self.timer) {
                        [self.timer invalidate];
                        self.timer = nil;
                    }
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(scrollTheWinnerList:) userInfo:nil repeats:YES];
                } else {
                    self.peopleListView.hidden = YES;
                    noGetPrizeLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREENWIDTH - 80)/2, SCREENHEIGHT - 70, 80, 21)];
                    noGetPrizeLabel.font = [UIFont systemFontOfSize:13.0f];
                    noGetPrizeLabel.text = @"暂无人中奖";
                    noGetPrizeLabel.textColor = kkCColor;
                    [self.view addSubview:noGetPrizeLabel];
                }
            }
            
            // 开宝箱
            if (aRequest.tag == 1101) {
                [self.baoxiangImageView setImage:[UIImage imageNamed:@"activity_img_selected.png"]];
                NSString *imageUrl = dic[@"img"];
                if ([imageUrl isEqual:@""]) {
                    
                    //积分奖励
                    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"恭喜您！" contentText:dic[@"money"] leftButtonTitle:nil rightButtonTitle:@"确定"];
                    [alert show];
                    [GCUtil saveLajiaobijifenWithJifen:[NSString stringWithFormat:@"%d",[dic[@"money"] intValue] + [[GCUtil getlajiaobiJinfen]  intValue]]];
                } else {
                    //实物奖励
                    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"恭喜您！" contentText:dic[@"prize_name"] leftButtonTitle:@"确定" rightButtonTitle:@"炫耀一下" giftImage:nil orImageUrl:imageUrl];
                    [alert show];
                    alert.rightBlock = ^() {
                        NSLog(@"right");
                        self.shareContent = [NSString stringWithFormat:@"天哪！我在黑土开宝箱，开到%@，小伙伴还不一起来，看你能开出啥？ http://ht.sinosns.cn", dic[@"prize_name"]];
                        [self callOutShareViewWithUseController:self andSharedUrl:@"http://ht.sinosns.cn/"];
                    };
                    alert.leftBlock = ^() {
                        NSLog(@"left");
                    };
                }
                if (![GCUtil connectedToNetwork]) {
                    [self showStringMsg:@"网络连接失败" andYOffset:0];
                } else {
                    // 更新信息
                    [self openChestMessageRequest];
                }
            }
        } else {
            if (aRequest.tag == 1100) {
                self.openSerprizeBtn.userInteractionEnabled = NO;
                self.openSerprizeBtn.selected = YES;
            }
            [self showStringMsg:dic[@"message"] andYOffset:0];
        }
    } else {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    }
}

#pragma mark 宝箱首页信息请求
- (void)openChestMessageRequest
{
    [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI dayChestId:@"1" andUserId:kkUserId]];
    mainRequest.tag = 1100;
    [self showMsg:nil];
}

#pragma mark 开宝箱请求
- (void) openChestRequest
{
    [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI openTheDayChestWithUserID:kkUserId andActivityId:@"1"]];
    mainRequest.tag = 1101;
    [self showMsg:nil];
}

//滚动获奖者名单
- (void)scrollTheWinnerList:(NSTimer *)time
{
    self.timerInt ++;
    
    if (self.timerInt == self.winnerList.count) {
        self.timerInt = 0;
        [self.peopleListView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.timerInt inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    } else {
        [self.peopleListView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.timerInt inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark 循环滚动
- (void)resetContentOffsetIfNeeded
{
    NSArray *indexpaths = [self.peopleListView indexPathsForVisibleRows];
    int totalVisibleCells = [indexpaths count];
    if ( mTotalCellsVisible > totalVisibleCells ) {
        //we dont have enough content to generate scroll
        return;
    }
    CGPoint contentOffset  = self.peopleListView.contentOffset;
    //check the top condition
    if  ( contentOffset.y <= 0.0) {
        contentOffset.y = 0;
        self.timerInt = 0;
    } else if ( contentOffset.y >= (self.peopleListView.contentSize.height - self.peopleListView.bounds.size.height) ) {
        // scrollview content offset reached bottom minus the height of the tableview
        contentOffset.y = - self.peopleListView.bounds.size.height;
//        self.timerInt = 0;
    }
    [self.peopleListView setContentOffset: contentOffset];
}

- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self hide];
    [self showStringMsg:@"网络连接失败" andYOffset:0];
}

//奖品图片展示
- (void)showTheJiangPinImages
{
    NSMutableArray *prizes = [[NSMutableArray alloc] init];
    //奖品展示设置
    // t除积分
    for (int i = 0; i < self.jiangPinImages.count; i ++ ) {
        NSDictionary *dic = self.jiangPinImages[i];
        if (dic[@"img"] && ![dic[@"img"] isEqual:@""]) {
            [prizes addObject:dic];
        }
    }
    self.jiangPinImages = prizes;
    for (int i = 0; i < prizes.count; i ++ ) {
        NSDictionary *dic = prizes[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + i * 80 + i * 12, 10, 80, 80)];
        //去除多个button同事点击的效果
        [imageView setExclusiveTouch:YES];
        [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", img_url, dic[@"img"]]] placeholderImage:[UIImage imageNamed:@"defaultimgcollect_list_img.png"]];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 1000 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getAndLookBigPictures:)];
        tap.numberOfTapsRequired = 1;
        [imageView addGestureRecognizer:tap];
        [self.jianPinImageBgView addSubview:imageView];
    }
    
    self.jianPinImageBgView.contentSize = CGSizeMake(10 + prizes.count * 80 + prizes.count * 12, 80);
}

//查看大图
- (void)getAndLookBigPictures:(UITapGestureRecognizer *)tap
{
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [self.jiangPinImages count]];
    for (int i = 0; i < [self.jiangPinImages count]; i++) {
        // 替换为中等尺寸图片
        NSString * getImageStrUrl = [NSString stringWithFormat:@"%@%@",img_url, [[self.jiangPinImages objectAtIndex:i] objectForKey:@"big_img" ]];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString: getImageStrUrl ]; // 图片路径
        
        UIImageView * imageView = (UIImageView *)[self.view viewWithTag: tap.view.tag ];
        //去除多个button同事点击的效果
        [imageView setExclusiveTouch:YES];
        photo.srcImageView = imageView;
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = (tap.view.tag - 1000); // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
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
