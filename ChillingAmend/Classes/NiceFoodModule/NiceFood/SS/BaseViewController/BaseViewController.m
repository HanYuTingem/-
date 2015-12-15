//
//  BaseViewController.m
//  QQList
//
//  Created by sunsu on 15/6/29.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UIImageView+WebCache.h"

#import "UMSocialSinaHandler.h"
@interface BaseViewController ()<MBProgressHUDDelegate>{
    MBProgressHUD *_hud;
    
     
}
@property (nonatomic, strong) UIView *closeview;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [backView setHidden:NO];
    [returnButton setImage:[UIImage imageNamed:@"msxq_0013_title_back"] forState:UIControlStateNormal];
    [backView addSubview:returnButton];
    
    self.rightNavItem                          = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightNavItem.frame                    = CGRectMake(SCREEN_WIDTH-2*PADDING-20,30,40,20);
    [self.rightNavItem setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.rightNavItem.tag                      = 3001;
    self.rightNavItem.enabled                  = NO;
    UIBarButtonItem *rightItem                 = [[UIBarButtonItem alloc] initWithCustomView:_rightNavItem];
    self.navigationItem.rightBarButtonItem     = rightItem;
    [self.rightNavItem setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [self.rightNavItem addTarget:self
                          action:@selector(sendBtn:)
                forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:self.rightNavItem];
    
    UIColor * color = [UIColor blackColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
     
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifactionAction) name:@"tiaoguojietu" object:nil];
    
}


- (void)notifactionAction{
    _jietu = YES;
}

-(void)createCustomNavView{
//    CGRect backBtnFrame = CGRectMake(RECTFIX_WIDTH(10), 20, 44, 44);
//    self.backBtn = [[UIButton alloc]initWithFrame:backBtnFrame];
//    [self.backBtn addTarget:self action:@selector(backToView) forControlEvents:UIControlEventTouchUpInside];
//    
//    CGRect backImgFrame = CGRectMake(10, (44-30)/2, 30, 30);
//    UIImageView *backImg = [[UIImageView alloc]initWithFrame:backImgFrame];
//    backImg.image = [UIImage imageNamed:@"msxq_0013_title_back.png"];
//    [self.backBtn addSubview:backImg];
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:(UIView*)self.backBtn];
    [self createRightNavItem];
    
}

- (void)createRightNavItem
{
    self.rightNavItem                          = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightNavItem.frame                    = CGRectMake(0, 0, 40, 20);
    [self.rightNavItem setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.rightNavItem.tag                      = 3001;
    self.rightNavItem.enabled                  = NO;
    UIBarButtonItem *rightItem                 = [[UIBarButtonItem alloc] initWithCustomView:_rightNavItem];
    self.navigationItem.rightBarButtonItem     = rightItem;
    [self.rightNavItem setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [self.rightNavItem addTarget:self
                          action:@selector(sendBtn:)
                forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 导航栏方法;
-(void)sendBtn:(id)sender{
    
    ZNLog(@"rightComment");
}

//-(void)backButtonClick{
//    [self.navigationController popViewControllerAnimated:YES];
//}


//提示框
-(void)showMsg:(NSString *)msg
{
    
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_hud];
    
    // Set custom view mode
    _hud.mode = MBProgressHUDModeCustomView;
    
    _hud.labelText = msg;
    [_hud show:YES];
    [_hud hide:YES afterDelay:1];
    _hud = nil;
    
}

-(void)showStartHud{
    
    if (!_hud) {
        _hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        _hud.delegate = self;
        _hud.labelText = @"加载中...";
        [_hud show:YES];
    }else{
        _hud.labelText = @"加载中...";
        [self.view bringSubviewToFront:_hud];
        [_hud show:YES];
    }
    
}

-(void)showStartHudWithString:(NSString*)str{
    if (!_hud) {
        _hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.delegate = self;
        _hud.labelText = str;
        [_hud show:YES];
    }else{
        _hud.labelText = str;
        [self.view bringSubviewToFront:_hud];
        [_hud show:YES];
    }
}

-(void)stopHud:(NSString *)str{
    _hud.labelText = str;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

- (void)showStartHud1
{
    MBProgressHUD *hud1 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud1.delegate = self;
    hud1.labelText = @"加载中...";
    [hud1 show:YES];
}


//
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = NO;
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = YES;
//}

- (void)close{
    _closeview = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_closeview setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_closeview];
    [self.view bringSubviewToFront:_closeview];
}

- (void)open{
    [_closeview removeFromSuperview];
}
#pragma mark -
#pragma mark -分享
- (void)baseShareText:(NSString *)text withUrl:(NSString *)idStr withContent:(NSString *)content withImageName:(NSString *)imagePath ImgStr:(NSString *)AimgStr domainName:(NSString *)AdomainName withqqTitle:(NSString *)qqTitle withqqZTitle:(NSString *)qqZTitle withweCTitle:(NSString *)weCTitle withweChtTitle:(NSString *)weChtTitle withsinaTitle:(NSString *)sinaTitle
{
    // 分享标题
    [UMSocialData defaultData].extConfig.qzoneData.title = qqZTitle;//qq空间
    [UMSocialData defaultData].extConfig.qqData.title = qqTitle;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = weChtTitle;
 //   [UMSocialData defaultData].extConfig.wechatTimelineData.title= weCTitle;
    [UMSocialData defaultData].extConfig.sinaData.shareText = sinaTitle;
    
    [UMSocialData defaultData].extConfig.qzoneData.shareText = text;//qq空间
    [UMSocialData defaultData].extConfig.qqData.shareText = text;
    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = text;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title= weCTitle;
 
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeDefault url:nil];
    if(imagePath.length > 0) {
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:imagePath];
    }else {
        
    }
    
    if (idStr == nil || [idStr isEqualToString:@""]) {
        idStr = @"http://ht.sinosns.cn/";
    }
    
    if (text == nil || [text isEqualToString:@""]) {
        text = @"来自黑土的分享";
    }
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
//    [UMSocialWechatHandler setWXAppId:@"wx1611bbef8acfa7ca" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:idStr];
//    //设置分享到QQ空间的应用Id，和分享url 链接
//    [UMSocialQQHandler setQQWithAppId:@"1101248410" appKey:@"c7394704798a158208a74ab60104f0ba" url:idStr];
    
    [UMSocialWechatHandler setWXAppId:@"wx68cbf500fcda3024" appSecret:@"ef37bd35b48296dfa2de86bb38841d43" url:idStr];
    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"1104996522" appKey:@"fLQqwcFnOaY026fi" url:idStr];
   
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    NSString *contentTitle = @"";
    if ([content isEqualToString:@""]) {
//        contentTitle = @"天天乐玩是最火爆的电视、观众互动神器，多种互动玩法，瞬间收礼收到爆！马上注册天天乐玩，和我一起赢取丰富奖品呦~~。加下载微门户地址（点击进入下载微门户页面，页面上有当前用户的唯一邀请码）。";
        contentTitle = [NSString stringWithFormat:@"%@ %@ %@",text,@"黑土 辽宁人的生活娱乐电商平台",idStr];
    }else{
        //设置分享内容
        contentTitle = [NSString stringWithFormat:@"%@ %@ %@",text,content,idStr];
    }
    
    UIImage *shareImage;
    
    if ([AimgStr isEqualToString:@""] || AimgStr == nil) {
        shareImage = [UIImage imageNamed:@"Icon_120x120.png"];
    }else{
        NSURL * imageURL = [NSURL URLWithString:AimgStr];
        NSData * data = [NSData dataWithContentsOfURL:imageURL];
        shareImage = [UIImage imageWithData:data];
    }
    
    
    
    //设置分享
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:YoumengAppKey
                                      shareText:contentTitle
                                     shareImage:shareImage
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone,nil]delegate:self];
}


-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    _isShareLoading = NO;
    [UMSocialConfig setFinishToastIsHidden:YES position:UMSocialiToastPositionCenter];
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        [self showMsg:@"分享成功"];
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
        NSLog(@"分享成功");
        
        // 需要展示分享数量的界面在这里发送通知~~~~~~~
        //shareContentType 投票首页1 投票详情2  报名详情3 节目首页4 节目详情5  爆料首页6 爆料详情7 活动详情8 资讯详情9 评论分享10  个人足迹分享11  获奖详情分享12 邀请分享13 关于界面的分享14  扫一扫分享15 魔幻拼图分享16
        if (_shareContentType == 6) {//爆料首页
            [self.turnDelegate discloseIndexTurnCount];
        }else if (_shareContentType == 7) {//爆料详情
            [self.turnDelegate discloseDetailTurnCount];
        }
    }else {
        if (response.responseCode == UMSResponseCodeShareRepeated) {
            [self showMsg:@"这条信息您已分享过了"];
        }else if (response.responseCode == UMSResponseCodeCancel) {
            [self showMsg:@"您已取消此次分享"];
        }else {
            [self showMsg:@"分享失败"];
        }
    }
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"shareEndHideTabBar" object:nil];
    //    GAHomeTabBarController *homeTabBar = [GAHomeTabBarController sharedHomeTabBarController];
    //    [homeTabBar hideTabBarAnimated:YES];
}





@end
