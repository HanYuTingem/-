//
//  CrazyPushTool.m
//  MarketManage
//
//  Created by fielx on 15/4/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyPushTool.h"
#import <UIKit/UIKit.h>

/**
 *  购物车
 */
#import "CrazyShoppingCartViewController.h"
#import "shoppingCarViewController.h"

static CrazyPushTool *crazyPushTool = nil;


@implementation CrazyPushTool

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushInfoViewController:) name:PUSH_LSYConfirmOrderViewController object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushLSYHomePageViewController) name:PUSH_LSYHomePageViewController object:nil];
        
        
    
        
        
    }
    return self;
}



-(void)pushInfoViewController:(NSNotification *)no
{
    NSDictionary *dic = [no userInfo];
    switch ([dic[@"type"] integerValue]) {
        case 1:
            //用户订单
            [self pushLSYConfirmOrderViewController:dic];
            break;
        case 2:
            //秒杀详情
            [self pushLSYSeckillingListViewController:dic];
            break;
        case 3:
            //购物车首页
            [self pushCrazyShoppingCartViewController];
            break;
        default:
            break;
    }
}

#pragma mark 跳转用户订单
-(void)pushLSYConfirmOrderViewController:(NSDictionary *)dic
{
    
    NSLog(@"%@",dic);
    LSYConfirmOrderViewController *viewController = [[LSYConfirmOrderViewController alloc]init];
    viewController.shoppingCartArray = dic[@"info"];
    viewController.buyShopingPriceCount = dic[@"total"];
    [[self rootNavController] pushViewController:viewController animated:YES];
}




#pragma mark 跳转商城
-(void)pushLSYHomePageViewController
{
    NSLog(@"%lu",(unsigned long)[self rootNavController].viewControllers.count);
    for ( int i = 0;i < [self rootNavController].viewControllers.count;i++) {
        if ([[self rootNavController].viewControllers[i] isKindOfClass:[LSYHomePageViewController class]]) {
            LSYHomePageViewController * viewController = [self rootNavController].viewControllers[i];
            [[self rootNavController] popToViewController:viewController animated:YES];
//            viewController.scrollView.contentOffset = CGPointMake(0, 0);
            return;
        }
    }
    LSYHomePageViewController * viewController = [[LSYHomePageViewController alloc]init];
    [[self rootNavController] pushViewController:viewController animated:YES];
}



#pragma mark 秒杀详情
-(void)pushLSYSeckillingListViewController:(NSDictionary *)dic
{
    LSYSeckillingListViewController *pulishiVC = [[LSYSeckillingListViewController alloc] init];
    pulishiVC.miaoShaID=dic[@"miaoshaId"];
    pulishiVC.childMiaoShaID=dic[@"childId"];
    [[self rootNavController] pushViewController:pulishiVC animated:YES];
}

#pragma mark 购物车
-(void)pushCrazyShoppingCartViewController
{
    CrazyShoppingCartViewController *pulishiVC = [[CrazyShoppingCartViewController alloc] init];

    [[self rootNavController] pushViewController:pulishiVC animated:YES];
}




+ (CrazyPushTool *)Share
{
    if (!crazyPushTool) {
        crazyPushTool = [[CrazyPushTool alloc] init];
    }
    return crazyPushTool;
}


-(UINavigationController *)rootNavController
{
    return (UINavigationController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
}




@end

