//
//  LYQHarvestAddressViewController.m
//  Chiliring
//
//  Created by nsstring on 14-9-10.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "LYQHarvestAddressViewController.h"
#import "SelectCityView.h"
#import "MarketAPI.h"
#import "BSaveMessage.h"

@interface LYQHarvestAddressViewController ()
<selectDelegate,UITextFieldDelegate,UITextViewDelegate>

{
    CGRect areaFrame;
    BOOL isSelect;
    
    NSString *saveCountry;
    NSString *saveCity;
    NSString *saveArea;
    ASIFormDataRequest * mRequest;
    
 
}
@property (weak, nonatomic) IBOutlet UIView *areaView;
@property (weak, nonatomic) IBOutlet UILabel *areaNameLabel;

@property (strong, nonatomic) NSString *areaValue;
@property (weak, nonatomic) IBOutlet UITextField *harvestAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextView *deatilAddresTextView;
@property (weak, nonatomic) IBOutlet UILabel *detailAddressLabel;

@property (weak, nonatomic) IBOutlet UIView *detailAddresView;

@property (weak, nonatomic) IBOutlet UIView *popShowView;
@property (weak, nonatomic) IBOutlet UILabel *popShowLabel;

@property (nonatomic,strong)    SelectCityView *selectView ;

/** 箭头
 */
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
/** 线 */
@property (weak, nonatomic) IBOutlet UIImageView *OneLineImagView;
/** 详细地址 label */
@property (weak, nonatomic) IBOutlet UITextView *UItextView;
/** 详细地址 */
@property (weak, nonatomic) IBOutlet UILabel *UIlableOnTextView;
/** 姓名 手机 view */
@property (weak, nonatomic) IBOutlet UIView *UINameAndTelLabel;

@property (weak, nonatomic) IBOutlet UIImageView *NameAndTelOneline;

@property (weak, nonatomic) IBOutlet UIImageView *NameAndTelOnetwo;

@property (weak, nonatomic) IBOutlet UIImageView *NameAndTelthreeLine;

@property (weak, nonatomic) IBOutlet UILabel *CharLabel;

@property (weak, nonatomic) IBOutlet UIView *CharVIew;

- (IBAction)selectCityButtonCliked:(id)sender;

@end

@implementation LYQHarvestAddressViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBarStyle];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    isSelect =YES;
    
    [self.popShowView.layer setCornerRadius:7];
    [self.popShowView.layer setMasksToBounds:YES];
    [self.popShowView.layer setBorderWidth:0];
    self.popShowView.hidden = YES;
    

    
    
    areaFrame = _areaView.frame;
    _harvestAddressTextField.delegate = self;
    _phoneTextField.delegate = self;

    self.deatilAddresTextView.delegate = self;
    
    self.selectView = [[SelectCityView alloc]initWithFrame:CGRectMake(0,SCREENHEIGHT-216, SCREENWIDTH, 216)];
    self.selectView.delegate = self;
    [self.view addSubview:self.selectView];
    self.selectView.hidden = YES;
    
    [self aotuLayout];
}

/** 适配 */
-(void)aotuLayout{
    _areaView.frame = CGRectMake(0, _areaView.frame.origin.y, SCREENWIDTH, _areaView.frame.size.height);
    _arrowImageView.frame = CGRectMake(SCREENWIDTH - 30, _arrowImageView.frame.origin.y, _arrowImageView.frame.size.width, _arrowImageView.frame.size.height);
    _OneLineImagView.frame = CGRectMake(0, _OneLineImagView.frame.origin.y, SCREENWIDTH, _OneLineImagView.frame.size.height);
    _UItextView.frame = CGRectMake(0, _UItextView.frame.origin.y, SCREENWIDTH, _UItextView.frame.size.height);
    _UIlableOnTextView.frame = CGRectMake(_UIlableOnTextView.frame.origin.x, _UIlableOnTextView.frame.origin.y, SCREENWIDTH, _UIlableOnTextView.frame.size.height);
    _UINameAndTelLabel.frame = CGRectMake(0, _UINameAndTelLabel.frame.origin.y, SCREENWIDTH, _UINameAndTelLabel.frame.size.height);
    _NameAndTelOneline.frame =CGRectMake(0, _NameAndTelOneline.frame.origin.y, SCREENWIDTH, _NameAndTelOneline.frame.size.height);
    
    _NameAndTelOnetwo.frame =CGRectMake(0, _NameAndTelOnetwo.frame.origin.y, SCREENWIDTH, _NameAndTelOnetwo.frame.size.height);
    _NameAndTelthreeLine.frame=CGRectMake(0, _NameAndTelthreeLine.frame.origin.y, SCREENWIDTH, _NameAndTelthreeLine.frame.size.height);
    _CharLabel.frame = CGRectMake(_CharLabel.frame.origin.x, _CharLabel.frame.origin.y, _CharLabel.frame.size.width * SP_WIDTH, _CharLabel.frame.size.height);
    
    _CharVIew.frame = CGRectMake(_CharVIew.frame.origin.x, _CharVIew.frame.origin.y, _CharVIew.frame.size.width * SP_WIDTH, _CharVIew.frame.size.height);
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [mRequest cancel];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)popShowViewDalyHide
{
    [UIView animateWithDuration:1.5 animations:^{
        
        self.popShowView.alpha=0.3;
        
    } completion:^(BOOL finished) {
        
        self.popShowView.alpha=0.6;
        self.popShowView.hidden = YES;
        
    }];
}

#pragma mark - 初始化导航栏
-(void)setNavigationBarStyle
{
    
    self.mallTitleLabel.text = @"添加收货地址";
    
    [self.rightButton setTitle:@"保存" forState:UIControlStateNormal];
        self.rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
   
}

/*
 导航条返回方法
 */

- (void)LeftBtnCliked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma TextFiled Delegate

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _detailAddressLabel.hidden = YES;
    [self editeEnd];

}
-(void)textViewDidEndEditing:(UITextView *)textView{
    
    if([textView.text isEqualToString:@""]){
        _detailAddressLabel.hidden = NO;
    }
}
#pragma mark - UITextView Delegate Methods

//textView
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text]; //得到输入框的内容
    if (_deatilAddresTextView== textView)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 60) { //如果输入框内容大于60 则不能输入
            return NO;
        }
    }

    return YES;
}
//textField
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]){
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (_phoneTextField== textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 11) { //如果输入框内容大于11 则不能输入
            return NO;
        }
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGSize size = textView.contentSize;
    
    if ( size.height >= 64 ) {
        
        size.height = 64;
    }
    else if ( size.height <= 38 ) {
        
        size.height = 38;
    }
    
    if ( size.height != textView.frame.size.height ) {
        
        CGFloat span = size.height - textView.frame.size.height;
        
        self.deatilAddresTextView.frame = CGRectMake(ORIGIN_X(_deatilAddresTextView), ORIGIN_Y(self.deatilAddresTextView),FRAMNE_W(self.deatilAddresTextView) , FRAMNE_H(self.deatilAddresTextView)  + span);
        _detailAddresView.frame = CGRectMake(ORIGIN_X(_detailAddresView),ORIGIN_Y( _detailAddresView) + span,FRAMNE_W(_detailAddresView) ,FRAMNE_H(_detailAddresView));
    }
    if([textView.text isEqualToString:@""]){
        
        _detailAddressLabel.hidden = NO;
    }else{
        _detailAddressLabel.hidden = YES;
    }
    
}

#pragma SelectDelegate

-(void)sendCityStr:(NSString *)sStr chengshi:(NSString *)cStr quxiang:(NSString *)qStr
{
    NSString * cityString = [NSString stringWithFormat:@"%@%@%@",sStr,cStr,qStr];
    _areaNameLabel.text = cityString;
    saveCountry = sStr;
    saveCity = cStr;
    saveArea = qStr;
}

//选择滚筒 点击事件
- (IBAction)selectCityButtonCliked:(id)sender {
   
    if(isSelect){
        isSelect = NO;
        _areaNameLabel.text = @"北京北京市东城区";
        saveCountry = @"北京";
        saveCity = @"北京市";
        saveArea = @"东城区";
    }
    [_deatilAddresTextView resignFirstResponder];
    [_harvestAddressTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    [self editeEnd];

    if(self.selectView.hidden){
        [ self.selectView showPicker:self.view];
    }
}

//保存
- (void)rightBackCliked:(UIButton *)sender{
    
    [ self.selectView cancelPicker];
    [self.harvestAddressTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.deatilAddresTextView resignFirstResponder];
    [self editeEnd];
    
    if ([_areaNameLabel.text isEqualToString:@"省、市、区"]){
        _popShowView.hidden = NO;
        _popShowLabel.text = @"抱歉，请选择省、市、区";
        [self popShowViewDalyHide];

    }else if(_deatilAddresTextView.text.length == 0){
        _popShowView.hidden = NO;
        _popShowLabel.text = @"详细地址不能为空";
        [self popShowViewDalyHide];

    }else if(_harvestAddressTextField.text.length == 0){
        _popShowView.hidden = NO;
        _popShowLabel.text = @"收货人姓名不能为空";
        [self popShowViewDalyHide];

    }
        else if(![MarketAPI isHasNumder:_harvestAddressTextField.text]){

        _popShowView.hidden = NO;
        _popShowLabel.text = @"请输入正确的收货人姓名";
        [self popShowViewDalyHide];
        
    }
    else if(_phoneTextField.text.length==0){
        _popShowView.hidden = NO;
        _popShowLabel.text = @"手机号码不能为空";
        [self popShowViewDalyHide];

    }else if(_deatilAddresTextView.text.length > 60||_deatilAddresTextView.text.length <5){
        
        _popShowView.hidden = NO;
        _popShowLabel.text = @"详细地址仅支持5~60个字符";
        [self popShowViewDalyHide];
        
    }else if(_harvestAddressTextField.text.length >15||_harvestAddressTextField.text.length <2){
        
        _popShowView.hidden = NO;
        _popShowLabel.text = @"收货人姓名仅支持2~15个字符";
        [self popShowViewDalyHide];
        
    }else if(![MarketAPI isHasSpecialcharacters:_deatilAddresTextView.text]){
        
        _popShowView.hidden = NO;
        _popShowLabel.text = @"详细地址不支持输入特殊字符";
        [self popShowViewDalyHide];
        
    }else if(![MarketAPI isMobileNumber:_phoneTextField.text]){
        
        _popShowView.hidden = NO;
        _popShowLabel.text = @"手机号码号格式不正确!";
        [self popShowViewDalyHide];
        
    }else {
        [self requestSaveAddress];
    }
}


-(void)deletePlace
{
    _deatilAddresTextView.text = [_deatilAddresTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    _harvestAddressTextField.text = [_harvestAddressTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
   
}

- (void)popManageController
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    [ self.selectView cancelPicker];
    [_deatilAddresTextView resignFirstResponder];
    [_harvestAddressTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    [self editeEnd];
}

#pragma UITextFiled Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self editeEnd];

    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [ self.selectView cancelPicker];
    [self editeBegin];

}

//键盘动画效果
-(void)editeBegin
{
    if(!IPHONE5){
        [UIView animateWithDuration:0.3 animations:^{
            _areaView.frame = CGRectMake(areaFrame.origin.x, areaFrame.origin.y -70, areaFrame.size.width, areaFrame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)editeEnd
{
    if(!IPHONE5){
        [UIView animateWithDuration:0.3 animations:^{
            _areaView.frame = areaFrame;
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark - Request
-(void)requestSaveAddress
{

    [self startActivity];
    mRequest = [MarketAPI requestEdit5002WithController:self oderNum:@"" addressCity:[NSString stringWithFormat:@"%@-%@-%@",saveCountry,saveCity,saveArea] detailAddress:_deatilAddresTextView.text connectName:_harvestAddressTextField.text iphone:_phoneTextField.text];
    [self deletePlace];
       
}



- (void)requestFinished:(ASIHTTPRequest *)request;
{
    [self stopActivity];
    NSString *tEndString=[[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    tEndString = [tEndString stringByReplacingOccurrencesOfString:@"\n" withString:@"\n"];
    NSDictionary * dict  = [tEndString JSONValue];
    if (!dict ){
        NSLog(@"接口错误");
        return;
    }
    if(request.tag == 5002 ){
        if ([[dict objectForKey:@"code"]integerValue]==0){  //返回成功
             [self showMsg:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
            [self performSelector:@selector(popManageController) withObject:self afterDelay:1];
            
        } else{
             [self showMsg:dict[@"message"]];
        }
    }

}

- (void)requestFailed:(ASIHTTPRequest *)request;
{
    [self stopActivity];
    [self showMsg:@"请求失败，请检查网路设置"];
}

@end
