//
//  LYQMyMallViewController.m
//  Chiliring
//
//  Created by nsstring on 14-9-9.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "LYQMyMallViewController.h"
#import "LYQManageAddressController.h"
#import "ZXYOrderListViewController.h"

#import "CJFeedbackViewController.h" //意见反馈界面
#import "CJFAQViewController.h"//常见问题界面

@interface LYQMyMallViewController ()

/** 我的订单和管理受过地址底层 */
@property (weak, nonatomic) IBOutlet UIView *bgView;

/** 我的订单 点击事件－跳转 */
- (IBAction)myOrderButtonCliked:(id)sender;

/** 我的收货地址 点击事件-跳转 */
- (IBAction)managementHarvestAddressButtonCliked:(id)sender;
/** 常见问题按钮的点击事件 */
- (IBAction)FAQButtonClick:(UIButton *)sender;
/** 意见反馈按钮的点击事件 */
- (IBAction)feedbackButtonClick:(UIButton *)sender;

@end

@implementation LYQMyMallViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBarStyle];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Init

-(void)setNavigationBarStyle
{
    self.mallTitleLabel.text = @"我的商城";
}

#pragma mark - Push
/** 我的订单 点击事件－跳转 */
- (IBAction)myOrderButtonCliked:(id)sender {
    
    ZXYOrderListViewController * orderControl = [[ZXYOrderListViewController alloc]initWithNibName:@"ZXYOrderListViewController" bundle:nil];
    [self.navigationController pushViewController:orderControl animated:YES];
}
/** 我的收货地址 点击事件-跳转 */
- (IBAction)managementHarvestAddressButtonCliked:(id)sender {
    
    LYQManageAddressController * manageControl = [[LYQManageAddressController alloc]initWithNibName:@"LYQManageAddressController" bundle:nil];
    [self.navigationController pushViewController:manageControl animated:YES];
}

/** 常见问题按钮的点击事件 */
- (IBAction)FAQButtonClick:(UIButton *)sender {
    
    CJFAQViewController *FVC = [[CJFAQViewController alloc] init];
    [self.navigationController pushViewController:FVC animated:YES];
    
}

/** 意见反馈按钮的点击事件 */
- (IBAction)feedbackButtonClick:(UIButton *)sender {
    CJFeedbackViewController *feedbackVC = [[CJFeedbackViewController alloc] init];
    [self.navigationController pushViewController:feedbackVC animated:YES];
}

@end
