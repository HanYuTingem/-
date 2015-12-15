//
//  CJWithdrawDepositInfoViewController.m
//  Wallet
//
//  Created by zhaochunjing on 15-10-23.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "CJWithdrawDepositInfoViewController.h"
#import "mineWalletViewController.h"

@interface CJWithdrawDepositInfoViewController ()
/** 银行卡的名字label */
@property (weak, nonatomic) IBOutlet UILabel *bankCardNameLabel;
/** 价格label */
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
/** 完成按钮 */
@property (weak, nonatomic) IBOutlet UIButton *finshBtn;
/** 完成按钮的点击事件 */
- (IBAction)finshBtnClick:(UIButton *)sender;

@end

@implementation CJWithdrawDepositInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化界面
    [self makeInitView];
}

/** 初始化界面 */
- (void)makeInitView
{
    self.backView.backgroundColor = WalletHomeNAVGRD;
    self.mallTitleLabel.text = @"提现详情";
    self.mallTitleLabel.textColor = WalletHomeNAVTitleColor;
    self.mallTitleLabel.font = WalletHomeNAVTitleFont;
    [self.leftBackButton setImage:[UIImage imageNamed:@"title_btn_back02"] forState:UIControlStateNormal];
    
    
    self.finshBtn.layer.cornerRadius = 5;
    self.finshBtn.layer.masksToBounds = YES;
    
    self.moneyLabel.text = self.moneyCash;
    self.bankCardNameLabel.text = self.bankCardName;
}



- (IBAction)finshBtnClick:(UIButton *)sender {
    [self poptoWalletHomeControllet];
}

@end
