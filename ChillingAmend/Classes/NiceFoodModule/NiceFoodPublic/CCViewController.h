//
//  CCViewController.h
//  PRJ_NiceFoodModule
//
//  Created by sunsu on 15/8/25.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "GCRequest.h"
#import "UMSocial.h"
#import "UMSocialControllerService.h"
@protocol TurnCountDelegate <NSObject>

- (void)discloseIndexTurnCount;
- (void)discloseDetailTurnCount;

@end

@interface CCViewController : UIViewController<GCRequestDelegate,UMSocialUIDelegate>
{
    UIView *mainView;//界面View
    UIButton *returnButton;//返回按钮
    GCRequest *mainRequest;//请求
    UIButton *titleButton;//标题
    UIView *backView;//  标题栏ImageView
    int _shareContentType; // 分享平台
    BOOL _isShareLoading;//yes 分享中    no 没有分享
    UILabel *_loginShowLabel;
    UIViewController *_tempController;
    UILabel *connectLabel; // 没有网络时的遮盖层
}
@property(nonatomic, strong)NSString *jianbianDateString;

@property (nonatomic,retain) id <TurnCountDelegate> turnDelegate;

-(void)setJianbianDateString:(NSString *)jianbianDateString;

-(void)setJianbianDateColoeString:(NSString *)jianbianDateString;

-(void)showMsg:(NSString *)msg;
- (void)showLoginLabel:(NSString *)msg withViewController:(UIViewController *)viewController;

//bar颜色
-(void)barTabBar;

//
-(void)backButtonClick;


//显示
-(void)show;

//关闭
-(void)disappear;

//重新加载
-(void)dataReload;


//加载失败
-(void)failedToLoad;

/*
 菊花
 */
//开启
-(void)chrysanthemumOpen;

//关闭
-(void)chrysanthemumClosed;

/*
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


