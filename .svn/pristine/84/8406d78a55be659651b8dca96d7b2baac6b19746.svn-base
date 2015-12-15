//
//  L_BaseMallViewController.h
//  MarketManage
//
//  Created by 劳大大 on 15/4/7.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrazyBasisButton.h"
#import "LSYGoodsInfo.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
@interface L_BaseMallViewController : UIViewController

@property (nonatomic, strong) AppDelegate *appDelegate;

/** 自定义的view */
@property (nonatomic, strong) UINavigationBar    *barCenterView;
/** 导航左边的按钮*/
@property (nonatomic, strong) CrazyBasisButton  *leftButton;
/** 导航右边的按钮*/
@property (nonatomic, strong) UIButton  *rightButton;
/** 导航的title*/
@property (nonatomic, strong) UILabel  * mallTitleLabel;
/** 导航坐标的图片*/
@property (nonatomic,strong) UIImageView * imageVL;

/** 分享内容 */
@property (nonatomic, strong) NSString *shareContent;
/** 分享图片 */
@property (nonatomic, strong) UIImage *shareImageName;


/**左边按钮*/
- (void)leftBackCliked:(UIButton*)sender;

/**右边按钮*/
- (void)rightBackCliked:(UIButton*)sender;

/**分享*/
- (void)callOutShareGoodS:(LSYGoodsInfo*)goods;

- (void)showMessage:(NSString *)message;
- (void)showMsg:(NSString *)msg hideTime:(NSInteger)hideTime;
- (void)hide;
- (void)showStringMsg:(NSString *)msg andYOffset:(float)y;

/*登录*/

- (void)toLoginVC;

/**  加载提示框 */
-(void)startActivity;

/**  完成加载移除提示框*/
-(void)stopActivity;

/** 提示内容 */
-(void)showMsg:(NSString *)content;
/** 分享 */
- (void)callOutShareViewWithUseController:(UIViewController *)addController andSharedUrl:(NSString*)url;

@end
