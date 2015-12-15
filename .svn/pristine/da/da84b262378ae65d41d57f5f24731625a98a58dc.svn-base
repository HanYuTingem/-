//
//  HomeViewController.m
//  PRJ_NiceFoodModule
//
//  Created by 张恭豪 on 15/6/15.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "HomeViewController.h"
#import "NiceFoodViewController.h"
#import "StarsView.h"
#import "TakeoutViewController.h"
#import "AccountViewController.h"
#import "AddressViewController.h"
#import "OrderInformationViewController.h"
#import "PayModelViewController.h"
#import "CashierDeskViewController.h"
#import "OrderPutinViewController.h"
#import "LoginViewController.h"
#import "CouponViewController.h"
#import "MyTakeoutOrderViewController.h"
#import "MyBookSeatViewController.h"
#import "MyCouponViewController.h"
#import "SSCollectionViewController.h"
#import "ListTableViewController.h"

@interface HomeViewController ()
@property (nonatomic, strong) AppDelegate *appDelegate;
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    [self.appDelegate.homeTabBarController hideTabBarAnimated:YES];
    [self addButton];
    
    titleButton.hidden = NO;
    [titleButton setTitle:@"美食中心" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [returnButton setImage:[UIImage imageNamed:@"msxq_0013_title_back"] forState:UIControlStateHighlighted];
    [returnButton setImage:[UIImage imageNamed:@"msxq_0013_title_back"] forState:UIControlStateNormal];
    
    self.view.backgroundColor  = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GotoNiceFood) name:@"GotoNiceFood" object:nil];
}

- (void)GotoNiceFood{
    NiceFoodViewController *vc = [[NiceFoodViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addButton{
    
    CGFloat btnW = SCREEN_WIDTH - 2*PADDING;
    CGFloat bthH = 50;
    CGFloat btnY = 80;
    
    NSArray * titleArray = @[@"美食",@"我的订座",@"我的优惠券",@"我的收藏",@"我的外卖",];//@"商户详情"
    for (int i=0; i<titleArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(PADDING, i*(bthH+10)+btnY, btnW, bthH);
        button.layer.cornerRadius = 5.0f;
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor orangeColor];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 6000 + i;
        button.titleLabel.font = [UIFont fontWithName:@"SimHei" size:14.0f];
        [self.view addSubview:button];
    }

        

}

- (void)buttonClick:(UIButton*)sender{
    switch (sender.tag) {
        case 6000:
        {
            NiceFoodViewController *vc = [[NiceFoodViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6001:
        {
            if (UserId) {
                MyBookSeatViewController * list = [[MyBookSeatViewController alloc]init];
                [self.navigationController pushViewController:list  animated:YES];
            } else {
                LoginViewController *vc = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }     
        }
            break;
        case 6002:
        {
           
            if (UserId) {
                MyCouponViewController * list = [[MyCouponViewController alloc]init];
                [self.navigationController pushViewController:list  animated:YES];
            } else {
                LoginViewController *vc = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case 6003:
        {
            if (UserId) {
                SSCollectionViewController * list = [[SSCollectionViewController alloc]init];
                list.oId = UserId;
                [self.navigationController pushViewController:list  animated:YES];
            } else {
                LoginViewController *vc = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }

            
        }
            break;
            
        case 6004:
        {
            if (UserId) {
                MyTakeoutOrderViewController *niceFood = [[MyTakeoutOrderViewController alloc] init];
                [self.navigationController pushViewController:niceFood animated:YES];
            } else {
                LoginViewController *vc = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
//        case 6005:
//        {
//            LoginViewController * login = [[LoginViewController alloc]init];
//            [self.navigationController pushViewController:login  animated:YES];
//        }
//            break;
            
//        case 6006:
//        {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://18600601821"]];
//        }
//            break;
        default:
            break;
    }
}


- (void)clickButton:(UIButton *)button{
    
    
    
    
}

- (void)clickButton2:(UIButton *)button{
    
    MyTakeoutOrderViewController *niceFood = [[MyTakeoutOrderViewController alloc] init];
    [self.navigationController pushViewController:niceFood animated:YES];
    
    
}

- (void)clickButton3:(UIButton *)button{
    
    CashierDeskViewController *acc = [[CashierDeskViewController alloc] init];

    [self.navigationController pushViewController:acc animated:YES];
    
    
}

- (void)clickButton4:(UIButton *)button{
    
    LoginViewController *acc = [[LoginViewController alloc] init];
    
    [self.navigationController pushViewController:acc animated:YES];
    
    
}

- (void)clickButton5:(UIButton *)button{
    
    OrderPutinViewController *acc = [[OrderPutinViewController alloc] init];
    
    [self.navigationController pushViewController:acc animated:YES];
    
    
}

- (void)clickButton6:(UIButton *)button{
    
    CouponViewController *acc = [[CouponViewController alloc] init];
    
    [self.navigationController pushViewController:acc animated:YES];
    
    
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
