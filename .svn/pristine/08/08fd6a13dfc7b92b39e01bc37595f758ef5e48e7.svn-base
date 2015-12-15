//
//  GCRequest.m
//  aiGuoShi
//
//  Created by dreamRen on 13-3-19.
//  Copyright (c) 2013年 dreamRen. All rights reserved.
//

#import "GCRequest.h"
#import <QuartzCore/QuartzCore.h>
#import "Reachability.h"
//#import "GCUtil.h"
//#import "BuGeiLiView.h"

@implementation GCRequest

@synthesize delegate;
@synthesize tag,isRequest;

//是否连网, yes是, no否
-(BOOL)connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags){
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

-(void)showBuGiLiInfo
{
    NSUserDefaults *tInfo= [NSUserDefaults standardUserDefaults];
    if ([tInfo objectForKey:@"bugeili"]) {
        return ;
    }
//    UIWindow *tWindow = [UIApplication sharedApplication].keyWindow;
//    BuGeiLiView *tView = [[BuGeiLiView alloc] initWithFrame:tWindow.bounds];
//    [tWindow addSubview:tView];
//    [tView release];
    [self.lkIndicatorDelegate stopIndicatorDelegate];
}

-(void)finishFHL
{
    [self.lkIndicatorDelegate stopIndicatorDelegate];
    if (mFHLView) {
        [mFHLView removeFromSuperview];
        mFHLView=nil;
    }
}

-(void)loadFHL:(UIView*)aView
{
    [self finishFHL];
    mFHLView = [[UIView alloc] initWithFrame:aView.bounds];
    mFHLView.backgroundColor = [UIColor clearColor];
    [aView addSubview:mFHLView];
    [mFHLView release];

    UIView *tView = [[UIView alloc] initWithFrame:CGRectMake((mFHLView.frame.size.width-50)/2, (mFHLView.frame.size.height-50)/2, 50, 50)];
//    tView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
    tView.backgroundColor = [UIColor clearColor];
    tView.layer.cornerRadius = 6;
    tView.layer.masksToBounds = YES;
    [mFHLView addSubview:tView];
    [tView release];
    
    UIActivityIndicatorView *tActView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    tActView.frame = CGRectMake((mFHLView.frame.size.width-37)/2, (mFHLView.frame.size.height-37)/2, 37, 37);
    [mFHLView addSubview:tActView];
    [tActView release];
    [tActView startAnimating];
}

-(void)beginHttpRequest:(NSString*)aHttpString withMethod:(NSUInteger)aMethod withFHLView:(UIView*)aView{
//    [self.lkIndicatorDelegate startIndicatorDelegateWithContent:@"正在加载中..."];
    NSLog(@"--%@",aHttpString);
    if (isRequest) {
        [mRequest clearDelegatesAndCancel];
        isRequest=NO;
    }
    
    if (![self connectedToNetwork]) {
        //网络不通
        [self showBuGiLiInfo];
        return ;
    }
    
    if (aView) {
        [self loadFHL:aView];
    }
    isRequest=YES;
    mRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[aHttpString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    mRequest.timeOutSeconds=60;
//    mRequest.shouldAttemptPersistentConnection = NO;
    mRequest.delegate=self;
    if (aMethod == 0) {
        //GET请求
        mRequest.requestMethod=@"GET";
    }else if (aMethod == 1) {
        //POST请求
        mRequest.requestMethod=@"POST";
    }
//    [mRequest addRequestHeader:@"User-Agent" value:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:18.0) Gecko/20100101 Firefox/18.0"];
//    [mRequest addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [mRequest startAsynchronous];
}

//上传图片的
-(void)beginImageHttpRequest:(NSString*)aHttpString withMethod:(NSUInteger)aMethod withFHLView:(UIView*)aView
{
    [self.lkIndicatorDelegate startIndicatorDelegateWithContent:@"正在加载中..."];
    NSLog(@"%@",aHttpString);
    if (isRequest) {
        [mRequest clearDelegatesAndCancel];
        isRequest=NO;
    }
    
    if (![self connectedToNetwork]) {
        //网络不通
        [self showBuGiLiInfo];
        return ;
    }
    
    if (aView) {
        [self loadFHL:aView];
    }
    isRequest=YES;
    
    aHttpString = [aHttpString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    NSURL * test = [NSURL URLWithString:aHttpString];
    
    NSLog(@"url = %@",test);
    mRequest = [ASIFormDataRequest requestWithURL:test];
    mRequest.timeOutSeconds=60;
    mRequest.delegate=self;
    if (aMethod == 0) {
        //GET请求
        mRequest.requestMethod=@"GET";
    }else if (aMethod == 1) {
        //POST请求
        mRequest.requestMethod=@"POST";
    }
    //    [mRequest addRequestHeader:@"User-Agent" value:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:18.0) Gecko/20100101 Firefox/18.0"];
    //    [mRequest addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [mRequest startAsynchronous];
}

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    NSLog(@"GC code == %d ,message == %@",request.responseStatusCode,request.responseStatusMessage);
    if (request.responseStatusCode == 404) {
        [request clearDelegatesAndCancel];
        
        [self finishFHL];
        isRequest=NO;
        
        if (delegate && [delegate respondsToSelector:@selector(GCRequest:Error:)]) {
            [delegate performSelector:@selector(GCRequest:Error:) withObject:self withObject:@""];
        }
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *tEndString = [[[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding] autorelease];
    tEndString= [tEndString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    [self finishFHL];
    isRequest=NO;
    if (delegate && [delegate respondsToSelector:@selector(GCRequest:Finished:)]) {
        [delegate performSelector:@selector(GCRequest:Finished:) withObject:self withObject:tEndString];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self finishFHL];
    isRequest=NO;
    if (delegate && [delegate respondsToSelector:@selector(GCRequest:Error:)]) {
        [delegate performSelector:@selector(GCRequest:Error:) withObject:self withObject:@""];
    }
    [self.lkIndicatorDelegate stopIndicatorDelegate];
}

//发起get请求
-(void)requestHttpWithGet:(NSString*)aHttpString
{
    [self beginHttpRequest:aHttpString withMethod:0 withFHLView:nil];
}

-(void)requestHttpWithGet:(NSString*)aHttpString withFHLView:(UIView*)aView
{
    [self beginHttpRequest:aHttpString withMethod:0 withFHLView:aView];
}

//发起post请求
-(void)requestHttpWithPost:(NSString*)aHttpString
{
    [self.lkIndicatorDelegate startIndicatorDelegateWithContent:@"正在加载中..."];
     [self beginHttpRequest:aHttpString withMethod:1 withFHLView:nil];
}

//发起post请求没有loading页
-(void)requestHttpWithPostNoLoading:(NSString*)aHttpString
{
    [self beginHttpRequest:aHttpString withMethod:1 withFHLView:nil];
}

-(void)requestHttpWithPosttoo:(NSString*)aHttpString
{
    [self beginHttpRequest:aHttpString withMethod:1 withFHLView:nil];
}

//发起Imagepost请求
-(void)requestImageHttpWithPost:(NSString*)aHttpString
{
    [self beginImageHttpRequest:aHttpString withMethod:1 withFHLView:nil];
}

-(void)requestHttpWithPost:(NSString*)aHttpString withFHLView:(UIView*)aView
{
    [self beginHttpRequest:aHttpString withMethod:1 withFHLView:aView];
}

-(void)requestHttpWithPost:(NSString*)aHttpString withDict:(NSMutableDictionary*)aDict withFHLView:(UIView*)aView
{
    if (isRequest) {
        [mRequest clearDelegatesAndCancel];
        isRequest=NO;
    }
    
    if (![self connectedToNetwork]) {
        //网络不通
        return ;
    }
    
    if (aView) {
        [self loadFHL:aView];
    }
    
    isRequest=YES;
    mRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[aHttpString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    if ([[aDict objectForKey:@"por"] isEqualToString:@"403"]) { // 广告页面延迟时间
        mRequest.timeOutSeconds = 10;
    } else mRequest.timeOutSeconds = 30;
    mRequest.delegate=self;
    mRequest.requestMethod=@"POST";
    if (aDict!=nil) {
        for(NSString *key in aDict){
            id value = [aDict objectForKey:key];
            [mRequest setPostValue:value forKey:key];
        }
    }
//    [mRequest addRequestHeader:@"User-Agent" value:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:18.0) Gecko/20100101 Firefox/18.0"];
    [mRequest addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [mRequest startAsynchronous];
}

-(void)requestHttpWithPost:(NSString*)aHttpString withDict:(NSMutableDictionary*)aDict
{
    [self.lkIndicatorDelegate startIndicatorDelegateWithContent:@"正在加载中..."];
    [self requestHttpWithPost:aHttpString withDict:aDict withFHLView:nil];
}

-(void)cancelRequest
{
    if (isRequest) {
        [self.lkIndicatorDelegate stopIndicatorDelegate];
        [mRequest clearDelegatesAndCancel];
        isRequest=NO;
        [self finishFHL];
    }
}

-(id)init
{
    self = [super init];
    if (self) {
        isRequest=NO;
    }
    return self;
}

-(void)dealloc{
    
    if (isRequest) {
        [mRequest clearDelegatesAndCancel];
    }
    [_lkIndicatorDelegate release];
    [delegate release];
    [super dealloc];
}

+(void)requestHttpWithGet:(NSString*)aHttpString
{
    ASIFormDataRequest *tRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[aHttpString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    //GET请求
    tRequest.requestMethod=@"GET";
    [tRequest startAsynchronous];
}

@end
