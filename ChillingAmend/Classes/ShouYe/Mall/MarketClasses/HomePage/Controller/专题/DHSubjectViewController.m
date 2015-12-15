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
@interface DHSubjectViewController ()<UIWebViewDelegate>
{
    int _count;
    UIButton *btn;
    NSURLRequest *requestStr ;
    NSURLRequest *req;
    ZXYIndicatorView *indicatorView;
}
@end

@implementation DHSubjectViewController

//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];
//}
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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self ) {
        _count = 0;
    }
    return self;
}
/** 网页 */
-(void)webView{
    
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, SCREENWIDTH, SCREENHEIGHT - 20)];
    [self.view addSubview:webview];
    webview.tag = 7777;
    webview.delegate = self;
    
    NSLog(@"%@",kkUserCenterId);
    
    NSString *base64ID = [LBase64 encodeBase64String:kkUserCenterId];
    NSLog(@"%@",base64ID);
    [indicatorView showIndicator];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?userId=%@&productKey=%@",self.URL,base64ID,CHONGZHI];
    NSURL *url = [NSURL URLWithString:urlStr];
    //    NSURLRequest *req = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //    NSURLRequest *qq = [NSURLRequest requestWithURL:<#(NSURL *)#> cachePolicy:<#(NSURLRequestCachePolicy)#> timeoutInterval:<#(NSTimeInterval)#>]
    req = [NSURLRequest requestWithURL:url];
    
    //    req.timeoutInterval = 10.f;
    [self loadData:req];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(backDown) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 20, 44, 44);
    btn.hidden= YES;
    [self.view addSubview:btn];
}


-(void)loadData :(NSURLRequest* )urlStr{
    NSLog(@"%@",urlStr);
    
    UIWebView *webview = (UIWebView *)[self.view viewWithTag:7777];
    webview.hidden = NO;
    UIView *view= (UIView *)[self.view viewWithTag:5555];
    view.hidden = YES;
    [webview loadRequest:urlStr];
}
-(void)backDown{
    [self.navigationController popViewControllerAnimated:YES];
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
    
    if (_count==0) {
        _count++;
        btn.hidden = NO;
    }else{
        
        _count--;
        btn.hidden = YES;
    }
    NSLog(@"%d",_count);
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
