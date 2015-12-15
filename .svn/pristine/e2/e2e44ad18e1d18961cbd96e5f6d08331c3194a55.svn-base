//
//  BaseViewController.m
//  MapForbaidu
//
//  Created by liujinhe on 15/7/22.
//  Copyright (c) 2015年 liujinhe. All rights reserved.
//

#import "BaseController.h"
//#import "MBProgressHUD.h"
@interface BaseController ()
{
    MBProgressHUD *hud;
}

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [returnButton setImage:[UIImage imageNamed:@"msxq_0013_title_back"] forState:UIControlStateHighlighted];
    [returnButton setImage:[UIImage imageNamed:@"msxq_0013_title_back"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showStartHud{
    
    if (!hud) {
        NSLog(@"家在加载");
        hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.delegate = self;
        hud.labelText = @"加载中...";
        [hud show:YES];
    }else{
        hud.labelText = @"加载中...";
        [self.view bringSubviewToFront:hud];
        [hud show:YES];
    }
    
}

-(void)stopHud:(NSString *)str{
    hud.labelText = str;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)showStartHud1
{
    MBProgressHUD *hud1 = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud1.delegate = self;
    hud1.labelText = @"加载中...";
    [hud1 show:YES];
}
-(void)showMsg:(NSString *)msg
{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    
    
    // Set custom view mode
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.labelText = msg;
    [hud show:YES];
    [hud hide:YES afterDelay:1];
    hud = nil;
}

@end
