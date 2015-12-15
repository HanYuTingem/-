//
//  CJHelpViewController.m
//  Wallet
//
//  Created by zhaochunjing on 15-10-26.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "CJHelpViewController.h"

@interface CJHelpViewController ()

@end

@implementation CJHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
    self.mallTitleLabel.text = @"帮助";
    self.mallTitleLabel.font = WalletHomeNAVTitleFont;
    self.mallTitleLabel.textColor = WalletHomeNAVTitleColor;
    self.backView.backgroundColor = WalletHomeNAVGRD;
    [self.leftBackButton setImage:[UIImage imageNamed:@"title_btn_back02"] forState:UIControlStateNormal];
    
}

/** 拨打客服电话的点击事件 */
- (IBAction)iphoneBtnClick:(UIButton *)sender {
    NSMutableString *url = [NSMutableString stringWithFormat:@"telprompt://%@",@"4000-1000-1111"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end
