//
//  CJFeedbackViewController.m
//  MarketManage
//
//  Created by 赵春景 on 15-7-28.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CJFeedbackViewController.h"
#import "GCRequest.h"
#import "MarketAPI.h"

@interface CJFeedbackViewController ()<UITextFieldDelegate, ASIHTTPRequestDelegate>

{
    /** 占位字符文字 */
    UILabel *_placeHolderLabel;
    /** 记录联系方式到达30位字符 */
    NSString *_textFieldStr;
    /** 选中的类型按钮 */
    UIButton *_selectBtn;
    /** 临时记录选中类型的按钮 */
    UIButton *_tempBtn;
    
}

/** 网络请求 */
@property (nonatomic, strong) ASIFormDataRequest *request;
/** 反馈类型 */
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
/** 弹出页的选择按钮 */
@property (weak, nonatomic) IBOutlet UIView *btnView;
/** 弹出页的view是否隐藏 */
@property (weak, nonatomic) IBOutlet UIView *bigBtnView;
/** 功能意见按钮 */
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;

/** 按钮的点击事件 */
- (IBAction)btnClick:(UIButton *)sender;


@end

@implementation CJFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.iphoneTextfield.delegate = self;
    
    self.btnView.layer.masksToBounds = YES;
    self.btnView.layer.cornerRadius = 3;
    self.bigBtnView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    _selectBtn = self.firstBtn;
    CGRect frame = self.bigBtnView.frame;
    frame.size.height = SCREENHEIGHT;
    frame.size.width = SCREENWIDTH;
    self.bigBtnView.frame = frame;
    [[[UIApplication sharedApplication].delegate window] addSubview:self.bigBtnView];
    
    /**
     * 添加导航栏标题 和右侧提交按钮
     */
    [self makeNavgationBar];
    
    /**
     * 添加占位字符
     */
    [self makeLabel];
    
    //监听键盘即将出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:nil];
    
}
/**
 * 添加导航栏标题 和右侧提交按钮
 */
- (void)makeNavgationBar
{
    self.mallTitleLabel.text = @"意见反馈";
    self.mallTitleLabel.font = [UIFont systemFontOfSize:20];
    [self.rightButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    //    self.rightButton.enabled = NO;
    //判断两个文本框的状态  全部有文字 提交按钮激活
    //    if ((self.iphoneTextfield.text.length > 0) && (self.feedbackTextView.text.length > 0)) {
    //        self.rightButton.enabled = YES;
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    }
}

/**
 * 添加占位字符
 */
- (void)makeLabel
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    if (SCREENWIDTH == 320) {
        _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, (_feedbackTextView.size.width ) * SP_WIDTH, 45)];
    } else {
        _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, -8, (_feedbackTextView.size.width ) * SP_WIDTH, 45)];
    }
    
    _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _placeHolderLabel.font = [UIFont systemFontOfSize:12];
    _placeHolderLabel.textColor = [UIColor colorWithRed:190 / 255.0 green:190 / 255.0 blue:190 / 255.0 alpha:1];
    _placeHolderLabel.contentMode = UIViewContentModeScaleToFill;
    _placeHolderLabel.contentMode = UIViewContentModeScaleAspectFit;
    _placeHolderLabel.backgroundColor = [UIColor clearColor];
    _placeHolderLabel.alpha = 0;
    _placeHolderLabel.tag = 999;
    _placeHolderLabel.numberOfLines = 0;
    _placeHolderLabel.text = @"遇到什么系统问题啦？或有什么功能建议吗？欢迎您提给我们～";
    [_feedbackTextView addSubview:_placeHolderLabel];
    
    if ([[_feedbackTextView text] length] == 0) {
        [[_feedbackTextView viewWithTag:999] setAlpha:1];
    }
}
/** textView 改变的监听事件 */
- (void)textChanged:(NSNotification *)notification
{
    if ([[_feedbackTextView text] length] == 0) {
        [[_feedbackTextView viewWithTag:999] setAlpha:1];
    } else {
        [[_feedbackTextView viewWithTag:999] setAlpha:0];
        
    }
}

#pragma mark - 点击事件  网络请求

//键盘收起
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


/** 联系方式 文字的监听事件 超出30个字符 提示错误 */
- (void)textFieldTextDidChange
{
    //判断字符串的长度
    if (self.iphoneTextfield.text.length == 30) {
        _textFieldStr = self.iphoneTextfield.text;
    } else if (self.iphoneTextfield.text.length > 30) {
        [self showMsg:@"请输入正确的联系方式"];
        self.iphoneTextfield.text = _textFieldStr;
    }
    
    //    //判断两个文本框的状态  全部有文字 提交按钮激活
    //    if ((self.iphoneTextfield.text.length > 0) && (self.feedbackTextView.text.length > 0)) {
    //        self.rightButton.enabled = YES;
    //        [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    } else {
    //        self.rightButton.enabled = NO;
    //        [self.rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //    }
}
/** 右侧按钮的点击事件 加网络请求 */
- (void)rightBackCliked:(UIButton *)sender
{
    //判断两个文本框的状态  全部有文字 提交按钮激活
    if ((self.iphoneTextfield.text.length > 0) && (self.feedbackTextView.text.length > 0)) {
        [self.view endEditing:YES];
        [self startActivity];
        _request.delegate = self;
        NSString *type = [NSString stringWithFormat:@"%ld",(long)_selectBtn.tag];
        _request = [MarketAPI requestFeedback1001WithController:self information:self.iphoneTextfield.text message:self.feedbackTextView.text type:type];
    } else if (self.feedbackTextView.text.length == 0){
        [self showMsg:@"还没输入反馈内容呢..."];
        return;
    } else if(self.iphoneTextfield.text.length == 0){
        [self showMsg:@"小伙伴\n给我个你的联系方式吧"];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self stopActivity];
    NSString *tEndString=[[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    tEndString = [tEndString stringByReplacingOccurrencesOfString:@"\n" withString:@"\n"];
    NSDictionary * dict = [tEndString JSONValue];
    NSLog(@"LSYGoodsInfoView::%@",dict);
    if (!dict){
        NSLog(@"接口错误");
        return;
    }
    if ([dict[@"message"] isEqualToString:@"成功"]) {
        [self showMsg:@"提交成功！"];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self showMsg:dict[@"message"]];
    }
    
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self stopActivity];
    [self showMsg:@"提交网络请求失败"];
}

/**
 * 意见反馈 反馈类型的点击事件
 */
- (IBAction)typeBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    _tempBtn.selected = NO;
    _selectBtn.selected = YES;
    _tempBtn = _selectBtn;
    self.bigBtnView.hidden = NO;
}

/**
 * 弹出界面的点击事件
 */
- (IBAction)btnClick:(UIButton *)sender {
    
    if (sender.tag >= 100) {
        self.bigBtnView.hidden = YES;
        if (sender.tag == 101) {
            if (_tempBtn.currentTitle.length) {
                _selectBtn = _tempBtn;
            }
            self.typeLabel.text = _selectBtn.currentTitle;
        }
    } else if (sender.tag > 0 && sender.tag <= 4) {
        _tempBtn.currentTitle.length == 0 ? (_selectBtn.selected = NO) : (_tempBtn.selected = NO);
        sender.selected = YES;
        _tempBtn = sender;
    }
}
@end
