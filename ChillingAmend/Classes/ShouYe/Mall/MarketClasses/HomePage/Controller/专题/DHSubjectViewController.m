//
//  DHSubjectViewController.m
//  MarketManage
//
//  Created by 许文波 on 15/8/28.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHSubjectViewController.h"
#import "MarketAPI.h"
#import "LBase64.h"
#import "ZXYIndicatorView.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface DHSubjectViewController ()<UIWebViewDelegate>
{
    NSURLRequest *requestStr ;
    NSURLRequest *req;
    ZXYIndicatorView *indicatorView;
    UIWebView *_chongzhiwebview;
}
@end

@implementation DHSubjectViewController


-(void)dealloc{
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.mallTitleLabel.text =  @"手机充值";
    indicatorView = [ZXYIndicatorView shareInstance];
    
    self.barCenterView.hidden = YES;
    self.imageVL.hidden= YES;
    [self makeError];
    [self webView];
    // Do any additional setup after loading the view.
}

/** 网页 */
-(void)webView{
    
    
    _chongzhiwebview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, SCREENWIDTH, SCREENHEIGHT - 20)];
    [self.view addSubview:_chongzhiwebview];
    _chongzhiwebview.tag = 7777;
    _chongzhiwebview.delegate = self;
    
    NSLog(@"%@",kkUserCenterId);
    
    NSString *base64ID = [LBase64 encodeBase64String:kkUserCenterId];
    NSLog(@"%@",base64ID);
    [indicatorView showIndicator];
    
    
    //    NSString *urlStr = [NSString stringWithFormat:@"%@?userId=%@&productKey=%@",self.URL,base64ID,CHONGZHI];
    //    NSString *urlString = [[SaveMessage getAuthUserId] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString = [self encodeString:[SaveMessage getAuthUserId]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?userId=%@&productKey=%@&level=2&sys=2",self.URL,urlString,CHONGZHI];
    NSURL *url = [NSURL URLWithString:urlStr];
    //    NSURLRequest *req = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    req = [NSURLRequest requestWithURL:url];
    [self loadData:req];
    
}

- (NSString*)encodeString:(NSString*)unencodedString{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}


-(void)loadData :(NSURLRequest* )urlStr{
    NSLog(@"%@",urlStr);
    
    _chongzhiwebview.hidden = NO;
    UIView *view= (UIView *)[self.view viewWithTag:5555];
    view.hidden = YES;
    [_chongzhiwebview loadRequest:urlStr];
}

-(void)makeError{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREENWIDTH , SCREENHEIGHT - 20)];
    view.hidden = YES;
    //    view.backgroundColor = [UIColor yellowColor];
    view.tag = 5555;
    [self.view addSubview:view];
    
    
    UIImageView *leftWhat = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, SCREENWIDTH-20, SCREENHEIGHT - 130 -20)];
    leftWhat.image = [UIImage imageNamed:@"Erroe"];
    [view addSubview:leftWhat];
    //
    CGFloat whatFloat = CGRectGetMaxY(leftWhat.frame);
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(80, whatFloat+20, 45, 45);
    btnBack.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 30, 0);
    [btnBack setBackgroundImage:[UIImage imageNamed:@"baocuo_content_ico_back"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(btnDown) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat lableFloatX = btnBack.frame.origin.x;
    CGFloat labelFloatY = CGRectGetMaxY(btnBack.frame);
    CGFloat labelFloatW = btnBack.bounds.size.width;
    CGFloat lableFloatY = 20.f;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(lableFloatX, labelFloatY, labelFloatW, lableFloatY)];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.94f green:0.47f blue:0.21f alpha:1.00f];
    label.text= @"返回";
    [view addSubview:btnBack];
    [view addSubview:label];
    
    
    CGFloat btnBackFloat = CGRectGetMaxX(btnBack.frame);
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(btnBackFloat+70, whatFloat+20, 45, 45);
    //    [btn2 setTitle:@"再试一次" forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"baocuo_content_ico_again"] forState:UIControlStateNormal];
    //    btn2.titleEdgeInsets = UIEdgeInsetsMake(0, 0, -30, 0);
    [btn2 addTarget:self action:@selector(btnDown2) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn2];
    
    
    CGFloat lableBtn2FloatX = btn2.frame.origin.x;
    CGFloat labelBtn2FloatY = CGRectGetMaxY(btn2.frame);
    CGFloat labelBtn2FloatW = btn2.bounds.size.width;
    CGFloat lableBtn2FloatY = 20.f;
    
    UILabel *labelBtn2  =[[UILabel alloc] initWithFrame:CGRectMake(lableBtn2FloatX - 10, labelBtn2FloatY+20, labelBtn2FloatW+20, lableBtn2FloatY)];
    labelBtn2.textColor = [UIColor colorWithRed:0.94f green:0.47f blue:0.21f alpha:1.00f];
    labelBtn2.text = @"再试一次";
    labelBtn2.font = [UIFont boldSystemFontOfSize:14];
    labelBtn2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelBtn2];
    
    
    
}
#pragma mark  返回
-(void)btnDown{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)btnDown2{
    
    dispatch_after(2 *DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^{
        [self loadData:requestStr];
    });
    
}
#pragma  mark 代理

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [indicatorView hideIndicator];
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    __block DHSubjectViewController *actionVC = self;
    //fenx_ios('',share_content,share_url,share_img) 标题  内容  链接  图片
    context[@"goBack"] = ^() {
        [actionVC.navigationController popViewControllerAnimated:YES];
    };
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [indicatorView hideIndicator];
    UIView *view= (UIView *)[self.view viewWithTag:5555];
    view.hidden = NO;
    UIWebView *webView2 = (UIWebView *)[self.view viewWithTag:7777];
    webView2.hidden = YES;
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    requestStr = request;
    return YES;
}


@end
