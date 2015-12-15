//  小鸟快飞
//  YNLittleBirdViewController.m
//  LeWan
//
//  Created by 刘雅楠 on 14/11/29.
//  Copyright (c) 2014年 李祖浩. All rights reserved.
//

#import "YNLittleBirdViewController.h"
#import "GTMBase64.h"

@interface YNLittleBirdViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *littleBirdWebView;  // 加载游戏的webview

@end

@implementation YNLittleBirdViewController

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (mainRequest) {
        [mainRequest cancelRequest];
    }
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    self.littleBirdWebView = nil;
    self.view = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![GCUtil connectedToNetwork]) {
        [self setNavigationBarWithState:1 andIsHideLeftBtn:NO andTitle:@"小鸟快飞"];
        [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
        return;
    } else self.bar.hidden = YES;
    [self.view bringSubviewToFront:self.littleBirdWebView];
    self.littleBirdWebView.delegate = self;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/webgame/HTML5SHAKE/pages/?username=%@&channel=ljq_cqtv&footurl=%@", GAME_URL, kkUserName, @""]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.littleBirdWebView loadRequest:request];
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
    NSString *urlString = [[request URL] absoluteString];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"urlString=%@",urlString);
    if ([urlString isEqualToString:@"http://lewan.cn/"]) { // 返回
        [self hide];
        [self.navigationController popViewControllerAnimated:YES];
    }
    // 分享
    if ([urlString rangeOfString:@"##fengxiang"].location != NSNotFound ) {
        [self hide];
        NSString *tempStr = [[urlString componentsSeparatedByString:@"jifen="] objectAtIndex:1];
        NSString *coin = [tempStr substringToIndex:[tempStr rangeOfString:@"&time"].location];
        self.shareContent = nil;
        self.shareContent = [NSString stringWithFormat:@"我的小鸟飞了%@米高，哦~我是一只小小小小鸟...格叽格叽~~ http://ht.sinosns.cn/", coin];
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

//网页请求完成
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

//网页请求失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //请求失败后关闭风火轮
    [self hide];
    NSLog(@"Did Fail Load With Error");
    self.bar.hidden = NO;
    [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
