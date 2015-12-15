//  接金币
//  YNAcceptGoldViewController.m
//  LeWan
//
//  Created by 刘雅楠 on 14/11/29.
//  Copyright (c) 2014年 李祖浩. All rights reserved.
//

#import "YNAcceptGoldViewController.h"
#import "GTMBase64.h"

@interface YNAcceptGoldViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *acceptGoldWebView; // 加载游戏的webview

@end

@implementation YNAcceptGoldViewController

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.acceptGoldWebView stopLoading];
    // 退出界面隐藏风火轮
    if (mainRequest) {
        [mainRequest cancelRequest];
    }
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    self.acceptGoldWebView = nil;
    self.view = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![GCUtil connectedToNetwork]) {
        [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"接金币"];
        [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
        return;
    } else self.bar.hidden = YES;
    
    [self.view bringSubviewToFront:self.acceptGoldWebView];
    
    self.acceptGoldWebView.delegate = self;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/webgame/PickUpGold-v3.0/?username=%@&channel=ljq_cqtv&footurl=%@", GAME_URL, kkUserName, @""]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.acceptGoldWebView loadRequest:request];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    //每当收到请求的时候，去打开风火轮
    [self showMsg:nil];
    NSString* urlStr = [[request URL] absoluteString];
    urlStr = [urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"urlString=%@",urlStr);
    if ([urlStr isEqualToString:@"http://lewan.cn/"]) { // 点返回键
        [self hide];
        [self.navigationController popViewControllerAnimated:YES];
    }
    // 分享
    if ([urlStr rangeOfString:@"##fengxiang"].location != NSNotFound ) {
        [self hide];
        NSString *tempStr = [[urlStr componentsSeparatedByString:@"jifen="] objectAtIndex:1];
        NSString *coin = [tempStr substringToIndex:[tempStr rangeOfString:@"&time"].location];
        self.shareContent = [NSString stringWithFormat:@"哥们儿我接了%@金币，康忙！接下来看你了~ http://ht.sinosns.cn/", coin];
        [self callOutShareViewWithUseController:self andSharedUrl:@"http://ht.sinosns.cn/"];
        return NO;
    }
    return YES;
}

//开始请求网页
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
    NSLog(@"Web View Did Start Load");
}

// 网页请求完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //请求完成后，也就是网页打开后，关闭风火轮
    [self hide];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    NSLog(@"Web View Did Finish Load");
}

// 网页请求失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //请求失败后关闭风火轮
    [self hide];
    NSLog(@"Did Fail Load With Error");
    //    returnButton.hidden = NO;
    //    backView.hidden = NO;
    [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
