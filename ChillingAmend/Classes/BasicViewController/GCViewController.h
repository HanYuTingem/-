//
//  GCViewController.h
//  dreamWorks
//
//  Created by dreamRen on 13-6-23.
//  Copyright (c) 2013年 dreamRen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCRequest.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "JPCommonMacros.h"
#import "AppDelegate.h"
#import "BXAPI.h"
#import "JSON.h"
#import "GCUtil.h"
#import "BSaveMessage.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"
#import "SaveMessage.h"
#import "LogInAPP.h"

#define SCREENWIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT  [UIScreen mainScreen].bounds.size.height

@protocol TurnCountDelegate;
@protocol shareDelegate <NSObject>

//是否需要在分享成功后执行（根据项目基类进行调整，此处用代理，只要分享成功即可执行）
- (void)shareSuccess;
@end


@interface GCViewController : UIViewController<GCRequestDelegate, MBProgressHUDDelegate,UMSocialUIDelegate>

/*
 *_header         刷新时顶部视图
 *_footer         刷新时底部视图
 *mainView        风火轮底部背景
 *mainRequest     请求
 *HUD             风火轮
 *backImageView   返回按钮图片
 */
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    UIView *mainView;
    GCRequest *mainRequest;
    MBProgressHUD *HUD;
    UIImageView *backImageView;
}

/*
 * bar    导航栏
 * leftButton 左边返回按钮
 *rightButton  右边按钮
 *shareContent   分享内容
 *shareImageName   分享图片 默认是icon
 */
@property (nonatomic, strong) UINavigationBar *bar; // 导航栏
@property (nonatomic, strong) UIButton *leftButton; // 左键
@property (nonatomic, strong) UIButton *rightButton; // 右键
@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) NSString *shareContent; // 分享内容
@property (nonatomic, strong) UIImage *shareImageName; // 分享图片
@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic,assign) id <shareDelegate> shareDelegate;
/*
 * 导航栏添加
 * @prama state 首页表示  0为首页  其他数不为首页
 * @prama leftHide 是否显示左边返回按钮  YES显示  NO 不显示
 * @prama title   导航栏标题
 */
- (void)setNavigationBarWithState:(int)state andIsHideLeftBtn:(BOOL)leftHide andTitle:(NSString *)title;

/*
 * 导航栏右边按钮添加
 * @prama imageName 按钮背景图片
 * @prama selector 点击按钮出发的方法
 * @prama frame   按钮大小设置
 * @prama title   按钮文字标题
 * @prama BtnTitleColor   按钮字体颜色
 */
- (void)addRightBarButtonItemWithImageName:(NSString *)imageName andTargate:(SEL)selector andRightItemFrame:(CGRect)frame andButtonTitle:(NSString *)title andTitleColor:(UIColor *)BtnTitleColor;
- (void)backButtonClick:(UIButton *)button;

//分享框  addController 需要添加分享框的控制器
- (void)callOutShareViewWithUseController:(UIViewController *)addController andSharedUrl:(NSString*)url;
//取消展示分享框
- (void)cancleIndicateShareView;

// 仅提示信息（1.5s后消失）
- (void)showStringMsg:(NSString *)msg andYOffset:(float)y;
// 带风火轮图标
- (void)showMsg:(NSString *)msg;
- (void)showMsgDetailsLabelText:(NSString *)msg succeed:(void(^)())succeed;

- (void)showMsg:(NSString *)msg hideTime:(NSInteger)hideTime;
// 隐藏带风火轮图标的提示
- (void)hide;

- (void)shareButtonClicked:(UIButton *)btn;

@end
