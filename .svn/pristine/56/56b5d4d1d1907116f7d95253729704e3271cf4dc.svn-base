//  邮箱找回密码
//  EmailFindPasswordViewController.m
//  ChillingAmend
//
//  Created by 许文波 on 14/12/18.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "EmailFindPasswordViewController.h"
#import "LoginViewController.h"

#define kYOffset 0 // 提示框偏移量

@interface EmailFindPasswordViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField; // 邮箱

- (IBAction)submit:(id)sender;
@end

@implementation EmailFindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 初始化导航栏
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"密码找回"];
    // 代理
    _emailTextField.delegate = self;
}

#pragma mark 点击空白处键盘消失
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_emailTextField resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
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

#pragma mark 按钮点击事件 提交
- (IBAction)submit:(id)sender
{
    [_emailTextField resignFirstResponder];
    // 判断有无网络的情况
    if ([GCUtil connectedToNetwork]) {
        if ([GCUtil isValidateEmail:_emailTextField.text]) {
            [self showMsg:nil];
            [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI mailFindPasswordType:@"1" andUser_mail:_emailTextField.text]];
        } else {
            [self showStringMsg:@"请您输入正确的邮箱号" andYOffset:kYOffset];
        }
    } else {
        [self showStringMsg:@"网络连接失败" andYOffset:kYOffset];
    }
}

#pragma mark GCRequestDelegate
- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    [self hide];
    NSMutableDictionary *dict = [aString JSONValue];
    if (!dict) {
        return;
    }
    
    if ([[dict objectForKey:@"code"]isEqual:@"0"]) {
        // 修改成功
        [self showStringMsg:@"提交成功" andYOffset:kYOffset];
        [self performSelector:@selector(jumpToLoginView) withObject:nil afterDelay:1.5];
        // 当找回密码成功的情况下跳转到登录的页面
    } else [self showStringMsg:[dict valueForKey:@"message"] andYOffset:kYOffset];
}

- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self hide];
    NSLog(@"%@", aError);
    [self showStringMsg:@"网络连接失败！" andYOffset:kYOffset];
    
}

#pragma mark 当找回密码成功的情况下跳转到登录的页面
- (void)jumpToLoginView
{
    NSArray *tList=self.navigationController.viewControllers;
    for (UIViewController *tViewCtr in tList) {
        if ([tViewCtr isKindOfClass:[LoginViewController class]]) {
            [self.navigationController popToViewController:tViewCtr animated:YES];
        }
    }
}
@end
