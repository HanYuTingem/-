//
//  MyDumplingViewController.m
//  LaoYiLao
//
//  Created by sunsu on 15/12/9.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "MyDumplingViewController.h"

@interface MyDumplingViewController ()

@end

@implementation MyDumplingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self changeBarTitleWithString:@"我的饺子"];
    
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
