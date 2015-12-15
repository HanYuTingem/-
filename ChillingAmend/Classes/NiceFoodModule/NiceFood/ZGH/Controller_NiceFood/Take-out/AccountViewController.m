//
//  AccountViewController.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/22.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "AccountViewController.h"
#import "dishesList.h"
#import "ViewOfCustomButton.h"
#import "SelectButton.h"
#import "AddressViewController.h"
#import "PayModelViewController.h"
#import "OrderPutinViewController.h"
#import "CashierDeskViewController.h"
#import "CouponViewController.h"
#import "ChangeBookSeatPhoneNumViewController.h"

@interface AccountViewController()<UITextFieldDelegate, UIAlertViewDelegate>

//--------------------存储网络数据---------------------------
@property (nonatomic, copy) NSString *bill;//是否提供发表
@property (nonatomic, copy) NSString *countPrice;//总金额
@property (nonatomic, copy) NSString *coupon;//是否有优惠券
@property (nonatomic, copy) NSString *deliveryPrice;//配送费
@property (nonatomic, copy) NSString *lat;//纬度
@property (nonatomic, copy) NSString *lng;//经度
@property (nonatomic, copy) NSString *serverScope;//服务范围
//---------------------------------------------------------

@property (nonatomic, strong) UILabel *moneyLabel;//应付金额文本框

@property (nonatomic, strong) ViewOfCustomButton *addressButton; //地址按钮
@property (nonatomic, copy) NSString *address; //地址

@property (nonatomic, strong) UIScrollView *scrollView; //

@property (nonatomic, strong) UIView *informationView;  //客户信息栏
@property (nonatomic, strong) UITextField *lastName;    //姓氏
@property (nonatomic, strong) UILabel *phoneLabel;      //电话

@property (nonatomic, strong) UIButton *switchBtn;         //发票开关
@property (nonatomic, strong) UIView *billView;         //发票view
@property (nonatomic, strong) UITextField *billTextField;     //发票输入框

@property (nonatomic, strong) UIView *remarksView;      //备注view
@property (nonatomic, strong) UITextField *remarks;     //备注

@property (nonatomic, strong) UILabel *takeoutParticular; //显示“外卖详情”的文本

@property (nonatomic, strong) UIView *takeoutListView;  //外卖详情View

@property (nonatomic, strong) ViewOfCustomButton * discountCouponView; //优惠券View
@property (nonatomic, strong) UILabel *discountCouponLabel3; //优惠券view上第三个label 显示优惠券使用情况

@property (nonatomic, strong) ViewOfCustomButton * payModelView;    //支付方式
@property (nonatomic, strong)  UILabel *payModelLabel2;     //支付方式view上第二个label 显示支付方式

@property (nonatomic, strong) SelectButton *tempButton;         //记录当前选中的按钮


@property (nonatomic, assign) BOOL addressIndex; //是否已经输入地址
@property (nonatomic, copy) NSString *payModel;//支付方式

@property (nonatomic, copy) NSArray *takeoutList;//菜品列表数组
@property (nonatomic, copy) NSString *sexIndex;//性别标记

@property (nonatomic, copy) NSString *couponState;//优惠券使用标记
@property (nonatomic, copy) NSDictionary *couponDic;//使用优惠券后回传的字典


@property (nonatomic, copy) NSString *actualPrice;//订单实际价格
@property (nonatomic, copy) NSString *salePrice;//优惠券价格

@end

@implementation AccountViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    _addressIndex = NO;
    _payModel = @"1";
    _sexIndex = [[NSString alloc] init];
    _actualPrice = _totalprice;
    _salePrice = [[NSString alloc] init];
    _couponState = @"0";
    
    
    
    [self requestData];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAddress:) name:@"address" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPayModel:) name:@"payModel" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UseCoupon:) name:@"UseCoupon" object:nil];
    
    //    监听键盘输入的通知  限制最大输入字符
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:nil];

    
}

- (void)UseCoupon:(NSNotification *)obj{
    
    _couponDic = [[NSDictionary alloc] initWithDictionary:obj.userInfo];
    
    [_discountCouponLabel3 setText:@"已使用"];
    _couponState = @"1";

    _actualPrice = _couponDic[@"actualPrice"];
    _salePrice = _couponDic[@"salePrice"];
    
    [_moneyLabel setText:[NSString stringWithFormat:@"应付：￥%.2f", [_actualPrice floatValue]]];
}

//支付方式回调方法
- (void)getPayModel:(NSNotification *)notification{
    _payModel = [NSString stringWithFormat:@"%@", notification.userInfo[@"payModel"]];
    
    if ([_payModel isEqualToString:@"1"]) {
        [_payModelLabel2 setText:@"在线支付"];
    } else {
        [_payModelLabel2 setText:@"货到付款"];
    }
}

//从选择地址页面跳回后的处理
- (void)getAddress:(NSNotification *)notification{
    
    _address = [NSString stringWithFormat:@"%@", notification.userInfo[@"address"]];
    [_addressButton setTitle:[NSString stringWithFormat:@"送餐地址  %@", _address] forState:UIControlStateNormal];
    
    _addressIndex = YES;
}


- (void)addUI{
//    标题
    titleButton.hidden = NO;
    [titleButton setTitle:_name forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
//    底部view
    UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
    [bottom setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bottom];
    
//    底部view的分割线
    UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49 -3, SCREEN_WIDTH, 3)];
    [bottomLine setImage:[UIImage imageNamed:@"programme_list_abg"]];
    [bottomLine setAlpha:0.2];
    [self.view addSubview:bottomLine];

    
//    应付金额文本框
    _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 150, 20)];
    CGFloat money = [_countPrice floatValue];
    [_moneyLabel setText:[NSString stringWithFormat:@"应付：￥%.2f", money]];
    [_moneyLabel setTextColor:RGBACOLOR(230, 60, 82, 1)];
    [bottom addSubview:_moneyLabel];
    
//    下单按钮
    UIButton *putin = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 10, 80, 30)];
    [putin setBackgroundColor:RGBACOLOR(230, 60, 82, 1)];
    [putin setTitle:@"立即下单" forState:UIControlStateNormal];
    [putin.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [putin.layer setCornerRadius:3];
    [bottom addSubview:putin];
    [putin addTarget:self action:@selector(clickPutin) forControlEvents:UIControlEventTouchUpInside];
    
//    滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavigationH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationH - 49)];
    [_scrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_scrollView];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    
    UITapGestureRecognizer *tapMain = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMainView)];
    [_scrollView addGestureRecognizer:tapMain];
    
//    地址栏
    _addressButton = [[ViewOfCustomButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ViewHeight)];
    [_addressButton setBackgroundColor: RGBACOLOR(130, 130, 130, 1)];
    [_scrollView addSubview:_addressButton];
    [_addressButton addTarget:self action:@selector(clickAddressButton) forControlEvents:UIControlEventTouchUpInside];

//    地址栏上的文本框
    [_addressButton setTitle:[NSString stringWithFormat:@"送餐地址  %@", @"请选择您的送餐地址~"] forState:UIControlStateNormal];
    [_addressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_addressButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    
//    客户信息栏
    _informationView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_addressButton.frame) + 10, SCREEN_HEIGHT, ViewHeight * 2)];
    [_informationView setBackgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:_informationView];
    
//    姓氏输入框
    _lastName = [[UITextField alloc] initWithFrame:CGRectMake(20, ViewHeight / 4, 80, ViewHeight / 2)];
    [_lastName setBorderStyle:UITextBorderStyleNone];
    _lastName.placeholder = @"您贵姓";
    _lastName.returnKeyType =UIReturnKeyDone;
    _lastName.delegate = self;
    [_informationView addSubview:_lastName];
    

    

//    女士
    SelectButton *woman = [[SelectButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 160, ViewHeight / 4, 80, ViewHeight / 2)];
    [woman setTag:301];
    [woman setTitle:@"女士" forState:UIControlStateNormal];
    [woman addTarget:self action:@selector(clickSexButton:) forControlEvents:UIControlEventTouchUpInside];
    [_informationView addSubview:woman];
    [self clickSexButton:woman];

//    男士
    SelectButton *man = [[SelectButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, ViewHeight / 4, 80, ViewHeight / 2)];
    [man setTag:300];
    [man setTitle:@"先生" forState:UIControlStateNormal];
    [man addTarget:self action:@selector(clickSexButton:) forControlEvents:UIControlEventTouchUpInside];
    [_informationView addSubview:man];
    
    
//    信息栏的分割线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(10, ViewHeight, SCREEN_WIDTH - 20, 1)];
    [line1 setBackgroundColor:RGBACOLOR(235, 235, 235, 1)];
    [_informationView addSubview:line1];
    
//    电话号码
    
    _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, ViewHeight + ViewHeight / 4, 150, ViewHeight / 2)];
    [_phoneLabel setText:PhoneNumber];
    [_informationView addSubview:_phoneLabel];
    
    UIButton *alter = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 20 - ViewHeight/2 , ViewHeight + ViewHeight / 4, ViewHeight / 2, ViewHeight / 2)];
    [alter setImage:[UIImage imageNamed:@"myorder_function_btn_changephonenumber"] forState:UIControlStateNormal];
    [_informationView addSubview:alter];
    [alter addTarget:self action:@selector(clickAlterPhoneNumber) forControlEvents:UIControlEventTouchUpInside];
    
//    _phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(20, ViewHeight + ViewHeight / 4, SCREEN_WIDTH - 40, ViewHeight / 2)];
//    [_phoneNumber setBorderStyle:UITextBorderStyleNone];
//    _phoneNumber.placeholder = @"请输入您的手机号";
//    _phoneNumber.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    _phoneNumber.text = PhoneNumber;
//    _phoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
//    _phoneNumber.delegate = self;
//    _phoneNumber.returnKeyType =UIReturnKeyDone;
//    [_informationView addSubview:_phoneNumber];
    
//   发票View
    _billView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_informationView.frame) + 10, SCREEN_WIDTH, ViewHeight)];
    [_billView setBackgroundColor:[UIColor whiteColor]];
    [_billView setClipsToBounds:YES];
    [_scrollView addSubview:_billView];
    
    UILabel *billLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, ViewHeight / 4, 150, ViewHeight / 2)];
    [billLabel setText:@"是否开具发票"];
    [_billView addSubview:billLabel];
    
    
//    发票开关
    _switchBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 63, (ViewHeight -35)/2, 53, 35)];
    [_switchBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    [_switchBtn setImage:[UIImage imageNamed:@"dingzuo_0000_Toggle-On"] forState:UIControlStateSelected];
    [_switchBtn setImage:[UIImage imageNamed:@"dingzuo_0002_Toggle-Off-"] forState:UIControlStateNormal];
    
    [_billView addSubview:_switchBtn];
    

    
//    发票分割线
    UIView *billViewLine = [[UIView alloc] initWithFrame:CGRectMake(10, ViewHeight + 1, SCREEN_WIDTH - 20, 1)];
    [billViewLine setBackgroundColor:[UIColor lightGrayColor]];
    [_billView addSubview:billViewLine];
    
//    发票输入框
    _billTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, ViewHeight / 4 +ViewHeight, SCREEN_WIDTH - 20, ViewHeight / 2)];
    _billTextField.placeholder = @"请输入发票抬头";
    _billTextField.returnKeyType =UIReturnKeyDone;
    _billTextField.delegate = self;
    [_billView addSubview:_billTextField];
    
    
//    备注
    _remarksView = [[UIView alloc] init];
    [_remarksView setBackgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:_remarksView];
    
//    备注输入框
    _remarks = [[UITextField alloc] initWithFrame:CGRectMake(20, ViewHeight / 4, SCREEN_WIDTH - 40, ViewHeight / 2)];
    _remarks.tag = 701;
    [_remarks setBorderStyle:UITextBorderStyleNone];
    _remarks.placeholder = @"其他备注：口味、餐具";
    _remarks.returnKeyType =UIReturnKeyDone;
    _remarks.delegate = self;
    [_remarksView addSubview:_remarks];
    
//    美食详情
    _takeoutParticular = [[UILabel alloc] init];
    [_takeoutParticular setText:@"外卖详情"];
    [_scrollView addSubview:_takeoutParticular];
    
//    外卖详情view
    _takeoutListView = [[UIView alloc] init];
    [_takeoutListView setBackgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:_takeoutListView];
    
    for (int i = 0; i <= _takeoutList.count; i++) {
        UILabel *left = [[UILabel alloc] initWithFrame:CGRectMake(20, ViewHeight * i + ViewHeight/4, 150, ViewHeight / 2)];
        UILabel *right = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 150, ViewHeight * i + ViewHeight/4, 130, ViewHeight / 2)];
        
        if (i < _takeoutList.count) {
            [left setText:[NSString stringWithFormat:@"%@", _takeoutList[i][@"contentName"]]];
            [right setText:[NSString stringWithFormat:@"￥%@/%@份", _takeoutList[i][@"price"], _takeoutList[i][@"contentCount"]]];
            
            [right setTextColor:RGBACOLOR(230, 60, 82, 1)];
            
            UIView *lin = [[UIView alloc] initWithFrame:CGRectMake(10, ViewHeight * (i+1), SCREEN_WIDTH - 20, 1)];
            [lin setBackgroundColor:RGBACOLOR(235, 235, 235, 1)];
            [_takeoutListView addSubview:lin];
            
        } else {
            [left setText:@"外送费"];
            [right setText:[NSString stringWithFormat:@"￥%@", _deliveryPrice]];
        }
        
        [right setTextAlignment:NSTextAlignmentRight];
        
        [_takeoutListView addSubview:left];
        [_takeoutListView addSubview:right];
    
    }
    
//    优惠券
    _discountCouponView = [[ViewOfCustomButton alloc] init];
    [_scrollView addSubview:_discountCouponView];
    [_discountCouponView setBackgroundColor:[UIColor whiteColor]];
    [_discountCouponView addTarget:self action:@selector(clickDiscountCouponView) forControlEvents:UIControlEventTouchUpInside];
    
//    label1
    UIImageView *discountCouponImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, ViewHeight /4, 30, ViewHeight / 2)];
    [discountCouponImage setImage:[UIImage imageNamed:@"wm_icoyhj"]];
    [_discountCouponView addSubview:discountCouponImage];
    
    UILabel *discountCouponLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(discountCouponImage.frame), ViewHeight / 4, 60, ViewHeight /2)];
    [discountCouponLabel setText:@"优惠券"];
    [discountCouponLabel setTextAlignment:NSTextAlignmentRight];
    [_discountCouponView addSubview:discountCouponLabel];
    
//    label2
    UILabel *discountCouponLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(discountCouponLabel.frame), ViewHeight / 4, 60, ViewHeight /2)];
    if ([_coupon isEqualToString:@"0"]) {
        [discountCouponLabel2 setText:@"可用"];
        [discountCouponLabel2 setTextColor:RGBACOLOR(230, 60, 82, 1)];
    } else {
        [discountCouponLabel2 setText:@"不可用"];
        [_discountCouponView setUserInteractionEnabled: NO];
    }
    [_discountCouponView addSubview:discountCouponLabel2];
    
//    label3
    _discountCouponLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100 , ViewHeight / 4, 60, ViewHeight /2)];
    [_discountCouponLabel3 setText:@"未使用"];
    [_discountCouponLabel3 setTextAlignment:NSTextAlignmentRight];
    [_discountCouponView addSubview:_discountCouponLabel3];
    
//    支付方式
    _payModelView = [[ViewOfCustomButton alloc] init];
    [_scrollView addSubview:_payModelView];
    [_payModelView setBackgroundColor:[UIColor whiteColor]];
    [_payModelView addTarget:self action:@selector(clickPayModelView) forControlEvents:UIControlEventTouchUpInside];
    
//    label1
    UILabel *payModelLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, ViewHeight / 4, 100, ViewHeight /2)];
    [payModelLabel setText:@"支付方式"];
    [_payModelView addSubview:payModelLabel];
    
//    label2
    _payModelLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 140 , ViewHeight / 4, 100, ViewHeight /2)];
    [_payModelLabel2 setText:@"在线支付"];
    [_payModelLabel2 setTextAlignment:NSTextAlignmentRight];
    [_payModelView addSubview:_payModelLabel2];
    
    [self.view bringSubviewToFront:bottomLine];
    
    [self reloadView];
}


//刷新控件的frame
- (void)reloadView{
    [_remarksView setFrame:CGRectMake(0, CGRectGetMaxY(_billView.frame) + 10, SCREEN_WIDTH, ViewHeight)];
    [_takeoutParticular setFrame:CGRectMake(20, CGRectGetMaxY(_remarksView.frame) +ViewHeight /4 , 80, ViewHeight / 2)];
    [_takeoutListView setFrame:CGRectMake(0, CGRectGetMaxY(_remarksView.frame) + ViewHeight, SCREEN_WIDTH, ViewHeight * (_takeoutList.count + 1))];
    [_discountCouponView setFrame:CGRectMake(0, CGRectGetMaxY(_takeoutListView.frame) + 10, SCREEN_WIDTH, ViewHeight)];
    [_payModelView setFrame:CGRectMake(0, CGRectGetMaxY(_discountCouponView.frame) + 10, SCREEN_WIDTH, ViewHeight)];
    
    [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(_payModelView.frame)+ 100)];
    
}

//开关按钮点击事件
- (void)switchAction:(UIButton *)btn{
    
    if ([_bill isEqualToString:@"0"]) {
        btn.selected = !btn.selected;
        if (btn.selected == YES) {
            [_billView setFrame:CGRectMake(0, CGRectGetMaxY(_informationView.frame) + 10, SCREEN_WIDTH, ViewHeight * 2)];
        } else {
            [_billView setFrame:CGRectMake(0, CGRectGetMaxY(_informationView.frame) + 10, SCREEN_WIDTH, ViewHeight)];
        }
        
        [self reloadView];
    } else {
        [self showMsg:@"商家不提供发票"];
    }
    
    
}

//性别按钮点击事件
- (void)clickSexButton:(SelectButton *)button{
    if (button.selected == YES) {
        
    } else {
        button.selected = YES;
        _tempButton.selected = NO;
        _tempButton = button;
        _sexIndex = [NSString stringWithFormat:@"%ld", button.tag % 2];
    }
}

//退回键盘
- (void)clickMainView{
    [_lastName resignFirstResponder];
    [_remarks resignFirstResponder];
    [_billTextField resignFirstResponder];
}

#pragma mark --UITextFieldDelegate实现方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    NSLog(@"开始编辑");
    
    if (textField.tag == 701) {
        [_scrollView setContentOffset:CGPointMake(0, textField.frame.origin.y + 150) animated:YES];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    NSLog(@"结束编辑");
    return YES;
}

#pragma mark -- 地址栏点击事件
- (void)clickAddressButton{
    AddressViewController *addVC = [[AddressViewController alloc] init];
    addVC.lat = _lat;
    addVC.lng = _lng;
    addVC.serverScope = _serverScope;
    
    [self.navigationController pushViewController:addVC animated:YES];

}

#pragma mark -- 修改电话按钮
- (void)clickAlterPhoneNumber{
    
    ChangeBookSeatPhoneNumViewController *vc = [[ChangeBookSeatPhoneNumViewController alloc] init];
    __block AccountViewController *accountVC = self;
    vc.myBlock = ^(NSString *str){
        accountVC.phoneLabel.text = str;
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -- 优惠券栏点击事件
- (void)clickDiscountCouponView{
    
    CouponViewController *vc = [[CouponViewController alloc] init];
    vc.ownerId = _ownerId;
    vc.totalprice = _totalprice;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -- 支付方式栏点击事件
- (void)clickPayModelView{
    PayModelViewController *PMVC = [[PayModelViewController alloc] init];
    PMVC.payModel = _payModel;
    
    [self.navigationController pushViewController:PMVC animated:YES];
}

#pragma mark -- 下单按钮点击事件
- (void)clickPutin{
    if (!_addressIndex) {
//        [self showMsg:@"请填您的送餐地址"];
        [GCUtil showInfoAlert:@"请填您的送餐地址"];
    } else if (_lastName.text.length <= 0) {
//        [self showMsg:@"请填您的姓氏"];
        [GCUtil showInfoAlert:@"请填您的姓氏"];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否提交订单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alertView show];
    
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"提交订单");
        
        NSString *isInvoice = [[NSString alloc] init];
        if (_switchBtn.selected == NO) {
            _billTextField.text = @"";
            isInvoice = @"0";
        } else {
            isInvoice = @"1";
        }
        
        NSString *couponId = @"";
        NSString *couponCodeId = @"";
        
        if (_couponDic[@"couponId"]) {
            couponId = _couponDic[@"couponId"];
        }
        if (_couponDic[@"couponCodeId"]) {
            couponCodeId = _couponDic[@"couponCodeId"];
        }
        
        
        NSDictionary *par = [Parameter saveOrderDataWithOwnerId:_ownerId sendAddr:_address linkman:_lastName.text linkmanPhone:_phoneLabel.text linkmanSex:_sexIndex isInvoice:isInvoice invoiceDetail:_billTextField.text takeoutList:_shoppingCartArray remark:_remarks.text couponState:_couponState payMode:_payModel couponId:couponId couponCodeId:couponCodeId deliveryPrice:_deliveryPrice account:_countPrice actualPrice:_actualPrice salePrice:_salePrice];
        
        NSLog(@"%@",par);
        
        [AFRequest PostRequestWithUrl:NiceFood_Url parameters:par andBlock:^(NSDictionary *Datas, NSError *error) {
            
            
            if (error == nil) {
        
                if ([Datas[@"rescode"] isEqualToString:@"0000"]) {
                    if ([_payModel isEqualToString:@"2"]) {
                        OrderPutinViewController *vc = [[OrderPutinViewController alloc] init];
                        vc.orderId = Datas[@"orderId"];
                        vc.orderCode = Datas[@"orderCode"];
                        [self.navigationController pushViewController:vc animated:YES];
                    } else {
                        CashierDeskViewController *vc = [[CashierDeskViewController alloc] init];
                        vc.orderCode = Datas[@"orderCode"];
                        vc.orderId = Datas[@"orderId"];
                        vc.actualPrice = _actualPrice;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }
                else {
                    [self showMsg:Datas[@"resdesc"]];
                }
                
            }
        }];
    }
}

- (void)requestData{
    
    NSDictionary *dic = [Parameter getTakeoutSettlementInfoWithOId:HUserId ownerId:_ownerId totalprice:_totalprice takeoutList:_shoppingCartArray];

    AFHTTPRequestOperationManager *request = [AFHTTPRequestOperationManager manager];
    request.responseSerializer = [AFJSONResponseSerializer serializer];
    NSLog(@"请求参数——%@", dic);
    [request POST:NiceFood_Url parameters:dic success:^(AFHTTPRequestOperation * operation, NSDictionary *responseObject) {
        NSLog(@"返回参数——%@", responseObject);
        
        _bill = responseObject[@"bill"];
        _countPrice = responseObject[@"countPrice"];
        _coupon = responseObject[@"coupon"];
        _deliveryPrice = responseObject[@"deliveryPrice"];
        _lat = responseObject[@"lat"];
        _lng = responseObject[@"lng"];
        _serverScope = responseObject[@"serverScope"];
        _takeoutList = responseObject[@"takeoutList"];
        
        NSLog(@"优惠券标记:%@", _coupon);
        
        _actualPrice = [NSString stringWithFormat:@"%.2f",[_totalprice floatValue] + [_deliveryPrice floatValue]];
        
        [self addUI];
        [self chrysanthemumClosed];
        [self open];
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@", error);
        [self chrysanthemumClosed];
        [self open];
        [self showMsg:@"加载失败"];
    }];
    
}

-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > 30) {
                textField.text = [toBeString substringToIndex:30];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > 30) {
            textField.text = [toBeString substringToIndex:30];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_countPrice == nil) {
        [self chrysanthemumOpen];
        [self close];
    }

}



@end
