//
//  LYLQuickLoginViewController.m
//  LaoYiLao
//
//  Created by sunsu on 15/11/7.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "LYLQuickLoginViewController.h"
#import "GetSuccessViewController.h"
#import "LYLLoginModel.h"
#import "DumplingInforModel.h"
#import "ServerAgreementViewController.h"
#import "NoGetMoneyView.h"
#import "mineWalletViewController.h"
#define TimerNum 59
#define PADDING 10
@interface LYLQuickLoginViewController ()
{
    NSTimer* timer; //  计时
    int  timecoutn ;
//    UITextField* phonetextfield;    //  输入电话
//    UITextField* yzmtextfileld ;    //  验证码
    NSString * numstr;              //  校验
    QuickLoginView *_quickLoginView; // 快速登录view
}
@property (nonatomic, strong) UILabel * titleLabel;
@end

@implementation LYLQuickLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = RGBACOLOR(242, 242, 242, 1);
    [self createCustomNavigation];
    
    timecoutn = TimerNum;
    [self createLoginView];
}


- (void)createCustomNavigation
{
    CGRect barViewFrame = CGRectMake(0, 0, kkViewWidth, NavgationBarHeight);
    UIView * barView = [[UIView alloc]initWithFrame:barViewFrame];
    barView.backgroundColor = [UIColor colorWithPatternImage:[LYLTools scaleImage:[UIImage imageNamed:@"lao_bg"] ToSize:CGSizeMake(kkViewWidth, NavgationBarHeight)]] ;

    CGFloat buttonY = 20;
    //返回按钮
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setExclusiveTouch:YES];
    leftButton.frame = CGRectMake(0, buttonY, 44, 44);
    [leftButton addTarget:self action:@selector(leftBarButtonOnclick) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat imageViewW = 44;
    CGFloat imageViewH = 44;
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (leftButton.frame.size.height-imageViewH)/2, imageViewW, imageViewH)];
    imageView.image = [UIImage imageNamed:@"LYL_nav_btn_back_left"];
    [leftButton addSubview:imageView];
    [barView addSubview:leftButton];
    
    CGFloat titleLabelW = kkViewWidth - 44 - 70;
    _titleLabel  = [[UILabel alloc] initWithFrame:CGRectMake(60,  buttonY, titleLabelW, 44)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.text = @"快速登录";
    [barView addSubview:_titleLabel];
    
    [self.view addSubview:barView];
}

-(void)leftBarButtonOnclick{
    _backBlock();
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [timer invalidate];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"popLYLVC" object:nil];

}

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidAppear:(BOOL)animated{
    
}
- (void) createLoginView{
    CGRect quickLoginViewFrame = CGRectMake(0, 64, kkViewWidth, kkViewHeight-64);
    _quickLoginView = [[QuickLoginView alloc]initWithFrame:quickLoginViewFrame];
    _quickLoginView.delegate = self;
    [self.view addSubview:_quickLoginView];
}



#pragma -mark 方法待实现
- (void) serverAgreementClicked{
    //服务协议
    ServerAgreementViewController * serverAgreementVC = [[ServerAgreementViewController alloc]init];
    [self.navigationController pushViewController:serverAgreementVC animated:YES];
}

//登录按钮
-(void)tijiaobtnclick{
    if (_quickLoginView.phonetextfield.text==nil||_quickLoginView.phonetextfield.text.length==0) {
        [LYLTools showInfoAlert:@"请输入手机号码"];
        return;
    }else if (![LYLTools isMobileNumber:_quickLoginView.phonetextfield.text]){
        [LYLTools showInfoAlert:@"请输入正确的手机号码"];
    }else if (_quickLoginView.yzmtextfileld.text==nil||_quickLoginView.yzmtextfileld.text.length==0) {
        [LYLTools showInfoAlert:@"请输入验证码"];
    }else{
        [self requestData];
    }
    
}


//获取验证码
-(void)getnumbtnclick:(UIButton*)sender{
    if (_quickLoginView.phonetextfield.text==nil||_quickLoginView.phonetextfield.text.length==0) {
        [LYLTools showInfoAlert:@"请输入手机号码"];
        return;
    }else if (![LYLTools isMobileNumber:_quickLoginView.phonetextfield.text]){
        [LYLTools showInfoAlert:@"请输入正确的手机号码"];
    }
//    else if(_quickLoginView.yzmtextfileld.text.length != 0 ||_quickLoginView.yzmtextfileld.text != nil){
//        [Tools showInfoAlert:@"请获取到验证码后再输入"];
//    }
    else{
        //请求验证码接口
        NSString * url = [LYLHttpTool sendIdentifyCodeWithUserName:_quickLoginView.phonetextfield.text andType:SysType];
        [LYLAFNetWorking postWithBaseURL:url success:^(id json) {
            ZHLog(@"验证码=%@",json);
            NSDictionary * yzmJson = (NSDictionary *)json;
            int returnCode = [[yzmJson objectForKey:@"code"]intValue];
            switch (returnCode) {
                case 99:
                {
                 [LYLTools showInfoAlert:@"超过最大发送次数"];
                }
                    break;
                case 203:
                {
                    [LYLTools showInfoAlert:@"系统异常"];
                }
                    break;
                case 101:
                {
                    [LYLTools showInfoAlert:@"用户名已存在"];
                }
                    break;
                case 100:
                {
                    [LYLTools showInfoAlert:@"用户名不存在"];
                }
                    break;
                case 98:
                {
                    [LYLTools showInfoAlert:@"同一手机号码一分钟之内发送频率不能超过1条"];
                }
                    break;
                    
                default:
                    break;
            }
  
        } failure:^(NSError *error) {
            ZHLog(@"%@",error);
        }];
    
   
        [sender setTitle:[NSString stringWithFormat:@"获取验证码(%2ds)",timecoutn--] forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor lightGrayColor];
        sender.enabled = NO;
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timechange) userInfo:nil repeats:YES];
    }
}


//验证码倒计时
-(void)timechange{
    

    UIButton* label =(UIButton*)[self.view viewWithTag:999];
    [label setTitle:[NSString stringWithFormat:@"获取验证码(%2ds)",timecoutn--] forState:UIControlStateNormal];
    if(timecoutn == -1){
        timecoutn = TimerNum;
        [timer invalidate];
        [label setTitle:@"重新获取" forState:UIControlStateNormal];
        [label setBackgroundColor:[UIColor colorWithPatternImage:[LYLTools scaleImage:[UIImage imageNamed:@"lao_bg"] ToSize:CGSizeMake(label.frame.size.width, label.frame.size.height)]]];
        label.enabled = YES;

    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


//java登录请求
-(void)requestData{
    NSString * url = [LYLHttpTool quickLoginWithUserName:_quickLoginView.phonetextfield.text Vcode:_quickLoginView.yzmtextfileld.text Type:SysType andpProIden:ProductCode];
    
    [self showHudInView:self.view hint:@"正在登陆。。。"];
    [LYLAFNetWorking postWithBaseURL:url success:^(id json) {
        ZHLog(@"登录 = %@",json);
        LYLLoginModel * loginModel = [LYLLoginModel getLYLLoginModelWithDic:json];
        if ([[json objectForKey:@"code"] intValue] == 1) {//登陆成功
            
            
            MySetObjectForKey(loginModel.resultModel.id,UserIDKey);//保存登陆用户的id
            MySetObjectForKey(_quickLoginView.phonetextfield.text, LoginPhoneKey);//保存手机号
            ZHLog(@"LYLuserID == %@,LYLPhone == %@",LYLUserId,LYLPhone);
            [ZHLoginInfoManager addSaveJavaCacheInLoginWithJson:json];
           //登录成功
            if(LOGINGTYPE == 1){//只掉java
                [self hideHud];
                [self showHint:@"登陆成功"];
                [self loadDataWithNoLoginGetMoney];

            }else if (LOGINGTYPE == 2){//掉完java调php
                [self loadPHP:json];
            }
            
        }else{
            [self hideHud];
            MySetObjectForKey(@"", UserIDKey);
            switch ([[json objectForKey:@"code"] intValue]) {
                case 103:
                {
                    [LYLTools showInfoAlert:@"没有登录平台权限"];
                }
                    break;
                case 203:
                {
                    [LYLTools showInfoAlert:@"系统异常"];
                }
                    break;
                case 2:
                {
                    [LYLTools showInfoAlert:@"用户锁定"];
                }
                    break;
                    
                default:
                    [LYLTools showInfoAlert:@"验证失败,请重新验证"];
                    break;
            }
            
        }
        
    } failure:^(NSError *error) {
        ZHLog(@"java---login%@",error);
        [self hideHud];
    }];

}
#pragma mark -- php 登陆请求
- (void)loadPHP:(id)json {
    
    NSDictionary *resultDic = json[@"result"];
    NSDictionary *urldic = [LYLHttpTool accessToLoginInformationUserId:[resultDic objectForKey:@"id"] userName:[resultDic objectForKey:@"userName"] sex:[resultDic objectForKey:@"sex"] nickName:[resultDic objectForKey:@"nickname"] src:[resultDic objectForKey:@"src"] jifen:@"0"status:[resultDic objectForKey:@"status"] lat:@"" ing:@"" token:@""];
    
    [LYLAFNetWorking postWithBaseURL:WZHLogingPHPWithUrl params:urldic success:^(id json) {
        [self hideHud];
        NSDictionary *dict = (NSDictionary *)json;
        if ([dict[@"code"] intValue] == 1) {
            
            [SaveMessage saveUserMessageJava:dict];
            [SaveMessage saveUserMessagePHP:json];
            [ZHLoginInfoManager addSavePHPCacheInLoginWithJson:json];
            [self showHint:@"登陆成功"];
            [self loadDataWithNoLoginGetMoney];
        }
    } failure:^(NSError *error) {
        ZHLog(@"php---loging%@",error);

        [self hideHud];

    }];
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
-(void)loadDataWithNoLoginGetMoney{
    
    //未登录饺子存储的饺子
    NSMutableArray *dumplingInforNoLogingArray = [NSMutableArray arrayWithContentsOfFile:DumplingInforNoLogingPath];
    NSMutableArray *dumplingIdArray = [NSMutableArray array];//未登录没有领取的饺子钱
    for (NSDictionary *subDic in dumplingInforNoLogingArray) {
        DumplingInforModel *model = [DumplingInforModel dumplingInforModelWithDic:subDic];
        [dumplingIdArray addObject:model.resultListModel.dumplingModel.prizeId];
    }
    
    if(dumplingIdArray.count == 0){
        if([_type isEqualToString:@"2"]){
            mineWalletViewController *myWalletVC = [[mineWalletViewController alloc]init];
            myWalletVC.type = @"1";
            [self.navigationController pushViewController: myWalletVC animated:YES];
        }else{
            [self leftBarButtonOnclick];
        }
    }else{
        NSString *dumplingStr =  [dumplingIdArray componentsJoinedByString:@","];
        
        [self showHudInView:self.view hint:@"正在领取。。。"];
        [LYLAFNetWorking getWithBaseURL:[LYLHttpTool noLogingGetMoneyWithProductCode:ProductCode sysType:SysType sessionValue:SessionValue phone:_quickLoginView.phonetextfield.text  prizeidList:dumplingStr andUserId:MyObjectForKey(UserIDKey)] success:^(id json) {
            ZHLog(@"%@",json);
            [self hideHud];
            
            switch ([[json objectForKey:@"code"] intValue]) {
                case 100://领取成功
                {
                    [self showHint:@"领取成功"];
                    NSMutableArray *logingArray = [NSMutableArray arrayWithContentsOfFile:DumplingInforLogingPath];
                    if(!logingArray){
                        logingArray = [NSMutableArray array];
                    }
                    [logingArray addObjectsFromArray:dumplingInforNoLogingArray];
                    ZHLog(@"已登陆数组%@",logingArray);
                    //将未登录的饺子存为已登陆的
                    if([logingArray writeToFile:DumplingInforLogingPath atomically:YES]){
                        ZHLog(@"写入已登陆成功");
                    }else{
                        ZHLog(@"写入已登陆失败");
                    }
                    
                    /**
                     *  更给储存未登陆的饺子信息
                     */
                    [dumplingInforNoLogingArray removeAllObjects];
                    ZHLog(@"未登陆数组%@",dumplingInforNoLogingArray);
                    if([dumplingInforNoLogingArray writeToFile:DumplingInforNoLogingPath atomically:YES]){
                        ZHLog(@"写入未登陆成功");
                    }else{
                        ZHLog(@"写入未登陆失败");
                    }
                    if([_type isEqualToString:@"1"]){
                        [self leftBarButtonOnclick];
                    }else if([_type isEqualToString:@"2"]){
                        mineWalletViewController *myWalletVC = [[mineWalletViewController alloc]init];
//                        myWalletVC.backBlock = ^void(){};
                        myWalletVC.type = @"1";
                        [self.navigationController pushViewController: myWalletVC animated:YES];
                    }else{
                        //未登录领取钱的
                        GetSuccessViewController * getSuccessVC = [[GetSuccessViewController alloc]init];
                        [self.navigationController pushViewController:getSuccessVC animated:YES];
                    }
                }
                    break;
                case 101:
                {
                    [LYLTools showInfoAlert:@"系统错误"];
                }
                    break;
                case 102:
                {
                    if([_type isEqualToString:@"1"]){
                        [self showHint:@"领取失败，可以换个手机号领取" yOffset:40 ];
                        [self leftBarButtonOnclick];
                    }else if([_type isEqualToString:@"2"]){
                        [self showHint:@"领取失败，可以换个手机号领取" yOffset:40 ];
                        mineWalletViewController *myWalletVC = [[mineWalletViewController alloc]init];
                        //                        myWalletVC.backBlock = ^void(){};
                        myWalletVC.type = @"1";
                        [self.navigationController pushViewController: myWalletVC animated:YES];
                    }else{
                        //未登录领取钱的
                        GetSuccessViewController * getSuccessVC = [[GetSuccessViewController alloc]init];
                        [self.navigationController pushViewController:getSuccessVC animated:YES];
                        [LYLTools showInfoAlert:@"领取失败，可以换个手机号领取"];
                    }
                    
                }
                    break;
                case 103:
                {
                    
                    [LYLTools showInfoAlert:@"登陆失败"];
                }
                    break;
                case 104:
                {
                    [dumplingInforNoLogingArray removeAllObjects];
                    [dumplingInforNoLogingArray writeToFile:DumplingInforNoLogingPath atomically:YES];
                    
                    [self leftBarButtonOnclick];
                    [LYLTools showInfoAlert:@"饺子已过期"];
                }
                    break;
                case 105:{
                    [dumplingInforNoLogingArray removeAllObjects];
                    [dumplingInforNoLogingArray writeToFile:DumplingInforNoLogingPath atomically:YES];
                    
                    [self leftBarButtonOnclick];
                    [LYLTools showInfoAlert:@"饺子已被领取"];
                    
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
                    [LYLTools showInfoAlert:@"饺子信息无效"];
                }
                    break;
                    
                default:
                    break;
            }
            [[NoGetMoneyView shareGetMoneyView] refreshShareGetMoneyView];//刷新捞一捞界面未领取金额的数据
            
        } failure:^(NSError *error) {
            ZHLog(@"%@",error);
            [self hideHud];
            
        }];
    }
}


#pragma mark -- 增加捞饺子机会接口 (在前段和APP页面第一次请求捞一捞页面 登陆状态)暂时没用

/**
 *  增加捞饺子机会接口 (在前段和APP页面第一次请求捞一捞页面 登陆状态)
 */
- (void)loadDataAddLYLDumplingWithNumber{
    [self showHudInView:self.view hint:@"正在加载"];
    
    [LYLAFNetWorking getWithBaseURL:[LYLHttpTool addDumplingNuumberWithUserId:MyObjectForKey(UserIDKey) productCode:ProductCode sysType:SysType andSessionValue:SessionValue ] success:^(id json) {
        ZHLog(@"增加捞饺子机会接口=%@",json);
        [self hideHud];

        [self loadDataWithNoLoginGetMoney];
    
    } failure:^(NSError *error) {
        ZHLog(@"增加捞饺子机会接口=%@",error);
        [self hideHud];
        [LYLTools showInfoAlert:@"操作失败"];
        
    }];
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
