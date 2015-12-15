//
//  AmendPassViewController.h
//  LANSING
//
//  Created by nsstring on 15/5/29.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKeyboardViewController.h"
#import "GCViewController.h"

@interface AmendPassViewController : GCViewController<UIKeyboardViewControllerDelegate>{
    UIKeyboardViewController *keyBoardController;
}

@end
