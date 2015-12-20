//
//  ShouRegisterdViewController.m
//  LANSING
//
//  Created by nsstring on 15/5/27.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "ShouRegisterdViewController.h"
#import "RegisteredViewController.h"
#import "LoginPublicObject.h"
#import "PromptView.h"
#import "InstructionsViewController.h"
#import "PRJ_HomeViewController.h"

#import "PrizeViewController.h"
#import "PRJ_DayDaytreasureViewController.h"
#import "PersonalCenterViewController.h"

@interface ShouRegisterdViewController ()<UITextFieldDelegate,PromptViewDelegate>{
    int timeInt;
    PromptView *promptView;
}
/*手机号码*/
@property (strong, nonatomic) IBOutlet UIView *numberView;
@property (strong, nonatomic) IBOutlet UITextField *numberTextField;

/*验证码*/
@property (strong, nonatomic) IBOutlet UIView *validationView;
@property (strong, nonatomic) IBOutlet UITextField *validationTextView;
@property (strong, nonatomic) IBOutlet UIButton *validationButton;
/*提示*/
@property (strong, nonatomic) IBOutlet UILabel *promptLabel;

/*设置密码*/
//错误提示
@property (strong, nonatomic) IBOutlet UIButton *confirmButton;
//输入提示
@property (strong, nonatomic) IBOutlet UILabel *theInputPromptLabel;

/*注册*/
@property (strong, nonatomic) IBOutlet UIButton *onRegisteredButton;

//切换默认登陆方式
@property (strong, nonatomic) IBOutlet UIButton *switchOnButton;

@end

@implementation ShouRegisterdViewController
@synthesize numberView;
@synthesize numberTextField;
@synthesize validationView;
@synthesize validationTextView;
@synthesize validationButton;
@synthesize confirmButton;
@synthesize onRegisteredButton;
@synthesize promptLabel;
@synthesize theInputPromptLabel;

//切换默认登陆方式
@synthesize switchOnButton;

/*
 界面 interfaceInt
 1、注册
 2、无密码快速登录
 3、忘记密码
*/
@synthesize interfaceInt;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [titleButton setTitle:interfaceInt == 1?@"注册":(interfaceInt == 3?@"找回密码":@"无密码快速登录") forState:UIControlStateNormal];
    switchOnButton.hidden = interfaceInt == 2?NO:YES;
    
    confirmButton.tag = interfaceInt;
    [confirmButton setTitle:interfaceInt == 1?@"设置密码":(interfaceInt == 3?@"立即找回":@"登录") forState:UIControlStateNormal];
    
    theInputPromptLabel.text = interfaceInt == 1?@"输入您的手机号并验证":@"输入您已注册的手机号";
    onRegisteredButton.hidden = interfaceInt == 1?YES:NO;
    [onRegisteredButton setTitle:interfaceInt == 1?@"登录":@"注册" forState:UIControlStateNormal];
//    [backView addSubview:onRegisteredButton];
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyBoardController addToolbarToKeyboard];
    numberTextField.delegate = self;
    validationTextView.delegate = self;
    
    timeInt = 0;
    [self hide];
    promptLabel.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [keyBoardController removeKeyBoardNotification];
    keyBoardController= nil;
}

#pragma mark -
#pragma mark - TextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([GCUtil isMobileNumber:numberTextField.text] != 0&&validationTextView.text.length == 6) {
        [confirmButton setBackgroundColor:[UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f]];

    }else
        [confirmButton setBackgroundColor:RGBACOLOR(195, 195, 195, 1)];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@"\n"]){
        [textField resignFirstResponder];
        return NO;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    NSString *passwordText = textField == validationTextView?toBeString:validationTextView.text;
    
    if (numberTextField == textField) {
        if (toBeString.length > 11) {
            //            [self showMsg:@"手机号码不能超过11位!"];
            return NO;
        }
    }

    if ([GCUtil isMobileNumber:textField == numberTextField?toBeString:numberTextField.text] != 0&&passwordText.length == 6) {
        [confirmButton setBackgroundColor:[UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f]];
        //yc20150626DLZC-8注册页面，手机号码和验证码均不填写，点击【设置密码】按钮，显示提示信息，【设置密码】按钮应为置灰不可用
        confirmButton.userInteractionEnabled = YES;
    }else{
        [confirmButton setBackgroundColor:RGBACOLOR(195, 195, 195, 1)];
        confirmButton.userInteractionEnabled = NO;
        promptLabel.hidden = YES;
    }
    //    NSLog(@"-------:%@",toBeString);
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:interfaceInt == 1?@"注册":(interfaceInt == 3?@"找回密码":@"无密码快速登录")];
    promptView = [PromptView Instance];
    promptView.frame = self.view.bounds;
    promptView.delegate = self;
    promptView.logInToRegisterLabel.text = @"登录成功";
    [self.view addSubview:promptView];
    
    /*阴影和倒角*/
    numberView.layer.shadowRadius = 1;
    numberView.layer.shadowOpacity = 0.4f;
    numberView.layer.shadowOffset = CGSizeMake(0, 0);
    numberView.layer.cornerRadius = 5;
    
    validationView.layer.shadowRadius = 1;
    validationView.layer.shadowOpacity = 0.4f;
    validationView.layer.shadowOffset = CGSizeMake(0, 0);
    validationView.layer.cornerRadius = 5;
    
    validationButton.layer.shadowRadius = 1;
    validationButton.layer.shadowOpacity = 0.2f;
    validationButton.layer.shadowOffset = CGSizeMake(0, 0);
    validationButton.layer.cornerRadius = 5;
    
    confirmButton.layer.shadowRadius = 1;
    confirmButton.layer.shadowOpacity = 0.2f;
    confirmButton.layer.shadowOffset = CGSizeMake(0, 0);
    confirmButton.layer.cornerRadius = 5;
    // Do any additional setup after loading the view from its nib.
    /*回收键盘*/
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toolbarButtonTap)];
    [self.view addGestureRecognizer:tap1];
    // Do any additional setup after loading the view from its nib.
}

/*键盘回收*/
-(void)toolbarButtonTap{
    [numberTextField resignFirstResponder];
    [validationTextView resignFirstResponder];
}

/*获取验证码*/
- (IBAction)getVerificationCodeBut:(id)sender {
    
    NSLog(@"12345678");
    if (numberTextField.text.length < 1) {
        promptLabel.hidden = NO;
        promptLabel.text = @"请输入您的手机号码!";
    }else if ([GCUtil isMobileNumber:numberTextField.text] == 0){
        promptLabel.hidden = NO;
        promptLabel.text = @"请输入正确的手机号码!";
    }else{
        validationButton.enabled = NO;
        [self toolbarButtonTap];
        promptLabel.hidden = YES;
        /*
         界面 interfaceInt
         1、注册
         2、无密码快速登录
         3、忘记密码
         */
        if (timeInt < 1) {
            mainRequest.tag = 100;
            [mainRequest requestHttpWithPost:[NSString stringWithFormat:@"%@findCode",ADDRESS] withDict:[LogInAPP getVerificationCode:numberTextField.text type:interfaceInt == 1?@"1":(interfaceInt == 2?@"3":(interfaceInt == 3?@"2":@"1"))]];
        }
        
    }
}

-(void)theCountdown:(NSTimer *)timer{
    if (timeInt < 1) {
        [timer invalidate];
        [validationButton setBackgroundColor:[UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f]];
        [validationButton setTitle:@"重新获取" forState:UIControlStateNormal];
        validationButton.enabled = YES;
    }else{
        [validationButton setTitle:[NSString stringWithFormat:@"%ds",timeInt] forState:UIControlStateNormal];
    }
    timeInt--;
}
-(void)GCRequest:(GCRequest*)aRequest Finished:(NSString*)aString{
    
    [self showMsg:nil];
    aString = [aString stringByReplacingOccurrencesOfString:@"null"withString:@"\"\""];
    NSMutableDictionary *dict=[aString JSONValue];
    NSLog(@"22==%@",dict);
    if (dict) {
        if ([[dict objectForKey:@"code"] intValue] == 1) {
            promptLabel.hidden = YES;
            if (aRequest.tag == 100) {
                [self showMsg:@"发送成功!"];
                [validationButton setBackgroundColor:RGBACOLOR(195, 195, 195, 1)];
                timeInt = 60;
                [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(theCountdown:) userInfo:nil repeats:YES];
            }
            
            switch (aRequest.tag) {
                case 101:{
                    RegisteredViewController *registered = [[RegisteredViewController alloc]init];
                    registered.rPhone = numberTextField.text;
                    registered.pageInt = 1;
                    [self.navigationController pushViewController:registered animated:YES];
                    break;
                }
                case 102:{
                    NSDictionary *resultDic = (NSDictionary *)[dict objectForKey:@"result"];
                    [SaveMessage saveUserMessageJava:resultDic];
                    if (APPLICATION == 1) {
//                        promptView.InTheFormOfInt = 1;
//                        promptView.hidden = NO;
                    }else{
                        mainRequest.tag = 104;
                        [mainRequest requestHttpWithPost:[NSString stringWithFormat:@"%@",ADDRESSPHP] withDict:[LogInAPP accessToLoginInformationUserId:[resultDic objectForKey:@"id"] userName:[resultDic objectForKey:@"userName"] sex:[resultDic objectForKey:@"sex"] nickName:[resultDic objectForKey:@"nickname"] src:[resultDic objectForKey:@"src"] jifen:@"0"status:[resultDic objectForKey:@"status"] lat:@"" ing:@"" token:@""]];
                    }
                    break;
                }
                case 103:{
                    RegisteredViewController *registered = [[RegisteredViewController alloc]init];
                    registered.rPhone = numberTextField.text;
                    registered.pageInt = 2;
                    [self.navigationController pushViewController:registered animated:YES];
                    break;
                }
                case 104:{

                    MySetObjectForKey([dict objectForKey:@"userid"],UserIDKey);//保存登陆用户的id
                    MySetObjectForKey([dict objectForKey:@"user_name"], LoginPhoneKey);//保存手机号
                    promptView.InTheFormOfInt = 1;
                    //                    promptView.hidden = NO;
                    [SaveMessage publicLoadDataWithNoLoginGetMoney];
                    [kkUserInfo resetInfo:[[NSUserDefaults standardUserDefaults]objectForKey:usernameMessagePHP]];
                    [BSaveMessage saveUserMessage:[[NSUserDefaults standardUserDefaults]objectForKey:usernameMessagePHP]];
                    [GCUtil saveLajiaobijifenWithJifen:[[[NSUserDefaults standardUserDefaults]objectForKey:usernameMessagePHP] objectForKey:@"jifen"]];
                    [self loadDataWithNoLoginGetMoney];
//                    GAHomeTabBarController *tabbar = [GAHomeTabBarController sharedHomeTabBarController];
//                    [tabbar selectTabBarAtIndex:0];
//                    [tabbar.homeTabBar selectTabBarAtIndex:0];
//                    [self.navigationController popToRootViewControllerAnimated:YES];

                    // 注册成功，跳转到首页
//                    PRJ_HomeViewController *homeVC = [[PRJ_HomeViewController alloc] init];
//                    [self.navigationController pushViewController:homeVC animated:YES];
                    
                    
                }
                default:
                    break;
            }
            
        }else{
            [self hide];
            promptLabel.hidden = NO;
            switch ([[dict objectForKey:@"code"] intValue]) {
                case 0:{
                    promptLabel.text = @"验证码错误!";
                    break;
                }
                case 2:{
                    promptLabel.text = @"用户被锁定!";
                    break;
                }
                case 100:{
                    promptView.InTheFormOfInt = 3;
                    promptView.hidden = NO;
                    //yc20150629用户不存在，这里我们就不给出验证码错误的提示，给隐藏。
                    promptLabel.hidden = YES;
                    break;
                }
                case 101:{
                    promptView.InTheFormOfInt = 4;
                    promptView.hidden = NO;
                    break;
                }
                case 103:{
                    promptLabel.text = @"没有登录平台权限!";
                    break;
                }
                case 99:{
                    promptLabel.text = @"超过最大发送次数!";
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
        promptLabel.hidden = YES;
        [self showMsg:@"服务器去月球了!"];
    }
    
}

-(void)GCRequest:(GCRequest*)aRequest Error:(NSString*)aError
{
    NSLog(@"aError ===  %@",aError);
    promptLabel.hidden = YES;
    validationButton.enabled = YES;
//    [self showMsg:@"网络原因!"];
    [self showMsg:@"网络连接失败!"];
}

#pragma mark -
#pragma mark - 登陆成功提示返回

-(void)chooseSkip:(int)skipInt{
    
    if (skipInt == 1){
//        [self jumpToHomeView];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (skipInt == 4){
        //    账号说明
        InstructionsViewController *instructions = [[InstructionsViewController alloc]init];
        instructions.entranceInt = 3;
        instructions.typeInt = 2;
        instructions.viewControllerIndex = self.viewControllerIndex;
        [self.navigationController pushViewController:instructions animated:YES];
    }
}



-(void)chooseToUnderstand:(int)understandInt{
    if (understandInt == 1) {
        //    账号说明
        InstructionsViewController *instructions = [[InstructionsViewController alloc]init];
        instructions.entranceInt = 2;
        instructions.typeInt = 2;
        instructions.viewControllerIndex = self.viewControllerIndex;
        [self.navigationController pushViewController:instructions animated:YES];
    }else if (understandInt == 3){
        ShouRegisterdViewController *shouRegisterd = [[ShouRegisterdViewController alloc]init];
        shouRegisterd.interfaceInt = 1;
        [self.navigationController pushViewController:shouRegisterd animated:YES];
    }else if (understandInt == 4){
//        [self.navigationController popToRootViewControllerAnimated:YES];
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[LoginViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }
    
}


- (IBAction)setThePassword:(id)sender {
    /*
     1、注册
     2、无密码快速登录
     3、忘记密码
     */     
    UIButton *but = (UIButton *)sender;
    mainRequest.tag = 100 + but.tag;
    if (numberTextField.text.length < 1) {
        promptLabel.hidden = NO;
        promptLabel.text = @"请输入您的手机号码!";
        return;
    }else if ([GCUtil isMobileNumber:numberTextField.text] == 0){
        promptLabel.hidden = NO;
        promptLabel.text = @"请输入正确的手机号码!";
        return;
    }else
    if (validationTextView.text.length < 1) {
        promptLabel.hidden = NO;
        promptLabel.text = @"请输入验证码!";
        return;
    }else if (validationTextView.text.length <= 5||validationTextView.text.length >= 7){
        promptLabel.hidden = NO;
        promptLabel.text = @"请输入正确的验证码!";
        return;
    }else{
        //yc20150629DLZC-50【注册】验证码只能在没有完全实现注册只能用一次，所以把if条件判断语句去掉
//        if (timeInt > 0) {
        promptLabel.hidden = YES;
        [mainRequest requestHttpWithPost:[NSString stringWithFormat:@"%@authValidateLoginCode/",ADDRESS] withDict:[LogInAPP verifyTheVerificationCodeUserName:numberTextField.text vcode:validationTextView.text type:interfaceInt == 1?@"1":(interfaceInt == 2?@"3":(interfaceInt == 3?@"2":@"1"))]];
        }
//    }
    
}

/*登陆\注册*/
- (IBAction)logInToRegister:(id)sender {
    if (interfaceInt == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        ShouRegisterdViewController *shouRegisterd = [[ShouRegisterdViewController alloc]init];
        shouRegisterd.interfaceInt = 1;
        [self.navigationController pushViewController:shouRegisterd animated:YES];
    }
    
}

//切换默认登陆方式
- (IBAction)switchOnBut:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 {“code”:  101 系统错误
 “message”:”There’s an error.” //错误说明
 }
 展示捞奖次数不足，领取失败，提示可以换个手机号领取
 {“code”:  102 //展示捞奖次数不足
 “message”:” 领取失败，提示可以换个手机号领取.” //失败说明
 }
 
 {“code”:  103 登陆失败
 “message”:”” // 验证码错误 注册失败
 }
 {“code”:  104 //饺子已过期
 “message”:” 饺子已过期” //失败说明
 }
 {““code”:  105 //饺子已被领取
 “message”:” 饺子已被领取.” //失败说明
 }
 {“code”:  106//参数不正确
 “message”:” 参数不正确” //失败说明
 }
 {“code”:  107//饺子配置规则缓存无数据
 “message”:” 饺子配置规则缓存无数据” //失败说明
 }
 {“code”:  108 //用户饺子配置规则缓存无数据
 “message”:” 用户饺子配置规则缓存无数据” //失败说明
 }
 {“code”:  109 //饺子缓存为空
 “message”:” 饺子缓存为空” //失败说明
 }
 */
#pragma mark -- 调用领取接口
-(void)loadDataWithNoLoginGetMoney{
    
    //未登录饺子存储的饺子
    NSMutableArray *dumplingInforNoLogingArray = [NSMutableArray arrayWithContentsOfFile:DumplingInforNoLogingPath];
    NSMutableArray *dumplingIdArray = [NSMutableArray array];//未登录没有领取的饺子
    for (NSDictionary *subDic in dumplingInforNoLogingArray) {
        DumplingInforModel *model = [DumplingInforModel dumplingInforModelWithDic:subDic];
        [dumplingIdArray addObject:model.resultListModel.dumplingModel.prizeId];
    }
    if (dumplingIdArray.count > 0) {
        NSString *dumplingStr =  [dumplingIdArray componentsJoinedByString:@","];
        
        
        //        [self showHudInView:self.view hint:@"正在领取。。。"];
        [LYLAFNetWorking getWithBaseURL:[LYLHttpTool noLogingGetMoneyWithProductCode:ProductCode sysType:SysType sessionValue:SessionValue phone:kkUserName  prizeidList:dumplingStr andUserId:kkUserCenterId] success:^(id json) {
            ZHLog(@"%@",json);
            //            [self hideHud];
            
            switch ([[json objectForKey:@"code"] intValue]) {
                case 100://领取成功
                {
                    //                    [self showHint:@"领取成功"];
                    NSMutableArray *logingArray = [NSMutableArray arrayWithContentsOfFile:DumplingInforLogingPath];
                    if(!logingArray){
                        logingArray = [NSMutableArray array];
                    }
                    [logingArray addObjectsFromArray:dumplingInforNoLogingArray];
                    [logingArray writeToFile:DumplingInforLogingPath atomically:YES];//将未登录的饺子存为已登陆的
                    
                    /**
                     *  更给储存未登陆的饺子信息
                     */
                    [dumplingInforNoLogingArray removeAllObjects];
                    [dumplingInforNoLogingArray writeToFile:DumplingInforNoLogingPath atomically:YES];
                    //                    promptView.InTheFormOfInt = 1;
                    //                    promptView.hidden = NO;
//                    GAHomeTabBarController *tabbar = [GAHomeTabBarController sharedHomeTabBarController];
//                    [tabbar selectTabBarAtIndex:0];
//                    [tabbar.homeTabBar selectTabBarAtIndex:0];
//                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                    break;
                case 101:
                {
                    //                    [Tools showInfoAlert:@"系统错误"];
                }
                    break;
                case 102:
                {
                    //                    [Tools showInfoAlert:@"领取失败，可以换个手机号领取"];
                }
                    break;
                case 103:
                {
                    
                    //                    [Tools showInfoAlert:@"登陆失败"];
                }
                    break;
                case 104:
                {
                    [dumplingInforNoLogingArray removeAllObjects];
                    [dumplingInforNoLogingArray writeToFile:DumplingInforNoLogingPath atomically:YES];
                    //                    [Tools showInfoAlert:@"饺子已过期"];
                }
                    break;
                case 105:{
                    [dumplingInforNoLogingArray removeAllObjects];
                    [dumplingInforNoLogingArray writeToFile:DumplingInforNoLogingPath atomically:YES];
                    //                    [Tools showInfoAlert:@"饺子已被领取"];
                }
                    break;
                    
                case 106:
                {
                    //                [Tools showInfoAlert:@"参数不正确"];
                }
                    break;
                case 107:
                case 108:
                case 109:{
                    [dumplingInforNoLogingArray removeAllObjects];
                    [dumplingInforNoLogingArray writeToFile:DumplingInforNoLogingPath atomically:YES];
                    //                    [Tools showInfoAlert:@"饺子信息无效"];
                }
                    break;
                default:
                    break;
            }
            [[NoGetMoneyView shareGetMoneyView] refreshShareGetMoneyView];//刷新捞一捞界面未领取金额的数据
            GAHomeTabBarController *tabbar = [GAHomeTabBarController sharedHomeTabBarController];
            [tabbar selectTabBarAtIndex:0];
            [tabbar.homeTabBar selectTabBarAtIndex:0];
            [self.navigationController popToRootViewControllerAnimated:YES];

        } failure:^(NSError *error) {
            ZHLog(@"%@",error);
            //            [self hideHud];
            GAHomeTabBarController *tabbar = [GAHomeTabBarController sharedHomeTabBarController];
            [tabbar selectTabBarAtIndex:0];
            [tabbar.homeTabBar selectTabBarAtIndex:0];
            [self.navigationController popToRootViewControllerAnimated:YES];

        }];
    }
    else {
        //        promptView.InTheFormOfInt = 1;
        //        promptView.hidden = NO;
        GAHomeTabBarController *tabbar = [GAHomeTabBarController sharedHomeTabBarController];
        [tabbar selectTabBarAtIndex:0];
        [tabbar.homeTabBar selectTabBarAtIndex:0];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

@end
