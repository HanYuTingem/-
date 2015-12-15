//
//  BoActivityViewController.m
//  MarketManage
//
//  Created by 许文波 on 15/5/6.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "BoActivityViewController.h"
#import "ZXYIndicatorView.h"
#import "ZXYWarmingView.h"
#import "LSYHomePageViewController.h"
#import "ZXYClassifierListViewController.h"
#import "LSYSeckillingListViewController.h"

@interface BoActivityViewController () <UIWebViewDelegate>
{
    ZXYIndicatorView *indicatorView; // 加载提示框
    ZXYWarmingView *warmingView; // 警告提示框
    UIWebView *_activityWebView; // webview
}

//@property (weak, nonatomic) IBOutlet UIWebView *activityWebView;
@end

@implementation BoActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    indicatorView = [ZXYIndicatorView shareInstance];
    warmingView = [ZXYWarmingView shareInstance];
    self.mallTitleLabel.text = @"女性专区";
    
    self.rightButton.frame = CGRectMake(SCREENWIDTH - 100, 20, 80, 44);
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.rightButton setTitle:@"进入商城" forState:UIControlStateNormal];
    [self.rightButton setTitle:@"进入商城" forState:UIControlStateHighlighted];
}

// 重写右键方法
- (void)rightBackCliked:(UIButton *)sender
{
    LSYHomePageViewController  * homeContrl = [[LSYHomePageViewController alloc]initWithNibName:@"LSYHomePageViewController" bundle:nil];
    [self.navigationController pushViewController:homeContrl animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    _activityWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    [self.view addSubview:_activityWebView];
    [_activityWebView setUserInteractionEnabled:YES];
    _activityWebView.scalesPageToFit = YES;
    _activityWebView.scrollView.showsVerticalScrollIndicator = NO;
    _activityWebView.delegate = self;
    _activityWebView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    
    //加载网址
    NSString* path = @"http://192.168.10.210:8099/index.php/shop";
    NSURL* url = [NSURL URLWithString:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [_activityWebView loadRequest:request];
    [indicatorView showIndicator];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

// webview加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [indicatorView hideIndicator];
    [warmingView showMsg:@"加载失败"];
}

// webview加载完成调用的方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [indicatorView hideIndicator];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* urlStr= [[request URL] absoluteString];
    urlStr = [urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"activity url = %@", urlStr);
    
    if ([self parseUrlWithUrlString:urlStr] != nil) { // 链接是否带参数
        NSMutableDictionary *urlDic = [NSMutableDictionary dictionaryWithDictionary:[self parseUrlWithUrlString:urlStr]];
        // 判断跳转类型
        switch ([urlDic[@"type"] intValue]) {
            case 7: // 商城首页
                {
                    LSYHomePageViewController  * homeContrl = [[LSYHomePageViewController alloc]initWithNibName:@"LSYHomePageViewController" bundle:nil];
                    [self.navigationController pushViewController:homeContrl animated:YES];
                }
                break;
            case 8: // 商城分类
                {
                    ZXYClassifierListViewController *classifierVC = [[ZXYClassifierListViewController alloc] initWithNibName:@"ZXYClassifierListViewController" bundle:nil];
                    classifierVC.cat_id = urlDic[@"gid"];
                    classifierVC.fromAppBanner = YES;
                    [self.navigationController pushViewController:classifierVC animated:YES];
                }
                break;
            case 9: // 商品详情
                {
                    LSYGoodsInfoViewController * goodsVC = [[LSYGoodsInfoViewController alloc] initWithNibName:@"LSYGoodsInfoViewController" bundle:nil];
                    goodsVC.goods_id = urlDic[@"gid"];
                    [self.navigationController pushViewController:goodsVC animated:YES];
                }
                break;
            case 10: // 商城活动
                {
                    LSYSeckillingListViewController *lsyVC = [[LSYSeckillingListViewController alloc] initWithNibName:@"LSYSeckillingListViewController" bundle:nil];
                    lsyVC.miaoShaID = urlDic[@"gid"];
                    lsyVC.childMiaoShaID = urlDic[@"fid"];
                    [self.navigationController pushViewController:lsyVC animated:YES];
                }
                break;
            default:
                break;
        }
        return NO;
    }
    
    return YES;
}

// 把请求url解析成字典
- (NSMutableDictionary*)parseUrlWithUrlString:(NSString*)url
{
    //获取问号的位置，问号后是参数列表
    NSRange range = [url rangeOfString:@"?"];
    if (range.length > 0) {
        //获取参数列表
        NSString *propertys = [url substringFromIndex:(int)(range.location + 1)];
        //进行字符串的拆分，通过&来拆分，把每个参数分开
        NSArray *subArray = [propertys componentsSeparatedByString:@"&"];
        //把subArray转换为字典
        //tempDic中存放一个URL中转换的键值对
        NSMutableDictionary *urlDic = [NSMutableDictionary dictionaryWithCapacity:4];
        for (int j = 0 ; j < subArray.count; j++) {
            //在通过=拆分键和值
            NSArray *dicArray = [subArray[j] componentsSeparatedByString:@"="];
            //给字典加入元素
            [urlDic setObject:dicArray[1] forKey:dicArray[0]];
        }
        NSLog(@"参数字典：\n%@", urlDic);
        return urlDic;
    } else return nil;
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
