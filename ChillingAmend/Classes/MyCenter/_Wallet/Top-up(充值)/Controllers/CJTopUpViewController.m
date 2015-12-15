//
//  CJTopUpViewController.m
//  Wallet
//
//  Created by zhaochunjing on 15-10-21.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//  充值页面

#import "CJTopUpViewController.h"
#import "CJTopUpRecordViewController.h"
#import "WalletHome.h"
#import "mineWalletViewController.h"

@interface CJTopUpViewController () <UITextFieldDelegate>

{
    /** 记录支付方式的之前按钮 */
    UIButton *_oldBtn;
}

/** 输入金额的文本框 */
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
/** 支付类型的label */
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
/** 充值成功的提示框 充值成功后显示 */
@property (weak, nonatomic) IBOutlet UILabel *succeedLabel;
/** 确认充值按钮 */
@property (weak, nonatomic) IBOutlet UIButton *topUpBtn;
/** 支付宝选中图片 */
@property (weak, nonatomic) IBOutlet UIImageView *zhiFuImage;
/** 微信支付选中图片 */
@property (weak, nonatomic) IBOutlet UIImageView *weiXinImage;
/** 借记卡选中图片 */
@property (weak, nonatomic) IBOutlet UIImageView *jieJiImage;
/** 弹出页（蒙板） */
@property (weak, nonatomic) IBOutlet UIView *jumpView;
/** 弹出页的子页（支付方式页） */
@property (weak, nonatomic) IBOutlet UIView *jumpSubView;


/** 选择支付类型的点击事件 */
- (IBAction)paytypeClick:(UIButton *)sender;
/** 确认充值按钮的点击事件 */
- (IBAction)topUpBtnClick:(UIButton *)sender;
/** 支付方式的点击状态事件 */
- (IBAction)zhiFuTypeClick:(UIButton *)sender;

@end

@implementation CJTopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化界面
    [self makeInitView];
}

/** 初始化界面 */
- (void)makeInitView
{
    self.backView.backgroundColor = WalletHomeNAVGRD;
    self.mallTitleLabel.text = @"充值";
    self.mallTitleLabel.textColor = WalletHomeNAVTitleColor;
    self.mallTitleLabel.font = WalletHomeNAVTitleFont;
    [self.leftBackButton setImage:[UIImage imageNamed:@"title_btn_back02"] forState:UIControlStateNormal];
    [self.rightButton setTitle:@"充值记录" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:WalletHomeNAVTitleColor forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = WalletHomeNAVRigthFont;
    CGRect frame = self.rightButton.frame;
    frame.size.width += 20;
    frame.origin.x -= 20;
    self.rightButton.frame = frame;
    
    self.topUpBtn.layer.cornerRadius = 5;
    self.topUpBtn.layer.masksToBounds = YES;
    self.succeedLabel.hidden = YES;
    self.jumpView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    mainView.backgroundColor =[UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
    self.view.backgroundColor = WalletHomeBackGRD;
    self.moneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
    // 隐藏弹出界面
    [self hiddenJumpView];
}
/** 右侧按钮的点击事件 */
- (void)rightBackCliked
{
    //充值记录界面
    CJTopUpRecordViewController *recordVC = [[CJTopUpRecordViewController alloc] init];
    recordVC.recordType = @"0";
    [self.navigationController pushViewController:recordVC animated:YES];
}
/** 隐藏弹出界面 */
- (void)hiddenJumpView
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.jumpSubView.frame;
        frame.origin.y = ScreenHeight ;
        self.jumpSubView.frame = frame;
    } completion:^(BOOL finished) {
        self.jumpView.hidden = YES;
    }] ;
}

/** 显示弹出界面 */
- (void)showJumpView
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.jumpSubView.frame;
        frame.origin.y = ScreenHeight - 164;
        self.jumpSubView.frame = frame;
        self.jumpView.hidden = NO;
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    if (self.jumpSubView.frame.origin.y < ScreenHeight) {
        [self hiddenJumpView];
    }
}

#pragma mark - TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    self.moneyTextField.text = @"";
    if (self.moneyTextField.text.length) {
        NSMutableString *str = [NSMutableString stringWithString:self.moneyTextField.text];
        self.moneyTextField.text = [str stringByReplacingOccurrencesOfString:@"元" withString:@""];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.moneyTextField.text.length) {
        NSMutableString *str =[NSMutableString stringWithString:self.moneyTextField.text];
        self.moneyTextField.text = [str stringByAppendingString:@"元"];
    }
}


#pragma mark - 按钮的点击事件
/** 选择支付类型的点击事件 */
- (IBAction)paytypeClick:(UIButton *)sender {
    [self.view endEditing:YES];
    //展示弹出页
    [self showJumpView];
    //判断类型
    self.zhiFuImage.hidden = YES;
    self.weiXinImage.hidden = YES;
    self.jieJiImage.hidden = YES;
    if ([self.payLabel.text isEqualToString:@"支付宝"]) {
        self.zhiFuImage.hidden = NO;
//        _oldBtn = (UIButton *)[self.view viewWithTag:0];
    } else if ([self.payLabel.text isEqualToString:@"微信支付"]) {
        self.weiXinImage.hidden = NO;
    } else if ([self.payLabel.text isEqualToString:@"借记卡（U付）"]) {
        self.jieJiImage.hidden = NO;
    }
    
}

/** 确认充值按钮的点击事件 */
- (IBAction)topUpBtnClick:(UIButton *)sender {
    
//    self.succeedLabel.hidden = NO;
    [self showMsg:@"充值成功！"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.succeedLabel.hidden = YES;
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
    
}

- (IBAction)zhiFuTypeClick:(UIButton *)sender {
//    if (_oldBtn == sender) return;
    
    self.zhiFuImage.hidden = YES;
    self.weiXinImage.hidden = YES;
    self.jieJiImage.hidden = YES;
    switch (sender.tag) {
        case 0:
        {
            self.zhiFuImage.hidden = NO;
            
            self.payLabel.text = @"支付宝";
        }
            break;
        case 1:
        {
            self.weiXinImage.hidden = NO;
            
            self.payLabel.text = @"微信支付";
        }
            break;
        case 2:
        {
            self.jieJiImage.hidden = NO;
            
            self.payLabel.text = @"借记卡（U付）";
        }
            break;
            
        default:
            break;
    }
    _oldBtn = sender;
    //隐藏弹出页
    [self hiddenJumpView];
}


@end




