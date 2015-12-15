//
//  GDHSubmiitOrderController.m
//  Wallet
//
//  Created by GDH on 15/10/26.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "GDHSubmiitOrderController.h"
#import "GDHTitleView.h"
#import "GDHSetPassWordViewController.h"
#import "GDHInputPassWordView.h"
#import "GDHSetPassWordViewController.h"
#import "CJNotSufficientFundsView.h"
#import "CJPayJudgeView.h"


#define X  (ScreenWidth - 270)/2
/** 密码提示的次数  */
static int number = 4;
@interface GDHSubmiitOrderController ()<UITextFieldDelegate,CJPayJudgeViewDelegate>
{
    UIButton *btn;


}


/** 请输入密码视图 */
@property(nonatomic,strong)GDHInputPassWordView *InputPassWordView;
/**  请输入密码 蒙版按钮 */
@property(nonatomic,strong)UIButton *inputButton;

/** 是否取消支付 */
@property(nonatomic,strong)GDHTitleView *CancelTitleView;

/** 是否取消支付 */
@property(nonatomic,strong)UIButton  *ifCancelPayButton;
/** 请输入支付密码 */
@property(nonatomic,strong)UILabel  *payPassWordLabel;
/** 支付方式的View */
@property (nonatomic, strong) CJNotSufficientFundsView *notView;
/** 输入金额的文本框 */
@property (nonatomic,strong) UITextField *moneyTextField;

@property (nonatomic, strong) CJPayJudgeView *payJudgeView;



@end

@implementation GDHSubmiitOrderController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:@"judgePayStatu"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mallTitleLabel.text = @"提交订单";
    UIButton *submit_button = [UIButton buttonWithType: UIButtonTypeCustom];
    submit_button.frame = CGRectMake(100, 400, 100, 100);
    [submit_button  setTitle:@"支付" forState:UIControlStateNormal];
    [submit_button addTarget:self action:@selector(submit_button) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit_button];
    submit_button.backgroundColor = [UIColor redColor];
    
    UIButton *btnNo = [UIButton buttonWithType: UIButtonTypeCustom];
    btnNo.frame = CGRectMake(100, 80, 100, 40);
    [btnNo  setTitle:@"余额不足" forState:UIControlStateNormal];
    [btnNo addTarget:self action:@selector(btnNoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnNo];
    btnNo.backgroundColor = [UIColor redColor];
    
    self.moneyTextField = [[UITextField alloc] init];
    self.moneyTextField.center = CGPointMake(ScreenWidth * 0.5, ScreenHeight * 0.5);
    self.moneyTextField.bounds = CGRectMake(0, 0, 150, 40);
    self.moneyTextField.placeholder = @"请输入金额";
    self.moneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.moneyTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.moneyTextField];
    
    //余额不足弹出框
    self.notView = [[CJNotSufficientFundsView alloc] initWithFrame:self.view.frame];
    
    //点击的充值类型的回调
    self.notView.blookBtnClick = ^(UIButton *balanceTypeBtn){
        DHLog(@" %ld",(long)balanceTypeBtn.tag);
        NSLog(@"%@",balanceTypeBtn.titleLabel.text);
    };
    
    [self.view addSubview:self.notView];
    
    
    /** 输入支付密码 */
    [self.view addSubview:self.inputButton];
    /**  是否取消支付按钮 */
    [self.view addSubview:self.ifCancelPayButton];
    [self makeNav];
    
    CJPayJudgeView *payJudgeView = [CJPayJudgeView shareCJPayJudgeViewWithController:self];
    payJudgeView.delegate = self;
    
#if 1  //提现 密码逻辑判断
    payJudgeView.moneyTextField = self.moneyTextField;
    self.moneyTextField.delegate = payJudgeView;
#else
    payJudgeView.moneyText = self.moneyTextField.text;
    
#endif
    payJudgeView.hidden = YES;
    [self.view addSubview:payJudgeView];
    self.payJudgeView = payJudgeView;
    
}
/** 余额不足的点击事件 */
- (void)btnNoClick
{
    [_notView showNotSufficientFundsView];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSArray * textArr = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%lu",(unsigned long)range.length],[NSString stringWithFormat:@"%lu",(unsigned long)range.location],string, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"judgePayStatu" object:textArr];
    return YES;
}

/** 提交订单页面 */
-(void)submit_button{
    [self.view endEditing:YES];
#if 0
    self.payJudgeView.moneyText = self.moneyTextField.text;
#endif
    self.payJudgeView.hidden = NO;
    [self.payJudgeView toCashBtnClick];
}


#pragma mark - 代理方法实现
- (void)payJudgeViewSucceedFinishWithPassWord:(NSString *)passWord
{
    NSLog(@"VC  ---  passWord  %@",passWord);
}
- (void)topUpJudgeViewSucceedFinishWithTopUpType:(NSString *)topUpType
{
    NSLog(@"VC --- type  %@",topUpType);
}


/** 设置导航 */
-(void)makeNav{
    self.backView.backgroundColor = WalletHomeNAVGRD
    self.mallTitleLabel.textColor = [UIColor whiteColor];
    self.mallTitleLabel.font = WalletHomeNAVTitleFont
    [self.leftBackButton setImage:[UIImage imageNamed:@"title_btn_back02"] forState:UIControlStateNormal];
    mainView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    btn.hidden=  NO;
}

@end
