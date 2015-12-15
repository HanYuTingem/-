//
//  AppDelegate.m
//  ChillingAmend
//
//  Created by svendson on 14-12-17.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "RegisteredViewController.h"
#import "PersonalCenterViewController.h"
#import "YXSqliteHeader.h"
#import "APService.h"
#import "GS_LogoView.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialWechatHandler.h"
#import "PrizeViewController.h"
#import "NdUncaughtExceptionHandler.h"
#import "HelpViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ZXYOrderListViewController.h"
#import "LSYSeckillingListViewController.h"
#import "MobClick.h"
#import "ZXYCommitOrderRequestModel.h"
//565d3d56e0f55a169f0004c3
//#define YoumengAppKey @"5328fbfa56240b9ada067458"
#define YoumengAppKey @"565d3d56e0f55a169f0004c3"
#define FIRST_OPEN_APPLICATION_KEY @"firstOpneTheApplication" //第一次开启应用的key

static AppDelegate *appdelegate;

@interface AppDelegate ()
@property (nonatomic,strong) GS_LogoView* loadingView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    // bug日志 THE_DEVELOPMENT_STATUS @"2"//1,为开发状态  2,为测试状态  3,为上线状态
    //    [NdUncaughtExceptionHandler setDefaultHandler];
    //    [[NdUncaughtExceptionHandler Instence] sethttpBug];
    
    
    //地图初始化
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:BD_MAP  generalDelegate:nil];
    
    if (!ret) {
        NSLog(@"地图初始化失败!");
    } else {
        NSLog(@"地图初始化成功!");
    }
    
    if (!CityName) {
        [[NSUserDefaults standardUserDefaults] setObject:@"辽宁市" forKey:@"CityName"];
    }
    
    [self getUserLocation];
    
    // 友盟统计
    [MobClick startWithAppkey:YoumengAppKey reportPolicy:BATCH channelId:nil];
    [UMSocialData setAppKey:YoumengAppKey];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick setLogEnabled:YES];
    [MobClick event:@"openApp"];
    
    // 单例数据
    NSMutableDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"usernameMessage"];
    if (dic) {
        [[BSaveMessage Share] resetInfo:dic];
    }
        
    //数据库的创建
    FMDatabase* database= [FMDatabase databaseWithPath:[self databasePath]];
    if (![database open]) {
        NSLog(@"Open database failed");
    } else {
        NSLog(@"Open database success");
    }
    if (![database tableExists:@"historyList"]) {
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' TEXT, '%@' INTEGER, '%@'  TEXT)",TABLE_NAME, @"id", TABLE_TITLE, TABLE_CONTENT, TABLE_TYPE, TABLE_DATE];
        BOOL res = [database executeUpdate:sqlCreateTable];
        if (!res) {
            NSLog(@"error when creating db table");
        } else {
            NSLog(@"success to creating db table");
        }
        [database close];
    }
    
    [UMSocialData defaultData].extConfig.qqData.title=@"来自黑土的分享";//qq
    [UMSocialData defaultData].extConfig.qzoneData.title=@"来自黑土的分享";//qq空
    [UMSocialData defaultData].extConfig.wechatSessionData.title=@"来自黑土的分享";//微信好友
    [UMSocialData defaultData].extConfig.tencentData.title=@"来自黑土的分享";//腾讯
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
    
//    // 极光推送
//    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                   UIRemoteNotificationTypeSound |
//                                                   UIRemoteNotificationTypeAlert)
//                                       categories:nil];
    
    
    [APService setupWithOption:launchOptions];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidLogin:) name:kJPFNetworkDidSetupNotification object:nil];
    
    [self judgeFirstLaunch];
    if ([GCUtil connectedToNetwork]) {
        [self initializeLoadingView];
    }
    
    //判断是否第一次开启应用 没有的情况下存个值 添加引导页
    /*
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:FIRST_OPEN_APPLICATION_KEY]) {
        [userDefaults setObject:@"1" forKey:FIRST_OPEN_APPLICATION_KEY];
        [userDefaults synchronize];// 存盘
        // 添加引导页
        HelpViewController *guidPageControl = [[HelpViewController alloc]initWithNibName:nil bundle:nil];
        guidPageControl.delegate = self;
        guidPageControl.onStartClick = @selector(loadHomePageViewController);
        self.window.rootViewController = guidPageControl;
    } else {
        // 加载首页的试图控制器
        [self loadHomePageViewController];
    }
     */
    [self loadHomePageViewController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self.window  addSubview:self.loadingView];
    
    return YES;
}

// 调用加载首页的试图控制器
- (void)loadHomePageViewController
{
    self.homeTabBarController = [[GAHomeTabBarController alloc] init];
    [self.homeTabBarController.homeTabBar onHomePageButtonClicked:nil];
    self.window.rootViewController = self.homeTabBarController;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    /*支付宝回调 重要
     */
    //跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService]
         processOrderWithPaymentResult:url
         standbyCallback:^(NSDictionary *resultDic) {
             NSLog(@"result = %@", resultDic);
             commitModel = [ZXYCommitOrderRequestModel shareInstance];
             commitModel.payStatu = resultDic[@"resultStatus"];
             
             if ([commitModel.payView isEqual:@"HeiTuDiApp"]) {
                 //商城
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"judgePayStatu" object:self];
             }else{
             }
             
         }];
        return YES;
    }
    
    return  [UMSocialSnsService handleOpenURL:url];
}

#pragma mark 第一次加载
- (void)judgeFirstLaunch
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"launchFirst"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"launchFirst"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"appFirstInstall"]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"appFirstInstall"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"alertShowFirst"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ISPL"]; // yes 表示以后可以弹出   no表示以后不再弹出
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

#pragma mark GCRequestDelegate
- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    NSMutableDictionary *dict= [aString JSONValue];
    // 广告
    if ([[[aString JSONValue] objectForKey:@"code"]intValue] == 0) {
        NSString *adUrl = dict[@"img"];
        NSLog(@"guanggao = %@", adUrl);
        if (!adUrl.length > 0) {
            [self performSelector:@selector(hiddenLoadingImage) withObject:self afterDelay:0];
        } else {
            self.loadingView.imageUrl = dict[@"start_img"]; // 启动
            self.loadingView.adUrl = dict[@"img"];
        }
    } else {
        [self performSelector:@selector(hiddenLoadingImage) withObject:self afterDelay:0];
    }
}

- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self performSelector:@selector(hiddenLoadingImage) withObject:self afterDelay:0];
}

#pragma mark 隐藏启动
- (void)hiddenLoadingImage
{
    [UIView animateWithDuration:.6 animations:^{
        self.loadingView.alpha = 0;
    }completion:^(BOOL finished) {
        [self.loadingView removeFromSuperview];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"adDisappear" object:nil];
    }];
}

#pragma mark 初始化启动页面
- (void)initializeLoadingView
{
    self.loadingView = [[[UINib nibWithNibName:@"GS_LogoView" bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
    self.loadingView.hideDelay = YES;
    
    // 广告
    advertisingRequest = [[GCRequest alloc] init];
    advertisingRequest.delegate = self;
    if (iPhone5) {
        [advertisingRequest requestHttpWithPost:CHONG_url withDict:[BXAPI advertiseMentForAppStartWithResolution:@"640*1136"]];
    } else {
        [advertisingRequest requestHttpWithPost:CHONG_url withDict:[BXAPI advertiseMentForAppStartWithResolution:@"640*960"]];
    }
}

#pragma mark - 极光推送
// 监听RegistrionID
- (void)networkDidLogin:(NSNotification *)notification
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString *ID= [ud objectForKey:@"registrionID"];
    if (ID==NULL) {
        ID = [APService registrationID];
        [ud setObject:ID forKey:@"registrionID"];
        [ud synchronize];
    }
}


// 注册deviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (NSString* )databasePath
{
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* dbPath = [path stringByAppendingPathComponent:DATABASE_NAME];
    return dbPath;
    
}

+ (AppDelegate *)sharedAppDelegate
{
    return appdelegate;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [MobClick event:@"ResignActiveApp"];
    [BMKMapView willBackGround];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [MobClick event:@"EnterBackground"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"inActiveTheApp"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//app启动
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    //     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [MobClick event:@"EnterForeground"];
    application.applicationIconBadgeNumber = 0;
    [APService setBadge:0];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationCent" object:@"yes"];
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    application.applicationIconBadgeNumber = 0;
    [APService setBadge:0];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PaymentFinish" object:@"yes"];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [MobClick event:@"BecomeActive"];
    [BMKMapView didForeGround];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MobClick event:@"Terminate"];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [APService handleRemoteNotification:userInfo];
    NSLog(@"userInfo = %@", userInfo);
    NSString *type = [userInfo objectForKey:@"type"];
    if (type && ![type isEqual:@""]) { // 消息类型
        if ([type intValue] == 3) { // 商城
            LSYSeckillingListViewController *lsyVC = [[LSYSeckillingListViewController alloc] init];
            lsyVC.miaoShaID = [userInfo objectForKey:@"id"];
            lsyVC.childMiaoShaID = userInfo[@"activityId"];                    //需要参数
            UIViewController *vc = [self topViewController];
            [vc.navigationController pushViewController:lsyVC animated:YES];
            [self.homeTabBarController hideTabBarAnimated:YES];
        } else {
            if (kkUserId && ![kkUserId isEqual:@""]) { // 用户已登录
                switch ([type intValue]) {
                    case 1: // 奖品
                    case 2: // 奖品
                    {
                        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"inActiveTheApp"]) {
                            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"inActiveTheApp"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            // 跳转奖品列表
                            GAHomeTabBarController * controller = (GAHomeTabBarController *)[self getCurrentRootViewController];
                            PrizeViewController *prize = [[PrizeViewController alloc] init];
                            UINavigationController *getNavi = (UINavigationController *)controller.selectedViewController;
                            if (!(getNavi && ![getNavi.visibleViewController isKindOfClass:[LoginViewController class]])) {
                                getNavi = (UINavigationController *)self.homeTabBarController.selectedViewController;
                            }
                            [getNavi pushViewController:prize animated:YES];
                            [self.homeTabBarController hideTabBarAnimated:YES];
                        }
                    }
                        break;
                    default:
                        break;
                }
            } else {
                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"inActiveTheApp"]) {
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"inActiveTheApp"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    // 跳转登录界面
                    GAHomeTabBarController * controller = (GAHomeTabBarController *)[self getCurrentRootViewController];
                    LoginViewController *login = [[LoginViewController alloc] init];
                    login.viewControllerIndex = 6;
                    UINavigationController *getNavi = (UINavigationController *)controller.selectedViewController;
                    if (!(getNavi && ![getNavi.visibleViewController isKindOfClass:[LoginViewController class]])) {
                        getNavi = (UINavigationController *)self.homeTabBarController.selectedViewController;
                    }
                    
                    [getNavi pushViewController:login animated:YES];
                    [self.homeTabBarController hideTabBarAnimated:YES];
                }
            }
            
        }
    }
    application.applicationIconBadgeNumber = 0;
    [APService setBadge:0];
    completionHandler(UIBackgroundFetchResultNewData);
}

// 获取当前的viewcontroller
- (UIViewController *)getCurrentRootViewController
{
    UIViewController *result;
    // Try to find the root view controller programmically
    // Find the top window (that is not an alert view or other window)
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    if (topWindow.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (topWindow in windows) {
            if (topWindow.windowLevel == UIWindowLevelNormal) {
                break;
            }
        }
    }
    
    UIView *rootView;
    if ([topWindow subviews].count > 0) {
        rootView = [[topWindow subviews] objectAtIndex:0];
    }
    
    id nextResponder;
    if (rootView) {
        nextResponder  = [rootView nextResponder];
    }
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil) {
        if (rootView) {
            result = topWindow.rootViewController;
        }
    } else {
        NSAssert(NO, @"ShareKit: Could not find a root view controller.  You can assign one manually by calling [[SHK currentHelper] setRootViewController:YOURROOTVIEWCONTROLLER].");
        result = self.homeTabBarController;
    }
    return result;
}

- (UIViewController*)topViewController
{
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

- (void)getUserLocation{
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSString *latitude = [NSString stringWithFormat:@"%f", userLocation.location.coordinate.latitude];
    [[NSUserDefaults standardUserDefaults] setObject:latitude forKey:@"latitude"];
    
    NSString *longitude = [NSString stringWithFormat:@"%f", userLocation.location.coordinate.longitude];
    [[NSUserDefaults standardUserDefaults] setObject:longitude forKey:@"longitude"];
    
    [_locService stopUserLocationService];
    _locService.delegate = nil;
    
    //    逆地理编码
    BMKGeoCodeSearch *search = [[BMKGeoCodeSearch alloc] init];
    search.delegate = self;
    BMKReverseGeoCodeOption *loc = [[BMKReverseGeoCodeOption alloc] init];
    loc.reverseGeoPoint = CLLocationCoordinate2DMake(LATITUDE, LONGITUDE);
    [search reverseGeoCode:loc];
}



- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    NSLog(@"%@", result.addressDetail.city);
    
    NSString *cityName = result.addressDetail.city;
    
    if (result.addressDetail.city != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:@"CityName"];
    }
    
    NSDictionary *dic = [Parameter getCityinfoWithCity:CityName];
    
    [AFRequest GetRequestWithUrl:NiceFood_Url parameters:dic andBlock:^(NSDictionary *Datas, NSError *error) {
        if (error == nil) {
            if ([Datas[@"rescode"] isEqualToString:@"0000"]) {
                NSString *cityId = Datas[@"cityId"];
                [[NSUserDefaults standardUserDefaults] setObject:cityId forKey:@"cityId"];
            }
        }
    }];
}


@end
