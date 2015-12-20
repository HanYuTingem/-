//
//  CJCashViewController.m
//  Wallet
//
//  Created by zhaochunjing on 15-10-22.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "CJCashViewController.h"
#import "CJTopUpRecordViewController.h"
#import "CJCashTableViewCell.h"
#import "GDHADDBlankViewController.h"
#import "WalletHome.h"
#import "CJWithdrawDepositInfoViewController.h"
#import "GDHBankModel.h"
#import "GDHInputPassWordView.h"
#import "GDHTitleView.h"
#import "GDHSetPassWordViewController.h"
#import "GDHPassWordModel.h"
#import "SINOUIkeyboardView.h"
#import "SecurityUtil.h"

#define CellH 42
#define X  (ScreenWidth - 270)/2

/** 密码提示的次数  */
static int number = 5;

@interface CJCashViewController () <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

{
    /** 记录支付方式的之前按钮 */
    UIButton *_oldBtn;
    /** 记录点击之前的cell */
    CJCashTableViewCell *_oldCell;
    /** 选中状态时的位置 */
    NSIndexPath *_selecteIndexPath;
    /** 记录上一次的出现.的字符串 */
    NSString *_oldTextFieldText;
    UIButton *btn;
}

/** 输入金额的文本框 */
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
/** 提现类型的label */
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
/** 提现成功的提示框 提现成功后显示 */
@property (weak, nonatomic) IBOutlet UILabel *succeedLabel;
/** 确认提现按钮 */
@property (weak, nonatomic) IBOutlet UIButton *toCashBtn;
/** 支付宝选中图片 */
@property (weak, nonatomic) IBOutlet UIImageView *zhiFuImage;
/** 微信支付选中图片 */
@property (weak, nonatomic) IBOutlet UIImageView *weiXinImage;
/** 借记卡选中图片 */
@property (weak, nonatomic) IBOutlet UIImageView *jieJiImage;
/** 弹出页（蒙板） */
@property (weak, nonatomic) IBOutlet UIView *jumpView;
/** 弹出页的子页（选择银行卡） */
@property (weak, nonatomic) IBOutlet UIView *jumpSubView;
/** 弹出页的子页的高度（选择银行卡） */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *jumpSubViewH;

/** 银行卡显示的tableView */
@property (weak, nonatomic) IBOutlet UITableView *bankCardTableView;
/** tableView的高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bankCardTableViewH;
/** 提示框 超出额度的提示框 */
@property (weak, nonatomic) IBOutlet UIView *reminderView;
/** 提示框的文字提示 */
@property (weak, nonatomic) IBOutlet UILabel *reminderLabel;
/** 提示框确定按钮的文字 */
@property (weak, nonatomic) IBOutlet UIButton *reminderBtn;
/** 末尾元字后缀 */
@property (weak, nonatomic) IBOutlet UILabel *yuanLabel;

/** 数据源数组（银行卡信息） */
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 网络请求 */
@property (nonatomic, strong) AFHTTPRequestOperation *operation;
/** 请求 验证支付密码后的次数 */
@property (nonatomic, copy) NSString *num;


/** 选择支付类型的点击事件 */
- (IBAction)paytypeClick:(UIButton *)sender;
/** 确认提现按钮的点击事件 */
- (IBAction)toCashBtnClick:(UIButton *)sender;
/** 选择银行卡的点击状态事件 */
- (IBAction)zhiFuTypeClick:(UIButton *)sender;
/** 提示框的确定按钮的点击事件 */
- (IBAction)reminderBtnClick:(UIButton *)sender;





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


@end

@implementation CJCashViewController

static NSString *ID = @"cashCell";

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.ifCancelPayButton];
    [self.view addSubview:self.inputButton];
    [self makeTitle];
    // 初始化界面
    [self makeInitView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(theblankAddSuccess) name:@"theBlankAddSuccess" object:nil];
}
/** 银行卡添加成功 */
-(void)theblankAddSuccess{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showMsg:@"添加成功！"];
    });
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    [SINOAFNetWorking cancelAllRequest];
}

/** 1112. 获取用户银行卡列表 */
-(void)requestWalletPersonUserBankCardList1112{
    [self chrysanthemumOpen];
    NSDictionary *dict = [WalletRequsetHttp WalletPersonUserBankCardList1112];
    NSString *url = [NSString stringWithFormat:@"%@%@", WalletHttp_BankCardList1112,[dict JSONFragment]];
    [SINOAFNetWorking postWithBaseURL:url controller:self success:^(id json) {
        NSLog(@"%@",json);
        [self.dataArray removeAllObjects];
        
        NSDictionary *dict  = json;
        if ([dict[@"code"] isEqualToString:@"100"]) {
            NSArray *myBankArray = dict[@"rs"];
            for (NSDictionary *dic in myBankArray) {
                GDHBankModel *model = [[GDHBankModel alloc] initWithDic:dic];
                [self.dataArray addObject:model];
            }
            if (!myBankArray.count) {
//                [self showMsg:ShowNoMessage];
            }
        }
        [self chrysanthemumClosed];
        [self makeTableView];
        [self.bankCardTableView reloadData];
    } failure:^(NSError *error) {
        [self showMsg:ShowMessage];
        [self chrysanthemumClosed];
    } noNet:^{
        [self chrysanthemumClosed];
    }];
    
    
}



/** 创建银行卡tableView */
- (void)makeTableView
{
    NSInteger num = self.dataArray.count;
//    NSInteger num = 3;
    if (num > 5) {
        self.bankCardTableViewH.constant = 5 * CellH;
        self.jumpSubViewH.constant = self.bankCardTableViewH.constant + 80;
    } else {
        self.bankCardTableViewH.constant = num * CellH;
        self.jumpSubViewH.constant = self.bankCardTableViewH.constant + 80;
    }
}

/** 初始化界面 */
- (void)makeInitView
{
    self.backView.backgroundColor = WalletHomeNAVGRD;
    self.mallTitleLabel.text = @"提现";
    self.mallTitleLabel.textColor = WalletHomeNAVTitleColor;
    self.mallTitleLabel.font = WalletHomeNAVTitleFont;
    [self.leftBackButton setImage:[UIImage imageNamed:@"title_btn_back02"] forState:UIControlStateNormal];
    [self.rightButton setTitle:@"提现记录" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:WalletHomeNAVTitleColor forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = WalletHomeNAVRigthFont;
    CGRect frame = self.rightButton.frame;
    frame.size.width += 20;
    frame.origin.x -= 20;
    self.rightButton.frame = frame;
    mainView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
    CGRect frameJump = self.jumpSubView.frame;
    frameJump.origin.y = ScreenHeight;
    self.jumpSubView.frame = frameJump;
    
    self.toCashBtn.layer.cornerRadius = 5;
    self.toCashBtn.layer.masksToBounds = YES;
    self.succeedLabel.hidden = YES;
    self.jumpView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    self.moneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.moneyTextField.placeholder = [NSString stringWithFormat:@"最多提出¥%@",self.balance];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoAction)name:UITextFieldTextDidChangeNotification object:nil];
    
    //CJCashViewController
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CJCashViewController) name:@"CJCashViewController" object:nil];

    //设置提示框的圆角
    self.reminderView.layer.masksToBounds = YES;
    self.reminderView.layer.cornerRadius = 3;
    
    
    self.bankCardTableViewH.constant = 0;
    self.jumpSubViewH.constant = self.bankCardTableViewH.constant + 80;
    self.bankCardTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/** textField的监听事件 */
- (void)infoAction
{
    if (self.moneyTextField.text.length == 2 && ![[self.moneyTextField.text substringFromIndex:1] isEqualToString:@"."] && [self.moneyTextField.text intValue] < 10) {
        self.moneyTextField.text = @"";
        [self showMsg:@"请输入正确的金额"];
        return;
    }
    NSArray *array = [self.moneyTextField.text componentsSeparatedByString:@"."];
    if (array.count == 2) {
        NSString *textStr = array[1];
        if (textStr.length > 2) {
            self.moneyTextField.text = _oldTextFieldText;
//            [self showMsg:@"最小金额为分"];
        }
        _oldTextFieldText = self.moneyTextField.text;
    } else if (array.count == 3) {
        self.moneyTextField.text = _oldTextFieldText;
        [self showMsg:@"请输入正确的金额"];
    }
    if ([self.moneyTextField.text floatValue] > [self.balance floatValue]) {
        self.moneyTextField.text = @"";
        [self showMsg:@"输入的金额已超出余额数"];
    }
}
/** 右侧按钮的点击事件 */
- (void)rightBackCliked
{
    //提现记录界面
    CJTopUpRecordViewController *recordVC = [[CJTopUpRecordViewController alloc] init];
    recordVC.recordType = @"1";
    [self.navigationController pushViewController:recordVC animated:YES];
}



#pragma mark - 弹出界面
/** 隐藏提示框 */
- (void)hiddenReminderView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.reminderView.hidden = YES;
        self.jumpView.hidden = YES;
    }];
}
/** 显示提示框 0表示超出最高提现金额 1表示超出余额 2表示不允许输入密码的提示 */
- (void)showReminderViewType:(int)type
{
    
    CGRect frame = self.jumpSubView.frame;
    frame.origin.y = ScreenHeight ;
    self.jumpSubView.frame = frame;
    self.reminderBtn.titleLabel.text = @"确定";
    if (!type) {
        self.reminderLabel.text = [NSString stringWithFormat:@"单笔提现金额限%d，请重新输入金额",MaxMoney];
    } else if (type == 1) {
        self.reminderLabel.text = @"输入的金额已超出余额数";
    } else if (type == 2) {
        self.reminderLabel.text = @"您今日密码输入次数超限，密码被锁定，请于24小时后再尝试。";
        self.reminderBtn.titleLabel.text = @"返回";
        self.inputButton.hidden = YES;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.reminderView.hidden = NO;
        self.jumpView.hidden = NO;
    }];
}

/** 隐藏弹出界面 */
- (void)hiddenJumpView
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.jumpSubView.frame;
        frame.origin.y = ScreenHeight ;
        self.jumpSubView.frame = frame;
    } completion:^(BOOL finished) {
        self.jumpView.hidden = YES;
    }] ;
}

/** 显示弹出界面 */
- (void)showJumpView
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.jumpSubView.frame;
//        frame.origin.y = ScreenHeight - 80 - self.dataArray.count * CellH;
        frame.origin.y = ScreenHeight - 80 - self.bankCardTableViewH.constant;
        self.jumpSubView.frame = frame;
        self.jumpView.hidden = NO;
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
        if ((self.jumpSubView.frame.origin.y < ScreenHeight) && (self.moneyTextField.text)) {
            [self hiddenJumpView];
        }
}

#pragma mark - TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.moneyTextField.text.length) {
        NSMutableString *str = [NSMutableString stringWithString:self.moneyTextField.text];
        self.moneyTextField.text = [str stringByReplacingOccurrencesOfString:@"元" withString:@""];
//        self.yuanLabel.hidden = YES;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.moneyTextField.text isEqualToString:@""]) {
        return;
    }
    if ([self.moneyTextField.text floatValue] <= 0) {
        self.moneyTextField.text = @"";
        [self showMsg:@"提现最低为0.01元"];
        return;
    }
    
    //判断是否超出最高限额
    if ([self.moneyTextField.text floatValue] > MaxMoney) {
        [self showReminderViewType:0];
        return;
    } else if ([self.moneyTextField.text floatValue] > [self.balance floatValue]) {//判断是否超出余额
        [self showReminderViewType:1];
    }
    if (self.moneyTextField.text.length) {
//        NSMutableString *str =[NSMutableString stringWithString:self.moneyTextField.text];
//        self.moneyTextField.text = [str stringByAppendingString:@"元"];
//        self.yuanLabel.hidden = NO;
    }
}
/** 金额末尾是否需要添加0 */
- (NSString *)addMoneyZeroWithMoneyText:(NSString *)moneyText
{
    NSArray *array = [moneyText componentsSeparatedByString:@"."];
    NSMutableString *text = [NSMutableString stringWithString:self.moneyTextField.text];
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

#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
//    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellH;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.bankCardTableView registerNib:[UINib nibWithNibName:@"CJCashTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
    CJCashTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.tag = indexPath.row;
    if (_selecteIndexPath == indexPath) {
        cell.selecteImageView.hidden = NO;
    } else {
        cell.selecteImageView.hidden = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.bankModel = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selecteIndexPath = indexPath;
    CJCashTableViewCell * cell = (CJCashTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (_oldCell !=cell) {
        _oldCell.selecteImageView.hidden = YES;
        cell.selecteImageView.hidden = NO;
        _oldCell = cell;
        self.payLabel.text = cell.bankCardNameLabel.text;
        [self hiddenJumpView];
    }
}

#pragma mark - 按钮的点击事件
/** 选择支付类型的点击事件 */
- (IBAction)paytypeClick:(UIButton *)sender {
    [self.view endEditing:YES];
    
    /** 网络请求数据 */
    [self requestWalletPersonUserBankCardList1112];
    //展示弹出页
    [self showJumpView];
    //判断类型
    
}

/** 确认提现按钮的点击事件 */
- (IBAction)toCashBtnClick:(UIButton *)sender {

//    self.yuanLabel.hidden = YES;
    NSString *moneyStr = [self.moneyTextField.text stringByReplacingOccurrencesOfString:@"元" withString:@""];
    moneyStr = [self addMoneyZeroWithMoneyText:moneyStr];
    
    if ([moneyStr floatValue] <= 0) {
        [self showMsg:@"请输入金额"];
        return;
    } else if ([self.payLabel.text isEqualToString:@"请选择银行卡"]) {
        [self showMsg:@"请选择提现的银行卡"];
        return;
    }
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    id hasPass = [userD objectForKey:HasPassWord];
    if (![hasPass isEqual:@"Y"]) {
        btn.hidden = NO;
        return;
    } else {
        NSDictionary *dict = [WalletRequsetHttp WalletPersonPassWordErrorNum110];
        NSString *url = [NSString stringWithFormat:@"%@%@",WalletHttp_getPassWordErrorNum110,[dict JSONFragment]];
        [self chrysanthemumOpen];
        [SINOAFNetWorking postWithBaseURL:url controller:self success:^(id json) {
            [self chrysanthemumClosed];
            NSLog(@"--== -- %@",json);
            
            if ([json[@"code"] intValue] == 100) {
                if ([json[@"errCount"] intValue] >= 5) {
                    [self showReminderViewType:2];
                    return ;
                    
                }else {
                    _inputButton.hidden = NO;
                    [_InputPassWordView theKeyboardShow];
                    _InputPassWordView.payMoney = [NSString stringWithFormat:@"¥%@",self.moneyTextField.text];                }
            }
            
            
            
        } failure:^(NSError *error) {
            [self chrysanthemumClosed];
            [self showMsg:ShowMessage];
        } noNet:^{
            [self chrysanthemumClosed];
        }];
        
    }
}
/** 网络请求数据 putInPassWord 输入的密码 */
- (void)requestDataWithPutInPassWord:(NSString *)putInPassWord encryptKey:(NSString *)encryptKey ID:(NSString *)ID
{
        NSString *moneyStr = [self.moneyTextField.text stringByReplacingOccurrencesOfString:@"元" withString:@""];
        GDHBankModel *bankModel = self.dataArray[_selecteIndexPath.row];
        NSDictionary *dict = [WalletRequsetHttp WalletPersonGetCash1007WithPayType:@"3" amount: moneyStr userbcid:bankModel.userbcid putInPassWord:putInPassWord businessTypekey:@"0" num:self.num];
        //加密
        NSData *data = [SecurityUtil encryptAESData:[dict JSONFragment] andPublicPassWord:encryptKey];
        NSString *base64 = [SecurityUtil encodeBase64Data:data];
        
        NSString *url = [NSString stringWithFormat:@"%@%@&&tradeId=%@",WalletHttp_Record1107,[WalletRequsetHttp encodeString:base64],ID];
        
        [SINOAFNetWorking postWithBaseURL:url controller:self success:^(id json) {
            [self chrysanthemumClosed];
            if ([json[@"code"] isEqualToString:@"100"]) {
                NSLog(@"---- %@---",json[@"msg"]);
                if ([(json[@"rs"])[@"result"] isEqualToString:@"Y"]) {//请求成功后
                    //提示框的显示
                    //                self.succeedLabel.hidden = NO;
                    [self showMsg:@"提现成功！"];
                    [_InputPassWordView clearTextPassWordWithOneTextFiledEnabled:YES];
                    self.inputButton.hidden = YES;
                    [self.view endEditing:YES];
                    [SINOUIkeyboardView hidden];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.succeedLabel.hidden = YES;
                        
                        CJWithdrawDepositInfoViewController *IVC = [[CJWithdrawDepositInfoViewController alloc] init];
                        [_InputPassWordView clearTextPassWordWithOneTextFiledEnabled:YES];
                        IVC.bankCardName = self.payLabel.text;
                        IVC.moneyCash = self.moneyTextField.text;
                        [self.navigationController pushViewController:IVC animated:YES];
                    });
                } else {
                    [self showNumberPassWord];
                }
            } else {
                
                if (!json[@"rs"]) {
                    [self showMsg:ShowNoMessage];
                    return ;
                }
//                [self showMsg:(json[@"rs"])[@"result"]];
                [self showMsg:json[@"msg"]];
            }
        } failure:^(NSError *error) {
            [self chrysanthemumClosed];
            [self showMsg:ShowMessage];
        } noNet:^{
            [self chrysanthemumClosed];
        }];
    
}

/** 密钥网络请求 */
- (void)passWorldKeyWithFinish:(void(^)(NSString *encryptKey,NSString * ID))passWorldKey
{
    [self chrysanthemumOpen];
    [SINOAFNetWorking postWithBaseURL:WalletHttp_getPassWordKey120 controller:self success:^(id json) {
            passWorldKey(json[@"encryptKey"],json[@"id"]);
    } failure:^(NSError *error) {
        [self chrysanthemumClosed];
        [self showMsg:ShowMessage];
    } noNet:^{
        [self chrysanthemumClosed];
    }];
}

/** 密码验证 的网络请求 */
- (void)passWordVerifyWithPutInPassWord:(NSString *)putInPassWord encryptKey:(NSString *)encryptKey ID:(NSString *)ID
{
    NSDictionary *dict = [WalletRequsetHttp WalletPersonVerificationPayPassWord1004VerifyPassword:putInPassWord];
    NSData *data = [SecurityUtil encryptAESData:[dict JSONFragment] andPublicPassWord:encryptKey];
    NSString *basc64 = [SecurityUtil encodeBase64Data:data];
    
    NSString *url = [NSString stringWithFormat:@"%@%@&&tradeId=%@",WalletHttp_checkPassword1004,[WalletRequsetHttp encodeString:basc64],ID];
    [SINOAFNetWorking postWithBaseURL:url controller:self success:^(id json) {
        NSLog(@"----- json %@",json);
        if ([json[@"code"] isEqualToString:@"100"]) {
            self.payPassWordLabel.hidden = YES;
            self.num = [NSString stringWithFormat:@"%@",json[@"num"]];
            //密码验证
            [self passWorldKeyWithFinish:^(NSString *encryptKey, NSString *ID) {
                [self requestDataWithPutInPassWord:putInPassWord encryptKey:encryptKey ID:ID];
            }];
            
            return ;
        } else if ([json[@"code"] isEqualToString:@"102"]) {
            self.num = [NSString stringWithFormat:@"%@",json[@"num"]];
            [self showNumberPassWord];
            if (number - [self.num intValue]) {
                [self showMsg:json[@"msg"]];
            }
        } else if ([json[@"code"] isEqualToString:@"101"]) {
            [self showMsg:json[@"msg"]];
        }
        [self chrysanthemumClosed];
        [_InputPassWordView clearTextPassWordWithOneTextFiledEnabled:YES];
    } failure:^(NSError *error) {
        [self chrysanthemumClosed];
        [self showMsg:ShowMessage];
    } noNet:^{
        [self chrysanthemumClosed];
    }];
}
/** 密码输入不正确的显示 */
- (void)showNumberPassWord
{
    self.payPassWordLabel.hidden = NO;
    int num = number - [self.num intValue];
    self.payPassWordLabel.text = [NSString stringWithFormat:@"支付密码输入不正确，您还有%d次机会",num];
    if (num) {
        [self.InputPassWordView clearTextPassWordWithOneTextFiledEnabled:YES];
        [_InputPassWordView theKeyboardShow];
    } else {
        [self.InputPassWordView clearTextPassWordWithOneTextFiledEnabled:NO];
    }
    if (num == 0) {
        [self showReminderViewType:2];
    }
}

/** 添加银行卡的点击状态事件 */
- (IBAction)zhiFuTypeClick:(UIButton *)sender {
    
    //隐藏弹出页
    [self hiddenJumpView];
    GDHADDBlankViewController *BVC = [[GDHADDBlankViewController alloc] init];
    
    [self.navigationController pushViewController:BVC animated:YES];
}


/** 提示框的确定按钮的点击事件 */
- (IBAction)reminderBtnClick:(UIButton *)sender {
    self.moneyTextField.text = @"";
    [self hiddenReminderView];
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
        /** 等一下 */
    };
    titleView.ReleaseBoundBlock = ^(UIButton *ReleaseBound){
        /** 去设置*/
        GDHSetPassWordViewController *setPassWord = [[GDHSetPassWordViewController alloc] init];
        setPassWord.fromVcToSetPassWord = @"未设置密码，提现，设置了密码后返回提现界面";

        [self.navigationController pushViewController:setPassWord animated:YES];
        btn.hidden = YES;
    };
    [btn addSubview:titleView];
    [btn addTarget:self action:@selector(btnDownHidden:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
/**  隐藏 密码设置的蒙版 */
-(void)btnDownHidden:(UIButton *)sender{
    btn.hidden = YES;
    NSLog(@"取消隐藏");
}

#pragma   mark - 请输入按钮视图
-(GDHInputPassWordView *)InputPassWordView{
    if (!_InputPassWordView) {
        _InputPassWordView = [[GDHInputPassWordView alloc] initWithFrame:CGRectMake((ScreenWidth - 270)*0.5, 110, 270, 170) andPayMoney:self.moneyTextField.text];
        _InputPassWordView.layer.masksToBounds = YES;
        _InputPassWordView.layer.cornerRadius = 2;
        _InputPassWordView.backgroundColor =[UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f];
        __weak CJCashViewController *weekSelf = self;
        _InputPassWordView.closeBlock =^(UIButton *close){
            weekSelf.ifCancelPayButton.hidden = NO;
            weekSelf.inputButton .hidden=  YES;
            /** 关闭 */
        };
        _InputPassWordView.findBlock = ^(UIButton *findPassWord){
            GDHSetPassWordViewController *setPassWord = [[GDHSetPassWordViewController alloc] init];
            setPassWord.findPassWord = @"找回密码";
            [weekSelf.navigationController pushViewController:setPassWord animated:YES];
            
            
            /** 找回密码 */
        };
        _InputPassWordView.payPassWordBlock = ^(NSString *payPassWordSting){
            [weekSelf.view endEditing:YES];
            NSLog(@"payPassWordSting:  %@",payPassWordSting);
//                [weekSelf requestDataWithPutInPassWord:payPassWordSting];
            
            //密码验证 的网络请求
            [weekSelf passWorldKeyWithFinish:^(NSString *encryptKey, NSString *ID) {
                [weekSelf passWordVerifyWithPutInPassWord:payPassWordSting encryptKey:encryptKey ID:ID];
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
        [_inputButton addTarget:self action:@selector(inputButtonDown) forControlEvents:UIControlEventTouchUpInside];
        _inputButton.backgroundColor = payMask;
        [_inputButton addSubview:self.payPassWordLabel];
        [_inputButton addSubview:self.InputPassWordView];
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
        [_ifCancelPayButton addTarget:self action:@selector(ifCancelPayButtonDown:) forControlEvents:UIControlEventTouchUpInside];
        [_ifCancelPayButton addSubview:self.CancelTitleView];
    }
    return _ifCancelPayButton;
}



/** 是否取消支付 */
-(GDHTitleView *)CancelTitleView{
    if (!_CancelTitleView) {
        
        _CancelTitleView = [[GDHTitleView alloc] initWithFrame:CGRectMake(X, 110, 270, 124) andMessage:@"是否取消支付？ " andleftButtonTitle:@"是" andRightButtonTitle:@"否"];
        __weak CJCashViewController *weekSelf = self;
        _CancelTitleView.CancelButtonBlock = ^(UIButton *CancelButton){
            [weekSelf.view endEditing:YES];
            weekSelf.ifCancelPayButton.hidden = YES;
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

-(void)CJCashViewController{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showMsg:@"设置密码成功！"];
        btn.hidden = YES;
    });
}


@end



