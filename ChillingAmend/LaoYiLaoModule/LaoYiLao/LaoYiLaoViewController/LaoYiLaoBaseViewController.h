//
//  LaoYiLaoBaseViewController.h
//  LaoYiLao
//
//  Created by sunsu on 15/11/2.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarView.h"

@interface LaoYiLaoBaseViewController : UIViewController{
    BOOL _isAvailible;
}

@property (nonatomic, strong) BarView * customNavigation;//自定义navigation

//展示需要网络请求才能显示的界面
//-(BOOL) isConnectionAvailable;//判断网络是否连接 YES 连接，NO 未连接
-(void)backBtnClicked;
-(void)helpBtnClicked;
-(void)shareBtnClicked:(UIButton *)btn;


/**
 *  分享参数
 *
 *  @param text        分享内容
 *  @param idStr       跳转的URL
 *  @param content     分享内容
 *  @param imagePath   分享图片
 *  @param AimgStr     分享图片
 *  @param AdomainName 名称
 *  @param qqTitle     分享QQ标题
 *  @param qqZTitle    分享QQ空间标题
 *  @param weCTitle    分享微信标题
 *  @param weChtTitle  分享朋友圈标题
 *  @param sinaTitle   分享新浪标题
 */
- (void)baseShareText:(NSString *)text withUrl:(NSString *)idStr withContent:(NSString *)content withImageName:(NSString *)imagePath ImgStr:(NSString *)AimgStr domainName:(NSString *)AdomainName withqqTitle:(NSString *)qqTitle withqqZTitle:(NSString *)qqZTitle withweCTitle:(NSString *)weCTitle withweChtTitle:(NSString *)weChtTitle withsinaTitle:(NSString *)sinaTitle;


//修改标题
- (void) changeBarTitleWithString:(NSString *) title;
@end
