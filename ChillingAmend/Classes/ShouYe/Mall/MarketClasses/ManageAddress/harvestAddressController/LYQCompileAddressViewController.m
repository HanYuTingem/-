//
//  LYQCompileAddressViewController.m
//  MarketManage
//
//  Created by 劳大大 on 15/4/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LYQCompileAddressViewController.h"
#import "SelectCityView.h"
#import "CrazyBasisAlertView.h"
#import "MarketAPI.h"
@interface LYQCompileAddressViewController ()
<selectDelegate,UITextViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    //原来的地址
    NSString  * originalAddressStr;
    //修改后的地址
    NSString  * todayAddressStr;
    ASIFormDataRequest * mRequest;
    NSString * saveCountry;
    NSString * saveCity ;
    NSString * saveArea;


}
//城市的选择
@property (nonatomic,strong)    SelectCityView *selectView ;
//昵称
@property (weak, nonatomic) IBOutlet UITextField *editNickNameTextFiled;
//手机号码
@property (weak, nonatomic) IBOutlet UITextField *editIphoneTextFiled;
//城市
@property (weak, nonatomic) IBOutlet UITextField *editCityNameTextFiled;
//详细地址
@property (weak, nonatomic) IBOutlet UITextView *editDetailTextView;
//设置为默认地址
- (IBAction)setDefaultAddress:(id)sender;
//保存修改的地址
- (IBAction)saveEditAddress:(id)sender;

@end

@implementation LYQCompileAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加城市的选择
    [self addSelectCity];
    //chushihua
    [self initData];
    //添加手势
    [self addAGesutreRecognizerForYourView];
  
    // Do any additional setup after loading the view from its nib.
}
//添加城市的选择
- (void)addSelectCity
{
    self.selectView = [[SelectCityView alloc]initWithFrame:CGRectMake(0,self.view.bounds.size.height-216, SCREENWIDTH, 216)];
    self.selectView.delegate = self;
    [self.view addSubview:self.selectView];
    self.selectView.hidden = YES;
}
#pragma SelectDelegate

-(void)sendCityStr:(NSString *)sStr chengshi:(NSString *)cStr quxiang:(NSString *)qStr
{
    NSString * cityString = [NSString stringWithFormat:@"%@-%@-%@",sStr,cStr,qStr];
    _editCityNameTextFiled.text = cityString;
    saveCountry = sStr;
    saveCity = cStr;
    saveArea = qStr;
}
//初始化数据
- (void)initData
{
    self.editCityNameTextFiled.delegate = self;
    self.editIphoneTextFiled.delegate   = self;
    self.editDetailTextView.delegate    = self;
    self.editNickNameTextFiled.delegate = self;

    saveCountry = @"";
    saveCity    = @"";
    saveArea    = @"";
    self.editCityNameTextFiled.text = IfNullToString(_indexPatchDict[@"area"]);
    self.editIphoneTextFiled.text   = IfNullToString(_indexPatchDict[@"connect_tel"]);
    self.editNickNameTextFiled.text = IfNullToString(_indexPatchDict[@"connect_name"]);
    self.editDetailTextView.text    = IfNullToString(_indexPatchDict[@"address"]);

    //原来的地址
    originalAddressStr = [NSString stringWithFormat:@"%@%@%@%@",self.editNickNameTextFiled.text,self.editIphoneTextFiled.text,self.editCityNameTextFiled.text,self.editDetailTextView.text];
    //修改后的地址
    todayAddressStr =[NSString stringWithFormat:@"%@%@%@%@",self.editNickNameTextFiled.text,self.editIphoneTextFiled.text,self.editCityNameTextFiled.text,self.editDetailTextView.text];
    
      self.mallTitleLabel.text = @"收货地址";
    [self.rightButton setTitle:@"删除" forState:UIControlStateNormal];
    self.rightButton.frame = CGRectMake(self.view.frame.size.width - 50,20, 40, 44);
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

//添加点击事件
- (void)addAGesutreRecognizerForYourView
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedDetected:)]; // 手势类型随你喜欢。
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
}
//方法
- (void) tapGesturedDetected:(UITapGestureRecognizer *)recognizer

{
    [ self.selectView cancelPicker];
    [[[[UIApplication sharedApplication]delegate]window] endEditing:YES];
    // do something
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
    if (_editDetailTextView== textView)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 60) { //如果输入框内容大于60 则不能输入
            return NO;
        }
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == self.editCityNameTextFiled){
        [textField resignFirstResponder];
        [self.selectView showPicker:self.view];
    }else{
        [ self.selectView cancelPicker];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//textField
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]){
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (_editIphoneTextFiled== textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 11) { //如果输入框内容大于11 则不能输入
            return NO;
        }
    }
    return YES;
}
/*请求删除地址
 */
-(void)requetDelAddress
{
    mRequest = [MarketAPI requestAddressDelete5003WithController:self oderNum:_indexPatchDict[@"id"] action:@"1" tag:50031];

}
/*请求设置默认地址
 */
-(void)requestSetDefaultAddress
{
    mRequest = [MarketAPI requestAddressDelete5003WithController:self oderNum:_indexPatchDict[@"id"] action:@"2" tag:50032];
}
//编辑地址
- (void)requestSaveAddress
{
    mRequest = [MarketAPI requestEdit5002WithController:self oderNum:_indexPatchDict[@"id"] addressCity:_editCityNameTextFiled.text detailAddress:_editDetailTextView.text connectName:_editNickNameTextFiled.text iphone:_editIphoneTextFiled.text];
       
}


#pragma mark - RequestDelegate
//成功的方法
- (void)requestFinished:(ASIHTTPRequest *)request;
{    [self stopActivity];
    NSString *tEndString=[[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    tEndString = [tEndString stringByReplacingOccurrencesOfString:@"\n" withString:@"\n"];
    NSDictionary * dict  = [tEndString JSONValue];
    NSLog(@"%@",dict);
    if (!dict ){
        NSLog(@"接口错误");
        return;
    }
    
   if (request.tag ==50031){//删除
       
        if ([[dict objectForKey:@"code"]integerValue]==0){
            [self showMsg:@"删除成功"];
            [self.navigationController popViewControllerAnimated:YES];

        }else{
            [self showMsg:dict[@"message"]];
        }
    }else if(request.tag == 50032){//设置默认
        if ([[dict objectForKey:@"code"]integerValue]==0){
            
            [self showMsg:@"设置成功"];
            [self.navigationController popViewControllerAnimated:YES];

        }else{
            [self showMsg:dict[@"message"]];
        }
    }else{
          if ([[dict objectForKey:@"code"]integerValue]==0){  //返回成功
                
            [self showMsg:@"修改成功"];
              [self.navigationController popViewControllerAnimated:YES];

            } else{
                [self showMsg:dict[@"message"]];
            }
    }


    
}
//失败的方法
- (void)requestFailed:(ASIHTTPRequest *)request;
{
    [self stopActivity];
    [self showMsg:@"请求失败，请检查网路设置"];
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

//判断条件是否满足
- (BOOL)conditionLimit
{
    if ([_editCityNameTextFiled.text isEqualToString:@""]){
        [self showMsg:@"抱歉，请选择省、市、区"];
        return NO;

    }else if(_editDetailTextView.text.length == 0){
        [self showMsg:@"详细地址不能为空"];
        return NO;

    }else if(_editNickNameTextFiled.text.length == 0){
        [self showMsg:@"收货人姓名不能为空"];
        return NO;

    }
    else if(![MarketAPI isHasNumder:_editNickNameTextFiled.text]){
        
        [self showMsg:@"请输入正确的收货人姓名"];
        return NO;

    }else if(self.editIphoneTextFiled.text.length==0){
        [self showMsg:@"手机号码不能为空"];
        return NO;

    }else if(_editDetailTextView.text.length > 60||_editDetailTextView.text.length <5){
        
        [self showMsg:@"详细地址仅支持5~60个字符"];
        return NO;

    }else if(_editNickNameTextFiled.text.length >15||_editNickNameTextFiled.text.length <2){
        
        [self showMsg:@"收货人姓名仅支持2~15个字符"];
        return NO;

    }else if(![MarketAPI isHasSpecialcharacters:_editDetailTextView.text]){
        
        [self showMsg:@"详细地址不支持输入特殊字符"];
        return NO;

    }else if(![MarketAPI isMobileNumber:_editIphoneTextFiled.text]){
        
        [self showMsg:@"手机号码号格式不正确!"];
        return NO;

    }else  {
        todayAddressStr =[NSString stringWithFormat:@"%@%@%@%@",self.editNickNameTextFiled.text,self.editIphoneTextFiled.text,self.editCityNameTextFiled.text,self.editDetailTextView.text];
        return YES;
    }
    
    return NO;

}

//设置为默认地址
- (IBAction)setDefaultAddress:(id)sender {
    
    if([self conditionLimit]){
        //设置的默认地址判断是否是先进来的地址
        if([originalAddressStr isEqualToString:todayAddressStr]){
            
            [self requestSetDefaultAddress];
        }else{
            [self showMsg:@"请先保存您修改的收获管理地址"];

        }
    }
    
}

//保存编辑的地址
- (IBAction)saveEditAddress:(id)sender {
    
    if([self conditionLimit]){
        [self requestSaveAddress];
    }
}

//删除的操作
- (void)rightBackCliked:(UIButton *)sender{
    
    
    
    
    if([self conditionLimit]){
        //删除的操作否是先进来的地址
        if([originalAddressStr isEqualToString:todayAddressStr]){
            [CrazyBasisAlertView CrazyBasisAlertViewShowTitle:@"" content:@"你确定要删除该地址吗？"buttonTextArray:@[@"取消",@"确定"] leftSelectBlock:^(CrazyBasisButton *confirmButton) {
            } rigthSelectBlock:^(CrazyBasisButton *cancelBlock) {
                [self requetDelAddress];
            }];

        }else{
            [self showMsg:@"请选择填写的收货管理地址"];

        }
    }

}

//按钮返回的操作
-(void)leftBackCliked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
