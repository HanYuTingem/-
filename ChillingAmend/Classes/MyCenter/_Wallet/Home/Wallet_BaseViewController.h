//
//  Wallet_BaseViewController.h
//  dreamWorks
//
//  Created by dreamRen on 13-6-23.
//  Copyright (c) 2013年 dreamRen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "UMSocial.h"
#import "UMSocialControllerService.h"


@protocol TurnCountDelegate;

@interface Wallet_BaseViewController : UIViewController<UMSocialUIDelegate>
{
    /** 界面View */
    UIView *mainView;
    /** 标题栏ImageView */
    UIView * backView;
    /** 分享平台 */
    int _shareContentType;
    /** yes 分享中    no 没有分享 */
    BOOL _isShareLoading;
    UILabel *_loginShowLabel;
    UIViewController *_tempController;
}
@property(nonatomic, strong)NSString *jianbianDateString;




/**  标题栏ImageView */
@property (nonatomic,strong)UIView *backView;
/** 返回按钮 */
@property(nonatomic,strong)UIButton *leftBackButton;
/** 右侧按钮 */
@property (nonatomic, strong) UIButton  *rightButton;
/** 标题文字 */
@property (nonatomic, strong) UILabel  * mallTitleLabel;




@property (nonatomic,retain) id <TurnCountDelegate> turnDelegate;

/** 导航栏时间转换颜色 */
-(void)setJianbianDateString:(NSString *)jianbianDateString;
/** 提示框 */
-(void)showMsg:(NSString *)msg;
/** 跳转登录 */
- (void)showLoginLabel:(NSString *)msg withViewController:(UIViewController *)viewController;
/** 返回按钮 */
-(void)backButtonClick;
/** 右侧按钮 */
-(void)rightBackCliked;
/*
 菊花
 */
/** 菊花开启 */
-(void)chrysanthemumOpen;

/** 菊花关闭 */
-(void)chrysanthemumClosed;

/** 返回首页 */
-(void)poptoWalletHomeControllet;

/**
 分享
 @param title 分享到各平台的标题
 @param url 分享的链接
 @param content 分享的文字内容
 @param imagePath 分享的图片地址 // 这个不用传
 @param type 来自某个平台的分享  投票首页1 投票详情2  报名详情3 节目首页4 节目详情5  爆料首页6 爆料详情7 活动详情8 资讯详情9 评论分享10  个人足迹分享11  获奖详情分享12 邀请分享13 关于界面的分享14  扫一扫分享15 魔幻拼图分享16 接金币17 小鸟18
 @param AimgStr  图片
 @param AdomainName 域名  此变量不用了
 */
- (void)shareTitle:(NSString *)title withUrl:(NSString *)idStr withContent:(NSString *)content withImageName:(NSString *)imagePath withShareType:(int)shareContentType ImgStr:(NSString *)AimgStr domainName:(NSString *)AdomainName;


/*
 需要展示分享数量的看这~~~~~~~~
 
 在触发分享的方法里启动通知
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forwardNotification:) name:@"TopicForWard" object:nil];//转发
 在触发通知的方法里先将通知移除   （在离开界面的时候也要移除通知）
 - (void)forwardNotification:(NSNotification *)notification
 {
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TopicForWard" object:nil];
     if ([notification.object isEqualToString:@"yes"]) {
     NSLog(@"share success");
       发送请求
     }else {
     NSLog(@"share fail");
     }
 
 }
 */

@end

@protocol TurnCountDelegate <NSObject>

- (void)discloseIndexTurnCount;
- (void)discloseDetailTurnCount;

@end
