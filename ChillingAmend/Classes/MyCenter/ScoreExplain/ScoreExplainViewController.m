//  积分说明
//  ScoreExplainViewController.m
//  ChillingAmend
//
//  Created by 许文波 on 14/12/22.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "ScoreExplainViewController.h"
#import "GTMBase64.h"

@interface ScoreExplainViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *web;
@end

@implementation ScoreExplainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 导航栏
    [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"积分说明"];
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    } else {
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI ruleType:@"2"]];
        [self showMsg:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    [self hide];
    
    NSDictionary *dic = [aString JSONValue];
    if (dic) {
        if ([dic[@"code"] integerValue] == 0) {
            NSDictionary *dicStr = dic[@"result"];
            NSString *guize = dicStr[@"content"];
            NSData *dataStr = [GTMBase64 decodeString:guize];
            NSString *str = [[NSString alloc]initWithData:dataStr encoding:NSUTF8StringEncoding];
//            UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, 320, self.view.frame.size.height - 64)];
            //            web.scalesPageToFit = YES;
            _web.dataDetectorTypes = UIDataDetectorTypeNone;
            [_web loadHTMLString:str baseURL:nil];
        } else _web.hidden = YES;
    } else {
        _web.hidden = YES;
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    }
}

- (void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    [self hide];
    _web.hidden = YES;
    [self showStringMsg:@"网络连接失败" andYOffset:0];
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
