//
//  LoginViewController.h
//  LANSING
//
//  Created by nsstring on 15/5/27.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKeyboardViewController.h"
#import "GCViewController.h"
@interface LoginViewController : GCViewController<UIKeyboardViewControllerDelegate>{
    UIKeyboardViewController *keyBoardController;
}

@property (nonatomic,assign) NSInteger viewControllerIndex;

@end
