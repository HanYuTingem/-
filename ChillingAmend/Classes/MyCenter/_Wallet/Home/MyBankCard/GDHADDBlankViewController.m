//
//  GDHADDBlankViewController.m
//  Wallet
//
//  Created by GDH on 15/10/22.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "GDHADDBlankViewController.h"
#import "GDHTitleView.h"
#import "GDHallBankTableViewCell.h"
@interface GDHADDBlankViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UIButton *btn;
    /**  输入的字符串 */
    NSString *inputString;
}

@property (weak, nonatomic) IBOutlet UIImageView *refreshImage;
@property(nonatomic,strong)NSMutableArray *bankArray;
/** 时间记时器 */
@property (nonatomic, strong) CADisplayLink *link;

@property(nonatomic,strong)NSArray *arr ;
@end

@implementation GDHADDBlankViewController

- (void)viewDidLoad {
    inputString = @"";
    [super viewDidLoad];
    mainView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
    self.maskView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.9];
    /* 边框隐藏 */
//    self.inputView.layer.borderColor = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f].CGColor;
//    self.inputView.layer.borderWidth = 0.5f;
    self.allBankTableView.layer.borderColor =  [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f].CGColor;
    self.allBankTableView.layer.borderWidth = 0.5f;
    self.allBankTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.blankNumberTextFlied.keyboardType = UIKeyboardTypeNumberPad;
     [self.selectBankTextFiled addTarget:self action:@selector(textChangeAction) forControlEvents:UIControlEventEditingChanged];
    
//    [self.blankNameFlied addTarget:self action:@selector(blankNameAction) forControlEvents:UIControlEventEditingChanged];
    [self makeLine];
    [self makeNav];
    [self makeTitle];
    [self loadData];
    if (![self.theRightIden isEqualToString:@"显示"]) {
        
        self.bankImageVIww.hidden = YES;
        self.BankOfChinalabel.hidden = YES;
        self.inputView.hidden = NO;
    }else{
        
        [self.rightButton setTitle:@"解除绑定" forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        self.rightButton.frame = CGRectMake(ScreenWidth - 70, self.rightButton.frame.origin.y + 10, 60, 30);
        self.BankOfChinalabel.hidden = NO;
        self.inputView.hidden = YES;
        [self request1115BlankID:[NSString stringWithFormat:@"%@",self.bankID]];
        self.blankNumberTextFlied.enabled = NO;
        self.blankNameFlied.enabled = NO;
        self.confirmButton.hidden = YES;
        self.bankNumTitle.text = @"持卡人:";
        self.bankOftitleLabel.hidden = YES;
        self.theNameTitle.text = @"卡号:";
    }
    self.confirmButton.layer.masksToBounds = YES;
    self.confirmButton.layer.cornerRadius = 4;
    self.blankNameFlied.delegate = self;
    // Do any additional setup after loading the view from its nib.
}
/** 适配线 */
-(void)makeLine{
    //1
    self.uplineImage.frame = CGRectMake(self.uplineImage.frame.origin.x, self.uplineImage.frame.origin.y, self.uplineImage.frame.size.width, 0.5);
    //2
    self.twoLineImage.frame = CGRectMake(self.twoLineImage.frame.origin.x, self.twoLineImage.frame.origin.y, self.twoLineImage.frame.size.width, 0.5);
    //3
    self.threeLineImage.frame = CGRectMake(self.threeLineImage.frame.origin.x, self.threeLineImage.frame.origin.y, self.threeLineImage.frame.size.width, 0.5);
    //4
    self.fourLineIamge.frame = CGRectMake(self.fourLineIamge.frame.origin.x, self.fourLineIamge.frame.origin.y, self.fourLineIamge.frame.size.width, 0.5);
   
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SINOAFNetWorking cancelAllRequest];
}

-(void)request1115BlankID:(NSString *)BlankID{
    NSDictionary *dict = [WalletRequsetHttp WalletPersonGetBankCardDetail1115andTheBlankID:BlankID];
    NSString *url = [NSString stringWithFormat:@"%@%@",WalletHttp_getBankCardDetail1115,[dict JSONFragment]];

    [SINOAFNetWorking postWithBaseURL:url controller:self success:^(id json) {
        NSLog(@"%@",json);
        
        NSDictionary *dict = json;
        if ([dict[@"code"] isEqualToString:@"100"]) {
            
            self.blankNumberTextFlied.text = (dict[@"rs"])[@"cardName"];
            self.blankNameFlied.text = (dict[@"rs"])[@"cardSn"];
            self.BankOfChinalabel.text = [NSString stringWithFormat:@"%@(尾号%@)",self.theBank,self.bankNum];
            [self.bankImageVIww setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",walletMybankimh_UrL,self.bankImg]]];
            self.BankOfChinalabel.frame = CGRectMake(CGRectGetMaxX(self.bankImageVIww.frame)+10, self.BankOfChinalabel.frame.origin.y, self.BankOfChinalabel.frame.size.width, self.BankOfChinalabel.frame.size.height);
        }else if ([dict[@"code"] isEqualToString:@"101"]){
            [self showMsg:dict[@"msg"]];
        }
    } failure:^(NSError *error) {
        
    } noNet:^{
        
    }];
}

/** 开始动画旋转 */
- (void)startImage
{
    if (self.link) return;
    self.VerificationLabel.hidden = NO;
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.link = link;
}
- (void)update
{
    self.refreshImage.transform = CGAffineTransformRotate(self.refreshImage.transform, M_PI / 50);
}
/** 停止动画旋转 */
- (void)stopImage
{
    self.VerificationLabel.hidden = YES;
    [self.link invalidate];
    self.link = nil;
}
/**
 招商银行	B007
 工商银行	B003
 农业银行	B002
 中国银行	B001
 建设银行	B004
 交通银行	B005
 民生银行	B008
 邮储银行	B006
 中信银行	B009
 光大银行	B010
 浦发银行	B015
 广发银行	B012
 华夏银行	B011
 兴业银行	B014
 平安银行	B041
 */
- (void)loadData{
    self.arr = @[@"招商银行",@"工商银行",@"农业银行",@"中国银行",@"建设银行",@"交通银行",@"民生银行",@"邮储银行",@"中信银行",@"光大银行",@"浦发银行",@"广发银行",@"华夏银行",@"兴业银行",@"平安银行"];
        [self.bankArray removeAllObjects];

    for (NSString *str in self.arr) {
        if ([str rangeOfString:inputString].location != NSNotFound ) {
            NSLog(@"%@",str);
            [self.bankArray addObject:str];
        }
    }
    [self.allBankTableView reloadData];
}

/** 懒加载 数据源的存储 */
-(NSMutableArray *)bankArray{
    if (!_bankArray) {
        
        _bankArray = [NSMutableArray array];
    }
    return _bankArray;
}

/** 设置导航 */
-(void)makeNav{
    self.backView.backgroundColor = WalletHomeNAVGRD
    self.mallTitleLabel.text  = @"我的银行卡";
    self.mallTitleLabel.textColor = [UIColor whiteColor];
    self.mallTitleLabel.font = WalletHomeNAVTitleFont
    [self.leftBackButton setImage:[UIImage imageNamed:@"title_btn_back02"] forState:UIControlStateNormal];
}
-(void)makeTitle{
   btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64);
    btn.backgroundColor = payMask;
    btn.hidden = YES;
    CGFloat X = (ScreenWidth - 270) / 2;
    GDHTitleView *titleView = [[GDHTitleView alloc] initWithFrame:CGRectMake(X, 110, 270, 124) andMessage:@"确定对这张卡解除绑定吗?" andleftButtonTitle:@"取消" andRightButtonTitle:@"解除绑定"];
    titleView.layer.masksToBounds = YES;
    titleView.layer.cornerRadius = 2;
    titleView.CancelButtonBlock = ^(UIButton *CancelButton){
        btn.hidden = YES;
        /** 取消 */
    };
    titleView.ReleaseBoundBlock = ^(UIButton *ReleaseBound){
        /** 确定 */
        NSDictionary *dict = [WalletRequsetHttp WalletPersonDeleteBankCard1111bankCardID:[NSString stringWithFormat:@"%@",self.bankID]];
        NSString *url = [NSString stringWithFormat:@"%@%@",WalletHttp_CancelBound1111,[dict JSONFragment]];
        [SINOAFNetWorking postWithBaseURL:url controller:self success:^(id json) {
            NSLog(@"%@  解除绑定验证成功",json);
            if ([dict[@"code"] isEqualToString:@"100"]) {
                if ([dict[@"rs"] isEqualToString:@"Y"]) {
                    NSLog(@" 解除成功");
                }
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSError *error) {
            
        } noNet:^{
            [self chrysanthemumClosed];
        }];
        btn.hidden = YES;
    };
    [btn addSubview:titleView];
    [btn addTarget:self action:@selector(btnDownHidden:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
-(void)btnDownHidden:(UIButton *)sender{
    btn.hidden = YES;
    NSLog(@"取消隐藏");
}
-(void)rightBackCliked{
    
    btn.hidden = NO;
       NSLog(@"解除绑定");
}
/** 下一步 */
- (IBAction)confirmBtnDown:(id)sender {
 
    if ([[self theBankID:self.selectBankTextFiled.text] isEqualToString:@"不在所属银行之内"]) {
        
        [self showMsg:@"请输入所属银行"];
        return;
    } else if (self.selectBankTextFiled.text.length == 0) {
        [self showMsg:@"请输入所属银行"];
        return;
    }else if (self.blankNumberTextFlied.text.length == 0 ) {
        [self showMsg:@"请输入银行卡号"];
        return;
    }else if (self.blankNumberTextFlied.text.length < 16 )
    {
        [self showMsg:@"您输入的位数不对"];
        return;
    }else  if (self.blankNameFlied.text.length == 0) {
        [self showMsg:@"请输入姓名"];
        return;
    }
    [self startImage];
    NSDictionary *dict = [WalletRequsetHttp WalletPersonAddBankCard1010andbankID:[self theBankID:self.selectBankTextFiled.text] andBankCardSN:self.blankNumberTextFlied.text andBankCardUser:self.blankNameFlied.text];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",WalletHttp_addBankCard,[dict JSONFragment]];
    [SINOAFNetWorking postWithBaseURL:url controller:self success:^(id json) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if ([json[@"code"]isEqualToString:@"100"]) {
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"theBlankAddSuccess" object:nil];
                [self stopImage];
                [self.navigationController popViewControllerAnimated:YES];
            }else if ([json[@"code"] isEqualToString:@"102"]){
                [self showMsg:json[@"msg"]];
            }
            [self stopImage];
            
        });
        NSLog(@"%@",json);
        
            } failure:^(NSError *error) {
        [self showMsg:ShowMessage];
        [self stopImage];
    } noNet:^{
        [self chrysanthemumClosed];
    }];

}
#pragma  mark - tableview 的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bankArray.count;
}
static NSString *iden = @"iden";
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GDHallBankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell=  [[NSBundle mainBundle]loadNibNamed:@"GDHallBankTableViewCell" owner:self options:nil].lastObject;
    }
    cell.bankLable.text = self.bankArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.maskView.hidden = YES;
    self.selectBankTextFiled.text = self.bankArray[indexPath.row];
}
#pragma  mark - textFiled 监听

-(void)textChangeAction{
     NSLog(@"%@",self.selectBankTextFiled);
    inputString = self.selectBankTextFiled.text;
    //判断输入的字符串有没有在字符串中
    for (NSString *str in self.arr) {
        if (([str rangeOfString:inputString].location != NSNotFound)) {
            self.maskView.hidden = NO;
             [self loadData];
            return;
        }else{
            self.maskView.hidden = YES;
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.blankNameFlied) {
        if (![self ifContainfigure:string]) {
            [self showMsg:@"请不要输入数字"];
            return NO;
        }
    }
    
    return YES;
}
/** 判断是否有数字 */
-(BOOL)ifContainfigure:(NSString *)figure{
    
    NSString *figureStr = @"0123456789";
    if ([figureStr rangeOfString:figure].location != NSNotFound) {
        return NO;
    }
    return YES;
}

/**
 招商银行	B007
 工商银行	B003
 农业银行	B002
 中国银行	B001
 建设银行	B004
 交通银行	B005
 民生银行	B008
 邮储银行	B006
 中信银行	B009
 光大银行	B010
 浦发银行	B015
 广发银行	B012
 华夏银行	B011
 兴业银行	B014
 平安银行	B041
 */

/** 判断银行卡对应的id */
-(NSString *)theBankID:(NSString *)theBank{

    if ([theBank isEqualToString:@"招商银行"]) {
        return @"1";
    }if([theBank isEqualToString:@"工商银行"]){
        return @"2";
    }if ([theBank isEqualToString:@"农业银行"]) {
        return @"3";
    }if([theBank isEqualToString:@"中国银行"]){
        return @"4";
    }if ([theBank isEqualToString:@"建设银行"]) {
        return @"5";
    }if([theBank isEqualToString:@"交通银行"]){
        return @"6";
    } if ([theBank isEqualToString:@"民生银行"]) {
        return @"7";
    }if([theBank isEqualToString:@"邮储银行"]){
        return @"8";
    }if([theBank isEqualToString:@"中信银行"]){
        return @"9";
    }if([theBank isEqualToString:@"光大银行"]){
        return @"10";
    }if([theBank isEqualToString:@"浦发银行"]){
        return @"11";
    }if([theBank isEqualToString:@"广发银行"]){
        return @"12";
    }if([theBank isEqualToString:@"华夏银行"]){
        return @"13";
    }if([theBank isEqualToString:@"兴业银行"]){
        return @"14";
    }if([theBank isEqualToString:@"平安银行"]){
        return @"15";
    }else{// 平安银行
        return @"不在所属银行之内";
    }
}
@end
