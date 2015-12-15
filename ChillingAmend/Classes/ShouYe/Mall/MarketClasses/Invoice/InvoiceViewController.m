//
//  InvoiceViewController.m
//  MarketManage
//
//  Created by Rice on 15/1/17.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "InvoiceViewController.h"

@interface InvoiceViewController ()
{
    ZXYInvoiceModel *invoiceModel;
}

@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollview;
//电脑耗材
@property (weak, nonatomic) IBOutlet UIImageView *type_1;
//耗材
@property (weak, nonatomic) IBOutlet UIImageView *type_2;
//明细
@property (weak, nonatomic) IBOutlet UIImageView *type_3;
//办公用品
@property (weak, nonatomic) IBOutlet UIImageView *type_4;
//不开发票
@property (weak, nonatomic) IBOutlet UIImageView *type_no;
//发票类型-纸质
@property (weak, nonatomic) IBOutlet UIButton *invoiceTypeBtn;
//发票抬头-个人
@property (weak, nonatomic) IBOutlet UIButton *titlePersonBtn;
//发票抬头-单位
@property (weak, nonatomic) IBOutlet UIButton *titleIncBtn;
//发票抬头-线
@property (weak, nonatomic) IBOutlet UIImageView *invoiceTitleLine;

//发票抬头
@property (weak, nonatomic) IBOutlet UIView *invoiceTitleView;
//单位名称
@property (weak, nonatomic) IBOutlet UIView *incExView;
//发票类型
@property (weak, nonatomic) IBOutlet UIView *invoicetypeView;
//单位名称输入框
@property (weak, nonatomic) IBOutlet UITextField *invoiceTitleTextField;

//暂存发票抬头
@property (copy, nonatomic) NSString *tempTitle;
//暂存发票内容
@property (copy, nonatomic) NSString *tempContent;


- (IBAction)invoiceTitleAcion:(id)sender;
- (IBAction)selectInvoiceType:(id)sender;

@end

@implementation InvoiceViewController
#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationStyle];
    [self initLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Init
-(void)initNavigationStyle
{
    self.mallTitleLabel.text = @"发票信息";
}

/*
 导航条返回方法
 */
- (void)leftBackCliked:(UIButton *)sender{
    
    [self.invoiceTitleTextField resignFirstResponder];
    if ((![self.tempContent isEqual:@"不开发票"])&&[self.tempTitle isEqual:@"单位"]) {
        [self showMsg:@"请填写单位名称"];
    }else{
        invoiceModel.invoiceTitle = self.tempTitle;
        invoiceModel.invoiceContent = self.tempContent;
        [self.delegate getInvoiceMsgModel:invoiceModel];
        [self.navigationController popViewControllerAnimated:YES];
    }

}


-(void)initLayout
{
    invoiceModel = [ZXYInvoiceModel shareInstance];
    
    [self.bgScrollview setFrame:CGRectMake(0, 44, 320, SCREENHEIGHT-44)];
    [self.bgScrollview  setContentSize:CGSizeMake(320, 568)];
    
    [self selectInvoiceContent:invoiceModel.invoiceContent];
    [self judgeBtnsStatu];
    self.tempTitle = invoiceModel.invoiceTitle;
    self.tempContent = invoiceModel.invoiceContent;
}

- (IBAction)invoiceTitleAcion:(id)sender {
    UIButton *typeBtn = (UIButton *)sender;
    NSString *btnTitlt = typeBtn.titleLabel.text;
    if ([btnTitlt isEqual:@"个人"]) {
        [self.invoiceTitleTextField resignFirstResponder];
        self.tempTitle = @"个人";
        [MarketAPI setGrayButton:self.titleIncBtn];
        [MarketAPI setRedButton:self.titlePersonBtn];
        [self hideIncExView];
    }else if (@"单位"){
        self.tempTitle = @"单位";
        [MarketAPI setGrayButton:self.titlePersonBtn];
        [MarketAPI setRedButton:self.titleIncBtn];
        [self showIncExView];
    }
}

- (IBAction)selectInvoiceType:(id)sender {
    UIButton *typeBtn = (UIButton *)sender;
    NSString *btnTitlt = typeBtn.titleLabel.text;
    
    if ([btnTitlt isEqual:@"不开发票"]){
        
        [self setTypeImageWithTag:0];
    }else if ([btnTitlt isEqual:@"电脑耗材"]) {
        
        [self setTypeImageWithTag:1];
    }else if ([btnTitlt isEqual:@"耗材"]){
        
         [self setTypeImageWithTag:2];
    }else if ([btnTitlt isEqual:@"明细"]){
        
         [self setTypeImageWithTag:3];
    }else if ([btnTitlt isEqual:@"办公用品"]){
        
         [self setTypeImageWithTag:4];
    }
}

-(void)setTypeImageWithTag:(NSInteger)tag
{
    NSArray *typeName = [[NSArray alloc] initWithObjects:@"不开发票",@"电脑耗材",@"耗材",@"明细",@"办公用品",nil];
    self.type_1.image = [UIImage imageNamed:@"zxy_spanner_btn_normal"];
    self.type_2.image = [UIImage imageNamed:@"zxy_spanner_btn_normal"];
    self.type_3.image = [UIImage imageNamed:@"zxy_spanner_btn_normal"];
    self.type_4.image = [UIImage imageNamed:@"zxy_spanner_btn_normal"];
    self.type_no.image = [UIImage imageNamed:@"zxy_spanner_btn_normal"];
    switch (tag) {
        case 0:
        {
            self.type_no.image = [UIImage imageNamed:@"zxy_spanner_icon_selected"];
            break;
        }
        case 1:
        {
            self.type_1.image = [UIImage imageNamed:@"zxy_spanner_icon_selected"];
            break;
        }
        case 2:
        {
            self.type_2.image = [UIImage imageNamed:@"zxy_spanner_icon_selected"];
            break;
        }
        case 3:
        {
            self.type_3.image = [UIImage imageNamed:@"zxy_spanner_icon_selected"];
            break;
        }
        case 4:
        {
            self.type_4.image = [UIImage imageNamed:@"zxy_spanner_icon_selected"];
            break;
        }
        default:
            break;
    }

    self.tempContent = typeName[tag];
}

-(void)showIncExView
{
    [UIView animateWithDuration:.3 animations:^{
        self.invoiceTitleLine.hidden = YES;
        [self.incExView setFrame:CGRectMake(ORIGIN_X(self.incExView), ORIGIN_Y(self.invoiceTitleView) + FRAMNE_H(self.invoiceTitleView), FRAMNE_W(self.incExView), FRAMNE_H(self.incExView))];
        [self.invoicetypeView setFrame:CGRectMake(ORIGIN_X(self.invoicetypeView), ORIGIN_Y(self.incExView) + FRAMNE_H(self.incExView) + 10, FRAMNE_W(self.invoicetypeView), FRAMNE_H(self.invoicetypeView))];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideIncExView
{
    [UIView animateWithDuration:.3 animations:^{
        [self.incExView setFrame:CGRectMake(ORIGIN_X(self.incExView), ORIGIN_Y(self.invoiceTitleView) + FRAMNE_H(self.invoiceTitleView) - FRAMNE_H(self.incExView), FRAMNE_W(self.incExView), FRAMNE_H(self.incExView))];
        [self.invoicetypeView setFrame:CGRectMake(ORIGIN_X(self.invoicetypeView), ORIGIN_Y(self.invoiceTitleView) + FRAMNE_H(self.invoiceTitleView) + 10, FRAMNE_W(self.invoicetypeView), FRAMNE_H(self.invoicetypeView))];
    } completion:^(BOOL finished) {
        self.invoiceTitleLine.hidden = NO;
    }];
   
}

#pragma mark - UITextfield
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqual:@"\n"]) {
        
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.tempTitle = textField.text;
}


-(void)selectInvoiceContent:(NSString *)content
{
    if ([content isEqual:@"不开发票"]){
        
        [self setTypeImageWithTag:0];
    }else if ([content isEqual:@"电脑耗材"]) {
        
        [self setTypeImageWithTag:1];
    }else if ([content isEqual:@"耗材"]){
        
        [self setTypeImageWithTag:2];
    }else if ([content isEqual:@"明细"]){
        
        [self setTypeImageWithTag:3];
    }else if ([content isEqual:@"办公用品"]){
        
        [self setTypeImageWithTag:4];
    }
}

-(void)judgeBtnsStatu
{
    [MarketAPI setRedButton:self.invoiceTypeBtn];
    if ([invoiceModel.invoiceTitle isEqual:@"个人"]) {
        [MarketAPI setRedButton:self.titlePersonBtn];
        [MarketAPI setGrayButton:self.titleIncBtn];
    }else{
        [MarketAPI setGrayButton:self.titlePersonBtn];
        [MarketAPI setRedButton:self.titleIncBtn];
        [self showIncExView];
        self.invoiceTitleTextField.text = [invoiceModel.invoiceTitle isEqual:@"单位"]?@"":invoiceModel.invoiceTitle;
    }
}


@end
