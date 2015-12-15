//
//  RechargeViewController.m
//  MarketManage
//
//  Created by 许文波 on 15/7/29.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "RechargeViewController.h"
#import "MarketAPI.h"
#import "LBase64.h"
@interface RechargeViewController ()

@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.mallTitleLabel.text =  @"手机充值";
    [self webView];
    // Do any additional setup after loading the view.
}
/** 网页 */
-(void)webView{
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    [self.view addSubview:webview];
    NSString *base64ID = [LBase64 encodeBase64String:@"12345"];
    NSLog(@"%@",base64ID);
    
//    NSString *urlStr = [NSString stringWithFormat:@"%@userId=%@productKey=%@",ReCharge,base64ID,PROINDEN];
//    NSLog(@"%@",urlStr);
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSURLRequest *req = [NSURLRequest requestWithURL:url];
//    [webview loadRequest:req];
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
