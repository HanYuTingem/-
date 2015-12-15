//
//  PRJ_HomeViewController.m
//  ChillingAmend
//
//  Created by svendson on 14-12-18.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "PRJ_HomeViewController.h"
#import "ImagePlayerView.h"
#import "PRJ_DayDaytreasureViewController.h"
#import "PRJ_RecommendViewController.h"
#import "PRJ_ActivityViewController.h"
#import "ActivityAndAdAndBannerModel.h"
#import "PRJ_ShouYeShopModel.h"
#import "PRJ_ShouYeVideoModel.h"
#import "PRJ_VideoDetailViewController.h"
#import "SaomiaoViewController.h"
#import "ActivityDetailViewController.h"
#import "LoginViewController.h"
#import "ZBarSDK.h"
#import "ActivityListModel.h"
#import "LSYGoodsInfoViewController.h"
#import "LSYSeckillingListViewController.h"
#import "YaoYiYaoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "mineWalletViewController.h"
#import "LaoYiLaoViewController.h"

#import "PRJ_BusinessModel.h"
#import "PRJ_BusinessList.h"
#import "PRJ_BusinessInfoModel.h"
#import "NiceFoodViewController.h"
#import "AFRequest.h"
#import "ListTableViewController.h"
#import "SINOActionDetailViewController.h"

@interface PRJ_HomeViewController () <UIAlertViewDelegate, ImagePlayerViewDelegate>
{
    NSString *updateUrl; // 更新地址
    ZBarReaderView *readerView;
    int isFirstIn;    //判断是否是第一次进入此页面 用于是否需要加载圈
    UIView *maskView; // 蒙版
    // 四个蒙版button
    UIButton *maskButtonFourth;
    UIButton *maskButtonThird;
    UIButton *maskButtonSecond;
    UIButton *maskButtonFirst;
    NSArray *_adArr;
    NSArray *_businessArr;
    NSArray *_shopArr;
    NSArray *_shopRequestArr;
//    NSArray *_bannerBusinessArr;
    
}
/*
 *backScrollView         整个滚动背景View
 *SMBannerImageViews     小banner的图片集合
 *activityImageViews     活动图片集合
 *activityMoreBtn        活动更多按钮
 *movieBackView          推荐影视背景View
 *movieImageViews        推荐影视图片
 *movieTitleLabels       影视描述
 *movieMoreBtn           更多按钮
 *goodsView              推荐商品背景View
 *goodsBackScroll        推荐商品图片轮循背景View
 *goodsImageView         商品图片
 *goodsTitle             商品描述
 *cashLabel              金额
 *scoreLabel             积分
 *merchantView           推荐商家
 */
@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *SMBannerImageViews;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *activityImageViews;
@property (weak, nonatomic) IBOutlet UIButton *activityMoreBtn;
@property (weak, nonatomic) IBOutlet UIView *movieBackView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *movieImageViews;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *movieTitleLabels;
@property (weak, nonatomic) IBOutlet UIButton *movieMoreBtn;
@property (weak, nonatomic) IBOutlet UIView *goodsView;
@property (weak, nonatomic) IBOutlet UIScrollView *goodsBackScroll;

@property (strong, nonatomic) UIImageView *goodsImageView;
@property (strong, nonatomic) UILabel *goodsTitle;
@property (strong, nonatomic) UILabel *cashLabel;
@property (strong, nonatomic) UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *SMBannerTitleLabels;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *SMBannerDetailLabels;
@property (weak, nonatomic) IBOutlet UIView *merchantView;



/*
 *mainScorllView            顶部轮播图
 *bannerViewsArray          顶部轮播图集合
 *goodsURLs                 推荐商品地址集合
 *activityArr                活动集合
 *bannerModels              轮播图信息集合
 *smallBannerModels         小banner图片信息集合
 *videoModels               推荐视频信息
 *businessModels            推荐商家ID信息
 */

@property (weak, nonatomic) IBOutlet ImagePlayerView *mainScorllView;
@property (nonatomic, strong) NSMutableArray *bannerViewsArray;
@property (nonatomic, strong) NSMutableArray *goodsURLs;
@property (nonatomic, strong) NSMutableArray *activityArr;
@property (nonatomic,strong) NSMutableArray *bannerModels;
@property (nonatomic, strong) NSMutableArray *smallBannerModels;
@property (nonatomic, strong) NSMutableArray *videoModels;
@property (nonatomic, strong) NSMutableArray *businessModels;
//@property (nonatomic, strong) NSMutableArray *bannerBusinessModels;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;
@property (weak, nonatomic) IBOutlet UIImageView *shopBGImageView;

//banner信息没有时的显示
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *noInfoForBanners;
//视频时长
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *movieDurationLabels;
//视频副标题
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *movieSubTitleLabels;
//视频时长背景图片
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *timeBGViews;
@property (weak, nonatomic) IBOutlet UIView *smallBannersView; //小bannner的View

@property (weak, nonatomic) IBOutlet UIView *HuoDongView;//推荐活动的View

@property (weak, nonatomic) IBOutlet UIView *VideoView;//视频的view

//推荐商户相关
@property (weak, nonatomic) IBOutlet UIImageView *businessFirstImg;
@property (weak, nonatomic) IBOutlet UILabel *businessFirstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessFirstAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessFirstAvgpriceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *businessSecondImg;
@property (weak, nonatomic) IBOutlet UILabel *businessSecondNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessSecondAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessSecondAvgpriceLabel;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *activityFirst;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *activitySecond;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *businessFirstStar;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *businessSecondStar;

@property (weak, nonatomic) PRJ_BusinessInfoModel *businessInfoModel;
@property (weak, nonatomic) PRJ_BusinessList *FirstBusinessList;
@property (weak, nonatomic) PRJ_BusinessList *SecondBusinessList;
//@property (weak, nonatomic) PRJ_BusinessList *BannerBusinessList;

@end

@implementation PRJ_HomeViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.mainScorllView invalidateMyTimer];
    [self hide];
    self.bannerModels = [@[] mutableCopy];
    for (UIView *iv in self.mainScorllView.subviews) {
        if ([iv isKindOfClass:[UIImageView class]]) {
            [iv removeFromSuperview];
        }
    }
    if (mainRequest) {
        [mainRequest cancelRequest];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    for (UIView *subView in readerView.subviews) {
        [subView removeFromSuperview];
    }
    //设置底部toolBar的显示
    [self.appDelegate.homeTabBarController showTabBarAnimated:YES];
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openScrollViewAutoScroll:) name:@"adDisappear" object:nil];
    
    if (![GCUtil connectedToNetwork]) {
//        [self noDataForSmallBannerAndGoods];
//        [self noDataForSmallBannerAndGoodsAndMerchantView];
        [self hide];
        [self showStringMsg:@"网络连接失败" andYOffset:0];
        
    } else {
        if (isFirstIn > 0) {
            [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI homePageUserId:kkUserCenterId]];
            mainRequest.tag = 100;
        }
    }
    self.mainScorllView.autoScroll = YES;
    
    isFirstIn ++;
    
    // 第一次加载教程
    [self addMaskScreen];
}

// 应用第一次开启的时候添加蒙版
- (void)addMaskScreen
{
    NSUserDefaults *userDict = [NSUserDefaults standardUserDefaults];
    //判断是否是第一次开启应用
    if (![userDict objectForKey:@"mask"]) {
        [userDict setObject:@"1" forKey:@"mask"];
        [userDict synchronize];
        
        UIWindow *tWindow = [UIApplication sharedApplication].keyWindow;
        maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        maskButtonFourth = [UIButton buttonWithType:UIButtonTypeCustom];
        maskButtonFourth.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        maskButtonFourth.tag = 104;
        maskButtonFourth.hidden = YES;
        [maskView addSubview:maskButtonFourth];
        [maskButtonFourth addTarget:self action:@selector(maskButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        maskButtonThird = [UIButton buttonWithType:UIButtonTypeCustom];
        maskButtonThird.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        maskButtonThird.tag = 103;
        maskButtonThird.hidden = YES;
        [maskView addSubview:maskButtonThird];
        [maskButtonThird addTarget:self action:@selector(maskButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        maskButtonSecond = [UIButton buttonWithType:UIButtonTypeCustom];
        maskButtonSecond.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        maskButtonSecond.tag = 102;
        maskButtonSecond.hidden = YES;
        [maskView addSubview:maskButtonSecond];
        [maskButtonSecond addTarget:self action:@selector(maskButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        maskButtonFirst = [UIButton buttonWithType:UIButtonTypeCustom];
        maskButtonFirst.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        maskButtonFirst.tag = 101;
        maskButtonFirst.hidden = NO;
        [maskView addSubview:maskButtonFirst];
        [maskButtonFirst addTarget:self action:@selector(maskButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 跳过
        UIButton *mastButtonSkip = [UIButton buttonWithType:UIButtonTypeCustom];
        mastButtonSkip.frame = CGRectMake(0, 20, 60, 40);
        [mastButtonSkip setTitle:@"跳过" forState:UIControlStateNormal];
        [mastButtonSkip setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        mastButtonSkip.tag = 105;
        [maskView addSubview:mastButtonSkip];
        [maskView bringSubviewToFront:mastButtonSkip];
        [mastButtonSkip addTarget:self action:@selector(maskButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [tWindow addSubview:maskView];
        if (iPhone5) {
            [maskButtonFirst setBackgroundImage:[UIImage imageNamed:@"guidance_img_one.png"] forState:UIControlStateNormal];
            [maskButtonSecond setBackgroundImage:[UIImage imageNamed:@"guidance_img_two.png"] forState:UIControlStateNormal];
            [maskButtonThird setBackgroundImage:[UIImage imageNamed:@"guidance_img_three.png"] forState:UIControlStateNormal];
            [maskButtonFourth setBackgroundImage:[UIImage imageNamed:@"guidance_img_four.png"] forState:UIControlStateNormal];
        } else {
            [maskButtonFirst setBackgroundImage:[UIImage imageNamed:@"guidance_img_one.png"] forState:UIControlStateNormal];
            [maskButtonSecond setBackgroundImage:[UIImage imageNamed:@"guidance_img_two.png"] forState:UIControlStateNormal];
            [maskButtonThird setBackgroundImage:[UIImage imageNamed:@"guidance_img_three.png"] forState:UIControlStateNormal];
            [maskButtonFourth setBackgroundImage:[UIImage imageNamed:@"guidance_img_four.png"] forState:UIControlStateNormal];
        }
    }
}

// 第一次启动应用蒙板点击事件
- (void)maskButtonClick:(UIButton*)sender
{
    if (sender.tag == 104 || sender.tag == 105) {
        maskView.hidden = YES;
    }
    sender.alpha = 0;
    switch (sender.tag) {
        case 101:
            maskButtonSecond.hidden = NO;
            break;
        case 102:
            maskButtonThird.hidden = NO;
            break;
        case 103:
            maskButtonFourth.hidden = NO;
            break;
        default:
            break;
    }
}

//开启轮播图自动轮播
- (void)openScrollViewAutoScroll:(NSNotification *) noty
{
    self.mainScorllView.scrollInterval = 2.0f;
    self.mainScorllView.autoScroll = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isFirstIn = 0;
    self.bannerViewsArray = [[NSMutableArray alloc] init];
    self.bannerModels = [[NSMutableArray alloc] init];
    self.goodsURLs = [[NSMutableArray alloc] init];
    self.smallBannerModels = [[NSMutableArray alloc] init];
    self.videoModels = [[NSMutableArray alloc] init];
    self.businessModels = [[NSMutableArray alloc] init];
//    self.bannerBusinessModels = [[NSMutableArray alloc] init];
    self.activityArr = [[NSMutableArray alloc] init];
    readerView = [[ZBarReaderView alloc] init];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showUsersEvaluateView) name:@"showUsersEvaluate" object:nil];
    [self setNavigationBarWithState:0 andIsHideLeftBtn:YES andTitle:@"黑土"];
    [self.leftButton addTarget:self action:@selector(goToSaoYiSao:) forControlEvents:UIControlEventTouchUpInside];
        // 天天宝箱图片
    UIImageView *dayDayTreasure = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH - 10 - 22, 33, 22, 20)];
    dayDayTreasure.image = [UIImage imageNamed:@"home_title_btn_box.png"];
    [self.bar addSubview:dayDayTreasure];
    [self addRightBarButtonItemWithImageName:@"" andTargate:@selector(myPresent:) andRightItemFrame:CGRectMake(SCREENWIDTH - 50, 20, 60, 44) andButtonTitle:@"" andTitleColor:nil];
    
    self.backScrollView.frame = self.view.frame;
    self.backScrollView.contentSize = CGSizeMake(320, 1650);
    
    //去除多个button同事点击的效果
    for (UIImageView *iv in self.SMBannerImageViews) {
        [iv setExclusiveTouch:YES];
    }
    for (UIImageView *iv in self.activityImageViews) {
        [iv  setExclusiveTouch:YES];
    }
    for (UIImageView *iv in self.movieImageViews) {
        [iv setExclusiveTouch:YES];
    }
    for (UIButton *btn in self.allButtons) {
        [btn setExclusiveTouch:YES];
    }
    
    [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI homePageUserId:kkUserCenterId]];
    mainRequest.tag = 100;
    
    [self showMsg:nil];
    
    self.businessFirstImg.layer.cornerRadius = 2;
    self.businessFirstImg.layer.borderWidth = 1;
    self.businessFirstImg.layer.borderColor = [UIColor colorWithRed:226.0/255 green:226.0/255 blue:226.0/255 alpha:1.0].CGColor;
    self.businessFirstImg.layer.masksToBounds = YES;
    
    self.businessSecondImg.layer.cornerRadius = 2;
    self.businessSecondImg.layer.borderWidth = 1;
    self.businessSecondImg.layer.borderColor = [UIColor colorWithRed:226.0/255 green:226.0/255 blue:226.0/255 alpha:1.0].CGColor;
    self.businessSecondImg.layer.masksToBounds = YES;
    
    //隐藏评分星级
    for (int i = 0; i < 5; i++) {
        [self.businessFirstStar[i] setHidden:YES];
        [self.businessSecondStar[i] setHidden:YES];
    }
    
    [self noDataForSmallBannerAndGoodsAndMerchantView];
}

#pragma mark 检测更新
- (void) checkUpdate
{
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    } else {
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI checkUpdateType:@"1"]];
        mainRequest.tag = 101;
    }
}

#pragma mark - 提示用户评价
- (void)showUsersEvaluateView // 60*60*24*30
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ISPL"]) {
        NSDate *oldDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"REMIND_DATE"];
        NSTimeInterval timeInterval = [oldDate timeIntervalSinceNow];
        timeInterval = -timeInterval;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"alertShowFirst"]) {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"alertShowFirst"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self showEncourageAlertView];
        } else if (timeInterval >= 60*60*24*30) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"REMIND_DATE"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self showEncourageAlertView];
        }
    }
}

- (void)showEncourageAlertView
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"REMIND_DATE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"鼓励我们" message:@"感谢使用，如果喜欢我们的软件，请给予鼓励！" delegate:self cancelButtonTitle:@"不，谢谢" otherButtonTitles:@"好的", @"以后再说", nil];
    alertView.tag = 789;
    [alertView show];
}

#pragma mark -手势处理
//小banners点击事件
- (IBAction)smallBannerClicked:(UIButton *)sender {
    if (self.smallBannerModels.count > 0) {
        for (int i = 0; i < self.smallBannerModels.count; i ++) {
            ActivityAndAdAndBannerModel *model  = self.smallBannerModels[i];
            
            NSLog(@"-------ActivityAndAdAndBannerModel---------%@",model);
            
            if (i == (sender.tag - 111)) {
                // 1 商品   2视频   3活动场  7商户详情  9商户列表
                if ([model.activityType integerValue] == 1) {
                    LSYGoodsInfoViewController *productDetail = [[LSYGoodsInfoViewController alloc] initWithNibName:@"LSYGoodsInfoViewController" bundle:nil];
                    productDetail.goods_id = model.activityID;
                    productDetail.isSeckilling = NO;
                    [self.navigationController pushViewController:productDetail animated:YES];
                } else if ([model.activityType integerValue] == 2) {
                    [self goToVideoDetailViewControllerWithModel:model];
                } else if ([model.activityType integerValue] == 3) {
                    if ([kkUserId isEqual:@""] || !kkUserId) {
                        //去登陆
                        LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                        login.viewControllerIndex = 4;
                        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
                        [self.navigationController pushViewController:login animated:YES];
                    } else {
                        if ([model.browser_type intValue] == 0) {
                            ActivityDetailViewController *detail = [[ActivityDetailViewController alloc] init];
                            detail.activityUrl = model.activityUrl;
                            detail.share_url = model.share_url;
                            detail.share_content = model.share_content;
                            [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
                            [self.navigationController pushViewController:detail animated:YES];
                        } else if ([model.browser_type intValue] == 1) {
                            //外置浏览器打开
                            NSString *urlString;
                            if ([model.activityUrl hasPrefix:@"http://"]) {
                                urlString = model.activityUrl;
                            } else {
                                urlString = [NSString stringWithFormat:@"http://%@",model.activityUrl];
                            }
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                        }
                    }
                } else if ([model.activityType integerValue] == 7) {
                    if ([kkUserId isEqual:@""] || !kkUserId) {
                        //去登陆
                        LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                        login.viewControllerIndex = 4;
                        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
                        [self.navigationController pushViewController:login animated:YES];
                    } else {
                        [self toBusinessInfoVC:[NSString stringWithFormat:@"%@",model.activityID]];
                    }
                    
                } else if ([model.activityType integerValue] == 9) {
                    
                    //更多推荐商家
                    [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
                    NiceFoodViewController *vc = [[NiceFoodViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }
    }
}

// 推荐活动
- (void)activityImageViewTaped:(UITapGestureRecognizer *)tap
{
    UIImageView *tapView =   (UIImageView *)tap.view;
    NSLog(@"-------------点击了活动第%ld张图片",(long)tapView.tag);
    ActivityListModel *model;
    if (_activityArr.count > 0) {
        if (_activityArr.count == 1) {
            model  = [_activityArr objectAtIndex:0];
        } else {
            model = _activityArr[tap.view.tag - 11];
        }
    }
    NSLog(@"activityurl = %@", model.activityUrl);
    if (model.activityUrl.length > 0) {
        if ([kkUserId isEqual:@""] || !kkUserId) {
            //去登陆
            LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            login.viewControllerIndex = 4;
            [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
            [self.navigationController pushViewController:login animated:YES];
        } else {
//            ActivityDetailViewController *detail = [[ActivityDetailViewController alloc] init];
//            detail.activityUrl = model.activityUrl;
//            detail.share_url = model.shareUrl;
//            detail.share_content = model.activitySharecontent;
//            [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
//            [self.navigationController pushViewController:detail animated:YES];
            
            
            SINOActionDetailViewController *detailVC = [[SINOActionDetailViewController alloc]init];
            NSString *userId,*userName;
            NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:usernameMessagePHP];
            userId = [dic objectForKey:@"id"];
            userName = [dic objectForKey:@"user_name"];
            NSString *activityId = model.activityId;
            detailVC.imageUrl = [NSString stringWithFormat:@"%@%@",model.activityUrl,model.shareUrl];
            detailVC.urlStr = [NSString stringWithFormat:@"%@&product_id=%@&user_name=%@&user_id=%@",model.activityUrl,LOGOAction,userName,userId];
            detailVC.shareContent = model.activitySharecontent;
            detailVC.shareTitle = model.activityName;
            detailVC.actionId = activityId;
            detailVC.type = model.type;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    } else {
        [self showStringMsg:@"活动地址不存在" andYOffset:0];
    }
}

// 推荐视屏
- (void)videoImageViewTaped:(UITapGestureRecognizer *)tap
{
    if ([kkUserId isEqual:@""] || !kkUserId) {
        //去登陆
        LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        login.viewControllerIndex = 4;
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        [self.navigationController pushViewController:login animated:YES];
    } else {
        UIImageView *tapView =   (UIImageView *)tap.view;
        PRJ_ShouYeVideoModel *model ;
        if (self.videoModels.count > 0) {
            if (self.videoModels.count == 1) {
                model  =self.videoModels[0];;
            } else {
                model  =self.videoModels[tap.view.tag];;
            }
        }
        PRJ_VideoDetailViewController *detail = [[PRJ_VideoDetailViewController alloc] initWithNibName:@"PRJ_VideoDetailViewController" bundle:nil];
        NSLog(@"==============%@",model.videoID);
        detail.videoID = model.videoID;
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        [self.navigationController pushViewController:detail animated:YES];
        NSLog(@"-------------点击了推荐视屏第%ld张图片",(long)tapView.tag);
    }
}

//推荐商品
#pragma mark - 推荐商品
- (void)goodsImageViewTaped:(UITapGestureRecognizer *)tap
{
    UIImageView *tapView =   (UIImageView *)tap.view;
    NSLog(@"-------------点击了推荐商品第%ld张图片",(long)tapView.tag);
    PRJ_ShouYeShopModel *shopModel = self.goodsURLs[tapView.tag - 30];
    
    LSYGoodsInfoViewController *productDetail = [[LSYGoodsInfoViewController alloc] initWithNibName:@"LSYGoodsInfoViewController" bundle:nil];
    productDetail.goods_id = shopModel.ShopID;
    productDetail.isSeckilling = NO;
    [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
    [self.navigationController pushViewController:productDetail animated:YES];
}

#pragma mark  ----------顶部轮播图
- (void)setAndAddScrollView
{
    [self.mainScorllView initWithCount:self.bannerModels.count delegate:self];
    // adjust pageControl position
    // 修改小圆钮位置
    self.mainScorllView.hidePageControl = NO;
    self.mainScorllView.pageControlPosition = ICPageControlPosition_BottomCenter;
    [self.mainScorllView openThePageControllAndIsOpenImageDetails:NO andTheDetails:@[] andState:2];
}

#pragma mark - ImagePlayerViewDelegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    if (index == 0) {
        ActivityAndAdAndBannerModel *model = self.bannerModels[self.bannerModels.count -1];
        [imageView setImageWithURL:[NSURL URLWithString:model.activityImage] placeholderImage:[UIImage imageNamed:@"defaultimgmall_banner_bg_img.png"]];
    } else if (index == self.bannerModels.count + 1) {
        ActivityAndAdAndBannerModel *model = self.bannerModels[0];
        [imageView setImageWithURL:[NSURL URLWithString:model.activityImage] placeholderImage:[UIImage imageNamed:@"defaultimgmall_banner_bg_img.png"]];
    } else {
        ActivityAndAdAndBannerModel *model = self.bannerModels[index - 1];
        [imageView setImageWithURL:[NSURL URLWithString:model.activityImage] placeholderImage:[UIImage imageNamed:@"defaultimgmall_banner_bg_img.png"]];
    }
}

//轮播图点击事件
#pragma mark - 轮播图点击事件
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    ActivityAndAdAndBannerModel *model;
    if (self.bannerModels.count == 1) {
        model = self.bannerModels[0];
        NSLog(@"---------就一张图片，我只能点你了----------%@",model);
    } else {
        if (self.bannerModels.count > 0) {
            if ((index > 0) && (index <= self.bannerModels.count)) {
                model = self.bannerModels[index - 1];
            }
            else if (index == 0) {
                model = self.bannerModels[self.bannerModels.count - 1];
            }
            
//            else {
//                model = self.bannerModels[0];
//            }
            
        }
    }
    
    // 1 商品   2视频   3活动场 4仅作展示 5秒杀列表 6商品类目 7商家详情 8摇一摇 9商户列表
    if ([model.activityType integerValue] == 1) {
        LSYGoodsInfoViewController *productDetail = [[LSYGoodsInfoViewController alloc] initWithNibName:@"LSYGoodsInfoViewController" bundle:nil];
        productDetail.goods_id = model.activityID;
        productDetail.isSeckilling = NO;
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        [self.navigationController pushViewController:productDetail animated:YES];
    } else if ([model.activityType integerValue] == 2) {
        [self goToVideoDetailViewControllerWithModel:model];
    } else if ([model.activityType integerValue] == 3) {
        if ([kkUserId isEqual:@""] || !kkUserId) {
            //去登陆
            LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            login.viewControllerIndex = 4;
            [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
            [self.navigationController pushViewController:login animated:YES];
        } else {
            if ([model.browser_type intValue] == 0) {
                //内置浏览器打开
                ActivityDetailViewController *detail = [[ActivityDetailViewController alloc] init];
                detail.activityUrl = model.activityUrl;
                detail.share_url = model.share_url;
                detail.share_content = model.share_content;
                [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
                [self.navigationController pushViewController:detail animated:YES];
            } else if ([model.browser_type intValue] == 1) {
                //外置浏览器打开
                NSString *urlString;
                if ([model.activityUrl hasPrefix:@"http://"]) {
                    urlString = model.activityUrl;
                } else {
                    urlString = [NSString stringWithFormat:@"http://%@",model.activityUrl];
                }
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            } else if ([model.activityType integerValue] == 7){
                NSLog(@"商家详情");
                [self toBusinessInfoVC: model.activityID];
                
            } else if ([model.activityType integerValue] == 8){
                NSLog(@"摇一摇");
                YaoYiYaoViewController * waveViewControl = [[YaoYiYaoViewController alloc] initWithNibName:@"YaoYiYaoViewController" bundle:nil];
                [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
                [self.navigationController pushViewController:waveViewControl animated:YES];
            }
        }
    } else if ([model.activityType integerValue] == 4) {
        //仅作展示  啥也不用干
    } else if ([model.activityType integerValue] == 5) {
        LSYSeckillingListViewController *lsyVC = [[LSYSeckillingListViewController alloc] init];
        lsyVC.miaoShaID = model.ad_activity;
        lsyVC.childMiaoShaID = model.activityID;
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        [self.navigationController pushViewController:lsyVC animated:YES];
    } else if ([model.activityType integerValue] == 6) {
        [self.appDelegate.homeTabBarController.homeTabBar onRecommandButtonClicked:nil];
    }  else if ([model.activityType integerValue] == 9) {
        
        //商户列表
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        NiceFoodViewController *vc = [[NiceFoodViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.activityType integerValue] == 11){
        LaoYiLaoViewController *vc = [[LaoYiLaoViewController alloc] init];
        if ([kkUserId isEqualToString:@""] || !kkUserId) {
            vc.userID = @"";
            vc.phone = @"";
        }else{
            vc.userID = kkUserCenterId;
            vc.phone = kkUserName;
        }
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//进入视频详情页面
- (void)goToVideoDetailViewControllerWithModel:(ActivityAndAdAndBannerModel *) model
{
    if ([kkUserId isEqual:@""] || !kkUserId) {
        //去登陆
        LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        login.viewControllerIndex = 4;
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        [self.navigationController pushViewController:login animated:YES];
    } else {
        PRJ_VideoDetailViewController *detail = [[PRJ_VideoDetailViewController alloc] initWithNibName:@"PRJ_VideoDetailViewController" bundle:nil];
        detail.videoID = model.activityID;
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        [self.navigationController pushViewController:detail animated:YES];
    }
}

//推荐商品设置
- (UIView *)creatGoodsViewWithImageURL:(NSString *)urlString andTitle:(NSString *)title andCashString:(NSString *)cash andScoreString:(NSString *)score
{
    UIView *goodView = [[UIView alloc] init];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 115, 115)];
    imageView .contentMode =  UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds  = YES;
    [imageView setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"defaultimghome_list_img_bottom.png"]];
    imageView.layer.borderColor = [UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1.0].CGColor;
    imageView.layer.borderWidth = 0.5;
    [goodView addSubview:imageView];
    
    UIImageView *bagView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 114, 115, 82)];
    bagView.image = [UIImage imageNamed:@"home_mall_list_bg_img.png"];
    bagView.layer.borderColor = [UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1.0].CGColor;
    bagView.layer.borderWidth = 0.5;
    [goodView addSubview:bagView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 4, 105, 21)];
    titleLabel.numberOfLines = 0;
    CGSize stringSize = [title sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(120, 30)];
    
    if (stringSize.width > 105) {
        titleLabel.frame = CGRectMake(5, 4, 105, stringSize.height);
    }
    
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:12.0];
    [bagView addSubview:titleLabel];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(6, 39, 103, 1)];
    line.image = [UIImage imageNamed:@"home_list_img_line.png"];
    [bagView addSubview:line];
    
    UILabel *cashLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 48, 105, 12)];
    cashLabel.text = cash;
    cashLabel.textColor = [UIColor colorWithRed:141.0/255 green:141.0/255 blue:141.0/255 alpha:1.0];
    cashLabel.font = [UIFont systemFontOfSize:12.0];
    [bagView addSubview:cashLabel];
    
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 63, 105, 12)];
    scoreLabel.text = score;
    scoreLabel.textColor = [UIColor colorWithRed:141.0/255 green:141.0/255 blue:141.0/255 alpha:1.0];
    scoreLabel.font = [UIFont systemFontOfSize:12.0];
    [bagView addSubview:scoreLabel];
    
    return goodView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --------------屏幕上按钮点击事件
//扫一扫
- (void)goToSaoYiSao:(UIButton *)btn
{
    NSLog(@"-----------扫一扫");
    SaomiaoViewController *saoYiSao = [[SaomiaoViewController alloc] initWithNibName:@"SaomiaoViewController" bundle:nil];
    saoYiSao.readerView = readerView;
    [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
    [self.navigationController pushViewController:saoYiSao animated:YES];
}

//天天宝箱
- (void)myPresent:(UIButton *)btn
{
    if ([kkUserId isEqual:@""] || !kkUserId) {
        //去登陆
        LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        login.viewControllerIndex = 8;
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        [self.navigationController pushViewController:login animated:YES];
    } else {
        PRJ_DayDaytreasureViewController *treasure = [[PRJ_DayDaytreasureViewController alloc] initWithNibName:@"PRJ_DayDaytreasureViewController" bundle:nil];
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        [self.navigationController pushViewController:treasure animated:YES];
    }
}

- (IBAction)moreButtonClicked:(UIButton *)sender {
//    if (sender.tag == 10) {
//        //活动更多
//        [self.appDelegate.homeTabBarController.homeTabBar onKnowledgeButtonClicked:nil];
//    } else if (sender.tag == 11) {
//        // 推荐视屏更多
//        PRJ_RecommendViewController  *treasure = [[PRJ_RecommendViewController alloc] initWithNibName:@"PRJ_RecommendViewController" bundle:nil];
//        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
//        [self.navigationController pushViewController:treasure animated:YES];
//    } else if (sender.tag == 12){
//        //商品更多
//        [self.appDelegate.homeTabBarController.homeTabBar onRecommandButtonClicked:nil];
//    }
//    else {
//        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
//        NiceFoodViewController *vc = [[NiceFoodViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
    switch (sender.tag) {
        case 10:
        {
            //活动更多
            [self.appDelegate.homeTabBarController.homeTabBar onKnowledgeButtonClicked:nil];
        }
            break;
        case 11:
        {
            // 推荐视屏更多
            PRJ_RecommendViewController  *treasure = [[PRJ_RecommendViewController alloc] initWithNibName:@"PRJ_RecommendViewController" bundle:nil];
            [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
            [self.navigationController pushViewController:treasure animated:YES];
        }
            break;
        case 12:
        {
            //商品更多
            [self.appDelegate.homeTabBarController.homeTabBar onRecommandButtonClicked:nil];
        }
            break;
        case 13:
        {
            //更多推荐商家
            [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
            NiceFoodViewController *vc = [[NiceFoodViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark GCRequestDelegate
//数据处理
- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    [self hide];
    [aString stringByReplacingOccurrencesOfString:@"\\n" withString:@" "];
    NSDictionary *dic = [aString JSONValue];
    NSLog(@"-----------------%@",dic);
    if (dic) {
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            switch (mainRequest.tag) {
                case 100:
                {
                    self.bannerViewsArray = [@[] mutableCopy];
                    self.bannerModels = [@[] mutableCopy];;
                    self.goodsURLs = [@[] mutableCopy];;
                    self.smallBannerModels = [@[] mutableCopy];;
                    self.videoModels = [@[] mutableCopy];;
                    self.businessModels = [@[] mutableCopy];;
//                    self.bannerBusinessModels = [@[] mutableCopy];;
                    self.activityArr = [@[] mutableCopy];;
                    
                    //推荐活动
                    NSArray *actArr = [dic objectForKey:@"activity"];
                    NSLog(@"%@",actArr);
                    if (actArr.count > 0) {
                        for ( int i = 0 ; i < actArr.count ; i ++) {
                            NSDictionary *actDic = actArr[i];
                            ActivityListModel *model = [ActivityListModel getActivityListModelWithDic:actDic];
                            UIImageView *activityView = self.activityImageViews[i];
                            [activityView setImageWithURL:[NSURL URLWithString:model.activityImage] placeholderImage:[UIImage imageNamed:@"defaultimghome_list_img.png"]];
                            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(activityImageViewTaped:)];
                            [activityView addGestureRecognizer:tap];
                            [self.activityArr addObject:model];
                        }
                    }
                    
                    //小banners
                    _adArr = dic[@"ad"];
                    if (_adArr) {
                        if (_adArr.count > 0) {
                            for (UILabel *label in self.noInfoForBanners) {
                                label.hidden = YES;
                            }
                            for (UILabel *label  in self.SMBannerDetailLabels) {
                                label.text = @"";
                            }
                            for (UILabel *label  in self.SMBannerTitleLabels) {
                                label.text = @"";
                            }
                            for (int i = 0; i < _adArr.count; i ++) {
                                NSDictionary *adDic = _adArr[i];
                                ActivityAndAdAndBannerModel *model = [ActivityAndAdAndBannerModel getActivityModelWithDic:adDic];
                                [self.smallBannerModels addObject:model];
                                
//                                if ([model.activityType integerValue] != 7) {
                                    UIImageView *bannerView = self.SMBannerImageViews[i];
                                    [bannerView setImageWithURL:[NSURL URLWithString:model.activityImage] placeholderImage:[UIImage imageNamed:@"defaultimgmall_content_img_bottom1.png"]];
                                    UILabel *titleLabel = self.SMBannerTitleLabels[i];
                                    titleLabel.text = model.activityName;
                                    
                                    UILabel *detailLabel = self.SMBannerDetailLabels[i];
                                    detailLabel.text = model.activityDetail;
//                                }
//                                else {
//                                    [self.bannerBusinessModels addObject:model.activityID];
//                                }
                            }
                        }
                        for (NSInteger j = _adArr.count; j < self.noInfoForBanners.count; j ++) {
                            UILabel *noBannerLabel = self.noInfoForBanners[j];
                            noBannerLabel.hidden = NO;
                            UIImageView *banner = self.SMBannerImageViews[j];
                            banner.image = [UIImage imageNamed:@"home_content_bg_morentu.png"];
                        }
                    }
                    
                    //轮播图
                    NSArray *bannerArr = dic[@"banner"];
                    if (bannerArr.count > 0) {
                        [self.bannerModels removeAllObjects];
                        for (NSDictionary *bannerDic in bannerArr) {
                            ActivityAndAdAndBannerModel *model = [ActivityAndAdAndBannerModel getActivityModelWithDic:bannerDic];
                            [self.bannerModels addObject:model];
                        }
                        [self setAndAddScrollView];
                    }
                    
                    //推荐商品
                    _shopArr = dic[@"shop"];
                    if (_shopArr.count > 0) {
                        for (NSDictionary *shopDic in _shopArr) {
                            PRJ_ShouYeShopModel *model = [PRJ_ShouYeShopModel getShopDetailModelWithDic:shopDic];
                            [self.goodsURLs addObject:model];
                        }
                        [self setTheGoodsInView];
                    }
                    
                    //推荐视屏
                    NSArray *videoArr = dic[@"video"];
                    if (videoArr.count > 0) {
                        for (int i = 0; i < videoArr.count; i ++) {
                            NSDictionary *videoDic = videoArr[i];
                            PRJ_ShouYeVideoModel *model = [PRJ_ShouYeVideoModel getVideoDetailModelWithDic:videoDic];
                            [self.videoModels addObject:model];
                            UIImageView *videoView = self.movieImageViews[i];
                            [videoView setImageWithURL:[NSURL URLWithString:model.videoImageUrl] placeholderImage:[UIImage imageNamed:@"defaultimgvideo_list_img1.png"]];
                            videoView.tag = i;
                            //视频标题
                            UILabel *label = self.movieTitleLabels[i];
                            label.text = model.videoName;
                            //视频副标题
                            UILabel *subtitleLabel = self.movieSubTitleLabels[i];
                            subtitleLabel.text = model.subTitle;
                            //视频时长
                            UILabel *timeLabel = self.movieDurationLabels[i];
                            timeLabel.text = model.videoDuration;
                            
                            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoImageViewTaped:)];
                            [videoView addGestureRecognizer:tap];
                        }
                        
                        for (NSInteger j = videoArr.count; j < self.timeBGViews.count; j ++) {
                            UIImageView *noBannerLabel = self.timeBGViews[j];
                            noBannerLabel.hidden = YES;
                        }
                    } else {
                        for (UIImageView *bgImage in self.timeBGViews) {
                            bgImage.hidden = YES;
                        }
                    }
                    
                    //推荐商家信息
                    _businessArr = [dic objectForKey:@"business"];
                    if (_businessArr.count > 0) {
                        for ( NSMutableDictionary *businessDic in _businessArr) {
                            PRJ_BusinessModel *model = [PRJ_BusinessModel getBusinessModelWithDic:businessDic];
                            [self.businessModels addObject:model];
                        }
                        NSLog(@"%@",self.businessModels);
                        [mainRequest requestHttpWithPost:NiceFood_Url withDict:[BXAPI getBusinessInfo:self.businessModels]];
                        mainRequest.tag = 102;
                        
                    }

                    [self reloadView];
                    
                    // 检测更新
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkUpdate) name:@"checkUpdate" object:nil];
                    
                    // 检测更新
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"checkUpdate" object:nil];
                }
                    break;
                case 101: // 检测更新
                {
                    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
                    NSString *VersionKey = [infoDict objectForKey:@"CFBundleShortVersionString"];
                    if ([VersionKey compare:[dic valueForKey:@"version"] options:NSNumericSearch] == NSOrderedAscending) {
                        updateUrl = [dic objectForKey:@"url"];
                        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil
                                                                         message:@"现在有新版本"
                                                                        delegate:self
                                                               cancelButtonTitle:@"不更新"
                                                               otherButtonTitles:@"现在更新", nil];
                        alert.delegate = self;
                        alert.tag = 111;
                        [alert show];
                    }
                }
                    break;
                case 102: // 加载推荐商户
                {
                    NSLog(@"测试");
                    _shopRequestArr = dic[@"businessList"];
                    
                    if (_shopRequestArr.count > 1) {
                        self.businessInfoModel = dic[@"businessList"];
                        self.FirstBusinessList = dic[@"businessList"][0];
                        self.SecondBusinessList = dic[@"businessList"][1];
                        [self setBusinessView];
                        
                    }
                    [self reloadView];
                    
//                    if (self.bannerBusinessModels.count > 0) {
//                        [mainRequest requestHttpWithPost:NiceFood_Url withDict:[BXAPI getBannerBusinessInfo:self.bannerBusinessModels]];
//                        mainRequest.tag = 103;
//                    }
                    
                }
                    break;
//                case 103: // 加载小Banner商户
//                {
//                    NSLog(@"banner测试");
//
//                    _bannerBusinessArr = dic[@"businessList"];
//                    NSInteger m = 0;
//                    for (int i = 0 ; i < _adArr.count ; i++) {
//                    
//                        NSDictionary *adDic = _adArr[i];
//                        ActivityAndAdAndBannerModel *model = [ActivityAndAdAndBannerModel getActivityModelWithDic:adDic];
//                        if ([model.activityType integerValue] == 7) {
//                            self.BannerBusinessList = _bannerBusinessArr[m];
//                            if (model.activityID == _bannerBusinessModels[m]) {
//                                UIImageView *bannerView = self.SMBannerImageViews[i];
//                                [bannerView setImageWithURL:[NSURL URLWithString:[self.BannerBusinessList valueForKey:@"imageUrl"]] placeholderImage:[UIImage imageNamed:@"defaultimgmall_content_img_bottom1.png"]];
//                                UILabel *titleLabel = self.SMBannerTitleLabels[i];
//                                titleLabel.text = [NSString stringWithFormat:@"%@",[self.BannerBusinessList valueForKey:@"name"]];
//                                UILabel *detailLabel = self.SMBannerDetailLabels[i];
//                                NSString *addressString;
//                                if ([self.BannerBusinessList valueForKey:@"districtName"] != nil) {
//                                    addressString = [NSString stringWithFormat:@"%@ %@",[self.BannerBusinessList valueForKey:@"districtName"],[self.BannerBusinessList valueForKey:@"industryName"]];
//                                }
//                                else {
//                                    addressString = [NSString stringWithFormat:@"%@",[self.BannerBusinessList valueForKey:@"industryName"]];
//                                }
//                                
//                                detailLabel.text = addressString;
//                            }
//                            m++;
//                        }
//                    }
//                    for (NSInteger j = _adArr.count; j < self.noInfoForBanners.count; j ++) {
//                        UILabel *noBannerLabel = self.noInfoForBanners[j];
//                        noBannerLabel.hidden = NO;
//                        UIImageView *banner = self.SMBannerImageViews[j];
//                        banner.image = [UIImage imageNamed:@"home_content_bg_morentu.png"];
//                    }
//                    
//                    [self reloadView];
//                }
//                    break;
                default:
                    break;
            }
        }
        else {
            [self showStringMsg:[dic objectForKey:@"message"] andYOffset:0];
            [self reloadView];
        }
    } else {
//        [self noDataForSmallBannerAndGoods];
        [self reloadView];
//        [self noDataForSmallBannerAndGoodsAndMerchantView];
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    }
}

- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
//    [self noDataForSmallBannerAndGoods];
//    [self noDataForSmallBannerAndGoodsAndMerchantView];
    [self reloadView];
    [self hide];
    [self showStringMsg:@"网络连接失败" andYOffset:0];
}

- (void)noDataForSmallBannerAndGoods
{
    self.smallBannersView.hidden = YES;
    self.goodsView.hidden = YES;
    self.HuoDongView.frame = CGRectMake(ORIGIN_X(self.HuoDongView), ORIGIN_Y(self.smallBannersView), CGRectGetWidth(self.HuoDongView.frame), CGRectGetHeight(self.HuoDongView.frame));
    
    self.VideoView.frame = CGRectMake(ORIGIN_X(self.VideoView),ORIGIN_Y(self.smallBannersView) + CGRectGetHeight(self.HuoDongView.frame) + 10 , CGRectGetWidth(self.VideoView.frame), CGRectGetHeight(self.VideoView.frame));
    
    self.backScrollView.contentSize = CGSizeMake(SCREENWIDTH, 1645 - CGRectGetHeight(self.smallBannersView.frame) - CGRectGetHeight(self.goodsView.frame) - 10);
}

#pragma mark 根据返回的数据刷新布局
- (void)reloadView {
    //判断smallBannerView 与 goodsView的显示问题
    NSInteger isSmallBanner = _adArr.count;
    NSInteger isGoods = _shopArr.count;
    NSInteger isMerchantRequestView = _shopRequestArr.count;
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"cityName"] isEqualToString:@"辽宁省"]) {
        isMerchantRequestView = 0;
    }
    if ((isSmallBanner <= 3) && (isGoods == 0) && (isMerchantRequestView <=1)) {
        //smallBanner 与 goods 与 merchantView 都没有
        self.smallBannersView.hidden = YES;
        self.goodsView.hidden = YES;
        self.merchantView.hidden = YES;
        self.HuoDongView.frame = CGRectMake(ORIGIN_X(self.HuoDongView), ORIGIN_Y(self.smallBannersView), CGRectGetWidth(self.HuoDongView.frame), CGRectGetHeight(self.HuoDongView.frame));
        
        self.VideoView.frame = CGRectMake(ORIGIN_X(self.VideoView),ORIGIN_Y(self.smallBannersView) + CGRectGetHeight(self.HuoDongView.frame) + 10 , CGRectGetWidth(self.VideoView.frame), CGRectGetHeight(self.VideoView.frame));
        
        self.backScrollView.contentSize = CGSizeMake(SCREENWIDTH, 1645 + CGRectGetHeight(self.merchantView.frame) - CGRectGetHeight(self.merchantView.frame) - CGRectGetHeight(self.smallBannersView.frame) - CGRectGetHeight(self.goodsView.frame) - 10);
    }
    else {
        //goods 与 merchantView 没有
        if ((isSmallBanner > 3) && (isGoods == 0) && (isMerchantRequestView <=1)) {
            self.smallBannersView.hidden = NO;
            self.merchantView.hidden = YES;
            self.goodsView.hidden = YES;
            
            self.HuoDongView.frame = CGRectMake(ORIGIN_X(self.HuoDongView), ORIGIN_Y(self.smallBannersView) + CGRectGetHeight(self.smallBannersView.frame) + 5 , CGRectGetWidth(self.HuoDongView.frame), CGRectGetHeight(self.HuoDongView.frame));
            
            self.VideoView.frame = CGRectMake(ORIGIN_X(self.VideoView), ORIGIN_Y(self.HuoDongView) + CGRectGetHeight(self.HuoDongView.frame) + 5 , CGRectGetWidth(self.VideoView.frame), CGRectGetHeight(self.VideoView.frame));
            
            self.backScrollView.contentSize = CGSizeMake(SCREENWIDTH, 1645 + CGRectGetHeight(self.merchantView.frame) - CGRectGetHeight(self.goodsView.frame) - CGRectGetHeight(self.merchantView.frame));
        }
        //smallBanner与 merchantView 没有
        if ((isSmallBanner <= 3) && (isGoods != 0) && (isMerchantRequestView <=1)) {
            self.smallBannersView.hidden = YES;
            self.merchantView.hidden = YES;
            self.goodsView.hidden = NO;
            
            self.HuoDongView.frame = CGRectMake(ORIGIN_X(self.HuoDongView), ORIGIN_Y(self.smallBannersView) , CGRectGetWidth(self.HuoDongView.frame), CGRectGetHeight(self.HuoDongView.frame));
            
            self.goodsView.frame = CGRectMake(ORIGIN_X(self.goodsView), ORIGIN_Y(self.HuoDongView) + CGRectGetHeight(self.HuoDongView.frame) + 10 , CGRectGetWidth(self.goodsView.frame), CGRectGetHeight(self.goodsView.frame));
            
            self.VideoView.frame = CGRectMake(ORIGIN_X(self.VideoView), ORIGIN_Y(self.goodsView) + CGRectGetHeight(self.goodsView.frame) + 5 , CGRectGetWidth(self.VideoView.frame), CGRectGetHeight(self.VideoView.frame));
            
            self.backScrollView.contentSize = CGSizeMake(SCREENWIDTH, 1645 + CGRectGetHeight(self.merchantView.frame) - CGRectGetHeight(self.smallBannersView.frame) - CGRectGetHeight(self.merchantView.frame));
        }
        //smallBanner 与 goods 没有
        if ((isSmallBanner <= 3) && (isGoods == 0) && (isMerchantRequestView > 1)) {
            self.smallBannersView.hidden = YES;
            self.merchantView.hidden = NO;
            self.goodsView.hidden = YES;
            
            self.HuoDongView.frame = CGRectMake(ORIGIN_X(self.HuoDongView), ORIGIN_Y(self.smallBannersView) , CGRectGetWidth(self.HuoDongView.frame), CGRectGetHeight(self.HuoDongView.frame));
            
            self.merchantView.frame = CGRectMake(ORIGIN_X(self.merchantView), ORIGIN_Y(self.HuoDongView) + CGRectGetHeight(self.HuoDongView.frame) + 10 , CGRectGetWidth(self.merchantView.frame), CGRectGetHeight(self.merchantView.frame));
            
            self.VideoView.frame = CGRectMake(ORIGIN_X(self.VideoView), ORIGIN_Y(self.merchantView) + CGRectGetHeight(self.merchantView.frame) + 5 , CGRectGetWidth(self.VideoView.frame), CGRectGetHeight(self.VideoView.frame));
            
            self.backScrollView.contentSize = CGSizeMake(SCREENWIDTH, 1645 + CGRectGetHeight(self.merchantView.frame) - CGRectGetHeight(self.goodsView.frame) - CGRectGetHeight(self.smallBannersView.frame));
        }
        //merchantView 没有
        if ((isSmallBanner > 3) && (isGoods != 0) && (isMerchantRequestView <= 1)) {
            self.smallBannersView.hidden = NO;
            self.merchantView.hidden = YES;
            self.goodsView.hidden = NO;
            
            self.goodsView.frame = CGRectMake(ORIGIN_X(self.goodsView), ORIGIN_Y(self.merchantView) , CGRectGetWidth(self.goodsView.frame), CGRectGetHeight(self.goodsView.frame));
            
            self.VideoView.frame = CGRectMake(ORIGIN_X(self.VideoView), ORIGIN_Y(self.goodsView) + CGRectGetHeight(self.goodsView.frame) + 5 , CGRectGetWidth(self.VideoView.frame), CGRectGetHeight(self.VideoView.frame));
            
            self.backScrollView.contentSize = CGSizeMake(SCREENWIDTH, 1645 + CGRectGetHeight(self.merchantView.frame) - CGRectGetHeight(self.merchantView.frame));
        }
        //goods 没有
        if ((isSmallBanner > 3) && (isGoods == 0) && (isMerchantRequestView > 1)) {
            self.smallBannersView.hidden = NO;
            self.merchantView.hidden = NO;
            self.goodsView.hidden = YES;
            
            self.VideoView.frame = CGRectMake(ORIGIN_X(self.VideoView), ORIGIN_Y(self.goodsView) , CGRectGetWidth(self.VideoView.frame), CGRectGetHeight(self.VideoView.frame));
            
            self.backScrollView.contentSize = CGSizeMake(SCREENWIDTH, 1645 + CGRectGetHeight(self.merchantView.frame) - CGRectGetHeight(self.goodsView.frame));
        }
        //smallBanner 都没有
        if ((isSmallBanner <= 3) && (isGoods != 0) && (isMerchantRequestView > 1)) {
            self.smallBannersView.hidden = YES;
            self.merchantView.hidden = NO;
            self.goodsView.hidden = NO;
            
            self.HuoDongView.frame = CGRectMake(ORIGIN_X(self.HuoDongView), ORIGIN_Y(self.smallBannersView) , CGRectGetWidth(self.HuoDongView.frame), CGRectGetHeight(self.HuoDongView.frame));
            
            self.merchantView.frame = CGRectMake(ORIGIN_X(self.merchantView), ORIGIN_Y(self.HuoDongView) + CGRectGetHeight(self.HuoDongView.frame) + 10 , CGRectGetWidth(self.merchantView.frame), CGRectGetHeight(self.merchantView.frame));
            
            self.goodsView.frame = CGRectMake(ORIGIN_X(self.goodsView), ORIGIN_Y(self.merchantView) + CGRectGetHeight(self.merchantView.frame) + 10 , CGRectGetWidth(self.goodsView.frame), CGRectGetHeight(self.goodsView.frame));
            
            self.VideoView.frame = CGRectMake(ORIGIN_X(self.VideoView), ORIGIN_Y(self.goodsView) + CGRectGetHeight(self.goodsView.frame) + 5 , CGRectGetWidth(self.VideoView.frame), CGRectGetHeight(self.VideoView.frame));
            
            self.backScrollView.contentSize = CGSizeMake(SCREENWIDTH, 1645 + CGRectGetHeight(self.merchantView.frame) - CGRectGetHeight(self.smallBannersView.frame));
        }
        //smallBanner 与 goods 与 merchantView 都有
        if ((isSmallBanner > 3) && (isGoods != 0) && ( isMerchantRequestView > 1)) {
            self.smallBannersView.hidden = NO;
            self.merchantView.hidden = NO;
            self.goodsView.hidden = NO;
            
            self.HuoDongView.frame = CGRectMake(ORIGIN_X(self.HuoDongView), ORIGIN_Y(self.smallBannersView) + CGRectGetHeight(self.smallBannersView.frame) + 10, CGRectGetWidth(self.HuoDongView.frame), CGRectGetHeight(self.HuoDongView.frame));
            
            self.merchantView.frame = CGRectMake(ORIGIN_X(self.merchantView), ORIGIN_Y(self.HuoDongView) + CGRectGetHeight(self.HuoDongView.frame) + 10 , CGRectGetWidth(self.merchantView.frame), CGRectGetHeight(self.merchantView.frame));
            
            self.goodsView.frame = CGRectMake(ORIGIN_X(self.goodsView), ORIGIN_Y(self.merchantView) + CGRectGetHeight(self.merchantView.frame) + 10 , CGRectGetWidth(self.goodsView.frame), CGRectGetHeight(self.goodsView.frame));
            
            self.VideoView.frame = CGRectMake(ORIGIN_X(self.VideoView), ORIGIN_Y(self.goodsView) + CGRectGetHeight(self.goodsView.frame) + 5 , CGRectGetWidth(self.VideoView.frame), CGRectGetHeight(self.VideoView.frame));
            
            self.backScrollView.contentSize = CGSizeMake(SCREENWIDTH, 1645 + CGRectGetHeight(self.merchantView.frame));
        }
    }
    
}

- (void)noDataForSmallBannerAndGoodsAndMerchantView
{
    self.smallBannersView.hidden = YES;
    self.goodsView.hidden = YES;
    self.merchantView.hidden = YES;
    self.HuoDongView.frame = CGRectMake(ORIGIN_X(self.HuoDongView), ORIGIN_Y(self.smallBannersView) + CGRectGetHeight(self.smallBannersView.frame) + 10, CGRectGetWidth(self.HuoDongView.frame), CGRectGetHeight(self.HuoDongView.frame));
    
    self.VideoView.frame = CGRectMake(ORIGIN_X(self.VideoView),ORIGIN_Y(self.smallBannersView) + CGRectGetHeight(self.HuoDongView.frame) + 10 , CGRectGetWidth(self.VideoView.frame), CGRectGetHeight(self.VideoView.frame));
    
    self.backScrollView.contentSize = CGSizeMake(SCREENWIDTH, 1645 + CGRectGetHeight(self.merchantView.frame) - CGRectGetHeight(self.merchantView.frame) - CGRectGetHeight(self.smallBannersView.frame) - CGRectGetHeight(self.goodsView.frame) - 10);
    
}

#pragma mark UIAlertView 代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 789: // 鼓励我们
            switch (buttonIndex) {
                case 1:
                {
                    NSLog(@"好的");
                    NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/us/app/la-jiao-quan/id715491678?ls=1&mt=8"];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                }
                    break;
                case 2:
                {
                    NSLog(@"以后再说");
                }
                    break;
                case 0:
                {
                    NSLog(@"不，谢谢");
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ISPL"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                    break;
                default:
                    break;
            }
            break;
        case 111: // 检测更新
            if (buttonIndex == 1) {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:updateUrl]];
            }
            break;
        default:
            break;
    }
}

#pragma mark 推荐商品设置
- (void)setTheGoodsInView
{
    //推荐商品设置
    for (int i = 0; i < self.goodsURLs.count; i++) {
        PRJ_ShouYeShopModel *model = self.goodsURLs[i];
        UIView *goodView = [self creatGoodsViewWithImageURL:model.ShopImageUrl andTitle:model.shopName andCashString:model.shopCash andScoreString:model.shopJiFenPrice];
        //去除多个button同事点击的效果
        [goodView setExclusiveTouch:YES];
        goodView.frame = CGRectMake(10 + i * 115 + i * 10, 0, 115, 196);
        [self.goodsBackScroll addSubview:goodView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goodsImageViewTaped:)];
        goodView.tag = i + 30;
        [goodView addGestureRecognizer:tap];
    }
    self.goodsBackScroll.contentSize = CGSizeMake(self.goodsURLs.count * 115 + (self.goodsURLs.count + 1 ) * 10, 193);
}

#pragma mark 推荐商户设置
- (void)setBusinessView
{
    
    //隐藏评分星级
    for (int i = 0; i < 5; i++) {
        [self.businessFirstStar[i] setHidden:YES];
        [self.businessSecondStar[i] setHidden:YES];
    }
    //隐藏优惠活动
    for (int i = 0; i < 3; i++) {
        [self.activityFirst[i] setHidden:YES];
        [self.activitySecond[i] setHidden:YES];
    }
    
    //文字和图片的显示
//    self.businessFirstImg.layer.cornerRadius = 2;
//    self.businessFirstImg.layer.borderWidth = 1;
//    self.businessFirstImg.layer.borderColor = [UIColor colorWithRed:226.0/255 green:226.0/255 blue:226.0/255 alpha:1.0].CGColor;
//    self.businessFirstImg.layer.masksToBounds = YES;
    
    [self.businessFirstImg setImageWithURL:[NSURL URLWithString:[self.FirstBusinessList valueForKey:@"imageUrl"]] placeholderImage:[UIImage imageNamed:@"defaultimgmall_content_img_bottom1.png"]];
    self.businessFirstNameLabel.text = [self.FirstBusinessList valueForKey:@"name"];
    NSString *addressString;
    if ([self.FirstBusinessList valueForKey:@"districtName"] != nil) {
        addressString = [NSString stringWithFormat:@"%@  %@",[self.FirstBusinessList valueForKey:@"districtName"],[self.FirstBusinessList valueForKey:@"industryName"]];
    }
    else {
        addressString = [NSString stringWithFormat:@"%@",[self.FirstBusinessList valueForKey:@"industryName"]];
    }
    self.businessFirstAddressLabel.text = addressString;
    NSString *firstAvgprice = [NSString stringWithFormat:@"人均%@元",[self.FirstBusinessList valueForKey:@"avgprice"]];
    self.businessFirstAvgpriceLabel.text = firstAvgprice;
    
//    self.businessSecondImg.layer.cornerRadius = 2;
//    self.businessSecondImg.layer.borderWidth = 1;
//    self.businessSecondImg.layer.borderColor = [UIColor colorWithRed:226.0/255 green:226.0/255 blue:226.0/255 alpha:1.0].CGColor;
//    self.businessSecondImg.layer.masksToBounds = YES;
    
    [self.businessSecondImg setImageWithURL:[NSURL URLWithString:[self.SecondBusinessList valueForKey:@"imageUrl"]] placeholderImage:[UIImage imageNamed:@"defaultimgmall_content_img_bottom1.png"]];
    self.businessSecondNameLabel.text = [self.SecondBusinessList valueForKey:@"name"];
    if ([self.SecondBusinessList valueForKey:@"districtName"] != nil) {
        addressString = [NSString stringWithFormat:@"%@  %@",[self.SecondBusinessList valueForKey:@"districtName"],[self.SecondBusinessList valueForKey:@"industryName"]];
    }
    else {
        addressString = [NSString stringWithFormat:@"%@",[self.SecondBusinessList valueForKey:@"industryName"]];
    }
    self.businessSecondAddressLabel.text = addressString;
    NSString *secondAvgprice = [NSString stringWithFormat:@"人均%@元",[self.SecondBusinessList valueForKey:@"avgprice"]];
    self.businessSecondAvgpriceLabel.text = secondAvgprice;
    
    //控制评分的显示
    for (int i = 0; i < 5; i++) {
        if ([[self.FirstBusinessList valueForKey:@"star"] isEqualToString:[NSString stringWithFormat:@"%d",i]]) {
            break;
        }
        else {
            [self.businessFirstStar[i] setHidden:NO];
        }
    }
    for (int i = 0; i < 5; i++) {
        if ([[self.SecondBusinessList valueForKey:@"star"] isEqualToString:[NSString stringWithFormat:@"%d",i]]) {
            break;
        }
        else {
            [self.businessSecondStar[i] setHidden:NO];
        }
    }
    
    //控制优惠活动图标的显示
    
    NSArray *activeFirstArray = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@",[self.FirstBusinessList valueForKey:@"provideServiceTakeout"]],[NSString stringWithFormat:@"%@",[self.FirstBusinessList valueForKey:@"provideServiceOrder"]],[NSString stringWithFormat:@"%@",[self.FirstBusinessList valueForKey:@"couponStart"]], nil];
    NSArray *activeSecondArray = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@",[self.SecondBusinessList valueForKey:@"provideServiceTakeout"]],[NSString stringWithFormat:@"%@",[self.SecondBusinessList valueForKey:@"provideServiceOrder"]],[NSString stringWithFormat:@"%@",[self.SecondBusinessList valueForKey:@"couponStart"]], nil];
    NSArray *activeImgArray = [[NSArray alloc] initWithObjects:@"home_list_content_img3",@"home_list_content_img2",@"home_list_content_img1", nil];
    
    int m = 0;
    int n = 0;
    for (int i = 0 ; i < 3 ; i++ ) {
        if ([activeFirstArray[i] isEqualToString:@"0"]) {
            [self.activityFirst[m] setHidden:NO];
            [self.activityFirst[m] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",activeImgArray[i]]]];
            m++;
        }
        if ([activeSecondArray[i] isEqualToString:@"0"]) {
            [self.activitySecond[n] setHidden:NO];
            [self.activitySecond[n] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",activeImgArray[i]]]];
            n++;
        }
    }
}

#pragma mark 推荐商户点击事件
- (IBAction)businessFirstBtnClick:(id)sender {
    if (_shopRequestArr.count > 0) {
        [self toBusinessInfoVC:[NSString stringWithFormat:@"%@",self.businessModels[0]]];
    }
}
- (IBAction)businessSecondBtnClick:(id)sender {
    if (_shopRequestArr.count > 0) {
        [self toBusinessInfoVC:[NSString stringWithFormat:@"%@",self.businessModels[1]]];
    }
}

- (void)toBusinessInfoVC:(NSString *)businessId {
    if (kkNickDicPHP == nil || [HUserId isEqualToString:@""]) {
        
        LoginViewController *loginPublic = [[LoginViewController alloc]init];
        loginPublic.viewControllerIndex = 4;
        [self.navigationController pushViewController:loginPublic animated:YES];
        
    } else {
        
        ListTableViewController * list = [[ListTableViewController alloc]init];
        //商户id到这
        list.ownerId = businessId;
        [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
        [self.navigationController pushViewController:list  animated:YES];
    }
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
