//  编辑详细资料（邮箱，昵称等）
//  EditDetailMessageViewController.m
//  ChillingAmend
//
//  Created by 许文波 on 14/12/20.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "EditDetailMessageViewController.h"
#import "LoginViewController.h"

#define kYOffset -20 // 提示框偏移量
#define MaxNumberOfDescriptionChars 100 // 最大输入字数

@interface EditDetailMessageViewController () <UITextViewDelegate>
{
    NSString *sexStr; // 记录当前选择性别
}

@property (weak, nonatomic) IBOutlet UIView *changeSignatureView; // 修改个性签名
@property (weak, nonatomic) IBOutlet UITextView *signatureTextView; // 个性签名输入框
@property (weak, nonatomic) IBOutlet UILabel *signatureCountLabel; // 个性签名字数

@property (weak, nonatomic) IBOutlet UIView *changeNickNameView; // 修改昵称
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField; // 昵称输入框
@property (weak, nonatomic) IBOutlet UIView *changeEmailView; // 修改邮箱
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;// 邮箱输入框
@property (weak, nonatomic) IBOutlet UIView *changeSexView; // 修改性别
@property (weak, nonatomic) IBOutlet UIImageView *maleImageView; // 男
@property (weak, nonatomic) IBOutlet UIImageView *femaleImageView; // 女
@property (weak, nonatomic) IBOutlet UIView *changePasswordView; // 修改密码
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField; // 旧密码输入框
@property (weak, nonatomic) IBOutlet UITextField *freshPasswordTextField; // 新密码输入框
@property (weak, nonatomic) IBOutlet UITextField *secondPasswordTextField; // 再次输入密码输入框

- (IBAction)changeSexAction:(id)sender; // 修改性别
@end

@implementation EditDetailMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.signatureTextView.delegate = self;
    // 男女
    _maleImageView.hidden = YES;
    _femaleImageView.hidden = YES;
    // 个性签名
    _signatureTextView.text = @"请输入内容...";
    _signatureTextView.textColor = RGBACOLOR(104, 104, 104, 1);
    
    [self hideOtherViewAndNavigationBar:self.btnTag];
    // 添加保存键
    [self addRightBarButtonItemWithImageName:@"" andTargate:@selector(saveChangedAction:) andRightItemFrame:CGRectMake(SCREENWIDTH - 10 - 40, 28, 60, 30) andButtonTitle:@"保存" andTitleColor:[UIColor colorWithRed:61/255.0 green:66/255.0 blue:69/255.0 alpha:1.0]];
    // 监听textView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:_signatureTextView];
    // 监听textField
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEditChanged:) name:UITextFieldTextDidChangeNotification object:_nickNameTextField];
}

#pragma mark 监听textField文本改变
- (void)textFieldEditChanged:(NSNotification *)obj
{
    int maxNumberOfDescriptionChars = 12;
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqual:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > maxNumberOfDescriptionChars) {
                textField.text = [toBeString substringToIndex:maxNumberOfDescriptionChars];
            }
        } else {
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    } else {
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > maxNumberOfDescriptionChars) {
            textField.text = [toBeString substringToIndex:maxNumberOfDescriptionChars];
        }
    }
}

#pragma mark 监听textView文本改变
- (void)textViewEditChanged:(NSNotification *)obj
{
    UITextView *textView = (UITextView *)obj.object;
    NSString *toBeString = textView.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqual:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > MaxNumberOfDescriptionChars) {
                textView.text = [toBeString substringToIndex:MaxNumberOfDescriptionChars];
            }
        } else {
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    } else {
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > MaxNumberOfDescriptionChars) {
            textView.text = [toBeString substringToIndex:MaxNumberOfDescriptionChars];
        }
    }
}

#pragma mark 隐藏其它的view和添加导航栏
- (void)hideOtherViewAndNavigationBar:(NSInteger)tag
{
    NSString *title;
    switch (tag) {
        case 100: // 修改个性签名
            self.changeSignatureView.frame = CGRectMake(0, 74, SCREENWIDTH, CGRectGetHeight(self.changeSignatureView.frame));
            self.changeNickNameView.hidden = YES;
            self.changeEmailView.hidden = YES;
            self.changeSexView.hidden = YES;
            self.changePasswordView.hidden = YES;
            _signatureTextView.text = kkUserRemark;
            [_signatureCountLabel setText:[NSString stringWithFormat:@"%lu/100",(unsigned long)_signatureTextView.text.length]];
            [_signatureTextView becomeFirstResponder];
            title = @"个性签名";
            break;
        case 101: // 修改昵称
            self.changeSignatureView.hidden = YES;
            self.changeNickNameView.frame = CGRectMake(0, 74, SCREENWIDTH, CGRectGetHeight(self.changeNickNameView.frame));
            self.changeEmailView.hidden = YES;
            self.changeSexView.hidden = YES;
            self.changePasswordView.hidden = YES;
            _nickNameTextField.text = kkUserNickName;
            title = @"昵称";
            break;
        case 102: // 修改邮箱
            self.changeSignatureView.hidden = YES;
            self.changeNickNameView.hidden = YES;
            self.changeEmailView.frame = CGRectMake(0, 74, SCREENWIDTH, CGRectGetHeight(self.changeEmailView.frame));
            self.changeSexView.hidden = YES;
            self.changePasswordView.hidden = YES;
            _emailTextField.text = kkUseremial;
            title = @"邮箱";
            break;
        case 103: // 修改性别
            self.changeSignatureView.hidden = YES;
            self.changeNickNameView.hidden = YES;
            self.changeEmailView.hidden = YES;
            self.changeSexView.frame = CGRectMake(0, 74, SCREENWIDTH, CGRectGetHeight(self.changeSexView.frame));
            self.changePasswordView.hidden = YES;
            if (kkUserSex.intValue == 1) {
                _maleImageView.hidden = NO;
            } else if (kkUserSex.intValue == 2) {
                _femaleImageView.hidden = NO;
            }
            title = @"性别";
            break;
        case 106: // 修改密码
            self.changeSignatureView.hidden = YES;
            self.changeNickNameView.hidden = YES;
            self.changeEmailView.hidden = YES;
            self.changeSexView.hidden = YES;
            self.changePasswordView.frame = CGRectMake(0, 74, SCREENWIDTH, CGRectGetHeight(self.changePasswordView.frame));
            title = @"修改密码";
            break;
        default:
            break;
    }
    // 导航栏
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:title];
}

#pragma mark 保存修改
- (void) saveChangedAction:(id)sender
{
    switch (_btnTag) {
        case 100: // 修改个性签名
        {
            [_signatureTextView resignFirstResponder];
            NSMutableString *str = [NSMutableString stringWithFormat:@"%@",_signatureTextView.text];
            _signatureTextView.text = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
            if (self.signatureTextView.text.length <= 0 || [self.signatureTextView.text isEqual:@" "]) {
                [self showStringMsg:@"请填写内容!" andYOffset:kYOffset];
            } else if ([self.signatureTextView.text isEqual:@"请输入内容..."]) {
                [self showStringMsg:@"请填写内容!" andYOffset:kYOffset];
            } else [self sendRequest:_btnTag];
        }
            break;
        case 101: // 修改昵称
            [_nickNameTextField resignFirstResponder];
            if ([_nickNameTextField.text isEqual:@""]) {
                [self showStringMsg:@"请输入昵称" andYOffset:kYOffset];
            } else if (![GCUtil convertToBool:_nickNameTextField.text andLength:12]) {
                [self showStringMsg:@"昵称仅支持1-12个字母或1-6个汉字" andYOffset:kYOffset];
            } else [self sendRequest:_btnTag];
            break;
        case 102: // 修改邮箱
            [_emailTextField resignFirstResponder];
            if ([_emailTextField.text isEqual:@""] || _emailTextField.text == nil) {
                [self showStringMsg:@"还没有填写邮箱啊亲~" andYOffset:kYOffset];
            } else if (_emailTextField.text.length <= 6 || _emailTextField.text.length > 30) {
                [self showStringMsg:@"邮箱仅支持输入6~30位中、英文字符" andYOffset:kYOffset];
            }else if (![GCUtil isValidateEmail:_emailTextField.text]) {
                [self showStringMsg:@"邮箱格式不正确!" andYOffset:kYOffset];
            } else [self sendRequest:_btnTag];
            break;
        case 103: // 修改性别
            NSLog(@"sext = %@", sexStr);
            if (_maleImageView.hidden && _femaleImageView.hidden) {
                [self showStringMsg:@"亲，你的性别是?" andYOffset:kYOffset];
            } else [self sendRequest:_btnTag];
            break;
        case 106: // 修改密码
            [_freshPasswordTextField resignFirstResponder];
            [_oldPasswordTextField resignFirstResponder];
            [_secondPasswordTextField resignFirstResponder];
            if ([_freshPasswordTextField.text isEqual:@""] || [_secondPasswordTextField.text isEqual:@""]) {
                [self showStringMsg:@"请输入密码" andYOffset:kYOffset];
            } else if (![_secondPasswordTextField.text isEqual:_freshPasswordTextField.text]) {
                [self showStringMsg:@"密码两次输入不一致" andYOffset:kYOffset];
            } else if (![GCUtil isEvaluateWithObject:_freshPasswordTextField.text]) {
                [self showStringMsg:@"密码仅支持6~18位字母或数字!" andYOffset:kYOffset];
            } else [self sendRequest:_btnTag];
            break;
        default:
            break;
    }
}

- (void) sendRequest:(NSInteger)requestTag
{
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:kYOffset];
        [self hide];
    } else {
        switch (requestTag) {
            case 100: // 修改个性签名
                if ([_signatureTextView.text isEqual:kkUserRemark]) { // 没有改变
                    [self dismiss];
                } else {
                    if (_signatureTextView.text.length <= 100) {
                        [self showMsg:nil];
                        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI changeSignatureUserId:kkUserId andSignature:_signatureTextView.text]];
                    } else [self showStringMsg:@"个性签名字数最多为100" andYOffset:kYOffset];
                };
                break;
            case 101: // 修改昵称
                if ([_nickNameTextField.text isEqual:kkUserNickName]) { // 没有改变
                    [self dismiss];
                } else {
                    [self showMsg:nil];
                    [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI changeNicknameUserId:kkUserId andNike_name:_nickNameTextField.text]];
                }
                break;
            case 102: // 修改邮箱
                if ([_emailTextField.text isEqual:kkUseremial]) { // 没有改变
                    [self dismiss];
                } else {
                    [self showMsg:nil];
                    [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI changEmailUserId:kkUserId andEmail:_emailTextField.text]];
                }
                break;
            case 103: // 修改性别
                if (!_maleImageView.hidden) {
                    sexStr = @"1";
                } else if (!_femaleImageView.hidden) {
                    sexStr = @"2";
                }
                if ([sexStr isEqual:kkUserSex]) { // 没有改变
                    [self dismiss];
                } else {
                    [self showMsg:nil];
                    [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI changeSexUserId:kkUserId andSex:sexStr]];
                }
                break;
            case 106: // 修改密码
                [self showMsg:nil];
                [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI changePassworduserId:kkUserId andOld_password:_oldPasswordTextField.text andNew_password:_freshPasswordTextField.text]];
                break;
            default:
                break;
        }
        mainRequest.tag = requestTag;
    }
}

#pragma mark GCRequestDelegate
- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    NSLog(@"editperson = %@", aString);
    [self hide];
    NSMutableDictionary *dict = [aString JSONValue];
    if ( !dict ) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
        return;
    }
    [self showStringMsg:[dict valueForKey:@"message"] andYOffset:kYOffset];
    
    if ([[dict objectForKey:@"code"] isEqual:@"0"]) { // 修改成功
        [self performSelector:@selector(changeSuccess:) withObject:dict afterDelay:1.5];
    }
}

- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self hide];
    NSLog(@"error = %@", aError);
    [self showStringMsg:@"网络连接失败！" andYOffset:kYOffset];
}


#pragma mark 没有改变
- (void)dismiss
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 修改成功
- (void)changeSuccess:(NSDictionary*)dict
{
//    switch (_btnTag) {
//        case 100: // 修改个性签名
//            break;
//        case 101: // 修改昵称
//            [_editDelegate messageChangedContent:_nickNameTextField.text andTag:_btnTag];
//            break;
//        case 102: // 修改邮箱
//            [_editDelegate messageChangedContent:_emailTextField.text andTag:_btnTag];
//            break;
//        case 103: // 修改性别
//            [_editDelegate messageChangedContent:sexStr andTag:_btnTag];
//            break;
//        default:
//            break;
//    }
    
    if (106 == _btnTag) { // 密码修改成功跳转登录界面
        [kkUserInfo clearInfo];
        [BSaveMessage clear];
        LoginViewController *login = [[LoginViewController alloc] init];
        login.viewControllerIndex = 5;
        [self.navigationController pushViewController:login animated:YES];
        [self removeFromParentViewController];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
        // 设置单利 保存数据 模型 NSUserDefaults
        [kkUserInfo resetInfo:dict];
        [BSaveMessage saveUserMessage:dict];
        [GCUtil saveLajiaobijifenWithJifen:[dict objectForKey:@"jifen"]];
        [_editDelegate messageChanged:_btnTag];
    }
}

#pragma mark - textDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqual:@""]) {
        textView.text = @"请输入内容...";
        textView.textColor = RGBACOLOR(148, 152, 163, 1);
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSUInteger length = self.signatureTextView.text.length;
    if (length > 99) {
        //        self.signatureTextView.text = [textView.text substringToIndex:100];
        [_signatureCountLabel setText:[NSString stringWithFormat:@"%d/100",100]];
        _signatureCountLabel.textColor = [UIColor redColor];
    } else {
        _signatureCountLabel.textColor = RGBACOLOR(104, 104, 104, 1);
        [_signatureCountLabel setText:[NSString stringWithFormat:@"%lu/100",(unsigned long)length]];
    }
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqual:@"请输入内容..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    return YES;
}

#pragma mark - 点击空白处键盘消失
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
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

#pragma mark 修改性别
- (IBAction)changeSexAction:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    switch (btn.tag) {
        case 101: // 男
            if (!_femaleImageView.hidden) {
                _femaleImageView.hidden = !_femaleImageView.hidden;
            }
            _maleImageView.hidden = !_maleImageView.hidden;
            sexStr = @"1";
            break;
        case 102: // 女
            if (!_maleImageView.hidden) {
                _maleImageView.hidden = !_maleImageView.hidden;
            }
            _femaleImageView.hidden = !_femaleImageView.hidden;
            sexStr = @"2";
            break;
        default:
            break;
    }
}
@end
