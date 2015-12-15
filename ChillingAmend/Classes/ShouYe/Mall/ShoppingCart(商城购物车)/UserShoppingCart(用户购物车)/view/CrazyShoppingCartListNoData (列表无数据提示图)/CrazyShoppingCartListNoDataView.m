//
//  CrazyShoppingCartListNoDataView.m
//  MarketManage
//
//  Created by fielx on 15/4/21.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyShoppingCartListNoDataView.h"
#import "CrazyNavigationController.h"
#import "AppDelegate.h"
#import "LSYHomePageViewController.h"

@implementation CrazyShoppingCartListNoDataView

-(instancetype)initWithFrame:(CGRect)frame imageString:(NSString *)imageString
{
    self = [super initWithFrame:frame imageString:imageString];
    if (self) {
        
        
        UIImage *image = [UIImage imageNamed:@"shopCar_mall_content_btn_normal"];
        self.mButton.frame = CGRectMake(0, CGRectGetMaxY(self.mContentLabel.frame)+18, image.size.width, image.size.height);
//        [self.mButton crazyButtonSetNormalImage:@"mall_content_btn_normal" highlightedImage:@"mall_content_btn_selected" normalString:@"去逛逛" highlightedString:@"去逛逛" normalTextColor:C1 highlightedTextColor:C8];
        
        [self.mButton setBackgroundImage:[UIImage imageNamed:@"shopCar_mall_content_btn_normal"] forState:UIControlStateNormal];
        [self.mButton setTitleColor:C1 forState:UIControlStateNormal];
        [self.mButton setTitle:@"去逛逛" forState:UIControlStateNormal];
        [self.mButton setTitle:@"去逛逛" forState:UIControlStateHighlighted];
        [self.mButton setTitleColor:C8 forState:UIControlStateHighlighted];

        [CrazyBasisFrameTool CrazyBasisFrameToolSubCenter:CrazyBasisFrameToolRelativePositionHorizontalCenter superView:self suberView:self.mButton];
     
        self.mTitleLabel.text = @"购物车空空如也(T_T)";
        self.mContentLabel.text = @"快去挑选喜欢的宝贝吧";
        
        
    }
    return self;
}


-(void)tapButton:(CrazyBasisButton *)button
{
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushLSYHomePageViewController" object:nil];
    
//    AppDelegate *app = [[UIApplication sharedApplication] keyWindow].rootViewController;
    
    //从 Nav 站中移除 购物车
    CrazyNavigationController *nav = (CrazyNavigationController *)[self viewController].navigationController;
//    nav.backNumber = 1;
    
    GAHomeTabBarController *tabbar = [GAHomeTabBarController sharedHomeTabBarController];
    [tabbar selectTabBarAtIndex:2];
    [tabbar.homeTabBar selectTabBarAtIndex:2];
    [nav popToRootViewControllerAnimated:YES];
}

@end
