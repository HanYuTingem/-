//
//  AmendPassViewController.m
//  LANSING
//
//  Created by nsstring on 15/5/29.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "AmendPassViewController.h"
#import "LoginPublicObject.h"

@interface AmendPassViewController ()<UITextFieldDelegate>{
    BOOL accordingToBool;
}
/*旧密码*/
@property (strong, nonatomic) IBOutlet UIView *theOldPasswordView;
@property (strong, nonatomic) IBOutlet UITextField *theOldPasswordTextField;

/*新密码*/
@property (strong, nonatomic) IBOutlet UIView *passwordView;
@property (strong, nonatomic) IBOutlet UITextField *passworTextField;

/*确认密码*/
@property (strong, nonatomic) IBOutlet UIView *confirmView;
@property (strong, nonatomic) IBOutlet UITextField *confirmTextField;

/*显示密码*/
@property (strong, nonatomic) IBOutlet UIImageView *accordingToImageView;

/*设置密码*/
@property (strong, nonatomic) IBOutlet UIButton *setUpTheButton;

/*错误提示*/
@property (strong, nonatomic) IBOutlet UILabel *promptLabel;

@property (copy, nonatomic) NSString *signStringtheOldPasswordTextField;
@property (copy, nonatomic) NSString *signStringPassworTextField;
@property (copy, nonatomic) NSString *signStringConfirmTextField;

@end

@implementation AmendPassViewController
@synthesize theOldPasswordView;
@synthesize theOldPasswordTextField;
@synthesize passwordView;
@synthesize passworTextField;
@synthesize confirmView;
@synthesize confirmTextField;
@synthesize setUpTheButton;
@synthesize accordingToImageView;
@synthesize promptLabel;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyBoardController addToolbarToKeyboard];
    theOldPasswordTextField.delegate = self;
    passworTextField.delegate = self;
    confirmTextField.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [keyBoardController removeKeyBoardNotification];
    keyBoardController= nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    是否显示密码 默认为不显示
    accordingToBool = NO;
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"修改密码"];

    /*阴影和倒角*/
    theOldPasswordView.layer.shadowRadius = 1;
    theOldPasswordView.layer.shadowOpacity = 0.4f;
    theOldPasswordView.layer.shadowOffset = CGSizeMake(0, 0);
    theOldPasswordView.layer.cornerRadius = 5;
    
    passwordView.layer.shadowRadius = 1;
    passwordView.layer.shadowOpacity = 0.4f;
    passwordView.layer.shadowOffset = CGSizeMake(0, 0);
    passwordView.layer.cornerRadius = 5;
    
    confirmView.layer.shadowRadius = 1;
    confirmView.layer.shadowOpacity = 0.4f;
    confirmView.layer.shadowOffset = CGSizeMake(0, 0);
    confirmView.layer.cornerRadius = 5;
    
    setUpTheButton.layer.shadowRadius = 1;
    setUpTheButton.layer.shadowOpacity = 0.2f;
    setUpTheButton.layer.shadowOffset = CGSizeMake(0, 0);
    setUpTheButton.layer.cornerRadius = 5;
    
    /*回收键盘*/
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toolbarButtonTap)];
    [self.view addGestureRecognizer:tap1];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -
#pragma mark - TextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (theOldPasswordTextField.text.length >= 6&&theOldPasswordTextField.text.length <= 15&&passworTextField.text.length >= 6&&passworTextField.text.length <= 15&&confirmTextField.text.length >= 6&&confirmTextField.text.length <= 15) {
        [setUpTheButton setBackgroundColor:[UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f]];

    }else
        [setUpTheButton setBackgroundColor:RGBACOLOR(195, 195, 195, 1)];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([textField isEqual:theOldPasswordTextField]) {
        
        _signStringtheOldPasswordTextField    = @"";
    }else if([textField isEqual:passworTextField]){
        
        _signStringPassworTextField           = @"";
    }else if ([textField isEqual:confirmTextField]){
        
        _signStringConfirmTextField           = @"";
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@"\n"]){
        [textField resignFirstResponder];
        return NO;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    NSString *theOldPasswordText = textField == theOldPasswordTextField?toBeString:theOldPasswordTextField.text;
    NSString *passworText = textField == passworTextField?toBeString:passworTextField.text;
    NSString *confirmText = textField == confirmTextField?toBeString:confirmTextField.text;
    
    if ([textField isEqual:theOldPasswordTextField]) {
        
        //清除密码标志位置空
        _signStringtheOldPasswordTextField = [_signStringtheOldPasswordTextField stringByAppendingString:string];;
        
    }
    
    if ([textField isEqual:passworTextField]) {
        
        //清除密码标志位置空
        _signStringPassworTextField = [_signStringPassworTextField stringByAppendingString:string];;
        
    }
    
    if ([textField isEqual:confirmTextField]) {
        
        //清除密码标志位置空
        _signStringConfirmTextField = [_signStringConfirmTextField stringByAppendingString:string];;
        
    }
    
    if (theOldPasswordText.length >= 6&&theOldPasswordText.length <= 20 && _signStringtheOldPasswordTextField.length >=6 &&passworText.length >= 6&&passworText.length <= 20 && _signStringPassworTextField.length >= 6 &&confirmText.length >= 6&&confirmText.length <= 20 && _signStringConfirmTextField.length >= 6) {
        [setUpTheButton setBackgroundColor:[UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f]];
        //yc20150626DLZC-8注册页面，手机号码和验证码均不填写，点击【设置密码】按钮，显示提示信息，【设置密码】按钮应为置灰不可用
        setUpTheButton.userInteractionEnabled = YES;
    }else{
        [setUpTheButton setBackgroundColor:RGBACOLOR(195, 195, 195, 1)];
        setUpTheButton.userInteractionEnabled = NO;
        promptLabel.hidden = YES;
    }

    return YES;
}

/*显示密码*/
- (IBAction)showThePassword:(id)sender{
    theOldPasswordTextField.secureTextEntry = accordingToBool; //密码
    accordingToImageView.image = [UIImage imageNamed:accordingToBool == YES?@"content_btn_password_edited":@"content_btn_password_edited-1"];
    accordingToBool = !accordingToBool;
}

/*键盘回收*/
-(void)toolbarButtonTap{
    [theOldPasswordTextField resignFirstResponder];
    [passworTextField resignFirstResponder];
    [confirmTextField resignFirstResponder];
}

- (IBAction)setThePasswordBut:(id)sender {
    promptLabel.hidden = NO;
    if ([GCUtil convertToInt:theOldPasswordTextField.text] < 1) {
        promptLabel.text = @"请输入旧密码";
    }else
    if ([GCUtil convertToInt:theOldPasswordTextField.text] < 6||[GCUtil convertToInt:theOldPasswordTextField.text] > 20){
        promptLabel.text = @"旧密码输入错误";
    }else if ([GCUtil convertToInt:passworTextField.text] < 1){
        promptLabel.text = @"请输入新密码";
    }else if ([GCUtil convertToInt:passworTextField.text] < 6||[GCUtil convertToInt:passworTextField.text] > 20){
        promptLabel.text = @"新密码输入错误";
    }else if (![passworTextField.text isEqualToString:confirmTextField.text]){
        promptLabel.text = @"确认密码不一致";
    }else{
        promptLabel.hidden = YES;
        [mainRequest requestHttpWithPost:[NSString stringWithFormat:@"%@updatePwd/",ADDRESS] withDict:[LogInAPP changeThePasswordOldPwd:theOldPasswordTextField.text newPwd:passworTextField.text userId:[kkNickDicJava objectForKey:@"id"]]];
//        [[NSUserDefaults standardUserDefaults] objectForKey:@"id"]
    }
}

-(void)GCRequest:(GCRequest*)aRequest Finished:(NSString*)aString
{
    NSMutableDictionary *dict=[aString JSONValue];
    NSLog(@"22==%@",dict);
    if (dict) {
        if ([[dict objectForKey:@"code"] intValue] == 1) {
            [self showMsg:@"修改成功!"];
        }else{
            switch ([[dict objectForKey:@"code"] intValue]) {
                case 0:{
                    [self showMsg:@"修改失败!"];
                    break;
                }
                case 102:{
                    [self showMsg:@"旧密码错误!"];
                    break;
                }
                case 203:{
                    [self showMsg:@"系统异常!"];
                    break;
                }
                case 9:{
                    [self showMsg:@"新密码不能与旧密码一致!"];
                    break;
                }
                    
                default:{
//                    [self showMsg:[dict objectForKey:@"message"]];
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
