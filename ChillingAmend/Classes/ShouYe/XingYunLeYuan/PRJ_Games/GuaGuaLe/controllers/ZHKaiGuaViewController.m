//
//  ZHKaiGuaViewController.m
//  LeWan
//
//  Created by 李祖浩 on 14/11/22.
//  Copyright (c) 2014年 李祖浩. All rights reserved.
//

#import "ZHKaiGuaViewController.h"
#import "STScratchView.h"
//#import "SVProgressHUD.h"

@interface ZHKaiGuaViewController ()<STScratchViewDelegate>{
    GCRequest *guaGuaMainRequest;
    NSDictionary *guaGuaDictionary;
    BOOL guaBool;
    BOOL isAward; // 是否有奖励
    NSString *suiJi;
}
@property (weak, nonatomic) IBOutlet STScratchView *scratchView;//刮刮乐类
@property (weak, nonatomic) IBOutlet UILabel *scratchLabel;//奖品名
@property (weak, nonatomic) IBOutlet UIButton *reselectionCardButton;
@property (weak, nonatomic) IBOutlet UIView *scratchBackgroundView;

//警告提示
@property (strong, nonatomic) IBOutlet UIView *jingGaoView;
@property (strong, nonatomic) IBOutlet UILabel *jingGaoLabel;
//广告
@property (strong, nonatomic) IBOutlet UIImageView *guangBaoImageView;

//消费提示
@property (strong, nonatomic) IBOutlet UIView *xiaoFeiTiShiView;
//帮助
@property (strong, nonatomic) IBOutlet UIView *bangZhuView;


@property (weak, nonatomic) IBOutlet UIView *moreView; // 更多
- (IBAction)shareBtnAction:(id)sender;
- (IBAction)helpBtnAction:(id)sender;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;
@end

@implementation ZHKaiGuaViewController
@synthesize scratchLabel;
@synthesize scratchView;
@synthesize reselectionCardButton;
@synthesize scratchBackgroundView;
@synthesize fanweiString;
@synthesize classidString;
@synthesize jingGaoLabel;
@synthesize jingGaoView;
@synthesize bangZhuView;
@synthesize bangZhuString;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    suiJi = @"";
    guaBool = NO;
    
    jingGaoView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    jingGaoView.hidden = YES;
    [self.view addSubview:jingGaoView];
    
    bangZhuView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    bangZhuView.hidden = YES;
    [self.view addSubview:bangZhuView];
    
    _moreView.hidden = YES;
    
    isAward = NO;
    //    导航栏
    [self layoutVideoIndexNavControl];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (UIButton *btn in self.allButtons) {
        [btn setExclusiveTouch:YES];
    }
    self.bar.hidden = YES;
    
    guaGuaMainRequest = [[GCRequest alloc]init];
    guaGuaMainRequest.delegate = self;
    [self.guangBaoImageView setImageWithURL:[NSURL URLWithString:self.ggImageString] placeholderImage:[UIImage imageNamed:@"public_middle_content_img_normal.png"]];
//    从选卡片
    [reselectionCardButton.titleLabel setFont:[UIFont fontWithName:[NSString stringWithFormat:@"JSaoEr"] size:16]];
//    奖品名
    [scratchLabel setFont:[UIFont fontWithName:[NSString stringWithFormat:@"JSaoEr"] size:16]];
    
    if (!iPhone5) {
        scratchBackgroundView.frame = CGRectMake(scratchBackgroundView.frame.origin.x + 10, 130, scratchBackgroundView.bounds.size.width - 20, scratchBackgroundView.bounds.size.height - 20);
    }
    
    NSLog(@"classidString = %@", self.classidString);
    [self request_100];
//    [self show];
//    requestView.frame = CGRectMake(0, 0, backView.bounds.size.width, mainView.bounds.size.height);
    //    刮刮
    [self scratch];
}

#pragma mark -数据请求结果
- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    [self hide];
    NSLog(@"--------------aString = %@",aString);
    NSDictionary * dic = [aString JSONValue];
    NSLog(@"dict = %@",dic);
    if (aString.length == 0) {
        [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
        return;
    }
    if (dic) {
        if (aRequest.tag == 100) { // 详情内容接口
            guaGuaDictionary = dic;
            if ([guaGuaDictionary[@"code"] intValue] == 0) {
                NSString *scratchString;
                if ([[guaGuaDictionary objectForKey:@"zhong"] intValue] == 1) {
                    isAward = YES;
                    scratchString = [NSString stringWithFormat:@"%@积分",[guaGuaDictionary objectForKey:@"ljb"]];
                }else if ([[guaGuaDictionary objectForKey:@"zhong"] intValue] == 2) {
                    isAward = NO;
                    scratchString = @"谢谢参与";
                }else if ([[guaGuaDictionary objectForKey:@"zhong"] intValue] == 3) {
                    isAward = YES;
                    scratchString = [guaGuaDictionary objectForKey:@"prize_name"];
                }
                
                scratchLabel.text = scratchString;
                
                NSString *getSuiJin = dic[@"suiji"];
                if (getSuiJin && ![getSuiJin isKindOfClass:[NSNull class]] && getSuiJin.length > 0) {
                    suiJi = getSuiJin;
                }else{
                    suiJi = @"";
                }
                
                
            }else if ([dic[@"code"] intValue] == 2) {
                isAward = NO;
                scratchLabel.text = @"谢谢参与";
            } else {
                [GCUtil showGameErrorMessageWithContent:dic[@"message"]];
            }
        }else if (aRequest.tag == 101) {
            
        }else if (aRequest.tag == 102) {
            guaBool = YES;
            if ([dic[@"code"] intValue] == 0) {
                if ([[guaGuaDictionary objectForKey:@"zhong"] intValue] == 3) { // 奖品
                    [GCUtil showGameAlertTitle:@"太给力了！亲~" andContent:[NSString stringWithFormat:@"获得%@",[guaGuaDictionary objectForKey:@"prize_name"]] cancel:nil andOK:@"确认"];
                } else if ([[guaGuaDictionary objectForKey:@"zhong"] intValue] == 1) { // 积分
                    [GCUtil showGameAlertTitle:@"太给力了！亲~" andContent:[NSString stringWithFormat:@"获得%@积分",[guaGuaDictionary objectForKey:@"ljb"]] cancel:nil andOK:@"确认"];
                    
                    NSString *jifen = [GCUtil getlajiaobiJinfen];
                    NSString *lastJifen = [NSString stringWithFormat:@"%d",([jifen intValue] + [[guaGuaDictionary objectForKey:@"ljb"] intValue] )];
                    [GCUtil saveLajiaobijifenWithJifen:lastJifen];
                    
                } else {
                    [GCUtil showGameAlertTitle:nil andContent:@"很遗憾 !\n没有中奖,再接再厉 !" cancel:nil andOK:@"确认"];
                }
            } else {
                [self showStringMsg:dic[@"message"] andYOffset:0];
            }
        } else if (aRequest.tag == 642) {
            if ([dic[@"code"] integerValue] == 0) {
                //                [self shareTitle:@"" withUrl:dic[@"url"] withContent:dic[@"content"] withImageName:dic[@"img"] withShareType:19 ImgStr:dic[@"img"] domainName:kkUserIMG];
            }
        }
    } else {
        [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
    }
}

- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self hide];
    [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
}

- (void)request_100
{
    [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI guaGuaLePremiumUserid:kkUserId fanwei:self.fanweiString classid:self.classidString]];
    mainRequest.tag = 100;
    [self showMsg:nil];
}

#pragma mark -
#pragma mark - 界面设置

-(void)scratch{
    scratchView.delegate = self;
    scratchView.scrapeBool = NO;
    scratchView.StartBool = YES;
    scratchView.scrapeInt = 0;
    scratchView.rect = CGRectMake(scratchLabel.frame.origin.x - scratchView.frame.origin.x, scratchLabel.frame.origin.y - scratchView.frame.origin.y, scratchLabel.bounds.size.width, scratchLabel.bounds.size.height);
    
    UIImageView* scrapeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"public_bottom_content_img_normal.png"]];
    scrapeImageView.frame = CGRectMake(0, 0, scratchView.bounds.size.width, scratchView.bounds.size.height);
    [scratchView setSizeBrush:30.0];
    [scratchView setPercentAccomplishment:20];
    // Define the hide view
    [scratchView setHideView:scrapeImageView];
}

#pragma mark -
#pragma mark - 刮刮乐返回代理

-(void)EndScratch{
    guaBool = NO;
    
    if (suiJi && suiJi.length > 0) {
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI guaGuaLeEnduserId:kkUserId suiji:suiJi]];
        mainRequest.tag = 102;
    }
    NSLog(@"成功");
}

-(void)StartScratch{
    guaBool = NO;
    [guaGuaMainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI guaGuaLeStartScratchuserId:kkUserId suiji:suiJi]];
    guaGuaMainRequest.tag = 101;
    NSLog(@"开始");
}

#pragma mark -
#pragma mark - 导航栏

-(void)layoutVideoIndexNavControl{
//    backView.hidden = YES;
//    returnButton.hidden = YES;
}

#pragma mark -
#pragma mark - 按钮方法
- (IBAction)jingGaoGuanButton:(id)sender {
    jingGaoView.hidden = YES;
}
- (IBAction)jingGaoQueRenButton:(id)sender {
    jingGaoView.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

//返回
- (IBAction)backtrackButton:(id)sender {
    if (guaBool == YES) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        NSLog(@"没刮完");
        jingGaoLabel.text = @"确认返回放弃一次机会么?";
        jingGaoView.hidden = NO;
    }
    
}

//重选卡片
- (IBAction)chongGuaButton:(id)sender{
    if (guaBool == YES) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        NSLog(@"没刮完");
        jingGaoLabel.text = @"确定放弃这次机会重选卡片么?";
        jingGaoView.hidden = NO;
    }
}

//更多
- (IBAction)bangZhuButton:(id)sender {
    _moreView.hidden = !_moreView.hidden;
}

#pragma mark - 按钮点击事件
#pragma mark 分享
- (IBAction)shareBtnAction:(id)sender {
    _moreView.hidden = YES;
    self.shareContent = [NSString stringWithFormat:@"伙伴们!我要开始刮奖了!来祝我好运吧!我在黑土App~ (来自于黑土App) http://ht.sinosns.cn/"];
    [self callOutShareViewWithUseController:self andSharedUrl:@"http://ht.sinosns.cn/"];
}

#pragma mark 帮助
- (IBAction)helpBtnAction:(id)sender {
    _moreView.hidden = YES;
    bangZhuView.hidden = NO;
}

// 取消帮助
- (IBAction)bangZhuGuanButton:(id)sender {
    bangZhuView.hidden = YES;
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
