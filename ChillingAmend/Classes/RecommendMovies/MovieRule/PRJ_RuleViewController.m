//
//  PRJ_RuleViewController.m
//  ChillingAmend
//
//  Created by svendson on 14-12-19.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "PRJ_RuleViewController.h"
#import "GTMBase64.h"
@interface PRJ_RuleViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *web;
@end

@implementation PRJ_RuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"规则"];
    
    if (![GCUtil connectedToNetwork]) {
        [self showStringMsg:@"网络连接失败" andYOffset:0];
    } else {
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI ruleType:@"1"]];
        [self showMsg:nil];
    }
}

- (void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    [self hide];

    NSDictionary *dic = [aString JSONValue];
    if (dic) {
        _web.dataDetectorTypes = UIDataDetectorTypeNone;
        if ([dic[@"code"] integerValue] == 0) {
            NSDictionary *dicStr = dic[@"result"];
            NSString *guize = dicStr[@"content"];
            NSData *dataStr = [GTMBase64 decodeString:guize];
            NSString *str = [[NSString alloc]initWithData:dataStr encoding:NSUTF8StringEncoding];
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
