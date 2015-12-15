//
//  CJPayJudgeView.m
//  Wallet
//
//  Created by zhaochunjing on 15-11-11.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "CJPayJudgeView.h"
#import "GDHInputPassWordView.h"
#import "GDHTitleView.h"
#import "Wallet_BaseViewController.h"
#import "GDHSetPassWordViewController.h"
#import "CJNotSufficientFundsView.h"
#import "GDHMyWalletModel.h"
#import "SecurityUtil.h"

#define X  (ScreenWidth - 270)/2

static CJPayJudgeView *payJudgeView = nil;
static Wallet_BaseViewController *selfController = nil;
/** 密码提示的次数  */
static int number = 5;


@interface CJPayJudgeView ()<CJNotSufficientFundsViewDelegate>
{
    /** 记录支付方式的之前按钮 */
    UIButton *_oldBtn;
    /** 选中状态时的位置 */
    NSIndexPath *_selecteIndexPath;
    /** 记录上一次的出现.的字符串 */
    NSString *_oldTextFieldText;
    
    
    UIButton *btn;
}

/** 请输入密码视图 */
@property(nonatomic,strong)GDHInputPassWordView *InputPassWordView;
/**  请输入密码 蒙版按钮 */
@property(nonatomic,strong)UIButton *inputButton;

/** 是否取消支付 */
@property(nonatomic,strong)GDHTitleView *CancelTitleView;
/** 是否取消支付 */
@property(nonatomic,strong)UIButton  *ifCancelPayButton;
/** 请输入支付密码 */
@property(nonatomic,strong)UILabel  *payPassWordLabel;

/** 请求 验证支付密码后的次数 */
@property (nonatomic, copy) NSString *num;
/** 用来接收 moneyText 或者 moneyTextField 的值 */
@property (nonatomic, copy) NSString *tempStr;
/** 余额 首页传入  本业提现完成请求 的数据 */
@property (nonatomic, copy) NSString *balance;

/** 支付方式的View */
@property (nonatomic, strong) CJNotSufficientFundsView *notView;


/** 弹出页（蒙板） */
@property (weak, nonatomic) IBOutlet UIView *jumpView;
/** 提示框 超出额度的提示框 */
@property (weak, nonatomic) IBOutlet UIView *reminderView;
/** 提示框的文字提示 */
@property (weak, nonatomic) IBOutlet UILabel *reminderLabel;
/** 提示框确定按钮的文字 */
@property (weak, nonatomic) IBOutlet UIButton *reminderBtn;

/** 提示框的确定按钮的点击事件 */
- (IBAction)reminderBtnClick:(UIButton *)sender;

@end

@implementation CJPayJudgeView

+ (CJPayJudgeView *)shareCJPayJudgeViewWithController:(GCViewController *)controller
{
    selfController = controller;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        payJudgeView = [[[NSBundle mainBundle] loadNibNamed:@"CJPayJudgeView" owner:payJudgeView options:nil] lastObject];
//        CGRect frame = payJudgeView.frame;
//        frame.size.height = ScreenHeight - 64;
//        frame.origin.y = 64;
//        payJudgeView.frame = frame;
        [payJudgeView addSubview:payJudgeView.ifCancelPayButton];
        [payJudgeView addSubview:payJudgeView.inputButton];
        
        [payJudgeView makeTitle];
        // 初始化界面
        [payJudgeView makeInitView];
    });
     [[NSNotificationCenter defaultCenter] addObserver:payJudgeView selector:@selector(zhiFuBaoHuiDiao:) name:@"judgePayStatu" object:nil];
    return payJudgeView;
}

-(void)zhiFuBaoHuiDiao:(id)sender{
    NSNotification * notif = (NSNotification *)sender;
    NSArray *arrrray = (NSArray *)notif.object;
    NSLog(@"arrrray:%@",arrrray);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

/** 初始化界面 */
- (void)makeInitView
{
    
    payJudgeView.jumpView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    //设置提示框的圆角
    payJudgeView.reminderView.layer.masksToBounds = YES;
    payJudgeView.reminderView.layer.cornerRadius = 3;
    
    //余额不足弹出框
    self.notView = [[CJNotSufficientFundsView alloc] initWithFrame:payJudgeView.frame];
    self.notView.delegate = payJudgeView;
    self.notView.blookBtnClick = ^(UIButton *balanceTypeBtn){
        DHLog(@" %ld",(long)balanceTypeBtn.tag);
        NSLog(@"%@",balanceTypeBtn.titleLabel.text);
        //代理回调
        if ([payJudgeView.delegate respondsToSelector:@selector(topUpJudgeViewSucceedFinishWithTopUpType:)]) {
            [payJudgeView.delegate topUpJudgeViewSucceedFinishWithTopUpType:balanceTypeBtn.titleLabel.text];
        }
    };
    [payJudgeView addSubview:payJudgeView.notView];
    [payJudgeView request1001AccountBalance];
}

#pragma mark -支付类型页面的代理方法实现
- (void)notSufficientFundsViewHiddenEvent
{
    [payJudgeView hiddenReminderView];
}

#pragma mark - 弹出界面
/** 隐藏提示框 */
- (void)hiddenReminderView
{
    [UIView animateWithDuration:0.5 animations:^{
        payJudgeView.reminderView.hidden = YES;
        payJudgeView.jumpView.hidden = YES;
        payJudgeView.hidden = YES;
        [selfController.view endEditing:YES];
        [selfController chrysanthemumClosed];
    }];
}
/** 显示提示框 0表示超出最高提现金额 1表示超出余额 2表示不允许输入密码的提示 */
- (void)showReminderViewType:(int)type
{
    payJudgeView.reminderBtn.titleLabel.text = @"确定";
    if (!type) {
        payJudgeView.reminderLabel.text = [NSString stringWithFormat:@"单笔提现金额限%d，请重新输入金额",MaxMoney];
    } else if (type == 1) {
        payJudgeView.reminderLabel.text = @"输入的金额已超出余额数";
    } else if (type == 2) {
        payJudgeView.reminderLabel.text = @"您今日密码输入次数超限，密码被锁定，请于24小时后再尝试。";
        payJudgeView.reminderBtn.titleLabel.text = @"返回";
        payJudgeView.inputButton.hidden = YES;
        if (_moneyTextField) {
            payJudgeView.moneyTextField.text = @"";
        }
    }
    [UIView animateWithDuration:0.5 animations:^{
        payJudgeView.reminderView.hidden = NO;
        payJudgeView.jumpView.hidden = NO;
    }];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [payJudgeView endEditing:YES];
}

#pragma mark - TextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    payJudgeView.tempStr = [NSString stringWithFormat:@"%@%@",textField.text,string];
    [payJudgeView infoAction];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (payJudgeView.moneyTextField.text.length) {
        NSMutableString *str = [NSMutableString stringWithString:payJudgeView.moneyTextField.text];
        payJudgeView.tempStr = [str stringByReplacingOccurrencesOfString:@"元" withString:@""];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([payJudgeView.moneyTextField.text isEqualToString:@""]) {
        return;
    }
    if ([payJudgeView.moneyTextField.text floatValue] <= 0) {
        payJudgeView.moneyTextField.text = @"";
        [selfController showMsg:@"提现最低为0.01元"];
        return;
    }
    
    //判断是否超出最高限额
    if ([payJudgeView.moneyTextField.text floatValue] > MaxMoney) {
        [payJudgeView showReminderViewType:0];
        return;
    } else if ([payJudgeView.moneyTextField.text floatValue] == [payJudgeView.balance floatValue]) {//判断是否超出余额
        [payJudgeView showReminderViewType:1];
    }
    if (payJudgeView.moneyTextField.text.length) {//后面添加 元
    }
}

- (void)setMoneyText:(NSString *)moneyText
{
        _moneyText = moneyText;
}

/** textField的监听事件 */
- (void)infoAction
{
    if (payJudgeView.tempStr.length == 2 && ![[payJudgeView.tempStr substringFromIndex:1] isEqualToString:@"."] && [payJudgeView.tempStr intValue] < 10) {
        payJudgeView.moneyTextField.text = @"";
        [selfController showMsg:@"请输入正确的金额"];
        [payJudgeView hiddenReminderView];
        return;
    }
    NSArray *array = [payJudgeView.tempStr componentsSeparatedByString:@"."];
    if (array.count == 2) {
        NSString *textStr = array[1];
        if (textStr.length > 2) {
            payJudgeView.tempStr = _oldTextFieldText;
            //            [self showMsg:@"最小金额为分"];
        }
        _oldTextFieldText = payJudgeView.tempStr;
    } else if (array.count == 3) {
        payJudgeView.moneyTextField.text = _oldTextFieldText;
        [selfController showMsg:@"请输入正确的金额"];
        
        [payJudgeView hiddenReminderView];
        return;
    }
    if ([payJudgeView.tempStr floatValue] > [payJudgeView.balance floatValue]) {
        payJudgeView.moneyTextField.text = @"";
        [selfController showMsg:@"输入的金额已超出余额数"];
        [payJudgeView hiddenReminderView];
        return;
    }
}

- (void)setMoneyTextField:(UITextField *)moneyTextField
{
    _moneyTextField = moneyTextField;
}

/** 金额末尾是否需要添加0 */
- (NSString *)addMoneyZeroWithMoneyText:(NSString *)moneyText
{
    NSArray *array = [moneyText componentsSeparatedByString:@"."];
    NSMutableString *text = [NSMutableString stringWithString:payJudgeView.tempStr];
    if (array.count == 1) {
        [text appendFormat:@".00"];
    } else if (array.count == 2) {
        NSString *textStr = array[1];
        if (textStr.length == 0) {
            [text appendFormat:@"00"];
        } else if (textStr.length == 1) {
            [text appendFormat:@"0"];
        }
    }
    return text;
}



#pragma mark - 按钮的点击事件
/** 按钮的点击事件 逻辑判断入口 */
- (void)toCashBtnClick {
    
    //    self.yuanLabel.hidden = YES;
    if (!_moneyTextField) {
        payJudgeView.tempStr = payJudgeView.moneyText;
    }
    NSString *moneyStr = [payJudgeView.tempStr stringByReplacingOccurrencesOfString:@"元" withString:@""];
    
    if ([moneyStr floatValue] <= 0) {
        [selfController showMsg:@"请输入金额"];
        [payJudgeView hiddenReminderView];
        return;
    }
    moneyStr = [payJudgeView addMoneyZeroWithMoneyText:moneyStr];

    //判断支付 跳转支付宝 钱包等
    if (!_moneyTextField) {
        //判断钱包状态
        if ([payJudgeView.tempStr floatValue] > [payJudgeView.balance floatValue]) {
            [_notView notSufficientFundsViewType:BalanceViewTypeNoBalance];
            [selfController showMsg:@"输入的金额已超出余额数"];
        } else {
            [_notView notSufficientFundsViewType:BalanceViewTypeHaveBalance];
//            [payJudgeView hiddenReminderView];
        }
        [_notView showNotSufficientFundsView];
    } else { //提现的判断
        
        NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
        id hasPass = [userD objectForKey:HasPassWord];
        if (![hasPass isEqual:@"Y"]) {
            btn.hidden = NO;
            return;
        } else {//密码次数判断
            NSDictionary *dict = [WalletRequsetHttp WalletPersonPassWordErrorNum110];
            NSString *url = [NSString stringWithFormat:@"%@%@",WalletHttp_getPassWordErrorNum110,[dict JSONFragment]];
            [selfController chrysanthemumOpen];
            [SINOAFNetWorking postWithBaseURL:url controller:selfController success:^(id json) {
                [selfController chrysanthemumClosed];
                if ([json[@"code"] intValue] == 100) {
                    if ([json[@"errCount"] intValue] >= 5) {
                        [payJudgeView showReminderViewType:2];
                        return ;
                    }else {
                        _inputButton.hidden = NO;
                        [_InputPassWordView theKeyboardShow];
                        _InputPassWordView.payMoney = [NSString stringWithFormat:@"¥%@",payJudgeView.tempStr];
                    }
                }
                
            } failure:^(NSError *error) {
                [payJudgeView hiddenReminderView];
                [selfController showMsg:ShowMessage];
            } noNet:^{
                [payJudgeView hiddenReminderView];
            }];
            
        }
    }
    
}
/** 网络请求数据 putInPassWord 输入的密码  */
- (void)requestDataWithPutInPassWord:(NSString *)putInPassWord encryptKey:(NSString *)encryptKey ID:(NSString *)ID
{
    if ([payJudgeView.delegate respondsToSelector:@selector(payJudgeViewSucceedFinishWithPassWord:encryptKey:ID:)]) {
        [payJudgeView.delegate payJudgeViewSucceedFinishWithPassWord:putInPassWord encryptKey:encryptKey ID:ID];
    }
}
/** 密码验证 的网络请求 */
- (void)passWordVerifyWithPutInPassWord:(NSString *)putInPassWord encryptKey:(NSString *)encryptKey ID:(NSString *)ID
{
    
        NSDictionary *dict = [WalletRequsetHttp WalletPersonVerificationPayPassWord1004VerifyPassword:putInPassWord];
        //加密
        NSData *data = [SecurityUtil encryptAESData:[dict JSONFragment] andPublicPassWord:encryptKey];
        NSString *base64 = [SecurityUtil encodeBase64Data:data];
        
        NSString *url = [NSString stringWithFormat:@"%@%@&&tradeId=%@",WalletHttp_checkPassword1004,[WalletRequsetHttp encodeString:base64],ID];
        
        
        [selfController chrysanthemumOpen];
        [SINOAFNetWorking postWithBaseURL:url controller:selfController success:^(id json) {
            NSLog(@"----- json %@",json);
            if ([json[@"code"] isEqualToString:@"100"]) {
                payJudgeView.payPassWordLabel.hidden = YES;
                payJudgeView.num = [NSString stringWithFormat:@"%@",json[@"num"]];
                //密钥的请求
                [WalletRequsetHttp getKeyVC:selfController andKey:^(NSString *key, NSString *theID) {
                    [payJudgeView requestDataWithPutInPassWord:putInPassWord encryptKey:key ID:theID];
                }];
                [payJudgeView hiddenReminderView];
                return ;
            } else if ([json[@"code"] isEqualToString:@"102"]) {
                payJudgeView.num = [NSString stringWithFormat:@"%@",json[@"num"]];
                [payJudgeView showNumberPassWord];
                if (number - [payJudgeView.num intValue]) {
                    [selfController showMsg:json[@"msg"]];
                }
            } else if ([json[@"code"] isEqualToString:@"101"]) {
                [selfController showMsg:json[@"msg"]];
            }
            [selfController chrysanthemumClosed];
            [_InputPassWordView clearTextPassWordWithOneTextFiledEnabled:YES];
        } failure:^(NSError *error) {
            [payJudgeView hiddenReminderView];
            [selfController showMsg:ShowMessage];
        } noNet:^{
            [payJudgeView hiddenReminderView];
        }];

}


/** 钱包个人中心账户余额1001 接口 */
-(void)request1001AccountBalance{
    [selfController chrysanthemumOpen];
    
    NSDictionary *dict  = [WalletRequsetHttp WalletPersonAccountBalance1001];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",WalletHttp_Balance,[dict JSONFragment]];
    [SINOAFNetWorking postWithBaseURL:url controller:selfController success:^(id json) {
        NSDictionary *dict = json;
        if ([dict[@"code"] isEqualToString:@"100"]) {
            GDHMyWalletModel *walletModel = [[GDHMyWalletModel alloc] initWithDic:dict[@"rs"]];
            NSUserDefaults *userD =[NSUserDefaults standardUserDefaults];
            [userD setObject:walletModel.isHasPass forKey:HasPassWord];
            [userD synchronize];
            payJudgeView.balance = walletModel.balance;
        }else{
            NSLog(@"%@",dict[@"msg"]);
        }
        [payJudgeView hiddenReminderView];
        
    } failure:^(NSError *error) {
        [payJudgeView hiddenReminderView];
        [selfController showMsg:ShowMessage];
    } noNet:^{
        [payJudgeView hiddenReminderView];
    }];
}


/** 密码输入不正确的显示 */
- (void)showNumberPassWord
{
    payJudgeView.payPassWordLabel.hidden = NO;
    int num = number - [payJudgeView.num intValue];
    payJudgeView.payPassWordLabel.text = [NSString stringWithFormat:@"支付密码输入不正确，您还有%d次机会",num];
    if (num) {
        [payJudgeView.InputPassWordView clearTextPassWordWithOneTextFiledEnabled:YES];
        [_InputPassWordView theKeyboardShow];
    } else {
        [payJudgeView.InputPassWordView clearTextPassWordWithOneTextFiledEnabled:NO];
    }
    if (num == 0) {
        [payJudgeView showReminderViewType:2];
    }
}



/** 提示框的确定按钮的点击事件 */
- (IBAction)reminderBtnClick:(UIButton *)sender {
    
    if (_moneyTextField) {
        _moneyTextField.text = @"";
    }
    [payJudgeView hiddenReminderView];
}



#pragma  mark - 设置您的支付密码
-(void)makeTitle{
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64);
    btn.backgroundColor = RGBACOLOR(83, 83, 83, .7);
    btn.hidden = YES;
    GDHTitleView *titleView = [[GDHTitleView alloc] initWithFrame:CGRectMake(X, 110*WalletSP_height, 270, 147) andMessage:@"您还没有设置支付密码，为了保障您的财产安全，请设置支付密码" andleftButtonTitle:@"等一下" andRightButtonTitle:@"去设置"];
    titleView.layer.masksToBounds= YES;
    titleView.layer.cornerRadius = 3;
    titleView.CancelButtonBlock = ^(UIButton *CancelButton){
        btn.hidden = YES;
        [payJudgeView hiddenReminderView];
        /** 等一下 */
    };
    titleView.ReleaseBoundBlock = ^(UIButton *ReleaseBound){
        /** 去设置*/
        GDHSetPassWordViewController *setPassWord = [[GDHSetPassWordViewController alloc] init];
        [selfController.navigationController pushViewController:setPassWord animated:YES];
        btn.hidden = YES;
        [payJudgeView hiddenReminderView];
    };
    [btn addSubview:titleView];
    [btn addTarget:payJudgeView action:@selector(btnDownHidden:) forControlEvents:UIControlEventTouchUpInside];
    [payJudgeView addSubview:btn];
    
}
/**  隐藏 密码设置的蒙版 */
-(void)btnDownHidden:(UIButton *)sender{
    btn.hidden = YES;
    NSLog(@"取消隐藏");
}

#pragma   mark - 请输入按钮视图
-(GDHInputPassWordView *)InputPassWordView{
    if (!_InputPassWordView) {
        _InputPassWordView = [[GDHInputPassWordView alloc] initWithFrame:CGRectMake((ScreenWidth - 270)*0.5, 110, 270, 170) andPayMoney:payJudgeView.tempStr];
        _InputPassWordView.layer.masksToBounds = YES;
        _InputPassWordView.layer.cornerRadius = 2;
        _InputPassWordView.backgroundColor =[UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f];
        __weak CJPayJudgeView *weekSelf = payJudgeView;
        _InputPassWordView.closeBlock =^(UIButton *close){
            weekSelf.ifCancelPayButton.hidden = NO;
            weekSelf.inputButton .hidden=  YES;
            /** 关闭 */
        };
        _InputPassWordView.findBlock = ^(UIButton *findPassWord){
            GDHSetPassWordViewController *setPassWord = [[GDHSetPassWordViewController alloc] init];
            setPassWord.findPassWord = @"找回密码";
            [selfController.navigationController pushViewController:setPassWord animated:YES];
            
            
            /** 找回密码 */
        };
        _InputPassWordView.payPassWordBlock = ^(NSString *payPassWordSting){
            [weekSelf endEditing:YES];
            NSLog(@"payPassWordSting:  %@",payPassWordSting);
            //                [weekSelf requestDataWithPutInPassWord:payPassWordSting];
            //密钥的请求
            [WalletRequsetHttp getKeyVC:selfController andKey:^(NSString *key, NSString *theID) {
                [weekSelf passWordVerifyWithPutInPassWord:payPassWordSting encryptKey:key ID:theID];
            }];
            
            
        };
    }
    return _InputPassWordView;
}

/** 蒙版 */
-(UIButton *)inputButton{
    
    if (!_inputButton) {
        _inputButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _inputButton.frame = CGRectMake(0, 65, ScreenWidth, ScreenHeight -65);
        _inputButton.hidden = YES;
        [_inputButton addTarget:payJudgeView action:@selector(inputButtonDown) forControlEvents:UIControlEventTouchUpInside];
        _inputButton.backgroundColor = payMask;
        [_inputButton addSubview:payJudgeView.payPassWordLabel];
        [_inputButton addSubview:payJudgeView.InputPassWordView];
    }
    return _inputButton;
}
-(UILabel *)payPassWordLabel{
    if (!_payPassWordLabel) {
        _payPassWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 75, ScreenWidth - 80, 20)];
        _payPassWordLabel.font = [UIFont systemFontOfSize:14];
        _payPassWordLabel.textAlignment = NSTextAlignmentCenter;
        _payPassWordLabel.hidden = YES;
        _payPassWordLabel.textColor = [UIColor colorWithRed:1.00f green:0.51f blue:0.04f alpha:1.00f];
    }
    return _payPassWordLabel;
}

#pragma mark - 是否取消支付提示
-(UIButton *)ifCancelPayButton{
    
    if (!_ifCancelPayButton) {
        _ifCancelPayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _ifCancelPayButton.frame = CGRectMake(0, 65, ScreenWidth, ScreenHeight - 64);
        _ifCancelPayButton.backgroundColor = payMask;
        _ifCancelPayButton.hidden = YES;
        [_ifCancelPayButton addTarget:payJudgeView action:@selector(ifCancelPayButtonDown:) forControlEvents:UIControlEventTouchUpInside];
        [_ifCancelPayButton addSubview:payJudgeView.CancelTitleView];
    }
    return _ifCancelPayButton;
}



/** 是否取消支付 */
-(GDHTitleView *)CancelTitleView{
    if (!_CancelTitleView) {
        
        _CancelTitleView = [[GDHTitleView alloc] initWithFrame:CGRectMake(X, 110, 270, 124) andMessage:@"是否取消支付？ " andleftButtonTitle:@"是" andRightButtonTitle:@"否"];
        __weak CJPayJudgeView *weekSelf = payJudgeView;
        _CancelTitleView.CancelButtonBlock = ^(UIButton *CancelButton){
            [weekSelf endEditing:YES];
            weekSelf.ifCancelPayButton.hidden = YES;
            [weekSelf hiddenReminderView];
            [weekSelf.InputPassWordView clearTextPassWordWithOneTextFiledEnabled:YES];
            // 是
            /**  不删除  */
            //            [weekSelf.navigationController popViewControllerAnimated:YES];
            NSLog(@"  取消-------------  支付，");
        };
        _CancelTitleView.ReleaseBoundBlock = ^(UIButton *ReleaseBound){
            // 否
            weekSelf.ifCancelPayButton.hidden = YES;
            weekSelf.inputButton.hidden = NO;
        };
    }
    return _CancelTitleView;
}
/**  取消支付的  蒙版 */
-(void)ifCancelPayButtonDown:(UIButton *)ifCancelPayButtonDown{
    
    //    _ifCancelPayButton.hidden = YES;
}

/**  隐藏 支付（请输入）的蒙版 */
-(void)inputButtonDown{
    
    //    _inputButton.hidden = YES;
}

@end
