//  忘记密码
//  ForgetPasswordViewController.m
//  ChillingAmend
//
//  Created by 许文波 on 14/12/18.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "PhoneFindPasswordViewController.h"
#import "EmailFindPasswordViewController.h"

@interface ForgetPasswordViewController ()

- (IBAction)phoneLookingButtonActionCliked:(id)sender; // 手机找回的点击事件
- (IBAction)emailLookingButtonActionCliked:(id)sender; // 邮箱找回的点击事件

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 初始化标题栏
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"密码找回"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark 按钮点击事件 手机找回
- (IBAction)phoneLookingButtonActionCliked:(id)sender
{
    PhoneFindPasswordViewController *phoneFind = [[PhoneFindPasswordViewController alloc] init];
    [self.navigationController pushViewController:phoneFind animated:YES];
}

#pragma mark 按钮点击事件 邮箱找回
- (IBAction)emailLookingButtonActionCliked:(id)sender
{
    EmailFindPasswordViewController *emailFind = [[EmailFindPasswordViewController alloc] init];
    [self.navigationController pushViewController:emailFind animated:YES];
}

@end
