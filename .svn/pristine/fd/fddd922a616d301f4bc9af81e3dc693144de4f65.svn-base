//
//  OrderStatusViewController.m
//  QQList
//
//  Created by sunsu on 15/7/6.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "OrderStatusViewController.h"
#import "MyBookSeatViewController.h"
#import "ListTableViewController.h"
@interface OrderStatusViewController ()<UIAlertViewDelegate>
@property (nonatomic, strong)UIButton *cancelBtn;
@property (nonatomic, strong)UILabel  *personNumberLabel;

@end

@implementation OrderStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createUI];
    NSLog(@"_isModification1=%@",_isModification);
    NSLog(@"seatId=%@",self.seatId);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([_isModification isEqualToString:@"0"]) {
        self.rightNavItem.hidden = YES;
        
    }else{
        self.rightNavItem.hidden = YES;
//        UIImage *image = [UIImage imageNamed:@"dingzuo_0005_icon_me.png"];
//        [self.rightNavItem setImage:image forState:UIControlStateNormal];
    }
    
    titleButton.hidden = NO;
    [titleButton setTitle:@"订单已提交" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}

-(void)backButtonClick{
    NSLog(@"_isModification2=%@",_isModification);
    //[self.navigationController popViewControllerAnimated:YES];
    if ([_isModification isEqualToString:@"0"]) {
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[MyBookSeatViewController class]]) {
                [self.navigationController popToViewController:temp animated:YES];
            }
        }
    }else{
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[ListTableViewController class]]) {
                [self.navigationController popToViewController:temp animated:YES];
            }
        }
    }

}

-(void)sendBtn:(id)sender{
    MyBookSeatViewController *myBookSeatVC = [[MyBookSeatViewController alloc] init];
    myBookSeatVC.formShang = YES;
    [self.navigationController pushViewController:myBookSeatVC animated:YES];
}

- (void)createUI
{
    CGFloat y = 0;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, 0)];
    
    // 图片
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-20, y+30, 40, 40)];
    topImageView.image = [UIImage imageNamed:@"dd_0002_icon_queding.png"];
    topImageView.backgroundColor = [UIColor clearColor];
    [topView addSubview:topImageView];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-80, CGRectGetMaxY(topImageView.frame)+PADDING, 160, 20)];
    if ([_isModification isEqualToString:@"0"]) {
        topLabel.text = @"订单修改成功";
    }else{
        topLabel.text = @"订座已经提交给餐厅";
    }
    
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.font = [UIFont systemFontOfSize:15];
    topLabel.textColor = [UIColor grayColor];
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-125, CGRectGetMaxY(topLabel.frame)+PADDING, 250, 20)];
    bottomLabel.text = @"稍后会以短信方式告知您订座结果";
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.font = [UIFont systemFontOfSize:15];
    bottomLabel.textColor = [UIColor grayColor];
    
    [topView addSubview:topLabel];
    //[topView addSubview:bottomLabel];
    
    
    // 线
    CGFloat lineY  = CGRectGetMaxY(bottomLabel.frame)+PADDING;
    CGFloat labelH = 30;
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0,lineY, SCREEN_WIDTH, 1)];
    lineView1.backgroundColor = [UIColor grayColor];
    [topView addSubview:lineView1];
    
    // 店名
    UILabel *MerchantNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(PADDING, lineY+PADDING, SCREEN_WIDTH-20, labelH)];
    MerchantNameLabel.text = _ownerName;
    MerchantNameLabel.font = [UIFont systemFontOfSize:17];
    MerchantNameLabel.textColor = [UIColor grayColor];
    MerchantNameLabel.textAlignment = NSTextAlignmentLeft;
    MerchantNameLabel.backgroundColor = [UIColor clearColor];
    [topView addSubview:MerchantNameLabel];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(MerchantNameLabel.frame)+PADDING, SCREEN_WIDTH, 1)];
    lineView2.backgroundColor = [UIColor grayColor];
    [topView addSubview:lineView2];
    
    // 时间
    UILabel *numberDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(PADDING, CGRectGetMaxY(lineView2.frame)+PADDING, 250, 30)];
    numberDateLabel.text = _numberDate;
    numberDateLabel.textColor = [UIColor grayColor];
    numberDateLabel.backgroundColor = [UIColor clearColor];
    numberDateLabel.font = [UIFont systemFontOfSize:17];
    numberDateLabel.textAlignment = NSTextAlignmentLeft;
    [topView addSubview:numberDateLabel];

    
    
    // 人数
    UILabel *numberPersonLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-PADDING-20-20, numberDateLabel.frame.origin.y, 20, 30)];
        numberPersonLabel.text = _numberPerson;
    numberPersonLabel.textColor = [UIColor grayColor];
    numberPersonLabel.textAlignment = NSTextAlignmentRight;
    numberPersonLabel.font = [UIFont systemFontOfSize:17];
    numberPersonLabel.backgroundColor =[UIColor clearColor];
    [topView addSubview:numberPersonLabel];
    
    UILabel *numberPersonLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-PADDING-20, numberDateLabel.frame.origin.y, 20, 30)];
    numberPersonLabel1.text = @"人";
    numberPersonLabel1.textColor = [UIColor grayColor];
    numberPersonLabel1.textAlignment = NSTextAlignmentRight;
    numberPersonLabel1.font = [UIFont systemFontOfSize:17];
    numberPersonLabel1.backgroundColor =[UIColor clearColor];
    [topView addSubview:numberPersonLabel1];
    
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(numberDateLabel.frame)+PADDING, SCREEN_WIDTH, 1)];
    lineView3.backgroundColor = [UIColor grayColor];
    [topView addSubview:lineView3];
    
    // 联系人
    UILabel *PersonNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(PADDING, CGRectGetMaxY(lineView3.frame)+PADDING, 150, 30)];
//    if ([_sex isEqualToString:@"1"]) {
//        PersonNameLabel.text = [NSString stringWithFormat:@"%@%@",[_personName substringToIndex:1],@"女士"];
//    }else {
//        PersonNameLabel.text = [NSString stringWithFormat:@"%@%@",[_personName substringToIndex:1],@"先生"];
//    }
    
    if ([_sex isEqualToString:@"0"]) {
        PersonNameLabel.text = [NSString stringWithFormat:@"%@%@",_personName,@"女士"];
    }else {
        PersonNameLabel.text = [NSString stringWithFormat:@"%@%@",_personName,@"先生"];
    }

    
    PersonNameLabel.textColor = [UIColor grayColor];
    PersonNameLabel.textAlignment = NSTextAlignmentLeft;
    PersonNameLabel.backgroundColor = [UIColor clearColor];
    PersonNameLabel.font = [UIFont systemFontOfSize:17];
    [topView addSubview:PersonNameLabel];
    
    // 电话
    _personNumberLabel =[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 140, PersonNameLabel.frame.origin.y, 130, 30)];
    _personNumberLabel.text = _numberTell;
    _personNumberLabel.textColor = [UIColor grayColor];
    _personNumberLabel.textAlignment = NSTextAlignmentRight;
    _personNumberLabel.font = [UIFont systemFontOfSize:17];
    _personNumberLabel.backgroundColor =[UIColor clearColor];
    [topView addSubview:_personNumberLabel];

    
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_personNumberLabel.frame)+PADDING, SCREEN_WIDTH, 1)];
    lineView4.backgroundColor = [UIColor grayColor];
    [topView addSubview:lineView4];
    topView.frame = CGRectMake(0, 64, SCREEN_WIDTH, CGRectGetMaxY(lineView4.frame));
    topView.backgroundColor = [UIColor colorWithRed:233/255.0 green:240/255.0 blue:236/255.0 alpha:1];
    [self.view addSubview:topView];
    
    
    
    // 取消订单按钮
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(PADDING, CGRectGetMaxY(topView.frame)+3*PADDING, SCREEN_WIDTH-20, 40);
    [_cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"dingzuo_0001_tijiao_btn.png"] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
    
}

// 取消订单
- (void)cancelAction:(UIButton *)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要取消订座嘛?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = TAG_CANCELORDER;
    [alertView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == TAG_CANCELORDER) {
        if (buttonIndex == 0) {
            NSLog(@"取消");
        }else if (buttonIndex == 1){
            [self cancelReserVation];
        }
    }else if (alertView.tag == TAG_TIPSORDER){
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[ListTableViewController class]]) {
                [self.navigationController popToViewController:temp animated:YES];
            }
        }
    }
}

// 取消订座请求
- (void)cancelReserVation
{
    [self showStartHud];
    UIAlertView *alertView1 = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    alertView1.tag = TAG_TIPSORDER;
    //NSDictionary * dictionary = @{@"oId":UserId,@"seatId":[NSString stringWithFormat:@"%@",_seatId]};
    NSDictionary *dictionary = @{@"oId":UserId,@"seatId":[NSString stringWithFormat:@"%@",self.seatId],@"proIden":PROIDEN};

    AFHTTPRequestOperationManager *shoplist=[AFHTTPRequestOperationManager manager];
    NSString * str = [NSString  stringWithFormat:@"%@",NFM_URL];
    NSDictionary *dic = @{@"method":CANCELRESERVATION,@"json":[dictionary JSONRepresentation]};

    [shoplist GET:str parameters:dic success:^(AFHTTPRequestOperation * operation, NSDictionary *responseObject) {
        [self stopHud:@""];
        NSLog(@"responseObject1=%@",responseObject);
        if ([[responseObject objectForKey:@"rescode"] integerValue] == 0000) {
            
            alertView1.message = @"取消订座成功";
            [alertView1 show];
        }else if ([[responseObject objectForKey:@"rescode"] integerValue] == 1002){
            alertView1.message = @"商家已确定订单，取消失败!";
            [alertView1 show];
        }
        NSLog(@"responseObject2=%@",responseObject);
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"失败:%@",error);
    }];
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
