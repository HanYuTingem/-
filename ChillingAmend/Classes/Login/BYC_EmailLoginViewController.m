//
//  BYC_EmailLoginViewController.m
//  LANSING
//
//  Created by yc on 15/8/14.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "BYC_EmailLoginViewController.h"
#import "RegisteredViewController.h"
#import "ShouRegisterdViewController.h"
#import "AmendPassViewController.h"
#import "InstructionsViewController.h"
#import "LoginPublicObject.h"
#import "PromptView.h"
#import "PrizeViewController.h"
#import "PRJ_DayDaytreasureViewController.h"
#import "PersonalCenterViewController.h"
#import "APService.h"
#import "BYC_ReceiveCaptchaViewController.h"
#import "BYC_FindPasswordViewController.h"
#import "BYC_ReceiveCaptchaViewController.h"

@interface BYC_EmailLoginViewController ()<UITextFieldDelegate,PromptViewDelegate>{
    PromptView *promptView;
}
/**
 用户名
 */
@property (strong, nonatomic) IBOutlet UIView *userView;
@property (strong, nonatomic) IBOutlet UITextField *userTextField;

/*密码*/
@property (strong, nonatomic) IBOutlet UIView *passwordView;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextield;

/*登陆*/
@property (strong, nonatomic) IBOutlet UIButton *landingButton;


/*忘记密码*/
@property (strong, nonatomic) IBOutlet UILabel *forgetLabel;


//判断密文
@property (strong, nonatomic) NSString    *SignString;

@property (weak, nonatomic) IBOutlet UILabel *label_accountAndPasswordWorry;

@property (strong, nonatomic) LoginPublicObject *LPobject;
@end

@implementation BYC_EmailLoginViewController

@synthesize userView;
@synthesize passwordView;
@synthesize landingButton;
@synthesize userTextField;
@synthesize passwordTextield;
@synthesize forgetLabel;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyBoardController addToolbarToKeyboard];
    userTextField.delegate = self;
    passwordTextield.delegate = self;
    
    promptView = [PromptView Instance];
    promptView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    promptView.delegate = self;
    promptView.logInToRegisterLabel.text = @"登录成功";
    promptView.InTheFormOfInt = 1;
    [promptView draw];
    promptView.hidden = YES;
    promptView.frame = self.view.bounds;
    [self.view addSubview:promptView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [keyBoardController removeKeyBoardNotification];
    keyBoardController = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"登录"];
    forgetLabel.userInteractionEnabled = YES;
    [forgetLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgotPassword)]];

    /*阴影和倒角*/
    userView.layer.shadowRadius = 1;
    userView.layer.shadowOpacity = 0.4f;
    userView.layer.shadowOffset = CGSizeMake(0, 0);
    userView.layer.cornerRadius = 5;
    
    passwordView.layer.shadowRadius = 1;
    passwordView.layer.shadowOpacity = 0.4f;
    passwordView.layer.shadowOffset = CGSizeMake(0, 0);
    passwordView.layer.cornerRadius = 5;
    
    landingButton.layer.shadowRadius = 1;
    landingButton.layer.shadowOpacity = 0.2f;
    landingButton.layer.shadowOffset = CGSizeMake(0, 0);
    landingButton.layer.cornerRadius = 5;
    
    /*回收键盘*/
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toolbarButtonTap)];
    [self.view addGestureRecognizer:tap1];
}

#pragma mark -
#pragma mark - TextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([GCUtil isValidateEmail:userTextField.text] != 0&&passwordTextield.text.length >= 6&&passwordTextield.text.length <= 20) {
        [landingButton setBackgroundColor:[UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f]];
    }else{
        [landingButton setBackgroundColor:RGBACOLOR(195, 195, 195, 1)];
    }
    
    _SignString = @"";
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{


    _SignString = @"";
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@"\n"]){
        [textField resignFirstResponder];
        return NO;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    NSString *passwordText = textField == passwordTextield?toBeString:passwordTextield.text;
    
    if ([textField isEqual:passwordTextield]) {
        
        
        _SignString = [_SignString stringByAppendingString:string];;
        
    }
    
    if ([GCUtil isValidateEmail:textField == userTextField?toBeString:userTextField.text] != 0&&passwordText.length >= 6&&passwordText.length <= 20 && _SignString.length >= 6 ) {
        [landingButton setBackgroundColor:[UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f]];
        landingButton.userInteractionEnabled = YES;
    }else{
        [landingButton setBackgroundColor:RGBACOLOR(195, 195, 195, 1)];
        landingButton.userInteractionEnabled = NO;
    }
    //    NSLog(@"-------:%@",toBeString);
    return YES;
}

/*键盘回收*/
-(void)toolbarButtonTap{
    [userTextField resignFirstResponder];
    [passwordTextield resignFirstResponder];
}

/*忘记密码*/
-(void)forgotPassword{

    BYC_FindPasswordViewController *ReceiveCaptchaVC = [[BYC_FindPasswordViewController alloc] init];
    [self.navigationController pushViewController:ReceiveCaptchaVC animated:YES];
}

/*登陆*/
- (IBAction)landingBut:(id)sender {
    [userTextField resignFirstResponder];
    [passwordTextield resignFirstResponder];
    
    if ([GCUtil isValidateEmail:userTextField.text] == 0) {
        [self showMsg:@"请输入正确的邮箱"];
        return;
    }else if ([GCUtil convertToInt:passwordTextield.text] < 6||[GCUtil convertToInt:passwordTextield.text] > 20){
        [self showMsg:@"请输入6-20位数字，英文字母或符号组合"];
        return;
    }else{
        if ([GCUtil connectedToNetwork]) {
            [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI loginUser_name:userTextField.text andPassword:passwordTextield.text]];
            [self showMsg:nil];
        } else {
            [self showMsg:@"网络连接失败！"];
        }
    }
}


#pragma mark GCRequestDelegate
- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    NSLog(@"%@", aString);
    NSMutableDictionary *dict = [aString JSONValue];
    
    if ( !dict ) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
        return;
    }
    if ([[dict objectForKey:@"code"]isEqual:@"0"]) {
        [self hide];
        _label_accountAndPasswordWorry.hidden = YES;
        // 保存登录数据
        // 设置单利 保存数据 模型 NSUserDefaults
        [kkUserInfo resetInfo:dict];
        [BSaveMessage saveUserMessage:dict];
        [GCUtil saveLajiaobijifenWithJifen:[dict objectForKey:@"jifen"]];
        [self jumpToHomeView];
        // 极光推送设置帐号别名
        [APService setAlias:[NSString stringWithFormat:@"HeiTuDi%@", kkUserId] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    } else {
        _label_accountAndPasswordWorry.hidden = NO;
        _label_accountAndPasswordWorry.text = [dict valueForKey:@"message"];
        [self showMsg:[dict valueForKey:@"message"]];
    }
}

-(void)GCRequest:(GCRequest*)aRequest Error:(NSString*)aError
{
    [self showMsg:@"网络原因!"];
}

#pragma mark 重写返回键方法
- (void)backButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 当登录成功跳转到我的页面
- (void)jumpToHomeView
{
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:NSClassFromString(@"LoginViewController")]) {
            
            [vc removeFromParentViewController];
        }
        
    }
    
    [self back];
}

- (void)back{

    switch (self.viewControllerIndex) {
        case 4: // 哪来回哪去
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 5: // 修改密码之后登录跳转
            for (UIViewController *ViewContrller in self.navigationController.viewControllers) {
                if ([ViewContrller isKindOfClass:[PersonalCenterViewController class]]) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }
            break;
        case 6:  // 推送未登录跳转
        {
            [self removeFromParentViewController];
            [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
            [self.appDelegate.homeTabBarController.homeTabBar onSetButtonClicked:nil];
            UINavigationController *nav = (UINavigationController*)self.appDelegate.homeTabBarController.selectedViewController;
            PrizeViewController *prize = [[PrizeViewController alloc] init];
            [nav pushViewController:prize animated:YES];
        }
            break;
        case 8: // 天天宝箱未登录跳转
        {
            [self.appDelegate.homeTabBarController.homeTabBar onHomePageButtonClicked:nil];
            UINavigationController *nav = (UINavigationController*)self.appDelegate.homeTabBarController.selectedViewController;
            PRJ_DayDaytreasureViewController *baoXiang = [[PRJ_DayDaytreasureViewController alloc] init];
            [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
            [nav pushViewController:baoXiang animated:YES];
            [self removeFromParentViewController];
        }
            break;
        default:
            [self removeFromParentViewController];
            [self.appDelegate.homeTabBarController.homeTabBar onSetButtonClicked:nil];
            [self.navigationController popViewControllerAnimated:YES];
            break;
    }

}

#pragma mark 极光推送设置帐号别名
- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet*)tags
                    alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

@end
