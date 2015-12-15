//
//  LaoYiLaoBaseViewController.m
//  LaoYiLao
//
//  Created by sunsu on 15/11/2.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "LaoYiLaoBaseViewController.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialData.h"
#import "UMSocial.h"
#import "UMSocialControllerService.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialSinaSSOHandler.h"

@interface LaoYiLaoBaseViewController ()<BarViewDelegate,UMSocialUIDelegate>
{
    int _shareContentType; // 分享平台
}
@end

@implementation LaoYiLaoBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createCustomNavigation];
    
//    _isAvailible = [self isConnectionAvailable];
//    if (_isAvailible == YES) {
////        [self showUIWithNetwork];
//    }
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void)createCustomNavigation
{
    self.navigationController.navigationBar.hidden = YES;
    self.customNavigation = [[BarView alloc]initWithFrame:CGRectMake(0, 0, kkViewWidth, 64)];
//    self.customNavigation.backgroundColor = [UIColor colorWithRed:0.81f green:0.16f blue:0.16f alpha:1.00f];
    self.customNavigation.delegate = self;
    [self.view addSubview:self.customNavigation];
}
#pragma navigationBarDelegate
-(void)backBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)helpBtnClicked{
}

-(void)shareBtnClicked{
    NSLog(@"分享");
}


//改变标题
// 改变导航栏标题
- (void) changeBarTitleWithString:(NSString *) title{
    if (!title || title.length == 0) {
        self.customNavigation.titleLabel.text = nil;
    } else if (self.customNavigation.titleLabel) {
        self.customNavigation.titleLabel.text = title;
        int count =[self convertChineseLengthToInt:title];
        if (count > 6) {
             self.customNavigation.titleLabel.font = [UIFont systemFontOfSize:18];
        }else {
            self.customNavigation.titleLabel.font = [UIFont systemFontOfSize:20];
        }
        
    }
}

-  (int)convertChineseLengthToInt:(NSString*)string {
    
    int strLength = 0;
    char* p = (char*)[string cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[string lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strLength++;
        }
        else {
            p++;
        }
    }
    return (strLength+1)/2;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma  mark --  网络状况
//-(BOOL) isConnectionAvailable{
//    
//    BOOL isExistenceNetwork = YES;
//    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
//    switch ([reach currentReachabilityStatus]) {
//        case NotReachable:
//            isExistenceNetwork = NO;
//            NSLog(@"notReachable");
//            break;
//        case ReachableViaWiFi:
//            isExistenceNetwork = YES;
//            NSLog(@"WIFI");
//            break;
//        case ReachableViaWWAN:
//            isExistenceNetwork = YES;
//            NSLog(@"3G");
//            break;
//        default:
//            break;
//    }
//    
//    if (!isExistenceNetwork) {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.removeFromSuperViewOnHide =YES;
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"当前网络不可用，请检查网络连接";
//        hud.minSize = CGSizeMake(132.f, 50.0f);
//        hud.frame = CGRectMake((kkViewWidth-132)/2, kkViewHeight/2+50, 132, 50);
//        [hud hide:YES afterDelay:3];
//        return NO;
//    }
//    
//    return isExistenceNetwork;
//}




- (void)baseShareText:(NSString *)text withUrl:(NSString *)idStr withContent:(NSString *)content withImageName:(NSString *)imagePath ImgStr:(NSString *)AimgStr domainName:(NSString *)AdomainName withqqTitle:(NSString *)qqTitle withqqZTitle:(NSString *)qqZTitle withweCTitle:(NSString *)weCTitle withweChtTitle:(NSString *)weChtTitle withsinaTitle:(NSString *)sinaTitle
{
    [UMSocialQQHandler setQQWithAppId:QQ_APPID appKey:QQ_APPKEY url:idStr];
    [UMSocialWechatHandler setWXAppId:WX_APPID appSecret:URL_LYL_SHARE url:idStr];
    [UMSocialSinaHandler openSSOWithRedirectURL:OpenSSOWithRedirectURL];
//    [UMSocialSinaHandler openNewSinaSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];

    // 分享标题
    //QQ空间
    [UMSocialData defaultData].extConfig.qzoneData.title = qqZTitle;//qq空间

    //QQ
    [UMSocialData defaultData].extConfig.qqData.title = qqTitle;
    
    
    [UMSocialData defaultData].extConfig.wechatSessionData.title = weChtTitle;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title= weCTitle;
    
    /*
    [UMSocialData defaultData].extConfig.qzoneData.shareText = text;//qq空间
    [UMSocialData defaultData].extConfig.qqData.shareText = text;
    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = text;
    [UMSocialData defaultData].extConfig.sinaData.shareText = sinaTitle;
    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText  = weCTitle;
*/
    
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeDefault url:idStr];
    if(imagePath.length > 0) {
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:imagePath];
    }else {
        
    } 
    
 
    
    NSString *contentTitle = @"";
    if ([content isEqualToString:@""]) {
        contentTitle = @"我在过年秀捞一捞活动捞到50个饺子，点我你也有钱拿。";
    }else{
        //设置分享内容
        contentTitle = [NSString stringWithFormat:@"%@ %@",text,idStr];
    }
    
    UIImage *shareImage = nil;
    
    NSRange range = [AimgStr rangeOfString:@"http"];
    
    if ([AimgStr isEqualToString:@""]) {
        shareImage = [UIImage imageNamed:@"9_default_avatar"];
    } else if (range.length > 0) {
        NSURL * imageURL = [NSURL URLWithString:AimgStr];
        NSData * data = [NSData dataWithContentsOfURL:imageURL];
        shareImage = [UIImage imageWithData:data];
    } else {
        shareImage = [UIImage imageNamed:AimgStr];
    }
    
    [UMSocialData defaultData].extConfig.qqData.shareImage = shareImage;
    [UMSocialData defaultData].extConfig.sinaData.shareImage = shareImage;
    [UMSocialData defaultData].extConfig.qzoneData.shareImage = shareImage;
//    [UMSocialData defaultData].shareImage = shareImage;
    NSArray * sharePlatformArray = @[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone];
    if (sharePlatformArray.count == 0) {
        [LYLTools showInfoAlert:@"当前设备没有任何可分享应用，请安装应用后再分享"];
    }
    
    //设置分享
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:LYL_UM_KEY
                                      shareText:contentTitle
                                     shareImage:shareImage
                                shareToSnsNames:sharePlatformArray
                                       delegate:self];
   
    
//新浪微博 弹出编辑页面
//    [[UMSocialControllerService defaultControllerService] setShareText:@"分享内嵌文字" shareImage:[UIImage imageNamed:@"icon"] socialUIDelegate:self];        //设置分享内容和回调对象
//    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
}


-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
//    if (platformName == UMShareToSina) {
//
//    }
    if([MyObjectForKey(ShareTypeKey) isEqualToString:ShareTypeWithBounce]){
        ZHLog(@"奖励次数");
        [LYLAFNetWorking getWithBaseURL:[LYLHttpTool markShareWithUserId:MyObjectForKey(UserIDKey) productCode:ProductCode sysType:SysType andSessionValue:SessionValue] success:^(id json) {
            ZHLog(@"%@",json);
        } failure:^(NSError *error) {
            ZHLog(@"%@",error);
        }];
    }else if ([MyObjectForKey(ShareTypeKey) isEqualToString:ShareTypeWithNavBar]){
        ZHLog(@"导航分享");

    }else if ([MyObjectForKey(ShareTypeKey) isEqualToString:ShareTypeWithMyDumpling]){
        ZHLog(@"炫耀一下");

    }

    
}

//新浪直接分享 只对新浪有效
//-(BOOL)isDirectShareInIconActionSheet
//{
//    return YES;
//}
///**
// 自定义关闭授权页面事件
// 
// @param navigationCtroller 关闭当前页面的navigationCtroller对象
// 
// */
//-(BOOL)closeOauthWebViewController:(UINavigationController *)navigationCtroller socialControllerService:(UMSocialControllerService *)socialControllerService{
//    
//}
//
///**
// 关闭当前页面之后
// 
// @param fromViewControllerType 关闭的页面类型
// 
// */
//-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType;

/**
 各个页面执行授权完成、分享完成、或者评论完成时的回调函数
 
 @param response 返回`UMSocialResponseEntity`对象，`UMSocialResponseEntity`里面的viewControllerType属性可以获得页面类型
 */
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
        NSLog(@"%@",response);
        if(response.responseCode == UMSResponseCodeSuccess)
        {
//            [Tools showInfoAlert:@"分享成功"];
            
            //得到分享到的微博平台名
            NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//            if([MyObjectForKey(ShareTypeKey) isEqualToString:ShareTypeWithBounce]){
//                [LYLAFNetWorking getWithBaseURL:[SINOHttptool markShareWithUserId:MyObjectForKey(UserIDKey) productCode:ProductCode sysType:SysType andSessionValue:SessionValue] success:^(id json) {
//                    ZHLog(@"%@",json);
//                } failure:^(NSError *error) {
//                    ZHLog(@"%@",error);
//                }];
//            }else if ([MyObjectForKey(ShareTypeKey) isEqualToString:ShareTypeWithNavBar]){
//                
//            }else if ([MyObjectForKey(ShareTypeKey) isEqualToString:ShareTypeWithMyDumpling]){
//                
//            }
            
            
        }else {
            if (response.responseCode == UMSResponseCodeShareRepeated) {
                [LYLTools showInfoAlert:@"这条信息您已分享过了"];
            }else if (response.responseCode == UMSResponseCodeCancel) {
                [LYLTools showInfoAlert:@"您已取消此次分享"];
            }else{
                [LYLTools showInfoAlert:@"分享失败"];
            }
        }
}


@end
