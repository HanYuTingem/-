//
//  LSYMarketNavigationViewController.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/12.
//  Copyright (c) 2015年 Rice. All rights reserved.
//
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define IWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 导航栏标题字体
#define IWNavigationBarTitleFont [UIFont boldSystemFontOfSize:16]

// 导航栏按钮文字颜色
#define IWBarButtonTitleColor (iOS7 ? IWColor(61, 66, 69) : IWColor(61, 66, 69))

// 导航栏按钮文字字体
#define IWBarButtonTitleFont (iOS7 ? [UIFont systemFontOfSize:15] : [UIFont boldSystemFontOfSize:12])
#define IWBarButtonTitleDisabledColor IWColor(208, 208, 208)
#import "LSYMarketNavigationViewController.h"
#import "UIBarButtonItem+IW.h"



@interface LSYMarketNavigationViewController ()

@end

@implementation LSYMarketNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];    
}

+ (void)initialize
{
    // 1.设置导航栏主题
    [self setupNavBarTheme];
    
    // 2.设置导航栏按钮的主题
    [self setupBarButtonTheme];
}


/**
 *  设置导航栏按钮的主题
 */
+ (void)setupBarButtonTheme
{
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    // 1.设置按钮的文字样式
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[UITextAttributeTextColor] = IWBarButtonTitleColor;
    attrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
    attrs[UITextAttributeFont] = IWBarButtonTitleFont;
    [barItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:attrs forState:UIControlStateHighlighted];
    
    NSMutableDictionary *disableAttrs = [NSMutableDictionary dictionary];
    disableAttrs[UITextAttributeTextColor] = IWBarButtonTitleDisabledColor;
    disableAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
    [barItem setTitleTextAttributes:disableAttrs forState:UIControlStateDisabled];
    
}

/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme
{
    
//    UINavigationBar *navBar = [UINavigationBar appearance];
//    [navBar setBackgroundColor:[UIColor redColor]];

}



-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"title_btn_back" higlightedImage:@"title_btn_back" target:self action:@selector(back)];
    }
     [super pushViewController:viewController animated:animated];
}



/**
 *  返回
 */

- (void)back
{
    [self popViewControllerAnimated:YES];
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
