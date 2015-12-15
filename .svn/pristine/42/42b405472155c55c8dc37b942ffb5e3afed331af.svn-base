//
//  ChangeBookSeatPhoneNumViewController.m
//  HCheap
//
//  Created by dairuiquan on 14-12-8.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//

#import "ChangeBookSeatPhoneNumViewController.h"

@interface ChangeBookSeatPhoneNumViewController ()<UITextFieldDelegate>
{
    NSTimer         *_timer;//验证码倒计定时器
    NSInteger        _second;//验证码倒计时55秒
}
//@property (nonatomic, copy) NSString *codeStr;//验证码
@end

@implementation ChangeBookSeatPhoneNumViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [returnButton setImage:[UIImage imageNamed:@"msxq_0013_title_back"] forState:UIControlStateHighlighted];
    [returnButton setImage:[UIImage imageNamed:@"msxq_0013_title_back"] forState:UIControlStateNormal];
    

//    self.codeStr = @"";

    titleButton.hidden = NO;
    [titleButton setTitle:@"修改手机号" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                              target:self
                                            selector:@selector(timeRun)
                                            userInfo:nil
                                             repeats:YES];
    _second = 60;
    [_timer setFireDate:[NSDate distantFuture]];
    
    [self.affirmBtn setBackgroundImage:[UIImage imageNamed:@"settingmessagelogin_message_btn_main_bg_normal"] forState:UIControlStateNormal];
    [self setAllTextFieldDelegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//手机号验证码delegate
- (void)setAllTextFieldDelegate
{
    self.phoneNumTextField.delegate = self;
    self.authCodeTextField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//验证码
- (IBAction)obtainOathCodeBtnClick:(id)sender
{
    if (self.phoneNumTextField.text.length < 1){
        [self showMsg:@"手机号不能为空"];
    }else if ([GCUtil isMobileNumber:self.phoneNumTextField.text] == 0){
        [self showMsg:@"请输入正确的手机号码"];
    }else{
        [self.obtainOathCodeBtn setBackgroundImage:[UIImage imageNamed:@"settingmessagelogin_message_btn_verification_bg_selected"] forState:UIControlStateNormal];
        self.obtainOathCodeBtn.enabled = NO;
        [self.phoneNumTextField setUserInteractionEnabled:NO];
        [_timer setFireDate:[NSDate distantPast]];
        [self startDownLoad];
    }
}
//确定
- (IBAction)affirmBtnClick:(id)sender
{
    if (self.authCodeTextField.text.length >= 1) {
       [self checkTheAuthenticationCodeIsCorrect];
    }else{
        [self showMsg:@"请输入验证码"];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    if (_timer.isValid)
    {
        [_timer invalidate];
    }
}

//定时器响应方法
- (void)timeRun
{
    _second -- ;
    //self..text = [NSString stringWithFormat:@"  ( %d )秒",_second];
    self.scondeLabel.text = [NSString stringWithFormat:@"(%ld)秒",(long)_second];
    if (_second == 0)
    {
        [self endTimeRunWhenDownLoad];
    }
}

//结束定时器当网络错误时
- (void) endTimeRunWhenDownLoad{
    [_timer setFireDate:[NSDate distantFuture]];
    [self.obtainOathCodeBtn setBackgroundImage:[UIImage imageNamed:@"myorder_function_btn_normal"] forState:UIControlStateNormal];
    _second = 60;
    self.obtainOathCodeBtn.enabled = YES;
    self.scondeLabel.text = [NSString stringWithFormat:@"(%ld)秒",(long)_second];
    [self.phoneNumTextField setUserInteractionEnabled:YES];
}

#pragma mark - 网络请求，获取验证码
- (void)startDownLoad
{
    NSDictionary *parameters = [Parameter getVerificationCodeByPhoneNumber:self.phoneNumTextField.text];
    __block ChangeBookSeatPhoneNumViewController *changeVC = self;
    [AFRequest GetRequestWithUrl:NiceFood_Url parameters:parameters andBlock:^(NSDictionary *Datas, NSError *error) {
        if (error == nil) {
            if ([Datas[@"rescode"]isEqualToString:@"0000"]) {
//                [changeVC showMsg:@"获取验证码成功"];
//                changeVC.codeStr = Datas[@"resdesc"];
            }else{
                [changeVC showMsg:Datas[@"resdesc"]];
                [changeVC endTimeRunWhenDownLoad];
            }
        } else {
            [changeVC chrysanthemumClosed];
            [changeVC showMsg:@"获取验证码失败"];
            [changeVC endTimeRunWhenDownLoad];
        }
    }];
}


//验证码核对
- (void)checkTheAuthenticationCodeIsCorrect{
    NSDictionary *parameters = [Parameter getCheckTheAuthenticationCodeIsCorrectByPhoneNumber:self.phoneNumTextField.text andRandom:self.authCodeTextField.text];
    //    NSLog(@"-------%@-----%@",self.phoneNumTextField.text,self.authCodeTextField.text);
    __block ChangeBookSeatPhoneNumViewController *change = self;
    [AFRequest GetRequestWithUrl:NiceFood_Url parameters:parameters andBlock:^(NSDictionary *Datas, NSError *error) {
//        [change chrysanthemumClosed];
        if (error == nil) {
            if ([Datas[@"rescode"]isEqualToString:@"0000"]) {
                [change endTimeRunWhenDownLoad];
                change.myBlock(change.phoneNumTextField.text);
                [change.navigationController popViewControllerAnimated:YES];
            }else{
                //                [changeVC showMsg:Datas[@"resdesc"]];
                [change showMsg:@"验证码不正确"];
            }
        } else {
//            [change chrysanthemumClosed];
            [self showMsg:@"网络不顺畅"];
        }
    }];
}


@end
