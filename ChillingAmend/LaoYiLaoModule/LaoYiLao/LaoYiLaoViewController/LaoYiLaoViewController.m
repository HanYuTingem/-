//
//  LaoYiLaoViewController.m
//  LaoYiLao
//
//  Created by sunsu on 15/10/29.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "LaoYiLaoViewController.h"
#import "BarView.h"
#import "SSDumplingView.h"
#import "LoadEffectView.h"
#import "SSNoNetView.h"
#import "BaoJiaoziView.h"

#import "SSMyDumplingModel.h"
#import "GetShareInfoModel.h"

#import "ActivityRuleViewController.h"
#import "LYLQuickLoginViewController.h"

#import "mineWalletViewController.h"
#import "AnimateView.h"
#import "BouncedView.h"
#import "ScrollBox.h"
#import "ScrollBoxItemView.h"
#import "ClickOnTheMoreView.h"
#import "SchematicDiagramView.h"
#import "GetMaxNumberModel.h"
#import "DumplingInforModel.h"
#import "DumplingInforListModel.h"
#import "NoGetMoneyView.h"
#import "UMSocial.h"
#import "RemainingDumplingNumberModel.h"
#import "WebViewController.h"
#import "ShareInfoManage.h"
#import "SSInfoDumpView.h"

#define MidHeight 2
#define AnimateHeight 500 //捞饺子动画的高度
#define LaoYiLaoScrollViewContentSize_H 0//捞一捞scrollView的contentsize高度
#define TimeIsOneDumplingList 18 / TimeMid / 2

//ScrollBox的frame
#define ScrollBoxX 0
#define ScrollBoxY CGRectGetMaxY(_animateView.frame)-2
#define ScrollBoxW kkViewWidth
#define ScrollBoxH 204

//点击更多的frame
#define ClickOnTheMoreViewX 0
#define ClickOnTheMoreViewY CGRectGetMaxY(_scrollBox.frame ) + LaoYiLaoScrollViewContentSize_H
#define ClickOnTheMoreViewW
#define ClickOnTheMoreViewH 48 *KPercenY

////未领取钱的Frame
//#define NoGetMoneyViewX 0//无所谓居中
//#define NoGetMoneyViewY 5 * KPercenY
//#define NoGetMoneyViewW 300
//#define NoGetMoneyViewH 30


@interface LaoYiLaoViewController ()<LoadEffectViewDelegate,UIScrollViewDelegate,AnimateViewDelegate,SSNoNetViewDelegate,SSInfoDumpViewDelegate,GetMoneyViewDelegate,SSBaoJiaoZiBtnViewDelegate>
{
    LoadEffectView * _loadEffectView;//加载view
    UIImageView * _posterImgView;//海报
    
    UIView *_backgroudView;//最底层view
    UIView *_titleView;//头部选择条的背景view
    
    
    UIScrollView *_scrollView;//包饺子。捞一捞 我得饺子界面的背景scrollview
    int _currentIndex;//当前界面的索引
    
    UIScrollView *_laoYiLaoScrollView;//捞一捞界面
    UIView *_baoJiaoZiView;//包饺子界面
    UIView *_woDeJiaoZiView;//我得饺子界面
    AnimateView *_animateView;//默认一点击勺就开始捞
    SSDumplingView * _ssDumplingView;
    SSNoNetView *_ssNoNetView;
    BaoJiaoziView * _baoJzQidaiView;//包饺子View
    
    
    UIButton  * _noDataLabel;//没有网络时的提示label
    UISwipeGestureRecognizer *_swipe;// 手势区别scrollView的事件
    
    BouncedView *_bounceView;//弹框的view
    ScrollBox *_scrollBox;//中奖信息的滚动的box
    
    SchematicDiagramView *_schematicDiagramView;//第一次进的时候  示意图界面
    ClickOnTheMoreView *_clickedOthTheMoreView;//点击更多的view
    
    int _maxNumber;//最大捞取次数
    //    int _remainingNumber;//剩余次数
    int _remainingDumplingNumber;//剩余饺子数
    
    NSMutableArray *_dumplingInforArray;
    NSTimer *_timer;//定时请求
    NoGetMoneyView *_noGetMoneyView;//没有领取的view
    
    NSString * _xianjinStr;
}

@end

@implementation LaoYiLaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(switchViewSelectIndex) name:@"popLYLVC" object:nil];

    MySetObjectForKey(_userID, UserIDKey);//存userID
    MySetObjectForKey(_phone, LoginPhoneKey);//存手机号
    ZHLog(@"LYLUserId = %@, LYLPhone = %@",LYLUserId,LYLPhone);
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self changeBarTitleWithString:@"捞一捞"];
    [self createLoadView];
    _currentIndex = 0;
    _dumplingInforArray = [NSMutableArray array];
    _swipe = [[UISwipeGestureRecognizer alloc]init];
    _bounceView = [[BouncedView alloc]init];
    _bounceView.viewController = self;
    
}
#pragma mark --  判断网络状态
- (void)judgeNetWorkStatus{
    /**
     *  监听网络状态连接成功与否
     */
    [LYLTools didConnectionStateChangedIsSuccessful:^{
        ZHLog(@"%有网");
        
        if(_currentIndex == 0){
            [self loadDataRemainingDumplingWithNumber];
        }else if (_currentIndex == 1){
            [self loadDataRemainingDumplingWithNumber];

        }else if (_currentIndex == 2){
            [self loadDataMyDumplingWithNetStateChange];
        }
       
//        [self loadDataMyDumpling];
        [self networkStatusOKWithView];

    } andFailure:^{
        ZHLog(@"%没网");
        [self networkStatusNOWithView];
    }];

}
//
//#pragma mark --  添加网络状态
//- (void)addNetWorkStatus{
//    //    /**
//    //     *  监听网络状态连接成功与否
//    //     */
//    //    [Tools didConnectionStateChangedIsSuccessful:^{
//    //        ZHLog(@"%有网");
//    //
//    //        [self networkStatusOKWithView];
//    //
//    //    } andFailure:^{
//    //        ZHLog(@"%没网");
//    //        [self networkStatusNOWithView];
//    //    }];
//    
//    
//    /**
//     *  监听网络
//     *
//     */
//    //        [Tools didConnectionStateChangedIsSuccessfulStatus:^(AFNetworkReachabilityStatus networkStatus) {
//    //            if(networkStatus == AFNetworkReachabilityStatusUnknown){
//    //                ZHLog(@"网络状态不确定");
//    //            }else if (networkStatus == AFNetworkReachabilityStatusReachableViaWWAN){
//    //                ZHLog(@"网络状态为蜂窝网络");
//    //            }else if (networkStatus == AFNetworkReachabilityStatusReachableViaWiFi){
//    //                ZHLog(@"网络状态Wifi");
//    //            }
//    //            [self loadDataNoLoginStatusNumber];
//    //            [self networkStatusOKWithView];
//    //
//    //        } andFailure:^{
//    //            ZHLog(@"网络不行");
//    //            [self networkStatusNOWithView];
//    //        }];
//    
//    [Tools didConnectionStateChanged:^{
//        
//        ZHLog(@"网络状态改变");
//        
//        if([LogingState isEqualToString:LoginStateYES]){//登陆状态
////            [self loadDataAddLYLDumplingWithNumber];
//            [self loadDataUserDumplingList];
//            [self networkStatusOKWithView];
//
//        }else{//未登录
//            [self loadDataNoLoginStatusMaxNumber];//未登录状态最大次数
//        }
//    }];
//}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.hidden = YES;
    [_scrollBox startTimer];//开启定时器
    [_timer setFireDate:[NSDate distantPast]];//开启定时器
    [_animateView startTimer];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];


    [_scrollBox stopTimer];//关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];//关闭定时器
    [_animateView stopTimer];
    
}


- (void)switchViewSelectIndex{
    [self.switchView rollingBackViewWithIndex:0 ];
    _currentIndex = 0;
}

#pragma mark 开场加载动画
-(void)createLoadView{
    _loadEffectView = [[LoadEffectView alloc]initWithFrame:CGRectMake(0, 0, kkViewWidth, kkViewHeight)];
    _loadEffectView.delegate = self;
    [_loadEffectView initUI];
}
-(void)startupview{
    [UIView animateWithDuration:2 animations:^{
        _loadEffectView.alpha = 0;
    }];
    [self createTiteView];
    [self performSelector:@selector(removeView) withObject:nil afterDelay:0.5];
}
-(void)removeView{
    _loadEffectView.alpha = 0;
    [_loadEffectView removeFromSuperview];
}


#pragma navigationBarDelegate
-(void)backBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)helpBtnClicked{
    ActivityRuleViewController * ar = [[ActivityRuleViewController alloc]init];
    [self.navigationController pushViewController:ar animated:YES];
}

#pragma mark 我的饺子界面按钮的代理方法
//分享活动
-(void)shareBtnClicked:(UIButton *)btn{
    MySetObjectForKey(ShareTypeWithNavBar, ShareTypeKey);
    [ShareInfoManage shareWithType:@"2" andAllMoney:@"" andViewController:self];
//    [ShareInfoManage shareActivityWithButton:btn andController:self];
}
//我包的饺子
- (void) ClickWoBaodeJiaozi{
    NSLog(@"包饺子点击方法");
}

//现金
- (void) ClickXianjin{
}
//优惠券
- (void) ClickYouhuiquan{

}

//贺卡
- (void) ClickHeka{

}

//炫耀一下
- (void) ClickXuanyaoyixia:(UIButton *)btn{
    MySetObjectForKey(ShareTypeWithMyDumpling, ShareTypeKey);
    [ShareInfoManage shareWithType:@"3" andAllMoney:_xianjinStr andViewController:self];
//    [ShareInfoManage shareJiaoziInfoWithButton:btn andController:self andAllMoney:_xianjinStr];
}

#pragma mark -- 添加选择及title图片
- (void)createTiteView{
    _backgroudView = [[UIView alloc]initWithFrame:CGRectMake(0, NavgationBarHeight, kkViewWidth, kkViewHeight + PosterHeight)];
    _backgroudView.backgroundColor = [UIColor colorWithPatternImage:[LYLTools scaleImage:[UIImage imageNamed:@"lao_bg"] ToSize:CGSizeMake(kkViewWidth, NavgationBarHeight)]];//最底层
    [self.view addSubview:_backgroudView];
    
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kkViewWidth, (PosterHeight+SwitchHeight + MidHeight * 2))];

    _titleView.backgroundColor = [UIColor clearColor];
    [_backgroudView addSubview:_titleView];
    
    CGRect posterFrame = CGRectMake(0, 0, kkViewWidth, PosterHeight);
    _posterImgView = [[UIImageView alloc]initWithFrame:posterFrame];
    _posterImgView.image = [UIImage imageNamed:@"lao_banner_top"];
    _posterImgView.backgroundColor = [UIColor cyanColor];
    [_titleView addSubview:_posterImgView];
    
    _switchView = [[ScrollTitleView alloc]initWithFrame:CGRectMake(SelectSwitchX,CGRectGetMaxY(_posterImgView.frame) + 2,kkViewWidth - SelectSwitchX * 2,SwitchHeight)];
    [_switchView createItem:@[@"捞一捞",@"包饺子",@"我的饺子",@"我的钱包"]];
    _switchView.backgroundColor = [UIColor clearColor];
    _switchView.layer.borderWidth = 1;
    _switchView.layer.borderColor = [UIColor whiteColor].CGColor;
    _switchView.layer.cornerRadius = 5;
    _switchView.clipsToBounds = YES;
    _switchView.layer.masksToBounds = YES;
    [_titleView addSubview:_switchView];
    
    [self addScrollewView];
    [self addUpSwipeGestureRecognizer];
    [self addDownSwipeGestureRecognizer];
    
}

#pragma mark -- 添加背景scrollview
- (void)addScrollewView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame), kkViewWidth, kkViewHeight - (NavgationBarHeight + SwitchHeight + 2 * MidHeight))];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(kkViewWidth * 3, 1);
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = NO;
    [_backgroudView addSubview:_scrollView];
    __weak  UIScrollView *blockScrollView = _scrollView;
    
    __weak LaoYiLaoViewController * vc = self;
    
    [_switchView setSelectIndexWithBlock:^(int index) {
        _currentIndex = index;
//        ZHLog(@"_selectSwitch  ===== %f", _switchView.sliderOffset);
        if(index < 3){
            if (index == 2) {
                if (LYLIsLoging) {//已登陆
                    blockScrollView.contentOffset = CGPointMake(kkViewWidth *index, 0);
                    [vc loadDataMyDumpling];

                }else{
                    LYLQuickLoginViewController  * quickLoginVC = [[LYLQuickLoginViewController alloc]init];
                    quickLoginVC.type = @"1";
                    quickLoginVC.backBlock = ^void(){
                        NSLog(@"afsdff");
                        if(LYLIsLoging){//已登陆
                            [vc loadDataMyDumpling];
                            blockScrollView.contentOffset = CGPointMake(kkViewWidth *index, 0);

                        }else{
                            [vc.switchView rollingBackViewWithIndex:0 ];
                            _currentIndex = 0;
                        }
                    };
                    [vc.navigationController pushViewController:quickLoginVC animated:YES];
                }
            }else{
                blockScrollView.contentOffset = CGPointMake(kkViewWidth *index, 0);
            }
            
            
        }else if (index == 3){
            if (LYLIsLoging) {//已登陆
                BOOL isYesNO = NO;//YES ----> pop NO----Push
                for (UIViewController *subVC in vc.navigationController.viewControllers) {
                    if([subVC isKindOfClass:[mineWalletViewController class]]){
                        isYesNO = YES;
                        [vc.navigationController popToViewController:subVC animated:YES];
                    }
                }
                if(isYesNO == NO){
                    mineWalletViewController *walletViewVC = [[mineWalletViewController alloc]init];
                    [vc.navigationController pushViewController:walletViewVC animated:YES];
                }
            }else{
                LYLQuickLoginViewController  * quickLoginVC = [[LYLQuickLoginViewController alloc]init];
                quickLoginVC.type = @"2";
                quickLoginVC.backBlock = ^void(){
                    [vc.switchView rollingBackViewWithIndex:0 ];
                    _currentIndex = 0;
                };
                [vc.navigationController pushViewController:quickLoginVC animated:YES];
            }
        }

    }];
//    [_selectSwitch setPressedHandler:^(NSUInteger index) {
//        ZHLog(@"_selectSwitch  ===== %f", _selectSwitch.sliderOffset);
//        if(index < 3){
//            if (index == 2) {
//                if ([LogingState isEqualToString:LoginStateYES]) {
//                    [vc loadDataMyDumpling];
//
//                }else{
//                    LYLQuickLoginViewController  * quickLoginVC = [[LYLQuickLoginViewController alloc]init];
//                    quickLoginVC.type = @"1";
//                    quickLoginVC.backBlock = ^void(){
//                        NSLog(@"afsdff");
//                        if([LogingState isEqualToString:LoginStateYES]){
//                            [vc loadDataMyDumpling];
////                            [vc.selectSwitch forceSelectedIndex:2 animated:YES];
//
//                        }else{
//                            [vc.selectSwitch forceSelectedIndex:0 animated:YES];
//                        }
//                    };
//                    [vc.navigationController pushViewController:quickLoginVC animated:YES];
//                }
//            }
//            
//            
//            
//            blockScrollView.contentOffset = CGPointMake(kkViewWidth *index, 0);
//        }else if (index == 3){
//            if ([LogingState isEqualToString:LoginStateYES]) {
//                MyWalletViewController *walletViewVC = [[MyWalletViewController alloc]init];
//                walletViewVC.backBlock = ^void(){
//                    [vc.selectSwitch forceSelectedIndex:0 animated:YES];
//                };
//                [vc.navigationController pushViewController:walletViewVC animated:YES];
//            }else{
//                LYLQuickLoginViewController  * quickLoginVC = [[LYLQuickLoginViewController alloc]init];
//                quickLoginVC.type = @"1";
//                quickLoginVC.backBlock = ^void(){
//                    [vc.selectSwitch forceSelectedIndex:0 animated:YES];
//                };
//                [vc.navigationController pushViewController:quickLoginVC animated:YES];
//            }
//        }

//    }];
    
    [self addLaoYiLaoView];
    [self addBaoJiaoZiView];
    
    [self woDeJiaoZiView];
    [self.view bringSubviewToFront:self.customNavigation];
    [self judgeNetWorkStatus];
    
//    [self addNetWorkStatus];
//    [self loadDataRemainingDumplingWithNumber];
}

#pragma mark -- 添加捞一捞界面
- (void)addLaoYiLaoView{
    _laoYiLaoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kkViewWidth, kkViewHeight - NavgationBarHeight - SwitchHeight - MidHeight * 2)];
    //    _laoYiLaoScrollView.contentSize = CGSizeMake(1, kkViewHeight *2);
    _laoYiLaoScrollView.scrollEnabled = NO;
    _laoYiLaoScrollView.bounces = NO;
    
    _laoYiLaoScrollView.showsVerticalScrollIndicator = NO;
    _laoYiLaoScrollView.backgroundColor = [UIColor clearColor];
    _laoYiLaoScrollView.delegate = self;
    [_scrollView addSubview:_laoYiLaoScrollView];
    
    [self addLaoYiLaoNONetworkView];
    [self addLaoYiLaoYESNetworkView];
    //    _timer = [NSTimer scheduledTimerWithTimeInterval:TimeIsOneDumplingList target:self selector:@selector(loadDataUserDumplingList) userInfo:nil repeats:YES];//循环掉中奖信息
}

#pragma mark -- 添加捞一捞没网的界面
/**
 *   添加捞一捞没网的界面
 */
- (void)addLaoYiLaoNONetworkView{
    ZHLog(@"增加没网界面");
    //没网的界面
    _ssNoNetView = [[SSNoNetView alloc]initWithFrame:CGRectMake(0, 0, kkViewWidth, kkViewHeight - NavgationBarHeight - SwitchHeight - MidHeight * 2)];
    _ssNoNetView.delegate = self;
    _ssNoNetView.hidden = YES;
    [_laoYiLaoScrollView addSubview:_ssNoNetView];
}

#pragma mark -- 没网界面的delegete
- (void)refreshNoNetView{
    [self loadDataNoLoginStatusMaxNumber];
}
#pragma mark -- 添加捞一捞有网界面
/**
 *  添加捞一捞有网界面
 */
- (void)addLaoYiLaoYESNetworkView{
    ZHLog(@"增加有网界面");

    _animateView = [[AnimateView alloc]initWithFrame:CGRectMake(0, 0, kkViewWidth, AnimateHeight * KPercenX)];
    _animateView.delegate  = self;
    [_laoYiLaoScrollView addSubview:_animateView];
    
    
    _scrollBox = [[ScrollBox alloc]initWithFrame:CGRectMake(ScrollBoxX, ScrollBoxY, ScrollBoxW, ScrollBoxH)];
    [_laoYiLaoScrollView addSubview:_scrollBox];
    NSLog(@"CGRectGetMaxY(_scrollBox.frame) = %f",CGRectGetMaxY(_scrollBox.frame));
    
    __block UIViewController *weakVC = self;
    _clickedOthTheMoreView = [[ClickOnTheMoreView alloc]initWithFrame:CGRectMake(ClickOnTheMoreViewX, ClickOnTheMoreViewY, kkViewWidth, ClickOnTheMoreViewH)];
    _clickedOthTheMoreView.moreBtnBlock = ^void(UIButton *button){
        WebViewController *webView = [[WebViewController alloc]init];
        [weakVC.navigationController pushViewController:webView animated:YES];
    };
    [_laoYiLaoScrollView addSubview:_clickedOthTheMoreView];
    
    
    //    _laoYiLaoScrollView.contentSize = CGSizeMake(1, CGRectGetMaxY(_clickedOthTheMoreView.frame) + 10);
    
    ZHLog(@"%f",_laoYiLaoScrollView.contentSize.height);
    
    
    if(!MyObjectForKey(IsFirstKey)){//判断是不是第一次进入这个界面
        //        __block AnimateView *blcokAnimateView = _animateView;
        __block LaoYiLaoViewController *blockLYLVC = self;
        _schematicDiagramView = [[SchematicDiagramView alloc]init];
        _schematicDiagramView.FirstBtnClickedBlock = ^void(){
            
            [blockLYLVC laoYiLaoAnimateBegin];//开始捞
            //            [blcokAnimateView start];//开始捞
            MySetObjectForKey(IsFirstNO,IsFirstKey);// 设置不是第一次启动
            ZHLog(@"将是否为第一次进入当前界面设置为否");
        };
        [[UIApplication sharedApplication].keyWindow addSubview:_schematicDiagramView];
    }
    
    _noGetMoneyView = [NoGetMoneyView shareGetMoneyView];
    _noGetMoneyView.center = CGPointMake(kkViewWidth / 2, _noGetMoneyView.center.y);
    [_noGetMoneyView refreshShareGetMoneyView];
    _noGetMoneyView.delegate = self;
    [_animateView addSubview:_noGetMoneyView];
}


#pragma mark -- getMoneyDelegate
- (void)getMoney{
    if(LYLIsLoging){//已登陆
        [self loadDataWithNoLoginGetMoney];
    }else{
        LYLQuickLoginViewController *quickVc = [[LYLQuickLoginViewController alloc]init];
        quickVc.backBlock = ^void(){
            
        };
        [self.navigationController pushViewController:quickVc animated:YES];
        ZHLog(@"去领钱");
    }
}


#pragma mark -- 添加包饺子界面
- (void)addBaoJiaoZiView{
    _baoJiaoZiView = [[UIView alloc]initWithFrame:CGRectMake(kkViewWidth, 0, kkViewWidth, kkViewHeight)];
//    _baoJiaoZiView.backgroundColor = [UIColor grayColor];
        _baoJiaoZiView.backgroundColor = [UIColor clearColor];

    [_scrollView addSubview:_baoJiaoZiView];
    
    CGFloat baoJz_H = kkViewHeight - NavgationBarHeight-SwitchHeight - 2 * MidHeight;
    _baoJzQidaiView = [[BaoJiaoziView alloc]initWithFrame:CGRectMake(0, 0, kkViewWidth, baoJz_H)];
    [_baoJiaoZiView addSubview:_baoJzQidaiView];
}

#pragma mark -- 我的饺子界面
- (void)woDeJiaoZiView{
    _woDeJiaoZiView = [[UIView alloc]initWithFrame:CGRectMake(kkViewWidth * 2, 0, kkViewWidth, kkViewHeight)];
//    _woDeJiaoZiView.backgroundColor = RGBACOLOR(242, 242, 242, 1);
    _woDeJiaoZiView.backgroundColor = [UIColor colorWithPatternImage:[LYLTools scaleImage:[UIImage imageNamed:@"lao_bg"] ToSize:CGSizeMake(kkViewWidth, NavgationBarHeight)]];
    [_scrollView addSubview:_woDeJiaoZiView];
    
    
    
    
    CGFloat info_H = kkViewHeight - NavgationBarHeight-SwitchHeight - 2 * MidHeight;
    CGRect infoFrame = CGRectMake(0, 0, kkViewWidth, info_H);
    
    _noDataLabel = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kkViewWidth, info_H-PosterHeight)];
    [_noDataLabel setTitle:@"没有网络,点此设置无线网络" forState:UIControlStateNormal];
    [_noDataLabel setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    _noDataLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
    _noDataLabel.hidden = YES;
    [_noDataLabel addTarget:self action:@selector(refreshByWifi) forControlEvents:UIControlEventTouchUpInside];
    [_woDeJiaoZiView addSubview:_noDataLabel];

    if (_ssDumplingView == nil) {
        _ssDumplingView = [[SSDumplingView alloc]initWithFrame:infoFrame];
        [_woDeJiaoZiView addSubview:_ssDumplingView];
    }
    _ssDumplingView.infoDumplingView.delegate = self;
    _ssDumplingView.baoJzView.delegate  = self;
    
    }

-(void)refreshByWifi{
    NSURL * url = [NSURL URLWithString:@"prefs:root=WIFI"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication  sharedApplication] openURL:url];
    }
}

#pragma mark -- 网络状态好的view的显示状态
/**
 *  网络状态好的view的显示状态
 */

- (void)networkStatusOKWithView{
    ZHLog(@"显示有网界面");

    _animateView.hidden = NO;
    _scrollBox.hidden = NO;
    _clickedOthTheMoreView.hidden = NO;
    _ssNoNetView.hidden = YES;
    _laoYiLaoScrollView.contentSize = CGSizeMake(1, CGRectGetMaxY(_clickedOthTheMoreView.frame) + LaoYiLaoScrollViewContentSize_H);
    
    _ssDumplingView.hidden = NO;
    _noDataLabel.hidden = YES;
    
}
#pragma mark -- 网络状态不好的view的显示状态
/**
 *  网络状态不好的view的显示状态
 */
- (void)networkStatusNOWithView{
    ZHLog(@"显示无网界面");
    _animateView.hidden = YES;
    _scrollBox.hidden = YES;
    _clickedOthTheMoreView.hidden = YES;
    _ssNoNetView.hidden = NO;
    _laoYiLaoScrollView.contentSize = CGSizeMake(1, CGRectGetMaxY(_ssNoNetView.frame) + LaoYiLaoScrollViewContentSize_H);

    _ssDumplingView.hidden = YES;
    _noDataLabel.hidden = NO;
}

#pragma mark --  scrollView 的delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _currentIndex = scrollView.contentOffset.x/kkViewWidth;
    if(_currentIndex == 0){
        [_scrollBox startTimer];//开启定时器
        [_animateView startTimer];
    }else{
        [_scrollBox stopTimer];//关闭定时器
        [_animateView stopTimer];
    }
    //    NSLog(@"%d",_currentIndex);
    if(scrollView == _laoYiLaoScrollView){
        if(_laoYiLaoScrollView.contentOffset.y < 0){
            _swipe.direction = UISwipeGestureRecognizerDirectionDown;
        }else if (_laoYiLaoScrollView.contentOffset.y > 0){
            _swipe.direction = UISwipeGestureRecognizerDirectionUp;
        }
        [self swipeUpOrDown:_swipe];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [_switchView rollingBackViewWithIndex:_currentIndex];
//    [_selectSwitch forceSelectedIndex:_currentIndex animated:YES];
}

#pragma mark - 添加手势
- (void)addUpSwipeGestureRecognizer{
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUpOrDown:)];
    upSwipe.direction  = UISwipeGestureRecognizerDirectionUp;//规定的轻扫方向
    [self.view addGestureRecognizer:upSwipe];
}


- (void)addDownSwipeGestureRecognizer{
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUpOrDown:)];
    upSwipe.direction  = UISwipeGestureRecognizerDirectionDown;//规定的轻扫方向
    [self.view addGestureRecognizer:upSwipe];
}


- (void)swipeUpOrDown:(UISwipeGestureRecognizer *)swipeUpOrDown{
    if(swipeUpOrDown.direction == UISwipeGestureRecognizerDirectionUp){
        //        NSLog(@"向上清扫le");
        if(_backgroudView.frame.origin.y == NavgationBarHeight){
            [UIView animateWithDuration:0.3 animations:^{
                
                _backgroudView.frame = CGRectMake(_backgroudView.frame.origin.x, _backgroudView.frame.origin.y - _posterImgView.frame.size.height, _backgroudView.frame.size.width, _backgroudView.frame.size.height);
                
                _laoYiLaoScrollView.scrollEnabled = YES;
            }];
        }
    }else if (swipeUpOrDown.direction == UISwipeGestureRecognizerDirectionDown){;
        if(_backgroudView.frame.origin.y < NavgationBarHeight){
            [UIView animateWithDuration:0.3 animations:^{
                
                _backgroudView.frame = CGRectMake(_backgroudView.frame.origin.x, _backgroudView.frame.origin.y + _posterImgView.frame.size.height, _backgroudView.frame.size.width, _backgroudView.frame.size.height);
                _laoYiLaoScrollView.scrollEnabled = NO;
                
            }];
        }
    }
}



#pragma mark -- 动画的delegate
- (void)laoYiLaoAnimateBegin{
    if(LYLIsLoging){
        [self loadDataLogingDumping];//登录捞饺子
    }else{
        [self loadDataNOLogingDumpling];//没有登录
    }
}

- (void)laoYiLaoAnimateFinished{

    if(_currentIndex == 0){
        [_bounceView addDumplingInforView];
        [self.navigationController.view addSubview:_bounceView];
        [[NoGetMoneyView shareGetMoneyView]refreshShareGetMoneyView];//更改跑马灯的状态
    }
    NSLog(@"结束捞");
}




#pragma mark --- 获取未登录捞取饺子上限
/**
 *  获取未登录捞取饺子上限
 */
- (void)loadDataNoLoginStatusMaxNumber{
    
    [self showHudInView:self.view hint:@"正在加载"];
    [LYLAFNetWorking getWithBaseURL:[LYLHttpTool noLogingNumberCeilingWithProductCode:ProductCode sysType:SysType andSessionValue:SessionValue] success:^(id json) {
        
        ZHLog(@"获取未登录捞取饺子上限json=%@",json);
        [self hideHud];
        if([json[@"code"] isEqualToString:@"100"]){
            
            GetMaxNumberModel *maxNumberModel = [GetMaxNumberModel getMaxNumberModelWithDic:(NSDictionary *)json];
            if([maxNumberModel.code isEqualToString:@"100"]){
                _maxNumber = IsStrWithNUll(maxNumberModel.count) ? 0 : [maxNumberModel.count intValue];
                [self loadDataUserDumplingList];
            }
            
        }
    } failure:^(NSError *error) {
        ZHLog(@"获取未登录捞取饺子上限失败=%@",error);
        [self networkStatusNOWithView];
        [self hideHud];
    }];
}


#pragma mark -- 未登录状态下捞饺子
/**
 *  未登录状态下捞饺子
 */
- (void)loadDataNOLogingDumpling{
    
    [self showHudInView:self.view hint:@""];
    [LYLAFNetWorking getWithBaseURL:[LYLHttpTool noLogingUserDumplingWithProductCode:ProductCode sysType:SysType andSessionValue:SessionValue] success:^(id json) {
        
        [self hideHud];
        if([((NSDictionary *)json)[@"code"] isEqualToString:@"100"]){
        
            DumplingInforModel *dumplingModel = [DumplingInforModel dumplingInforModelWithDic:(NSDictionary *)json];
            ZHLog(@"未登录状态下捞饺子json = %@",json);
            
            /**
             *  读缓存的饺子
             */
            NSMutableArray *dumplingInforArray = [NSMutableArray arrayWithContentsOfFile:DumplingInforNoLogingPath];
            if(!dumplingInforArray){
                dumplingInforArray = [[NSMutableArray alloc]init];
            }
            if(dumplingInforArray.count < _maxNumber){
                
                [dumplingInforArray addObject:json];//缓存饺子
                dumplingModel.resultListModel.userHasNum = [NSString stringWithFormat:@"%d",_maxNumber - (int)dumplingInforArray.count];//设置剩余次数
                ZHLog(@"有次数%d开始捞",_maxNumber - (int)dumplingInforArray.count);
                
                /**
                 *  写到缓存
                 */
                if([dumplingInforArray writeToFile:DumplingInforNoLogingPath atomically:YES]){
                    NSLog(@"未登录饺子缓存成功");
                }else{
                    NSLog(@"未登录饺子缓存失败");
                }
                
                _bounceView.dumplingInforModel = dumplingModel;
                [_animateView start];//开始动画
                
                //记录当前时间 存起来
                MySetObjectForKey([LYLTools currentDateWithDay], DumplingNoLogingTimeKey);
                
            }else{//没机会
                
                [_bounceView addSharedWithCeilingView];
                _bounceView.viewController = self;
                [self.navigationController.view addSubview:_bounceView];
                ZHLog(@"没次数  次数%d",_maxNumber - (int)dumplingInforArray.count);
            }
        }
        
    } failure:^(NSError *error) {
        [self hideHud];
        [LYLTools showInfoAlert:@"网络状态不好"];
        ZHLog(@"%@",error);
    }];
}

#pragma mark -- 登陆用户捞饺子
/**
 *  登陆用户捞饺子
 */
- (void)loadDataLogingDumping{
    
    /**
     *  读取饺子信息
     */
    NSMutableArray *dumplingInforArray = [NSMutableArray arrayWithContentsOfFile:DumplingInforLogingPath];
    if(!dumplingInforArray){
        dumplingInforArray = [NSMutableArray array];
    }
    [self showHudInView:self.view hint:@""];
    
    [LYLAFNetWorking getWithBaseURL:[LYLHttpTool logingUserDumplingWithUserId:LYLUserId logingPhone:LYLPhone productCode:ProductCode sysType:SysType andSessionValue:SessionValue] success:^(id json) {
        ZHLog(@"登陆用户捞饺子json =%@",json);
        [self hideHud];
        
        if([((NSDictionary *)json)[@"code"] isEqualToString:@"102"]){//没有次数
            [_bounceView addSharedWithCeilingView];
            _bounceView.viewController = self;
            [self.navigationController.view addSubview:_bounceView];//没次数
        }else if([((NSDictionary *)json)[@"code"] isEqualToString:@"100"]){//成功有次数
            DumplingInforModel *dumplingInforModel = [DumplingInforModel dumplingInforModelWithDic:(NSDictionary *)json];
            [dumplingInforArray addObject:json];
            
            /**
             *  写入缓存
             */
            if([dumplingInforArray writeToFile:DumplingInforLogingPath atomically:YES]){
                NSLog(@"写入成功");
            }else{
                NSLog(@"写入失败");
            }
            _bounceView.dumplingInforModel = dumplingInforModel;
            [_animateView start];//开始动画
            
            /**
             *  记录当前捞饺子时间
             */
            MySetObjectForKey([LYLTools currentDateWithDay], DumplingNoLogingTimeKey);
            
        }
        
        
    } failure:^(NSError *error) {
        [self hideHud];
        
        [LYLTools showInfoAlert:@"网络状态不好"];
        ZHLog(@"登陆用户捞饺子= %@",error);
    }];
    
}

#pragma mark -- 别人捞到饺子消息的列表
/**
 *  捞饺子用户列表(按时间倒序)
 */
- (void)loadDataUserDumplingList{
    
    //清除失效的缓存饺子
    if(LYLIsLoging){
        [LYLTools removeDumplingInforOfFailureWithPath:DumplingInforLogingPath];
    }else{
        [LYLTools removeDumplingInforOfFailureWithPath:DumplingInforNoLogingPath];
    }
    [[NoGetMoneyView shareGetMoneyView]refreshShareGetMoneyView];//更新跑马灯
    
    
    [LYLAFNetWorking getWithBaseURL:[LYLHttpTool userDumplingListWithProductCode:ProductCode sysType:SysType andSessionValue:SessionValue ] success:^(id json) {
        ZHLog(@"捞饺子用户列表(按时间倒序)json = %@",json);
        if([json[@"code"] isEqualToString:@"107"]){
            [LYLTools showInfoAlert:@"还没有中奖信息哦"];
        }else if ([json[@"code"] isEqualToString:@"100"]){
            DumplingInforListModel *dumplingInforModel = [DumplingInforListModel dumplingInforListModelWithDic:(NSDictionary *)json];
            [_dumplingInforArray addObjectsFromArray:dumplingInforModel.dumplingInforList];
            if(_dumplingInforArray.count != 0){
                [_scrollBox addItemWithArray:_dumplingInforArray];
            }
        }
    } failure:^(NSError *error) {
        ZHLog(@"%@",error);
        [self showHint:@"网络状态不好，中奖信息加载失败"];
        //        [Tools showInfoAlert:@"获取中奖信息失败"];
    }];
}


#pragma mark -- 我得饺子
/**
 *  我得饺子
 */
- (void)loadDataMyDumpling{
    [self showHudInView:self.view hint:@"正在加载"];

    NSString * urlStr = [LYLHttpTool myDumplingWithProductCode:ProductCode sysType:SysType andSessionValue:SessionValue andUserId:MyObjectForKey(UserIDKey)];
    [LYLAFNetWorking postWithBaseURL:urlStr success:^(id json) {
        ZHLog(@"我的饺子==%@",json);
        [self hideHud];
        if([json[@"code"] isEqualToString:@"100"]){
            _xianjinStr = json[@"resultList"][@"price"];
            SSMyDumplingModel *myDumpModel = [SSMyDumplingModel getMyDumplingModelWithDic:(NSDictionary *)json];
            _ssDumplingView.myDumModel = myDumpModel;
        }
    } failure:^(NSError *error) {
        ZHLog(@"%@",error);
        [self hideHud];
    }];
}

#pragma mark -- 在我的饺子界面时网络从没网到有网
- (void)loadDataMyDumplingWithNetStateChange{
    [self showHudInView:self.view hint:@"正在加载"];
    
    NSString * urlStr = [LYLHttpTool myDumplingWithProductCode:ProductCode sysType:SysType andSessionValue:SessionValue andUserId:MyObjectForKey(UserIDKey)];
    [LYLAFNetWorking postWithBaseURL:urlStr success:^(id json) {
        ZHLog(@"我的饺子==%@",json);
        [self hideHud];
        if([json[@"code"] isEqualToString:@"100"]){
            _xianjinStr = json[@"resultList"][@"price"];
            SSMyDumplingModel *myDumpModel = [SSMyDumplingModel getMyDumplingModelWithDic:(NSDictionary *)json];
            _ssDumplingView.myDumModel = myDumpModel;
            [self loadDataRemainingDumplingWithNumber];
        }
    } failure:^(NSError *error) {
        ZHLog(@"%@",error);
        [self hideHud];
    }];
}

#pragma mark -- （1）剩余饺子数
/**
 *  剩余饺子数
 */
- (void)loadDataRemainingDumplingWithNumber{
    [self showHudInView:self.view hint:@"正在加载"];
    [LYLAFNetWorking getWithBaseURL:[LYLHttpTool currentDumplingWithNumberProductCode:ProductCode sysType:SysType andSessionValue:SessionValue]success:^(id json) {
        ZHLog(@"%@",json);
        [self hideHud];
        if([json[@"code"] isEqualToString:@"100"]){
            RemainingDumplingNumberModel *remainingModel = [RemainingDumplingNumberModel remainingDumplingNumberModelWithDic:(NSDictionary *)json];
            _animateView.number = [remainingModel.number intValue];
            [_animateView startTimer];
            [self networkStatusOKWithView];
            
            if(LYLIsLoging){//已登陆
                [self loadDataUserDumplingList];//请求获奖信息列表  写后边

            }else{
                [self loadDataNoLoginStatusMaxNumber];//获取未登录捞饺子上限
            }
        }
    } failure:^(NSError *error) {
        [self hideHud];
        [self networkStatusNOWithView];

//        [self addNetWorkStatus];
        ZHLog(@"%@",error);
    }];
}

/**
 {“code”:  101 系统错误
 “message”:”There’s an error.” //错误说明
 }
 展示捞奖次数不足，领取失败，提示可以换个手机号领取
 {“code”:  102 //展示捞奖次数不足
 “message”:” 领取失败，提示可以换个手机号领取.” //失败说明
 }
 
 {“code”:  103 登陆失败
 “message”:”” // 验证码错误 注册失败
 }
 {“code”:  104 //饺子已过期
 “message”:” 饺子已过期” //失败说明
 }
 {““code”:  105 //饺子已被领取
 “message”:” 饺子已被领取.” //失败说明
 }
 {“code”:  106//参数不正确
 “message”:” 参数不正确” //失败说明
 }
 {“code”:  107//饺子配置规则缓存无数据
 “message”:” 饺子配置规则缓存无数据” //失败说明
 }
 {“code”:  108 //用户饺子配置规则缓存无数据
 “message”:” 用户饺子配置规则缓存无数据” //失败说明
 }
 {“code”:  109 //饺子缓存为空
 “message”:” 饺子缓存为空” //失败说明
 }
 */
#pragma mark -- 调用领取接口
-(void)loadDataWithNoLoginGetMoney{
    
    //未登录饺子存储的饺子
    NSMutableArray *dumplingInforNoLogingArray = [NSMutableArray arrayWithContentsOfFile:DumplingInforNoLogingPath];
    NSMutableArray *dumplingIdArray = [NSMutableArray array];//未登录没有领取的饺子
    for (NSDictionary *subDic in dumplingInforNoLogingArray) {
        DumplingInforModel *model = [DumplingInforModel dumplingInforModelWithDic:subDic];
        [dumplingIdArray addObject:model.resultListModel.dumplingModel.prizeId];
    }
    NSString *dumplingStr =  [dumplingIdArray componentsJoinedByString:@","];
    
    
    [self showHudInView:self.view hint:@"正在领取。。。"];
    [LYLAFNetWorking getWithBaseURL:[LYLHttpTool noLogingGetMoneyWithProductCode:ProductCode sysType:SysType sessionValue:SessionValue phone:MyObjectForKey(LoginPhoneKey)  prizeidList:dumplingStr andUserId:MyObjectForKey(UserIDKey)] success:^(id json) {
        ZHLog(@"%@",json);
        [self hideHud];
        
        switch ([[json objectForKey:@"code"] intValue]) {
            case 100://领取成功
            {
                [self showHint:@"领取成功"];
                NSMutableArray *logingArray = [NSMutableArray arrayWithContentsOfFile:DumplingInforLogingPath];
                if(!logingArray){
                    logingArray = [NSMutableArray array];
                }
                [logingArray addObjectsFromArray:dumplingInforNoLogingArray];
                [logingArray writeToFile:DumplingInforLogingPath atomically:YES];//将未登录的饺子存为已登陆的
                
                /**
                 *  更给储存未登陆的饺子信息
                 */
                [dumplingInforNoLogingArray removeAllObjects];
                [dumplingInforNoLogingArray writeToFile:DumplingInforNoLogingPath atomically:YES];
                
            }
                break;
            case 101:
            {
                [LYLTools showInfoAlert:@"系统错误"];
            }
                break;
            case 102:
            {
                [LYLTools showInfoAlert:@"领取失败，可以换个手机号领取"];
            }
                break;
            case 103:
            {
                
                [LYLTools showInfoAlert:@"登陆失败"];
            }
                break;
            case 104:
            {
                [dumplingInforNoLogingArray removeAllObjects];
                [dumplingInforNoLogingArray writeToFile:DumplingInforNoLogingPath atomically:YES];
                [LYLTools showInfoAlert:@"饺子已过期"];
            }
                break;
            case 105:{
                [dumplingInforNoLogingArray removeAllObjects];
                [dumplingInforNoLogingArray writeToFile:DumplingInforNoLogingPath atomically:YES];
                [LYLTools showInfoAlert:@"饺子已被领取"];
            }
                break;
                
            case 106:
            {
                //                [Tools showInfoAlert:@"参数不正确"];
            }
                break;
            case 107:
            case 108:
            case 109:{
                [dumplingInforNoLogingArray removeAllObjects];
                [dumplingInforNoLogingArray writeToFile:DumplingInforNoLogingPath atomically:YES];
                [LYLTools showInfoAlert:@"饺子信息无效"];
            }
                break;
            default:
                break;
        }
        [[NoGetMoneyView shareGetMoneyView] refreshShareGetMoneyView];//刷新捞一捞界面未领取金额的数据
        
    } failure:^(NSError *error) {
        ZHLog(@"%@",error);
        [self hideHud];
        
    }];
}

#pragma mark -- 增加捞饺子机会接口 (在前段和APP页面第一次请求捞一捞页面 登陆状态)
///**
// *  增加捞饺子机会接口 (在前段和APP页面第一次请求捞一捞页面 登陆状态)
// */
//- (void)loadDataAddLYLDumplingWithNumber{
//    [self showHudInView:self.view hint:@"正在加载"];
//
//    [LYLAFNetWorking getWithBaseURL:[LYLHttpTool addDumplingNuumberWithUserId:MyObjectForKey(UserIDKey) productCode:ProductCode sysType:SysType andSessionValue:SessionValue ] success:^(id json) {
//
//        ZHLog(@"增加捞饺子机会接口=%@",json);
//        [self hideHud];
//
//    } failure:^(NSError *error) {
//
//        ZHLog(@"增加捞饺子机会接口=%@",error);
//        [self hideHud];
//
//    }];
//}


@end
