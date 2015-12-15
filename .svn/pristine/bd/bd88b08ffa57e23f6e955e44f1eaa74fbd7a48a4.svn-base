//
//  InstructionsViewController.m
//  LANSING
//
//  Created by nsstring on 15/6/1.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "InstructionsViewController.h"
#import "PersonalCenterViewController.h"
#import "PrizeViewController.h"
#import "PRJ_DayDaytreasureViewController.h"

@interface InstructionsViewController ()
//标题
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

//内容
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation InstructionsViewController
@synthesize typeInt;
@synthesize titleLabel;
@synthesize contentTextView;
@synthesize entranceInt;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

}

- (void)viewDidLoad{
    [super viewDidLoad];
     [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"账号说明"];
    [mainRequest requestHttpWithPost:[NSString stringWithFormat:@"%@getAgreement/",ADDRESS] withDict:[LogInAPP userAgreementType:[NSString stringWithFormat:@"%d",typeInt]]];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark 重写返回键方法
- (void)backButtonClick:(UIButton *)button{

    if (_isFromChooseToUnderstand) {
        
        for (UIViewController *vc in self.navigationController.viewControllers) {
            
            if ([vc isKindOfClass:NSClassFromString(@"LoginViewController")]) {
                
                [vc removeFromParentViewController];
            }
            
        }
        
        [self jumpToHomeView];
    }else{
    
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

#pragma mark 当登录成功跳转到我的页面
- (void)jumpToHomeView
{
    switch (self.viewControllerIndex) {
            
        case 0: // 哪来回哪去
            [self.appDelegate.homeTabBarController.homeTabBar onHomePageButtonClicked:nil];
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        case 1: // 哪来回哪去
            [self.appDelegate.homeTabBarController.homeTabBar onMyGrapeAgencyButtonClicked:nil];
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        case 2: // 哪来回哪去
            [self.appDelegate.homeTabBarController.homeTabBar onRecommandButtonClicked:nil];
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        case 3: // 哪来回哪去
            [self.appDelegate.homeTabBarController.homeTabBar onKnowledgeButtonClicked:nil];
            [self.navigationController popViewControllerAnimated:YES];
            break;

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

-(void)GCRequest:(GCRequest*)aRequest Finished:(NSString*)aString
{
    NSMutableDictionary *dict=[aString JSONValue];
    NSLog(@"22==%@",dict);
    if (dict) {
        if ([[dict objectForKey:@"code"] intValue] == 1) {
            titleLabel.text = [dict objectForKey:@"title"];
            
            // 行间距
            contentTextView.text = [dict objectForKey:@"content"];
            [GCUtil lineSpacingTextView:contentTextView fontInt:11];
            contentTextView.textColor = RGBACOLOR(104, 104, 104, 1);
        }else{
            switch ([[dict objectForKey:@"code"] intValue]) {
                case 0:{
                    [self showMsg:@"获取失败!"];
                    break;
                }
                case 203:{
                    [self showMsg:@"系统异常!"];
                    break;
                }
                default:{
                    [self showMsg:[dict objectForKey:@"message"]];
                    break;
                }
            }
        }
    }
    else
    {
        [self showMsg:@"服务器去月球了!"];
    }
    
}

-(void)GCRequest:(GCRequest*)aRequest Error:(NSString*)aError
{
    [self showMsg:@"服务器去月球了!"];
    
}

@end
