//
//  PayModelViewController.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/30.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "PayModelViewController.h"

@interface PayModelViewController ()

@property (weak, nonatomic) IBOutlet UIButton *online;          //在线支付
@property (weak, nonatomic) IBOutlet UIButton *payOnDelivery;   //货代付款

@property (nonatomic, strong) UIButton *tempButton; //储存临时button
@property (nonatomic, assign) NSInteger payModelIndex;

@end

@implementation PayModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    titleButton.hidden = NO;
    [titleButton setTitle:@"支付方式" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    

    
    [_online setTag:500];
    [_online setImage:[UIImage imageNamed:@"activity_content_btn_normal"] forState:UIControlStateNormal];
    [_online setImage:[UIImage imageNamed:@"activity_content_btn_normal_selected"] forState:UIControlStateSelected];
    [_online addTarget:self action:@selector(cilckButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_payOnDelivery setTag:501];
    [_payOnDelivery setImage:[UIImage imageNamed:@"activity_content_btn_normal"] forState:UIControlStateNormal];
    [_payOnDelivery setImage:[UIImage imageNamed:@"activity_content_btn_normal_selected"] forState:UIControlStateSelected];
    [_payOnDelivery addTarget:self action:@selector(cilckButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    if ([_payModel isEqualToString:@"1"]) {
        [self cilckButton:_online];
    } else {
        [self cilckButton:_payOnDelivery];
    }
}

- (void)cilckButton:(UIButton *)button{
    if (button.selected == YES) {
        
    } else {
        button.selected = YES;
        _tempButton.selected = NO;
        _tempButton = button;
        _payModelIndex = button.tag % 2 + 1;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic setObject:[NSString stringWithFormat:@"%d",_payModelIndex] forKey:@"payModel"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)_payModelIndex] forKey:@"payModel"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"payModel" object:self userInfo:dic];
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
