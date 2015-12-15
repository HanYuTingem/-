//
//  BYC_FindPasswordViewController.m
//  ChillingAmend
//
//  Created by yc on 15/8/17.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import "BYC_FindPasswordViewController.h"
#import "GCUtil.h"

@interface BYC_FindPasswordViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textfile_Email;

@property (weak, nonatomic) IBOutlet UIButton *button_FindPassword;

@end

@implementation BYC_FindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"找回密码"];
    
    _textfile_Email.layer.shadowRadius = 1;
    _textfile_Email.layer.shadowOpacity = 0.2f;
    _textfile_Email.layer.shadowOffset = CGSizeMake(0, 0);
    _textfile_Email.layer.cornerRadius = 5;
    
    _button_FindPassword.layer.shadowRadius = 1;
    _button_FindPassword.layer.shadowOpacity = 0.2f;
    _button_FindPassword.layer.shadowOffset = CGSizeMake(0, 0);
    _button_FindPassword.layer.cornerRadius = 5;

}

- (IBAction)findPasswordAction:(UIButton *)sender {
    
    
    [_textfile_Email resignFirstResponder];
    
    if ([GCUtil isValidateEmail:_textfile_Email.text] == 0) {
        [self showMsg:@"请输入正确的邮箱"];
        return;
    }else if ([GCUtil convertToInt:_textfile_Email.text] < 6||[GCUtil convertToInt:_textfile_Email.text] > 20){
        [self showMsg:@"请输入6-20位数字，英文字母或符号组合"];
        return;
    }else{
        if ([GCUtil connectedToNetwork]) {
            [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI mailFindPasswordType:@"1" andUser_mail:_textfile_Email.text]];
            [self showMsg:nil];
        } else {
            [self showMsg:@"网络连接失败！"];
        }
    }
    
}

- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    
    NSDictionary *dic = [aString JSONValue];
    
    if (dic) {
        
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            
           __block BYC_FindPasswordViewController *this = self;
                [this hide];
                [this showMsgDetailsLabelText:@"密码已发送到您的邮箱，请注意查收!" succeed:^{
                    
                    [this.navigationController popViewControllerAnimated:YES];
                }];
        }else{
            
            [self showStringMsg:[dic objectForKey:@"message"] andYOffset:0];
        }
        
    }else{
        
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    }
}

- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    
    [self hide];
    [self showStringMsg:@"网络连接失败" andYOffset:0];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    if ([GCUtil isValidateEmail:textField.text]) {
        [_button_FindPassword setBackgroundColor:[UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f]];
        _button_FindPassword.userInteractionEnabled = YES;
    }else{
        [_button_FindPassword setBackgroundColor:RGBACOLOR(195, 195, 195, 1)];
        _button_FindPassword.userInteractionEnabled = NO;
    }
    
    return YES;
}
@end
