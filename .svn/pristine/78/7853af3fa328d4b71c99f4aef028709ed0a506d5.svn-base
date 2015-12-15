//  用户反馈
//  UserFeedbackViewController.m
//  UserFeedback
//
//  Created by pipixia on 14/10/22.
//  Copyright (c) 2014年 pipixia. All rights reserved.
//
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define kYOffset -20
#define MaxNumberOfDescriptionChars 300 // 最大输入字数

#import "UserFeedbackViewController.h"

@interface UserFeedbackViewController () <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *UnderlyingView; // 用于放所有按钮与textview
@property (strong, nonatomic) IBOutlet UITextField *emailTextFiled; // email
@property (strong, nonatomic) IBOutlet UITextView *feedbackTextView; // 反馈意见textView
@property (strong, nonatomic) IBOutlet UILabel *messageNumberLabel; // 显示输入字数的label

@end

@implementation UserFeedbackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"意见反馈"];
    _feedbackTextView.text = @"请输入内容...";
    _feedbackTextView.textColor = RGBACOLOR(167, 167, 167, 1);
    // 添加保存键
    [self addRightBarButtonItemWithImageName:@"" andTargate:@selector(amendButtonActionCliked:) andRightItemFrame:CGRectMake(SCREENWIDTH - 10 - 40, 28, 60, 30) andButtonTitle:@"提交" andTitleColor:kkRColor];
    // 监听textView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:_feedbackTextView];
}

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

#pragma mark 保存
- (void)amendButtonActionCliked:(id)sender
{
    [_emailTextFiled resignFirstResponder];
    [_feedbackTextView resignFirstResponder];
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@", _feedbackTextView.text];
    _feedbackTextView.text = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (_emailTextFiled.text.length <= 0) {
        [self showStringMsg:@"请输入邮箱！" andYOffset:kYOffset];
    } else if (![GCUtil isValidateEmail:_emailTextFiled.text]) {
        [self showStringMsg:@"请输入正确的邮箱格式！" andYOffset:kYOffset];
    } else if (self.feedbackTextView.text.length <= 0 || [self.feedbackTextView.text isEqual:@" "]) {
        [self showStringMsg:@"请填写你要反馈的内容!" andYOffset:kYOffset];
    } else if ([self.feedbackTextView.text isEqual:@"请输入内容..."]) {
        [self showStringMsg:@"请填写你要反馈的内容!" andYOffset:kYOffset];
    } else {
//        [self showStringMsg:@"去做相关操作" andYOffset:-20];
        [self requestData];
    }
}

#pragma mark 数据请求
- (void) requestData
{
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    } else {
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI userFeedbackUserId:kkUserId andUser_mail:_emailTextFiled.text andContent:_feedbackTextView.text]];
        [self showMsg:nil];
    }
}

#pragma mark GCRequestDelegate
- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    NSLog(@"feedback %@", aString);
    [self hide];
    NSMutableDictionary *dict = [aString JSONValue];
    if ( !dict ) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
        return;
    }
    if ([[dict objectForKey:@"code"]isEqual:@"0"]){
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5];
        [self showStringMsg:@"反馈成功" andYOffset:kYOffset];
    } else {
        [self showStringMsg:[dict valueForKey:@"message"] andYOffset:kYOffset];
    }
}

#pragma mark 反馈成功
- (void)dismiss
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self hide];
    NSLog(@"%@", aError);
    [self showStringMsg:@"网络连接失败！" andYOffset:kYOffset];
}

#pragma mark 监听文本改变

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

#pragma mark - textViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqual:@""]) {
        textView.text = @"请输入内容...";
        textView.textColor = RGBACOLOR(167, 167, 167, 1);
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqual:@"请输入内容..."]) {
        textView.text = @"";
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSUInteger length = self.feedbackTextView.text.length;
    if (length >= 300) {
        [_messageNumberLabel setText:[NSString stringWithFormat:@"%d/300", 300]];
        _messageNumberLabel.textColor = [UIColor redColor];
    } else {
        [_messageNumberLabel setText:[NSString stringWithFormat:@"%lu/300", (unsigned long)length]];
        _messageNumberLabel.textColor = [UIColor grayColor];
    }
}

@end
