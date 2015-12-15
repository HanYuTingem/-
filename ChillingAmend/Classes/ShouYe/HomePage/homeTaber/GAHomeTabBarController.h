//
//  GAHomeTabBarController.h
//  GrapeAgency
//
//  Created by pipixia on 13-12-24.
//  Copyright (c) 2013年 pipixia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAHomeTabBar.h"
#import "GCRequest.h"


@interface GAHomeTabBarController : UITabBarController<UITabBarControllerDelegate, GAHomeTabBarDelegate, GCRequestDelegate>

@property (retain, nonatomic) GAHomeTabBar *homeTabBar;

@property (assign, nonatomic) int lastIndex;

+ (GAHomeTabBarController *)sharedHomeTabBarController;

- (void)selectTabBarAtIndex:(int)index;

- (void)hideTabBarAnimated:(BOOL)animated;

- (void)showTabBarAnimated:(BOOL)animated;

@end


