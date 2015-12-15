//  幸运转盘
//  BLuckyguyViewController.m
//  Chiliring
//
//  Created by pipixia on 14-7-1.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "BLuckyguyViewController.h"
#import "UIImageView+WebCache.h"
#import "LuckyGuyModel.h"

@interface BLuckyguyViewController ()
{
    LKTurnTableView *turnTableView; // 转盘的view
    NSDictionary *zhongjiangDic; // 中奖的字典
    NSString *BjifenStr; // 积分
    UIView *maskview;  // 萌版
    UIImageView *imageview; // 奖品大图
    NSMutableArray *luckyModels; // 转盘对象
    UILabel *descriptView; // 大图文字
    NSArray *coinImageArray; // 积分图片
}

@property (strong, nonatomic) IBOutlet UIImageView *zhuanpanbackImage; // 转盘背景
@property (nonatomic, retain) IBOutlet UILabel *moneyLabel;  //积分的显示
@property (strong, nonatomic) IBOutlet UIView *alertView; // 提示框
@property (weak, nonatomic) IBOutlet UIView *chiliCoinView; // 积分
@property (weak, nonatomic) IBOutlet UIView *moreView; // 更多
@property (strong, nonatomic) IBOutlet UIView *helpView; // 帮助界面
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons; // 分享帮助按钮

- (IBAction)shareBtnAction:(id)sender;
- (IBAction)helpBtnAction:(id)sender;
- (IBAction)cancelHelpBtnAction:(id)sender;
- (IBAction)cancelBtnAction:(id)sender;
- (IBAction)exchangeBtnAction:(id)sender;
- (IBAction)backAction:(id)sender;
- (IBAction)helpAction:(id)sender;

@end

@implementation BLuckyguyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        BjifenStr = [[NSString alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bar.hidden = YES;
    
    for (UIButton *btn in self.allButtons) {
        //去除多个button同事点击的效果
        [btn setExclusiveTouch:YES];
    }
    // 初始化转盘
    turnTableView = [LKTurnTableView sharedTurnTableView];
    turnTableView.userInteractionEnabled = NO;
    turnTableView.backgroundColor = [UIColor clearColor];
    turnTableView.frame = CGRectMake(0, 69 , 320, 400);
    turnTableView.turnTableBearingViewCon = self;
    turnTableView.turnTableViewDelegate = self;
    // 调用展示转盘方法
    [turnTableView showTurnTableView];
    // 请求转盘的方法
    [self RequestzhuanpanData];
    // 积分图片数组
    coinImageArray = [[NSArray alloc] initWithObjects:@"zhuanpan0.png", @"zhuanpan1.png", @"zhuanpan2.png", @"zhuanpan3.png", @"zhuanpan4.png", @"zhuanpan5.png", @"zhuanpan6.png", @"zhuanpan7.png", @"zhuanpan8.png", @"zhuanpan9.png", nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    // 更多的位置
    _moreView.hidden = YES;
    [self.view bringSubviewToFront:_moreView];
    // 添加提示框
    _alertView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    [self.view addSubview:_alertView];
    _alertView.hidden = YES;
    // 添加帮助
    _helpView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    [self.view addSubview:_helpView];
    _helpView.hidden = YES;
    [super viewWillAppear:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hide];
}

#pragma mark -
#pragma mark 请求转盘的方法
- (void)RequestzhuanpanData
{
    if (![GCUtil connectedToNetwork]) {
        [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
        return;
    }
    [self showMsg:nil];
    mainRequest.tag = 100;
    [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI zhuanPanAwardListWithUserID:kkUserId]];
}

#pragma mark 请求抽奖的接口方法
- (void)RequestChoujiangData
{
    if (![GCUtil connectedToNetwork]) {
        [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
    } else {
        [self showMsg:nil];
        mainRequest.tag = 101;
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI zhuanPanAwardDetailsWithUserID:kkUserId]];
    }
}

#pragma mark 积分兑换的请求方法
- (void)RequestJifenduihuanData
{
    if (![GCUtil connectedToNetwork]) {
        [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
    } else {
        [self showMsg:nil];
        mainRequest.tag = 102;
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI zhuanPanZhongJiangDetailsWithUserID:kkUserId]];
    }
}

#pragma mark - SelectSocialDelegate

/*点击友盟分享对应的方法的事件
 */
//- (void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
//{
//    if (platformName == UMShareToQQ) {
//
//        socialData.shareImage = [UIImage imageNamed:@"nil"];
//
//    } else if (platformName == UMShareToQzone) {
//
//        socialData.shareText =   [NSString stringWithFormat:@"小伙伴们,我正在参与黑土app里的幸运转盘,快来黑土跟我一起转出大奖吧~(来自于黑土App) http://ht.sinosns.cn/"];
//
//    }
//
//}

#pragma mark - GCRequestDelegate
/*GCRequest成功请求放回的方法aRequest GCRequest对象 aString请求返回的字符串
 */
- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    [self hide];
    NSLog(@"lucky = %@", aString);
    NSMutableDictionary *dict= [aString JSONValue];
    if (!dict) {
        if (aRequest.tag == 103) {
            [self shareDefalutMessage];
        }
        return;
    }
    switch (mainRequest.tag) {
        case 100: //转盘
        {
            [self setZhuanpanbackData:dict];
        }
            break;
        case 101://抽奖
        {
            [self setChoujiangbanData:dict];
        }
            break;
        case 102://兑换积分
        {
            [self setChangedJifenbackData:dict];
        }
            break;
        case 103: // 分享内容
            [self setShareContentData:dict];
            break;
        default:
            break;
    }
}

/*GCRequest失败请求返回的方法aRequest GCRequest对象 aError请求错误信息
 */
- (void)GCRequest:(GCRequest*)aRequest Error:(NSString*)aError
{
    [self hide];
    if (mainRequest.tag == 103) {
        [self shareDefalutMessage];
    } else {
        self.view.userInteractionEnabled = YES;
        turnTableView.userInteractionEnabled = YES;
        if (mainRequest.tag == 101) { // 抽奖
            // 服务器请求失败可以设置为2：谢谢参与 由于现在奖品等级和位置不是对应所以这个数字有待改
            turnTableView.prizeWhich = 2;
        }
        [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
    }
}

#pragma mark 进入页面请求方法返回来的数据处理
- (void)setZhuanpanbackData:(NSDictionary*)dict
{
    self.view.userInteractionEnabled = YES;
    if ([[dict objectForKey:@"code"] intValue] == 0) {
        turnTableView.userInteractionEnabled = YES;
        [GCUtil changeChiliCoinView:[[dict objectForKey:@"myfen"] intValue] andCoinImageView:_chiliCoinView andImageArray:coinImageArray];
        [GCUtil saveLajiaobijifenWithJifen:[dict objectForKey:@"myfen"]];
        luckyModels = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < [[dict objectForKey:@"list"] count]; i++) {
            LuckyGuyModel *model = [LuckyGuyModel getLuckyGuyModelModelWithDic:[[dict objectForKey:@"list"] objectAtIndex:i]];
            [luckyModels addObject:model];
        }
        // 这里是添加奖品图片，按顺序赋值就好
        [turnTableView getImageByUrl:luckyModels];
    } else {
        [GCUtil showGameErrorMessageWithContent:[dict objectForKey:@"message"]];
    }
    
}
#pragma mark 抽奖 返回的数据处理
- (void)setChoujiangbanData:(NSDictionary*)dict
{
    zhongjiangDic = [[NSMutableDictionary alloc] init];
    zhongjiangDic = dict;
    if ([[zhongjiangDic objectForKey:@"code"] intValue] == 0) {
        // 我转转保存我转后中 积分的变话存贮
        [GCUtil saveLajiaobijifenWithJifen:[zhongjiangDic objectForKey:@"myfen"]];
        // 开始转转
        [turnTableView startTurining];
        self.view.userInteractionEnabled = NO;
        // 这里设置服务器返回的几等奖，如果服务器请求失败可以设置为：谢谢参与
        turnTableView.prizeWhich = [[zhongjiangDic objectForKey:@"weizhi"] intValue];
        [self performSelector:@selector(Rotatethestop) withObject:nil afterDelay:2.0];
    } else if ([[zhongjiangDic objectForKey:@"code"] intValue] == 3) {
        // 积分兑换的时候显示的弹出框的参数设置
        [self setExchangeViewShowMsg];
        self.view.userInteractionEnabled = YES;
        turnTableView.userInteractionEnabled = YES;
        [self againAction];
        NSLog(@"次数够了");
    } else {
        [self showStringMsg:[zhongjiangDic objectForKey:@"message"] andYOffset:0];
        turnTableView.userInteractionEnabled = YES;
        self.view.userInteractionEnabled = YES;
        //再一次转转
        [self againAction];
    }
}

#pragma mark 积分兑换的时候显示的弹出框的参数设置
- (void)setExchangeViewShowMsg
{
    _alertView.hidden = NO;
    _moneyLabel.text = [NSString stringWithFormat:@"花%@积分再来一次吗？", [zhongjiangDic objectForKey:@"xuyao"]];
}

#pragma mark 兑换积分请求返回的数据处理
- (void)setChangedJifenbackData:(NSDictionary*)dict
{
    if ([[dict objectForKey:@"code"] intValue] == 0) {
        zhongjiangDic = [[NSMutableDictionary alloc] init];
        zhongjiangDic = dict;
        [GCUtil changeChiliCoinView:[[dict objectForKey:@"myfen"] intValue] andCoinImageView:_chiliCoinView andImageArray:coinImageArray];
        [GCUtil saveLajiaobijifenWithJifen:[dict objectForKey:@"myfen"]];
        turnTableView.userInteractionEnabled = NO;
        [turnTableView startTurining];
        self.view.userInteractionEnabled = NO;
        // 这里设置服务器返回的几等奖，如果服务器请求失败可以设置为：谢谢参与
        turnTableView.prizeWhich = [[dict objectForKey:@"weizhi"] intValue];
        [self performSelector:@selector(Rotatethestop) withObject:nil afterDelay:2.0];
    } else {
        [GCUtil showGameErrorMessageWithContent:[dict objectForKey:@"message"]];
    }
}

#pragma mark 请求分享内容
- (void) shareContentRequest
{
    if (![GCUtil connectedToNetwork]) {
        [self shareDefalutMessage];
    } else {
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI shareContentType:@"1"]];
        mainRequest.tag = 103;
        [self showMsg:nil];
    }
}

#pragma mark 分享内容请求返回的数据处理
- (void) setShareContentData:(NSDictionary*)dict
{
    if ([[dict objectForKey:@"code"] intValue] == 1) { // 有分享内容
        self.shareContent = [NSString stringWithFormat:@"%@%@", dict[@"share_content"], dict[@"share_url"]];
        [self callOutShareViewWithUseController:self andSharedUrl:dict[@"share_url"]];
    } else {
        [self shareDefalutMessage];
    }
}

// 分享默认内容
- (void) shareDefalutMessage
{
    self.shareContent = @"什么??!!! 这个转盘里面竟然有我一直想要的...简直不敢相信!! 快来围观!!! http://ht.sinosns.cn/";
    [self callOutShareViewWithUseController:self andSharedUrl:@"http://ht.sinosns.cn/"];
}

#pragma mark - exchangedDelegate
/*点击对应的知道了 算了吧的按钮的点击事件方法
 */
- (void)exchangedButtonClikedWithTag:(NSInteger)buttonTag
{
    switch (buttonTag) {
        case 100: // 不兑换
        {
            break;
        }
        case 101: // 兑换积分
        {
            [self RequestJifenduihuanData];
            break;
        }
        default:
            break;
    }
    self.view.userInteractionEnabled = YES;
}

/*设置no，意味可以减速了
 */
- (void)Rotatethestop
{
    turnTableView.slowDownOrSpeedUp = NO; // 设置no，意味可以减速了
}

/*
 *如果想要再次抽奖，就做下面操作进行设置
 *lotteryState 抽奖的状态； 可以控制是否能够再次点击指针，NO是可以（代表还未抽奖）
 */
- (void)againAction
{
    // 在展示完抽奖结果后，如果想要再次抽奖可以把此设置为NO，就可以再次点击，并且需要做归零操作
    turnTableView.lotteryState = NO;
    [turnTableView settingStateReturnToZero]; // 归零操作。转盘状态回到初始化状态
}

#pragma mark - 点击指针的代理 抽奖
- (void)startRequestDelegate
{
    self.view.userInteractionEnabled = NO;
    turnTableView.userInteractionEnabled = NO;
    //抽奖
    [self RequestChoujiangData];
}

#pragma mark 返回抽奖成功的代理
- (void)turnTableResultDelegate
{
    self.view.userInteractionEnabled = YES;
    [GCUtil changeChiliCoinView:[[zhongjiangDic objectForKey:@"myfen"] intValue] andCoinImageView:_chiliCoinView andImageArray:coinImageArray];
    [GCUtil saveLajiaobijifenWithJifen:[zhongjiangDic objectForKey:@"myfen"]];
    // 转盘停止转动，出现抽奖结果
    if ([[zhongjiangDic objectForKey:@"fen"] isEqual:@"0"]) { // 没中奖
        GameAlertView *alert = [GCUtil showGameAlertTitle:nil andContent:@"很遗憾 !\n没有中奖,再接再厉 !" cancel:nil andOK:@"确认"];
        alert.rightBlock = ^() {
            turnTableView.userInteractionEnabled = YES;
            [self againAction];
        };
        alert.dismissBlock = ^() {
            turnTableView.userInteractionEnabled = YES;
            [self againAction];
        };
    } else if ([[zhongjiangDic objectForKey:@"fen"] isEqual:@"-1"]) { // 实物
        GameAlertView *alert = [GCUtil showGameAlertTitle:@"太给力了！亲~" andContent:[NSString stringWithFormat:@"获得%@!",[zhongjiangDic objectForKey:@"name"]] cancel:nil andOK:@"确认"];
        alert.rightBlock = ^() {
            turnTableView.userInteractionEnabled = YES;
            [self againAction];
        };
        alert.dismissBlock = ^() {
            turnTableView.userInteractionEnabled = YES;
            [self againAction];
        };
    } else {
        GameAlertView *alert = [GCUtil showGameAlertTitle:@"太给力了！亲~" andContent:[NSString stringWithFormat:@"获得%@积分!",[zhongjiangDic objectForKey:@"fen"]] cancel:nil andOK:@"确认"];
        alert.rightBlock = ^() {
            turnTableView.userInteractionEnabled = YES;
            [self againAction];
        };
        alert.dismissBlock = ^() {
            turnTableView.userInteractionEnabled = YES;
            [self againAction];
        };
    }
}

#pragma mark 奖品手势
- (void)prizeImageViewGesture:(NSString *)tag
{
    if (luckyModels.count != 0) {
        LuckyGuyModel *model = luckyModels[[tag intValue] - 11];
        if (model.big_img && ![model.big_img isEqual:@""]) {
            [self addMaskViewWithBigImage:[tag intValue] andDescrip:[luckyModels[[tag intValue] - 11] descript]];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 奖品放大图
- (void)addMaskViewWithBigImage:(int)index andDescrip:(NSString *)descripStr
{
    if (!maskview) {
        maskview = [[UIView alloc] initWithFrame:self.view.frame];
        maskview.backgroundColor = [UIColor blackColor];
        imageview = [[UIImageView alloc] init];
        [imageview setFrame:maskview.frame];
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidMaskViewWithBigImage)];
        [maskview addGestureRecognizer:tap];
        [maskview addSubview:imageview];
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 80, 320, 80)];
        bottomView.backgroundColor = [UIColor colorWithWhite:0 alpha:.6];
        if (!descriptView) {
            descriptView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
            [bottomView addSubview:descriptView];
        }
        [maskview addSubview:bottomView];
        [self.view addSubview:maskview];
    }
    LuckyGuyModel *model = luckyModels[index - 11];
    if (model.big_img && ![model.big_img isEqual:@""]) {
        [imageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", img_url, model.big_img]] placeholderImage:[UIImage imageNamed:@"L_luck_big_Image.png"]];
    }
    if (descripStr.length > 30) {
        descripStr = [NSString stringWithFormat:@"%@...",[descripStr substringToIndex:30]];
    }
    descriptView.text = descripStr;
    descriptView.textColor = [UIColor whiteColor];
    descriptView.backgroundColor = [UIColor colorWithWhite:0 alpha:.6];
    descriptView.font = [UIFont systemFontOfSize:16];
    descriptView.numberOfLines = 2;
    descriptView.lineBreakMode = NSLineBreakByWordWrapping;
    maskview.alpha = 1;
}

/*隐藏大图
 */
- (void)hidMaskViewWithBigImage
{
    maskview.alpha = 0;
}

#pragma mark - 按钮点击事件
#pragma mark 分享
- (IBAction)shareBtnAction:(id)sender {
    _moreView.hidden = YES;
    _helpView.hidden = YES;
    [self shareContentRequest];
}

#pragma mark 帮助
- (IBAction)helpBtnAction:(id)sender {
    _moreView.hidden = YES;
    _helpView.hidden = NO;
    [self cancleIndicateShareView];
}

#pragma mark 隐藏帮助
- (IBAction)cancelHelpBtnAction:(id)sender {
    _helpView.hidden = YES;
}

#pragma mark 取消兑换
- (IBAction)cancelBtnAction:(id)sender {
    _alertView.hidden = YES;
    [self cancleIndicateShareView];
}

#pragma mark 兑转转盘次数，再来一次
- (IBAction)exchangeBtnAction:(id)sender {
    _alertView.hidden = YES;
    [self cancleIndicateShareView];
    [self RequestJifenduihuanData];
}

#pragma mark 返回按钮的点击事件方法
- (IBAction)backAction:(id)sender {
    if (mainRequest) {
        [mainRequest cancelRequest];
    }
    [self cancleIndicateShareView];
    _moreView.hidden = YES;
    _helpView.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 更多按钮
- (IBAction)helpAction:(id)sender {
    _moreView.hidden = !_moreView.hidden;
    [self cancleIndicateShareView];
    _helpView.hidden = YES;
}
- (IBAction)hiddenAllSubViews:(UITapGestureRecognizer *)sender {
    _moreView.hidden = YES;
    [self cancleIndicateShareView];
}
@end
