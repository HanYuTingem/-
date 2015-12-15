//
//  ActivityRuleViewController.m
//  LaoYiLao
//
//  Created by sunsu on 15/11/2.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "ActivityRuleViewController.h"
#import "ActivityRuleView.h"
#import "BarView.h"
@interface ActivityRuleViewController ()<UIWebViewDelegate>
{
    ActivityRuleView * _actRuleView;//活动规则view
    
    UIWebView *_webView;
    UIActivityIndicatorView * activityIndicator;
}
@end

@implementation ActivityRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self changeBarTitleWithString:@"活动规则"];
    self.navigationController.navigationBar.hidden = YES;
    self.customNavigation.shareButton.hidden = YES;
    self.customNavigation.rightButton.hidden = YES;
    
//    [self initUI];
    [self createWebView];
}



//- (void) initUI{
//    _actRuleView = [[ActivityRuleView alloc]initWithFrame:CGRectMake(0, NavgationBarHeight, kkViewWidth, kkViewHeight-NavgationBarHeight)];
//    [self.view addSubview:_actRuleView];
//}


-(void)createWebView{
    CGFloat webView_Y = NavgationBarHeight;
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, webView_Y, kkViewWidth, kkViewHeight-webView_Y)];
    _webView.delegate = self;
//    [(UIScrollView *)[[_webView subviews] objectAtIndex:0] setBounces:NO];
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_webView];
    _webView.backgroundColor = [UIColor clearColor];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:URL_LYL_ActiveRule]];
    [_webView loadRequest:request];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
    [_webView stringByEvaluatingJavaScriptFromString:@"helloWorld(@"")"];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    NSLog(@"webViewDidFinishLoad");
    
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


#pragma navigationBarDelegate


-(void)helpBtnClicked{
}

-(void)shareBtnClicked{
    NSLog(@"分享");
}

@end
