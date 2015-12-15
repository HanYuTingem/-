//  奖品详情页面
//  PrizeDetailMessageViewController.m
//  ChillingAmend
//
//  Created by 许文波 on 14/12/26.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "PrizeDetailMessageViewController.h"

@interface PrizeDetailMessageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *prizeImageView; // 奖品图片
@property (weak, nonatomic) IBOutlet UILabel *prizeNameLabel; // 奖品名称
@property (weak, nonatomic) IBOutlet UILabel *prizeTimeLabel; // 奖品的时间
@property (weak, nonatomic) IBOutlet UILabel *contactLabel; // 联系人
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel; // 电话
@property (weak, nonatomic) IBOutlet UILabel *addressLabel; // 地址
@property (weak, nonatomic) IBOutlet UILabel *lingqu_typeLabel; // 领取方式
@property (weak, nonatomic) IBOutlet UILabel *getPrizeTimeLabel; // 领取奖品时间
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel; // 备注
@property (weak, nonatomic) IBOutlet UIButton *prizeStatusButton; // 奖品的状态

@end

@implementation PrizeDetailMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 导航栏
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"领取奖品"];
    [self addRightBarButtonItemWithImageName:@"" andTargate:@selector(sharedPrize:) andRightItemFrame:CGRectMake(SCREENWIDTH - 10 - 45, 31, 60, 23) andButtonTitle:@"分享" andTitleColor:kkRColor];
    
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    } else {
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI prizeType:@"1" andPrizeId:_prizeId andDay:@""]];
    }
}

#pragma mark 分享
- (void)sharedPrize:(id)sender
{
    self.shareContent = [NSString stringWithFormat:@"伙伴们!我在黑土app里中奖啦!奖品%@，快跟我一起加入黑土,赢好礼吧 (来自于黑土App) http://ht.sinosns.cn/", _prizeNameLabel.text];
    [self callOutShareViewWithUseController:self andSharedUrl:@"http://ht.sinosns.cn/"];
}

#pragma mark - 点击空白处
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

#pragma mark GCRequestDelegate
- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    NSLog(@"detail = %@", aString);
    [self hide];
    NSMutableDictionary *dict = [aString JSONValue];
    if ( !dict ) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
        return;
    }
    if ([[dict objectForKey:@"code"]isEqual:@"0"]) {
        [_prizeImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", img_url, [dict valueForKey:@"img"]]] placeholderImage:[UIImage imageNamed:@"defaultimg_content_img"]];
        [_prizeNameLabel setText:[dict valueForKey:@"name"]];
        [_prizeTimeLabel setText:[NSString stringWithFormat:@"有效期：%@ 至 %@", [dict valueForKey:@"create_time"], [dict valueForKey:@"end_time"]]];
        [_lingqu_typeLabel setText:[dict valueForKey:@"lingqu_type"]];
        [_contactLabel setText:[dict valueForKey:@"addressee"]];
        [_phoneLabel setText:[dict valueForKey:@"tel"]];
        [_getPrizeTimeLabel setText:[dict valueForKey:@"time"]];
        [_remarkLabel setText:[dict valueForKey:@"remark"]];
        [_addressLabel setText:[dict valueForKey:@"address"]];
        CGSize size = [GCUtil changeSize:_remarkLabel.text andSize:CGSizeMake(259, MAXFLOAT) andFontSize:15.0f];
        _remarkLabel.frame = CGRectMake(ORIGIN_X(_remarkLabel), ORIGIN_Y(_remarkLabel), size.width, size.height);
        //        _remarkLabel.frame = [GCUtil changeLabelFrame:_remarkLabel andSize:CGSizeMake(259, MAXFLOAT) andFontSize:[UIFont systemFontOfSize:13.0f]];
        if ([[dict valueForKey:@"status"]isEqual:@"1"]) { // 未领取
            [_prizeStatusButton setTitle:@"未领取" forState:UIControlStateNormal];
        } else if ([[dict valueForKey:@"status"]isEqual:@"2"]) { // 已领取
            [_prizeStatusButton setTitle:@"已领取" forState:UIControlStateNormal];
        } else if ([[dict valueForKey:@"status"]isEqual:@"3"]) { // 领取中
            [_prizeStatusButton setTitle:@"领取中" forState:UIControlStateNormal];
        } else if ([[dict valueForKey:@"status"]isEqual:@"4"]) {
            [_prizeStatusButton setTitle:@"已过期" forState:UIControlStateNormal];
        }
    } else {
        [self showStringMsg:@"网络连接失败！" andYOffset:0];
    }
}

- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self hide];
    NSLog(@"%@", aError);
    [self showStringMsg:@"网络连接失败！" andYOffset:0];
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
