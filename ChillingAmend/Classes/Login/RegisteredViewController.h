//
//  RegisteredViewController.h
//  LANSING
//
//  Created by nsstring on 15/5/27.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKeyboardViewController.h"
#import "GCViewController.h"

@interface RegisteredViewController : GCViewController<UIKeyboardViewControllerDelegate>{
    UIKeyboardViewController *keyBoardController;
}

@property (assign, nonatomic)int pageInt;  //1、注册 2、重设密码
@property (strong, nonatomic)NSString *rPhone;
@end
