//
//  CJFAQViewController.m
//  MarketManage
//
//  Created by 赵春景 on 15-7-28.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CJFAQViewController.h"
#import "ZXYIndicatorView.h"
#import "ZXYWarmingView.h"

@interface CJFAQViewController () <UIWebViewDelegate>

{
    /** 加载提示框 */
    ZXYIndicatorView *_indicatorView;
    /** 警告提示框 */
    ZXYWarmingView *_warmingView;
    
    UIWebView *_fAQWebView;
    
}

@end

@implementation CJFAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _indicatorView = [ZXYIndicatorView shareInstance];
    _warmingView = [ZXYWarmingView shareInstance];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    _fAQWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    [self.view addSubview:_fAQWebView];
    [_fAQWebView setUserInteractionEnabled:YES];
    _fAQWebView.scalesPageToFit = YES;
    _fAQWebView.scrollView.showsVerticalScrollIndicator = NO;
    _fAQWebView.delegate = self;
    _fAQWebView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    
    //加载网址
    NSString* path = @"http://mall.sinosns.cn/index.php/shop/faq";
    NSURL* url = [NSURL URLWithString:path];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    /** 数据缓存 */
//    [request setCachePolicy:NSURLRequestReturnCacheDataElseLoad];

    [_fAQWebView loadRequest:request];
    [_indicatorView showIndicator];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_indicatorView hideIndicator];
    [_warmingView showMsg:@"加载失败"];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_indicatorView hideIndicator];
}



@end
