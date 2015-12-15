//
//  OrderPutinViewController.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/31.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "OrderPutinViewController.h"
#import "TakeoutViewController.h"
#import "AccountViewController.h"
#import "ListTableViewController.h"
#import "MyTakeoutOrderViewController.h"
#import "NiceFoodViewController.h"
#import "ListTableViewController.h"



@interface OrderPutinViewController ()
@property (weak, nonatomic) IBOutlet UILabel *OrderNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *GoOnTakeout;
@property (weak, nonatomic) IBOutlet UIButton *LookOrder;

@property (nonatomic, assign) NSInteger ViewControllerindex;//父vc标记



@end

@implementation OrderPutinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _ViewControllerindex = 0;
        
    titleButton.hidden = NO;
    [titleButton setTitle:@"订单提交成功" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    [_OrderNumberLabel setText:_orderCode];
    
    
    [_GoOnTakeout.layer setCornerRadius:5];
    [_GoOnTakeout.layer setBorderWidth:1];
    [_GoOnTakeout.layer setBorderColor:[RGBACOLOR(230, 60, 82, 1) CGColor]];
    [_GoOnTakeout setTitleColor:RGBACOLOR(230, 60, 82, 1) forState:UIControlStateNormal];
    [_GoOnTakeout addTarget:self action:@selector(clickGoOnTakeout) forControlEvents:UIControlEventTouchUpInside];
    
    [_LookOrder.layer setCornerRadius:5];
    [_LookOrder setBackgroundColor:RGBACOLOR(230, 60, 82, 1)];
    [_LookOrder addTarget:self action:@selector(clickLookOrder) forControlEvents:UIControlEventTouchUpInside];
    
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MyTakeoutOrderViewController class]]) {
            _ViewControllerindex = 1;
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteItem" object:nil];
}

#pragma mark -- 继续叫外卖
- (void)clickGoOnTakeout{
    if (_ViewControllerindex == 0) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[ListTableViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteItem" object:nil];
        
    } else if (_ViewControllerindex == 1) {
        [self.navigationController popToRootViewControllerAnimated:NO];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteItem" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GotoNiceFood" object:nil];
    }
    

}

//重写返回按钮点击事件
- (void)backButtonClick{
    if (_ViewControllerindex == 0) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[ListTableViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteItem" object:nil];
        
    } else if (_ViewControllerindex == 1) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 3] animated:NO];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteItem" object:nil];
    }
}


#pragma mark -- 查看订单
- (void)clickLookOrder{
    
    if (_ViewControllerindex == 0) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[ListTableViewController class]]) {
                [self.navigationController popToViewController:controller animated:NO];
            }
        }
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:_orderId forKey:@"orderId"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteItem" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LookOrder" object:nil userInfo:dic];
    } else if (_ViewControllerindex == 1) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:_orderId forKey:@"orderId"];
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:NO];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteItem" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"order" object:nil userInfo:dic];
    }
    
    
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
