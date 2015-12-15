//  领奖之前验证手机
//  PrizePhoneCheckViewController.m
//  ChillingAmend
//
//  Created by 许文波 on 14/12/26.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "PrizePhoneCheckViewController.h"
#import "PrizeDetailMessageViewController.h"
#import "UIKeyboardViewController.h"

#define kYOffset -60 // 提示框偏移量

@interface PrizePhoneCheckViewController () <UITextFieldDelegate, UIKeyboardViewControllerDelegate>
{
    BOOL isSendvalidation; // 验证码是否发送
    UIKeyboardViewController *keyBoardController; // 键盘的高度自适应性
}

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField; // 手机号输入框
@property (weak, nonatomic) IBOutlet UITextField *validtionTextField; // 验证码输入框
@property (weak, nonatomic) IBOutlet UIButton *validationBtn; // 验证码btn

- (IBAction)phoneFindNextStep:(id)sender;
- (IBAction)getValidation:(id)sender;

@end

@implementation PrizePhoneCheckViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"手机验证"];
    isSendvalidation = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //增加键盘的自适应高度 代理要写在它之后 不然会覆盖 谨记
    keyBoardController = [[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyBoardController addToolbarToKeyboard];
    
    // 代理
    _phoneTextField.delegate = self;
    _validtionTextField.delegate =self;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_phoneTextField resignFirstResponder];
    [_validtionTextField resignFirstResponder];
    //当退出本页面记得移除
    [keyBoardController removeKeyBoardNotification];
    keyBoardController= nil;
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

#pragma mark 按钮点击事件 提交
- (IBAction)phoneFindNextStep:(id)sender
{
    [_phoneTextField resignFirstResponder];
    [_validtionTextField resignFirstResponder];
    if ([_phoneTextField.text isEqual:@""]) {
        [self showStringMsg:@"手机号码不能为空" andYOffset:kYOffset];
    } else if (![GCUtil ThePhoneNumber:_phoneTextField.text]) {
        [self showStringMsg:@"请输入正确的手机号码" andYOffset:kYOffset];
        [self showStringMsg:@"" andYOffset:-40];
    } else if ([_validtionTextField.text isEqual:@""]) {
        [self showStringMsg:@"验证码不能为空" andYOffset:kYOffset];
    } else {
        if (![GCUtil connectedToNetwork]) {
            [self showStringMsg:@"网络连接失败" andYOffset:0];
        } else {
            if (isSendvalidation) { // 验证码已发送
                // 提交
                [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI phoneCheckUserId:kkUserId andCode:_validtionTextField.text andPhone:_phoneTextField.text]];
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
            [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI getValidCodePhone:_phoneTextField.text andType:@"3"]];
            [self showMsg:nil];
        } else {
            [self showStringMsg:@"网络连接失败！" andYOffset:kYOffset];
        }
    } else {
        [self showStringMsg:@"请输入正确的手机号码" andYOffset:kYOffset];
    }
}

// 倒计时
- (void) countDown
{
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
            if (![[dict objectForKey:@"status"]isEqual:@"1"]) { // 失败
                [self showStringMsg:[dict valueForKey:@"msg"] andYOffset:kYOffset];
            } else {
                [self countDown];
                isSendvalidation = YES;
            }
            break;
        case 101: // 提交 跳转到奖品详情
            if ([[dict objectForKey:@"status"]isEqual:@"1"]) {
                PrizeDetailMessageViewController *prizeDetail = [[PrizeDetailMessageViewController alloc] init];
                prizeDetail.prizeId = self.prizeId;
                [self.navigationController pushViewController:prizeDetail animated:YES];
            } else {
                [self showStringMsg:[dict valueForKey:@"msg"] andYOffset:kYOffset];
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
