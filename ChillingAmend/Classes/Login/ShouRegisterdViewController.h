//
//  ShouRegisterdViewController.h
//  LANSING
//
//  Created by nsstring on 15/5/27.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKeyboardViewController.h"
#import "GCViewController.h"

@interface ShouRegisterdViewController : GCViewController<UIKeyboardViewControllerDelegate>{
    UIKeyboardViewController *keyBoardController;
}
/*
 界面
 1、注册
 2、无密码快速登录
 3、忘记密码
 */
@property(assign, nonatomic)int interfaceInt;
@property (nonatomic,assign)  NSInteger viewControllerIndex;

@end
