//
//  LaoYiLaoViewController.h
//  LaoYiLao
//
//  Created by sunsu on 15/10/29.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVSwitch.h"
#import "ScrollTitleView.h"

@interface LaoYiLaoViewController
: LaoYiLaoBaseViewController
-(void)shareBtnClicked;

//@property (nonatomic, strong) DVSwitch *selectSwitch;//选择按钮

@property (nonatomic, strong) ScrollTitleView *switchView;
/**
 *  必传参数，登录了传userid，没登陆传空字符串
 */
@property (nonatomic, strong) NSString *userID;

/**
 *  必传参数，登录了传手机号，没登陆传空字符串
 */
@property (nonatomic, strong) NSString *phone;

@end
