//
//  BYC_PromptViewController.m
//  ChillingAmend
//
//  Created by yc on 15/8/17.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import "BYC_PromptViewController.h"
#import "PrizeViewController.h"
#import "PRJ_DayDaytreasureViewController.h"
#import "PersonalCenterViewController.h"
@interface BYC_PromptViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button_Iknow;
@property (weak, nonatomic) IBOutlet UIView *view_Prompt;

@end


@implementation BYC_PromptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _view_Prompt.layer.shadowRadius = 1;
    _view_Prompt.layer.shadowOpacity = 0.2f;
    _view_Prompt.layer.shadowOffset = CGSizeMake(0, 0);
    _view_Prompt.layer.cornerRadius = 5;
    
    _button_Iknow.layer.shadowRadius = 1;
    _button_Iknow.layer.shadowOpacity = 0.2f;
    _button_Iknow.layer.shadowOffset = CGSizeMake(0, 0);
    _button_Iknow.layer.cornerRadius = 5;
}

- (IBAction)iknowAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    switch (_viewControllerIndex) {
        case 0:
            [self.appDelegate.homeTabBarController.homeTabBar onHomePageButtonClicked:nil];
            break;
        case 1:
            [self.appDelegate.homeTabBarController.homeTabBar onMyGrapeAgencyButtonClicked:nil];
            break;
        case 2:
            [self.appDelegate.homeTabBarController.homeTabBar onRecommandButtonClicked:nil];
            break;
        case 3:
            [self.appDelegate.homeTabBarController.homeTabBar onKnowledgeButtonClicked:nil];
            break;
        default:
            break;
    }
    
    [self jumpToHomeView];

}

#pragma mark 当登录成功跳转到我的页面
- (void)jumpToHomeView
{
    switch (self.viewControllerIndex) {
        case 4: // 哪来回哪去
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 5: // 修改密码之后登录跳转
            for (UIViewController *ViewContrller in self.navigationController.viewControllers) {
                if ([ViewContrller isKindOfClass:[PersonalCenterViewController class]]) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }
            break;
        case 6:  // 推送未登录跳转
        {
            [self removeFromParentViewController];
            [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
            [self.appDelegate.homeTabBarController.homeTabBar onSetButtonClicked:nil];
            UINavigationController *nav = (UINavigationController*)self.appDelegate.homeTabBarController.selectedViewController;
            PrizeViewController *prize = [[PrizeViewController alloc] init];
            [nav pushViewController:prize animated:YES];
        }
            break;
        case 8: // 天天宝箱未登录跳转
        {
            [self.appDelegate.homeTabBarController.homeTabBar onHomePageButtonClicked:nil];
            UINavigationController *nav = (UINavigationController*)self.appDelegate.homeTabBarController.selectedViewController;
            PRJ_DayDaytreasureViewController *baoXiang = [[PRJ_DayDaytreasureViewController alloc] init];
            [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
            [nav pushViewController:baoXiang animated:YES];
            [self removeFromParentViewController];
        }
            break;
        default:
            [self removeFromParentViewController];
            [self.appDelegate.homeTabBarController.homeTabBar onSetButtonClicked:nil];
            [self.navigationController popViewControllerAnimated:YES];
            break;
    }
}



@end
