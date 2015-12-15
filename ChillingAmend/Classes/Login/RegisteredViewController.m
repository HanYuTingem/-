//
//  RegisteredViewController.m
//  LANSING
//
//  Created by nsstring on 15/5/27.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "RegisteredViewController.h"
#import "InstructionsViewController.h"
#import "LoginPublicObject.h"
#import "PromptView.h"
#import "PerfectInformationViewController.h"
#import "LoginViewController.h"

@interface RegisteredViewController ()<UITextFieldDelegate,PromptViewDelegate>{
    BOOL agreedToBool;
    BOOL accordingToBool;
    PromptView *promptView;
}
/*设置密码*/
@property (strong, nonatomic) IBOutlet UIView *passwordView;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextView;

/*邀请码*/
@property (strong, nonatomic) IBOutlet UIView *inviteCodeView;
@property (strong, nonatomic) IBOutlet UITextField *inviteCodeTextField;

/*完成注册*/
@property (strong, nonatomic) IBOutlet UIButton *completeButton;

/*显示密码*/
@property (strong, nonatomic) IBOutlet UIImageView *accordingToImageView;

/*是否同意*/
@property (strong, nonatomic) IBOutlet UIImageView *agreedToImageView;

/*是否同意*/
@property (strong, nonatomic) IBOutlet UILabel *resetLabel;

/*用户协议*/
@property (strong, nonatomic) IBOutlet UILabel *line;
@property (strong, nonatomic) IBOutlet UILabel *agreementLabel;

//清除密码标志位
@property (copy, nonatomic) NSString    *SignStringPasswordTextView;
@property (copy, nonatomic) NSString    *SignStringInviteCodeTextField;
@property (assign, nonatomic) BOOL      isNotFirstPasswordTextView;
@property (assign, nonatomic) BOOL      isNotFirstInviteCodeTextField;


@end

@implementation RegisteredViewController
@synthesize passwordView;
@synthesize passwordTextView;
@synthesize inviteCodeView;
@synthesize inviteCodeTextField;
@synthesize completeButton;
@synthesize agreedToImageView;
@synthesize accordingToImageView;
@synthesize line;
@synthesize rPhone;
@synthesize agreementLabel;
@synthesize pageInt;
@synthesize resetLabel;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    [completeButton setTitle:pageInt == 1?@"完成注册":@"重置密码" forState:UIControlStateNormal];
    if (pageInt == 1) {
        resetLabel.text = @"输入您的新密码";
        inviteCodeTextField.placeholder = @"邀请码(可不填)";
        inviteCodeTextField.secureTextEntry = NO;
        agreementLabel.hidden = NO;
        line.hidden = NO;
        agreedToImageView.hidden = NO;
    }else{
        resetLabel.text = @"输入您的新密码";
        inviteCodeTextField.placeholder = @"确认密码";
        inviteCodeTextField.secureTextEntry = YES;
        
        agreementLabel.hidden = YES;
        line.hidden = YES;
        agreedToImageView.hidden = YES;
    }
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyBoardController addToolbarToKeyboard];
    passwordTextView.delegate = self;
    inviteCodeTextField.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [keyBoardController removeKeyBoardNotification];
    keyBoardController= nil;
    
}

#pragma mark -
#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([textField isEqual:passwordTextView]) {
        
        _SignStringPasswordTextView    = @"";
    }else if([textField isEqual:inviteCodeTextField]){
    
        _SignStringInviteCodeTextField = @"";
    }
    return YES;
}

-(void)complete{
    if (passwordTextView.text.length >= 6&&passwordTextView.text.length <=20&&agreedToBool == NO) {
        [completeButton setBackgroundColor:[UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f]];
        completeButton.userInteractionEnabled = YES;
    }else
        [completeButton setBackgroundColor:RGBACOLOR(195, 195, 195, 1)];
        completeButton.userInteractionEnabled = NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@"\n"]){
        [textField resignFirstResponder];
        return NO;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    NSString *passwordText = textField == passwordTextView?toBeString:passwordTextView.text;
    NSString *inviteCodeText = textField == inviteCodeTextField?toBeString:inviteCodeTextField.text;

    
    if ([textField isEqual:passwordTextView]) {
        
        //清除密码标志位置空
        _SignStringPasswordTextView = [_SignStringPasswordTextView stringByAppendingString:string];;
        
    }
    
    if ([textField isEqual:inviteCodeTextField]) {
        
        //清除密码标志位置空
        _SignStringInviteCodeTextField = [_SignStringInviteCodeTextField stringByAppendingString:string];;
        
    }
    
    if (pageInt == 1) {
        if (passwordText.length >= 6&&passwordText.length <=20&&agreedToBool == NO && _SignStringPasswordTextView.length >= 6) {
            [completeButton setBackgroundColor:[UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f]];
            completeButton.userInteractionEnabled = YES;
        }else{
            [completeButton setBackgroundColor:RGBACOLOR(195, 195, 195, 1)];
            completeButton.userInteractionEnabled = NO;
        }
    }else{
    
        NSLog(@"\n _SignStringPasswordTextView = %@  \n  _SignStringInviteCodeTextField = %@" ,_SignStringPasswordTextView,_SignStringInviteCodeTextField );
        if (passwordText.length >= 6 && passwordText.length <=20 && _SignStringPasswordTextView.length >= 6 && inviteCodeText.length >= 6 && inviteCodeText.length <=20 && _SignStringInviteCodeTextField.length >=6 ) {
            [completeButton setBackgroundColor:[UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f]];
            completeButton.userInteractionEnabled = YES;
        }else{
            [completeButton setBackgroundColor:RGBACOLOR(195, 195, 195, 1)];
            completeButton.userInteractionEnabled = NO;
        }
    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:pageInt == 1?@"注册":@"重置密码"];
    promptView = [PromptView Instance];
    promptView.logInToRegisterLabel.text = @"注册成功";
    promptView.delegate = self;
    promptView.frame = self.view.bounds;
    [self.view addSubview:promptView];
    
//    是否同意选择默认位为选择
    agreedToBool = NO;
    agreedToImageView.image = [UIImage imageNamed:@"content_btn_ok_selected"];
    
//    是否显示密码 默认为不显示
    accordingToBool = NO;
    
    /*阴影和倒角*/
    passwordView.layer.shadowRadius = 1;
    passwordView.layer.shadowOpacity = 0.4f;
    passwordView.layer.shadowOffset = CGSizeMake(0, 0);
    passwordView.layer.cornerRadius = 5;
    
    inviteCodeView.layer.shadowRadius = 1;
    inviteCodeView.layer.shadowOpacity = 0.4f;
    inviteCodeView.layer.shadowOffset = CGSizeMake(0, 0);
    inviteCodeView.layer.cornerRadius = 5;
    
    completeButton.layer.shadowRadius = 1;
    completeButton.layer.shadowOpacity = 0.2f;
    completeButton.layer.shadowOffset = CGSizeMake(0, 0);
    completeButton.layer.cornerRadius = 5;
    
    agreedToImageView.userInteractionEnabled = YES;
    [agreedToImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(agreedTo)]];
    
    
    // Do any additional setup after loading the view from its nib.
    /*回收键盘*/
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toolbarButtonTap)];
    [self.view addGestureRecognizer:tap1];
    // Do any additional setup after loading the view from its nib.
}

//是否同意选择默认位为选择
-(void)agreedTo{
    if (agreedToBool == NO) {
        agreedToBool = YES;
        agreedToImageView.image = [UIImage imageNamed:@"content_btn_ok_normal"];
    }else{
        agreedToBool = NO;
        agreedToImageView.image = [UIImage imageNamed:@"content_btn_ok_selected"];
    }
    [self complete];
}

/*键盘回收*/
-(void)toolbarButtonTap{
    [passwordTextView resignFirstResponder];
    [inviteCodeTextField resignFirstResponder];
}

/*完成 发送*/
- (IBAction)complete:(id)sender {
    if ([GCUtil convertToInt:passwordTextView.text] < 1){
        [self showMsg:@"请输入密码!"];
        return;
    }else if ([GCUtil convertToInt:passwordTextView.text] < 6||[GCUtil convertToInt:passwordTextView.text] > 20){
        [self showMsg:@"密码输入错误!"];
        return;
    }
    
//    pageInt;  //1、注册 2、重设密码
    
    if (pageInt == 2) {
        if (![inviteCodeTextField.text isEqualToString:passwordTextView.text]){
            [self showMsg:@"确认密码不一致!"];
            return;
        }else{
            mainRequest.tag = 100;
             [mainRequest requestHttpWithPost:[NSString stringWithFormat:@"%@updateAppPwd/",ADDRESS] withDict:[LogInAPP retrievePasswordUserName:rPhone pwd:passwordTextView.text]];
        }
    }else if (pageInt == 1){
        if (agreedToBool == YES) {
            [self showMsg:@"请阅读用户协议并同意!"];
            return;
        }else{
            mainRequest.tag = 101;
            [mainRequest requestHttpWithPost:[NSString stringWithFormat:@"%@registeredUser/",ADDRESS] withDict:[LogInAPP registeredUserName:rPhone pwd:passwordTextView.text inviteCode:inviteCodeTextField.text]];
        }
    }
    
}

#pragma mark -
#pragma mark - 登陆成功提示返回

-(void)chooseSkip:(int)skipInt{
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)chooseToUnderstand:(int)understandInt{
    //    账号说明
    InstructionsViewController *instructions = [[InstructionsViewController alloc]init];
    instructions.entranceInt = 2;
    instructions.typeInt = 2;
    [self.navigationController pushViewController:instructions animated:YES];
}

#pragma mark -
#pragma mark - 请求返回GCRequest

-(void)GCRequest:(GCRequest*)aRequest Finished:(NSString*)aString
{
    aString = [aString stringByReplacingOccurrencesOfString:@"null"withString:@"\"\""];
    NSMutableDictionary *dict=[aString JSONValue];
    NSLog(@"22==%@",dict);
    if (dict) {
        if ([[dict objectForKey:@"code"] intValue] == 1) {
            if (aRequest.tag == 100) {
                [self showMsg:@"修改成功!"];
//                [self.navigationController popToRootViewControllerAnimated:YES];
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[LoginViewController class]]) {
                        [self.navigationController popToViewController:controller animated:YES];
                    }
                }
                
            }else if (aRequest.tag == 101){
                NSDictionary *resultDic = (NSDictionary *)[dict objectForKey:@"result"];
                [SaveMessage saveUserMessageJava:resultDic];
                if (APPLICATION == 1) {
                    [self toolbarButtonTap];
                    promptView.InTheFormOfInt = 1;
                    promptView.hidden = NO;
                }else{
                mainRequest.tag = 102;
                [mainRequest requestHttpWithPost:[NSString stringWithFormat:@"%@",ADDRESSPHP] withDict:[LogInAPP accessToLoginInformationUserId:[resultDic objectForKey:@"id"] userName:[resultDic objectForKey:@"userName"] sex:[resultDic objectForKey:@"sex"] nickName:[resultDic objectForKey:@"nickname"] src:[resultDic objectForKey:@"src"] jifen:@"0"status:[resultDic objectForKey:@"status"] lat:@"" ing:@"" token:@""]];
                }
                
            }else if (aRequest.tag == 102){
                [SaveMessage saveUserMessagePHP:dict];
                [self toolbarButtonTap];
                promptView.InTheFormOfInt = 1;
//                promptView.hidden = NO;
                NSLog(@"%@",dict);
                [SaveMessage publicLoadDataWithNoLoginGetMoney];
                // 注册成功，跳转到完善资料界面
                PerfectInformationViewController *perfectInformation = [[PerfectInformationViewController alloc] init];
                perfectInformation.phoneNum = [dict objectForKey:@"user_name"];
                perfectInformation.dic = dict;
                [self.navigationController pushViewController:perfectInformation animated:YES];
            }
            
        }else{
            switch ([[dict objectForKey:@"code"] intValue]) {
                case 0:{
                    [self showMsg:@"验证码发送失败!"];
                    break;
                }
                case 100:{
                    [self showMsg:@"用户名不存在!"];
                    break;
                }
                case 101:{
                    [self showMsg:@"用户名存在!"];
                    break;
                }
                case 103:{
                    [self showMsg:@"没有登录平台权限!"];
                    break;
                }
                case 203:{
                    [self showMsg:@"系统异常!"];
                    break;
                }
                    
                default:{
                    [self showMsg:[dict objectForKey:@"message"]];
                    break;
                }
            }
        }
    }
    else
    {
        [self showMsg:@"服务器去月球了!"];
    }
    
}

-(void)GCRequest:(GCRequest*)aRequest Error:(NSString*)aError
{
    [self showMsg:@"网络原因!"];
}


/*显示密码*/
- (IBAction)showThePassword:(id)sender {
    passwordTextView.secureTextEntry = accordingToBool; //密码
    accordingToImageView.image = [UIImage imageNamed:accordingToBool == YES?@"content_btn_password_edited":@"content_btn_password_edited-1"];
    accordingToBool = !accordingToBool;
}

/*用户协议*/
- (IBAction)userAgreementBur:(id)sender {
    if (pageInt == 1) {
        InstructionsViewController *instructions = [[InstructionsViewController alloc]init];
        instructions.entranceInt = 1;
        instructions.typeInt = 1;
        [self.navigationController pushViewController:instructions animated:YES];
    }
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

@end
