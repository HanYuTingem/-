//
//  GAHomeTabBarController.m
//  GrapeAgency
//
//  Created by pipixia on 13-12-24.
//  Copyright (c) 2013年 pipixia. All rights reserved.
//

#import "GAHomeTabBarController.h"
#import "AppDelegate.h"
#import "UIView+ITTAdditions.h"
#import "PRJ_HomeViewController.h"
#import "LuckilyGordenTableViewController.h"
#import "LSYHomePageViewController.h"
#import "SINOActionListViewController.h"
#import "PersonalCenterViewController.h"
#import "LoginViewController.h"
#import "SINOActionListViewController.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface GAHomeTabBarController ()

@property (nonatomic, strong) PRJ_HomeViewController * homePageViewController; // 首页
@property (nonatomic, strong) LuckilyGordenTableViewController *myCommunityViewController; // 幸运乐园
@property (nonatomic, strong) LSYHomePageViewController * topRecommendViewController; // 辣椒商城
@property (nonatomic, strong) SINOActionListViewController * grapeKnowledgeViewController; // 椒点活动
@property (nonatomic, strong) PersonalCenterViewController * personalCenterViewController; // 我的
@end

@implementation GAHomeTabBarController

static GAHomeTabBarController * homeTabBarController = nil;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    if(self = [super init]){
        homeTabBarController = self;
        self.delegate = self;
        
        _homePageViewController = [[PRJ_HomeViewController alloc] initWithNibName:@"PRJ_HomeViewController" bundle:nil];
        _myCommunityViewController = [[LuckilyGordenTableViewController alloc] initWithNibName:@"LuckilyGordenTableViewController" bundle:nil];
        _topRecommendViewController = [[LSYHomePageViewController alloc] init];
        _grapeKnowledgeViewController = [[SINOActionListViewController alloc] initWithNibName:@"SINOActionListViewController" bundle:nil];
        _personalCenterViewController = [[PersonalCenterViewController alloc] initWithNibName:@"PersonalCenterViewController" bundle:nil];
//
        UINavigationController * homePageNavigationController = [[UINavigationController alloc] initWithRootViewController:_homePageViewController];
        UINavigationController * myCommunityNavigationController = [[UINavigationController alloc] initWithRootViewController:_myCommunityViewController];
        UINavigationController * topRecommendNavigationController = [[UINavigationController alloc] initWithRootViewController:_topRecommendViewController];
        UINavigationController * grapeKnowledgeNavigationController = [[UINavigationController alloc] initWithRootViewController:_grapeKnowledgeViewController];
        UINavigationController * moreNavigationController = [[UINavigationController alloc] initWithRootViewController:_personalCenterViewController];
//
        [homePageNavigationController setNavigationBarHidden:YES animated:NO];
        [myCommunityNavigationController setNavigationBarHidden:YES animated:NO];
        [topRecommendNavigationController setNavigationBarHidden:NO animated:NO];
        [grapeKnowledgeNavigationController setNavigationBarHidden:YES animated:NO];
        [moreNavigationController setNavigationBarHidden:YES animated:NO];
//
        [self setViewControllers:[NSArray arrayWithObjects:homePageNavigationController,myCommunityNavigationController,topRecommendNavigationController,grapeKnowledgeNavigationController,moreNavigationController, nil]];
        self.tabBar.hidden = YES;
        [self setContentViewHeight];        
    }
    return self;
}


+ (GAHomeTabBarController *)sharedHomeTabBarController
{
    return homeTabBarController;
}

- (void)setContentViewHeight
{
    UIView * contentView;
    if([[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]){
        contentView = [self.view.subviews objectAtIndex:1];
    }
    else{
        contentView = [self.view.subviews objectAtIndex:0];
    }
    contentView.height = [UIScreen mainScreen].bounds.size.height;
}

#pragma mark 跳转到登录界面
- (void)gotoLogin
{
    LoginViewController * loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    switch (self.selectedIndex) {
        case 0:
            [_homePageViewController.navigationController pushViewController:loginViewController animated:YES];
            break;
        case 1:
            [_myCommunityViewController.navigationController pushViewController:loginViewController animated:YES];
            break;
        case 2:
            [_topRecommendViewController.navigationController pushViewController:loginViewController animated:YES];
            break;
        case 3:
            [_grapeKnowledgeViewController.navigationController pushViewController:loginViewController animated:YES];
            break;
        default:
            break;
    }
    
    loginViewController.viewControllerIndex = self.selectedIndex;
    // 隐藏tabBar
    [self hideTabBarAnimated:YES];
}

- (void)selectTabBarAtIndex:(int)index
{
    if (self.selectedIndex != index) {
        if (index == 4) {
            if ([kkUserId isEqual:@""] || !kkUserId) {
                // 登录
                [self gotoLogin];
                return;
            }
        } else {
            _lastIndex = index;
        }
        self.selectedIndex = index;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   self.homeTabBar = [[NSBundle mainBundle] loadNibNamed:@"GAHomeTabBar" owner:self options:nil][0];
//    self.homeTabBar = [GAHomeTabBar loadFromXib];
    self.homeTabBar.bottom = SCREEN_HEIGHT;
    self.homeTabBar.height = 52;
    self.homeTabBar.backgroundColor = [UIColor redColor];
    self.homeTabBar.delegate = self;
    [self.view addSubview:self.homeTabBar];
}

- (void)hideTabBarAnimated:(BOOL)animated
{
    float animationTime = animated?0.3:0;
    [self.view bringSubviewToFront:self.homeTabBar];
    [UIView animateWithDuration:animationTime animations:^{
        self.homeTabBar.top = self.view.height+2;
    }];
}

- (void)showTabBarAnimated:(BOOL)animated
{
    float animationTime = animated?0.3:0;
    [self.view bringSubviewToFront:self.homeTabBar];
    [UIView animateWithDuration:animationTime animations:^{
        self.homeTabBar.bottom = self.view.height;
    }];
}

- (void)homeTabBar:(GAHomeTabBar *)homeTabBar didSelectTabAtIndex:(int)index
{
    [self selectTabBarAtIndex:index];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 屏幕旋转问题
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}

@end








