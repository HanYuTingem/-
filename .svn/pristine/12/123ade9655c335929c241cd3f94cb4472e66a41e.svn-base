//  手机找回密码
//  PhoneFindPasswordViewController.m
//  ChillingAmend
//
//  Created by 许文波 on 14/12/18.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "PhoneFindPasswordViewController.h"
//#import "ResetPasswordViewController.h"
#import "RegisteredViewController.h"

#define kYOffset -60 // 提示框偏移量

@interface PhoneFindPasswordViewController () <UITextFieldDelegate>
{
    BOOL isSendvalidation; // 是否发送验证码
}

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField; // 手机号输入框
@property (weak, nonatomic) IBOutlet UITextField *validtionTextField; // 验证码输入框
@property (weak, nonatomic) IBOutlet UIButton *validationBtn; // 验证码btn

- (IBAction)phoneFindNextStep:(id)sender;
- (IBAction)getValidation:(id)sender;

@end

@implementation PhoneFindPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"忘记密码"];
    // 代理
    _phoneTextField.delegate = self;
}

#pragma mark - textFiledDelegate
// 判断当输入的textField的text的长度是否为在你个人控制的的长度 返回NO不可输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqual:@"\n"]) {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; // 得到输入框的内容
    if (_phoneTextField == textField) { // 判断是否时我们想要限定的那个输入框
        if ([toBeString length] > 11) { // 如果输入框内容大于11 则不能输入
            return NO;
        }
    }
    return YES;
}

#pragma mark 点击空白处键盘消失
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_phoneTextField resignFirstResponder];
    [_validtionTextField resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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

#pragma mark 按钮点击事件 下一步
- (IBAction)phoneFindNextStep:(id)sender
{
    [_phoneTextField resignFirstResponder];
    [_validtionTextField resignFirstResponder];
    if ([_phoneTextField.text isEqual:@""]) {
        [self showStringMsg:@"手机号码不能为空" andYOffset:kYOffset];
    } else if (![GCUtil ThePhoneNumber:_phoneTextField.text]) {
        [self showStringMsg:@"请输入正确的手机号码" andYOffset:kYOffset];
    } else if ([_validtionTextField.text isEqual:@""]) {
        [self showStringMsg:@"验证码不能为空" andYOffset:kYOffset];
    } else {
        if (![GCUtil connectedToNetwork]) {
            [self showStringMsg:@"网络连接失败" andYOffset:0];
        } else {
            // 下一步 重置
            if (isSendvalidation) { // 验证码已发送
                [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI getResetPasswordPhoneNum:_phoneTextField.text andCode:_validtionTextField.text]];
                mainRequest.tag = 101;
                [self showMsg:nil];
            } else [self showStringMsg:@"该手机号还没发送验证码！" andYOffset:0];
        }
    }
}

#pragma mark 按钮的点击事件 获取验证码
- (IBAction)getValidation:(id)sender
{
    [_phoneTextField resignFirstResponder];
    [_validtionTextField resignFirstResponder];
    if ([GCUtil ThePhoneNumber:_phoneTextField.text]) { // 手机格式是否正确
        if ([GCUtil connectedToNetwork]) { // 网络是否正常
            // 网络请求
            mainRequest.tag = 100;
            [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI getValidCodePhone:_phoneTextField.text andType:@"2"]];
            [self showMsg:nil];
        } else {
            [self showStringMsg:@"网络连接失败！" andYOffset:kYOffset];
        }
    } else {
        [self showStringMsg:@"请输入正确的手机号码" andYOffset:kYOffset];
    }
}

#pragma mark 倒计时
- (void)countDown
{
    // 倒计时
    __block int timeout = 59; // 倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); // 每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) { // 倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置界面的按钮显示,根据自己需求设置
                [_validationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                _validationBtn.userInteractionEnabled = YES;
            });
        } else {
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置界面的按钮显示,根据自己需求设置
                [_validationBtn setTitle:[NSString stringWithFormat:@"%@ S",strTime] forState:UIControlStateNormal];
                _validationBtn.userInteractionEnabled = NO;
            });
            timeout --;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark GCRequestDelegate
- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    NSLog(@"%@", aString);
    [self hide];
    NSMutableDictionary *dict = [aString JSONValue];
    if ( !dict ) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
        return;
    }
    switch (mainRequest.tag) {
        case 100: // 手机获取验证
            if (![[dict objectForKey:@"status"]isEqual:@"1"]) {
                [self showStringMsg:[dict valueForKey:@"msg"] andYOffset:kYOffset];
            } else {
                [self countDown];
                isSendvalidation = YES;
            }
            break;
        case 101: // 忘记密码手机验证
            if ([[dict objectForKey:@"code"]isEqual:@"0"]) {
                // 验证成功，跳转到重置密码界面
                RegisteredViewController *resetPassword = [[RegisteredViewController alloc] init];
                resetPassword.rPhone = _phoneTextField.text;
                [self.navigationController pushViewController:resetPassword animated:YES];
            } else {
                [self showStringMsg:[dict valueForKey:@"message"] andYOffset:kYOffset];
            }
            break;
        default:
            break;
    }
}

- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self hide];
    [self showStringMsg:@"网络连接失败！" andYOffset:kYOffset];
}

@end
