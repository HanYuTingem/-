//
//  AlterPhoneNumberViewController.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/8/13.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "AlterPhoneNumberViewController.h"

@interface AlterPhoneNumberViewController ()

@end

@implementation AlterPhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    titleButton.hidden = NO;
    [titleButton setTitle:@"修改手机号" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    UITextField *phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH - 40, ViewHeight)];
    [mainView addSubview:phoneNumber];
    
    UITextField *verify = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(phoneNumber.frame) + 10, (SCREEN_WIDTH - 40) * 0.66, ViewHeight)];
    [mainView addSubview:verify];
    
    UIButton *getNumber = [[UIButton alloc] initWithFrame:CGRectMake(20+(SCREEN_WIDTH - 40) * 0.67, CGRectGetMaxY(phoneNumber.frame) + 10, (SCREEN_WIDTH - 40) * 0.33, ViewHeight)];
    [getNumber setBackgroundColor:[UIColor redColor]];
    [mainView addSubview:getNumber];
    
}

- (void)didReceiveMemoryWarning {
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

@end
