//
//  ZHGuaGuaLeViewController.m
//  LeWan
//
//  Created by 李祖浩 on 14/11/22.
//  Copyright (c) 2014年 李祖浩. All rights reserved.
//

#import "ZHGuaGuaLeViewController.h"
#import "ZHKaiGuaViewController.h"
#import "STScratchView.h"
#import "PRJ_GuaGuaLeListModel.h"
//#import "SVProgressHUD.h"
//#import "AppNoDataView.h"

@interface ZHGuaGuaLeViewController ()<STScratchViewDelegate>{
    int geShu;
    BOOL openScrapingBool;//是否有进入开过页
    NSMutableArray *guaGuaArray;   //刮刮卡数据
    NSString *jiFenString;      //用户积分
    NSString *numbers;         // 刮奖次数
    NSString *shf;            //是否可刮奖
    NSString *spendMoney;     //花费积分
    NSMutableArray *countArray;   //剩余刮卡次数图片
}

@property (weak, nonatomic) IBOutlet UIButton *reselectionCardButton;//刮刮次数
@property (weak, nonatomic) IBOutlet UIView *chiliCoinView; // 积分界面
@property (weak, nonatomic) IBOutlet UIScrollView *scratchScrollView;//显示刮刮乐
//消费提示
@property (strong, nonatomic) IBOutlet UIView *xiaoFeiTiShiView;
//消费积分
@property (strong, nonatomic) IBOutlet UILabel *xiaoFeiLabel;

//规则
@property (strong, nonatomic) IBOutlet UIView *guiZeView;
@property (weak, nonatomic) IBOutlet UIView *moreView; // 更多
- (IBAction)shareBtnAction:(id)sender;
- (IBAction)helpBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *countImageView;    //刮奖次数显示图片
@end

@implementation ZHGuaGuaLeViewController
@synthesize xiaoFeiLabel;
@synthesize reselectionCardButton;
@synthesize scratchScrollView;
@synthesize xiaoFeiTiShiView;
@synthesize guiZeView;

#pragma mark -数据请求结果
- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    [self hide];
    NSLog(@"guaguale = %@", aString);
    if (aString.length == 0) {
        if (mainRequest.tag == 103) {
            [self shareDefalutMessage];
        } else {
            [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
        }
        return;
    }
    NSDictionary *dict = [aString JSONValue];
    NSLog(@"dict = %@",dict);
   
    if (dict) {
        if (aRequest.tag == 100) {//详情内容接口
            if ([dict[@"code"] intValue] == 0 ||[dict[@"code"] intValue] == 4) {
                
                jiFenString = dict[@"jifen"];
                numbers = dict[@"nums"];
                shf = dict[@"shf"];
                spendMoney = dict[@"xuyao"];
                if (jiFenString && ![jiFenString isKindOfClass:[NSNull class]]) {
                } else jiFenString = @"0";
                [GCUtil changeChiliCoinView:[jiFenString intValue] andCoinImageView:_chiliCoinView andImageArray:countArray];
                [GCUtil saveLajiaobijifenWithJifen:jiFenString];
                NSArray *listArr = [dict objectForKey:@"json"];
                for (NSDictionary *listDic in listArr) {
                    PRJ_GuaGuaLeListModel *model = [PRJ_GuaGuaLeListModel getGuaGuaLeListModelWithDic:listDic];
                    [guaGuaArray addObject:model];
                }
                NSDictionary* infoDict1 = [[NSDictionary alloc] initWithObjectsAndKeys:scratchScrollView,@"scratchScrollView", nil];
                [self initiation:infoDict1];
            } else {
                 [self showStringMsg:dict[@"message"] andYOffset:0];
            }
        } else if (aRequest.tag == 101) {
            if ([dict[@"code"] intValue] == 0) {
                shf = dict[@"shf"];
                if ([dict[@"statusjifen"] intValue] == 1) {
                    [self showStringMsg:@"兑换成功!" andYOffset:0];
                    
                    NSString *jifen = [dict objectForKey:@"jifen"];
                    if (jifen && ![jifen isKindOfClass:[NSNull class]]) {
                        
                    }else jifen = @"0";
                    
                    [GCUtil changeChiliCoinView:[jifen intValue] andCoinImageView:_chiliCoinView andImageArray:countArray];
                    [GCUtil saveLajiaobijifenWithJifen:jifen];
                }
                
            } else {
               [self showStringMsg:dict[@"message"] andYOffset:0];
            }
            xiaoFeiTiShiView.hidden = YES;
        } else if (aRequest.tag == 103) { // 分享内容
            [self setShareContentData:dict];
        }
    } else {
        if (aRequest.tag == 101) {
           [GCUtil showGameErrorMessageWithContent:@"失败"];
        }
        if (aRequest.tag == 103) {
            [self shareDefalutMessage];
        }
    }
}


- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    if (mainRequest.tag == 103) {
        [self shareDefalutMessage];
    } else {
        [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
    }
}

- (void)request_100
{
    [guaGuaArray removeAllObjects];
    [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI guaGuaLeListWithUserID:kkUserId]];
    mainRequest.tag = 100;
     [self showMsg:nil];
}

#pragma mark 请求分享内容
- (void) shareContentRequest
{
    if (![GCUtil connectedToNetwork]) {
        [self shareDefalutMessage];
    } else {
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI shareContentType:@"2"]];
        mainRequest.tag = 103;
        [self showMsg:nil];
    }
}

#pragma mark 分享内容请求返回的数据处理
- (void) setShareContentData:(NSDictionary*)dict
{
    if ([[dict objectForKey:@"code"] intValue] == 1) { // 有分享内容
        self.shareContent = [NSString stringWithFormat:@"%@%@", dict[@"share_content"], dict[@"share_url"]];
        [self callOutShareViewWithUseController:self andSharedUrl:dict[@"share_url"]];
    } else {
        [self shareDefalutMessage];
    }
}

// 分享默认内容
- (void) shareDefalutMessage
{
    self.shareContent = [NSString stringWithFormat:@"伙伴们!我要开始刮奖了!来祝我好运吧!我在黑土App~ (来自于黑土App) http://ht.sinosns.cn/"];
    [self callOutShareViewWithUseController:self andSharedUrl:@"http://ht.sinosns.cn/"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.bar.hidden = YES;
    _moreView.hidden = YES;
    
    if (![GCUtil connectedToNetwork]) {
        [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
        return;
    }
    
//    是否有进入开过页
    openScrapingBool = NO;
    
    xiaoFeiTiShiView.hidden = YES;
    xiaoFeiTiShiView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    [self.view addSubview:xiaoFeiTiShiView];
    
    guiZeView.hidden = YES;
    guiZeView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    [self.view addSubview:guiZeView];
    
//    导航栏
    [self layoutVideoIndexNavControl];
    
    
    [self request_100];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [NSThread detachNewThreadSelector:@selector(initiation:) toTarget:self withObject:nil];
    // Do any additional setup after loading the view from its nib.
    guaGuaArray = [[NSMutableArray alloc]init];
    countArray = [[NSMutableArray alloc]initWithObjects:@"guaGuaLe0.png",@"guaGuaLe1.png",@"guaGuaLe2.png",@"guaGuaLe3.png",@"guaGuaLe4.png",@"guaGuaLe5.png",@"guaGuaLe6.png",@"guaGuaLe7.png",@"guaGuaLe8.png",@"guaGuaLe9.png", nil];
}

#pragma mark -
#pragma mark - 导航栏

-(void)layoutVideoIndexNavControl{
//    backView.hidden = YES;
//    returnButton.hidden = YES;
}

#pragma mark -
#pragma mark - 初始化界面

-(void)initiation:(id)sender{
    UIScrollView* displayView = self.scratchScrollView;
    displayView.showsVerticalScrollIndicator = NO;
    
    int l = 0;
    UIImageView *displayImageView;
    
    if (guaGuaArray.count > 0) {
        for (int i = 0; i < [guaGuaArray count]; i++) {
            PRJ_GuaGuaLeListModel *model = guaGuaArray[i];
            UIImageView *backgroundImageView;
            backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"public_middle_content_img_normal2.png"]];
            if ((i%2) == 0 &&i != 0) {
                l = l+1;
            }
            backgroundImageView.tag = i + 10;
            backgroundImageView.userInteractionEnabled = YES;
            [backgroundImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseScratch:)]];
            [backgroundImageView setExclusiveTouch:YES];
            displayImageView = backgroundImageView;
            [displayImageView setExclusiveTouch:YES];
            backgroundImageView.frame = CGRectMake((i % 2)*130 + 10, l*141 + 30, 120, 131);
            [displayView addSubview:backgroundImageView];
            
            UIImageView *rearImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"public_middle_content_img_normal.png"]];
            [rearImageView setImageWithURL:[NSURL URLWithString:model.lbImage] placeholderImage:[UIImage imageNamed:@"public_middle_content_img_normal.png"]];
            rearImageView.frame = CGRectMake(10, 8, 100, 100);
            rearImageView.tag = 100 + i;
            [backgroundImageView addSubview:rearImageView];
            
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, backgroundImageView.bounds.size.height - 23, 100, 20)];
            nameLabel.text = model.content;
            nameLabel.font = [UIFont systemFontOfSize: 14.0];
            nameLabel.tag = 200 + i;
            nameLabel.backgroundColor = [UIColor clearColor];
            nameLabel.textColor = [UIColor colorWithRed:148.0/255 green:104.0/255 blue:97.0/255 alpha:1.0];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            [backgroundImageView addSubview:nameLabel];
        }
        
        displayView.contentSize = CGSizeMake(0, displayImageView.frame.origin.y + displayImageView.bounds.size.height + 10);
    }
}

#pragma mark -
#pragma mark - 点击方法

-(void)chooseScratch:(id)sender
{
    self.moreView.hidden = YES;
    guiZeView.hidden = YES;
    [self cancleIndicateShareView];
    
    UITapGestureRecognizer* kaiGuaTap = (UITapGestureRecognizer*)sender;
    PRJ_GuaGuaLeListModel *model;
    if (guaGuaArray.count > 0) {
       model = guaGuaArray[kaiGuaTap.view.tag - 10];
    }
    
    if ( [shf intValue] == 2) {
        if ([jiFenString isKindOfClass:[NSNull class]]) {
            jiFenString = @"0";
        }
        xiaoFeiLabel.text = [NSString stringWithFormat:@"消费%@个积分", spendMoney];
        xiaoFeiTiShiView.hidden = NO;
    } else {
        ZHKaiGuaViewController *kaiGua = [[ZHKaiGuaViewController alloc] init];
        kaiGua.fanweiString = model.fanWei;
        kaiGua.classidString = model.classId;
        kaiGua.ggImageString = model.ggImage;
        [self.navigationController pushViewController:kaiGua animated:YES];
        
    }
}

#pragma mark -
#pragma mark - 按钮方法
- (IBAction)quXIaoButton:(id)sender {
    xiaoFeiTiShiView.hidden = YES;
}

- (IBAction)duiHuanButton:(id)sender
{
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    } else {
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI guaGuaLeExchangeJiFenForChangcesWithUserid:kkUserId]];
        mainRequest.tag = 101;
        [self showMsg:nil];

    }
}

//规则
- (IBAction)guiZeButton:(id)sender {
    _moreView.hidden = !_moreView.hidden;
    [self cancleIndicateShareView];
    guiZeView.hidden = YES;
}

- (IBAction)guiZeHuiButtom:(id)sender
{
    guiZeView.hidden = YES;
}

#pragma mark - 按钮点击事件
#pragma mark 分享
- (IBAction)shareBtnAction:(id)sender {
    _moreView.hidden = YES;
    [self shareContentRequest];
}

#pragma mark 帮助
- (IBAction)helpBtnAction:(id)sender {
    [self cancleIndicateShareView];
    _moreView.hidden = YES;
    guiZeView.hidden = NO;
}

//返回
- (IBAction)backtrackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//确定是否兑换刮刮乐
- (IBAction)duiHuanQuxiaoButton:(id)sender {
}

- (IBAction)duiHuanQueDingButton:(id)sender {
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self cancleIndicateShareView];
    self.moreView.hidden = YES;
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
