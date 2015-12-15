//
//  WebViewController.m
//  LaoYiLao
//
//  Created by wzh on 15/11/12.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    UIActivityIndicatorView * activityIndicator;
}
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeBarTitleWithString:@"明星投票"];
    self.customNavigation.shareButton.hidden = YES;
    self.customNavigation.rightButton.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createWebView];
}

-(void)createWebView{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kkViewWidth, kkViewHeight-64)];
    _webView.scrollView.scrollEnabled = NO;
    _webView.scrollView.bounces = NO;

    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:ClickMoreUrl]];
    [_webView loadRequest:request];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
    [_webView stringByEvaluatingJavaScriptFromString:@"helloWorld(@"")"];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    NSLog(@"webViewDidFinishLoad");
    
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"href_ios"] = ^() {
        NSLog(@"-----------");
        [self.navigationController popViewControllerAnimated:YES];
    };
    
}
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kkViewWidth, kkViewHeight-64)];
    [view setTag:108];
    [view setBackgroundColor:[UIColor lightGrayColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicator setCenter:view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:activityIndicator];
    [activityIndicator startAnimating];
}


@end
