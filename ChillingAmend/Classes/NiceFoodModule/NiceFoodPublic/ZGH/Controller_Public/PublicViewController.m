//
//  PublicViewController.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/6/18.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "PublicViewController.h"
#import "BackButton.h"

@interface PublicViewController ()

@end

@implementation PublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleButton setTitle:self.navigationController.title forState:UIControlStateNormal];
    titleButton.hidden = NO;
    




}



#pragma mark -- 导航栏左边返回按钮
//- (void)addLeftBarButtonItem{
//    
//    BackButton *backBtn = [BackButton setBackButtonWithImage:@"msxq_0013_title_back"];
//    
//    //    [navigation addSubview:backBtn];
//    
//    [backBtn addTarget:self
//                action:@selector(returnBtnClick)
//      forControlEvents:UIControlEventTouchUpInside];
//    
//    //    ---------下面这块代码在使用系统导航条的时候使用---------
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    self.navigationItem.leftBarButtonItem = leftItem;
//    //     ---------------------------------------------------
//}
//
////    返回按钮点击事件
//- (void)returnBtnClick{
//    [self.navigationController popViewControllerAnimated:YES];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
