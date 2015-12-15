//
//  ChangePhoneNumViewController.m
//  QQList
//
//  Created by sunsu on 15/6/30.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "ChangePhoneNumViewController.h"

@interface ChangePhoneNumViewController (){
    NSTimer* timer; //  计时
    int  timecoutn ;
    UITextField* phonetextfield;    //  输入电话
    UITextField* yzmtextfileld ;    //  验证码
    NSString * numstr;              //  校验
}


@end

@implementation ChangePhoneNumViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [timer invalidate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    timecoutn = 59;
    titleButton.hidden = NO;
    [titleButton setTitle:@"修改订座电话" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self createview];
    
    
}


-(void)createview{
    UILabel* label = [[UILabel alloc] init];
    [label setFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
    [label setBackgroundColor:[UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:235.0f/255.0f alpha:1]];
    label.font = [UIFont systemFontOfSize:15];
    label.text = [NSString stringWithFormat:@"  需要%@？请验证一下哦~",self.title];
    label.textColor =[UIColor colorWithRed:142.0f/255.0f green:142.0f/255.0f blue:142.0f/255.0f alpha:1];
    [self.view addSubview:label];
    
    UIImageView* phonenumimg= [[UIImageView alloc] initWithFrame:CGRectMake(PADDING, CGRectGetMaxY(label.frame)+5, SCREEN_WIDTH-2*PADDING, 40)];
    [phonenumimg setImage:[UIImage imageNamed:@"settingmessagelogin_function_edit_bg"]];
    phonenumimg.userInteractionEnabled = YES;
    [self.view addSubview:phonenumimg];
    
    UIImageView* phone = [[UIImageView alloc] initWithFrame:CGRectMake(PADDING, (phonenumimg.frame.size.height-18)/2, 17, 18)];
    phone.image = [UIImage imageNamed:@"settingmessagelogin_function_ico_phone"];
    [phonenumimg addSubview:phone];
    
    phonetextfield = [[UITextField alloc] init];
    phonetextfield.frame = CGRectMake(35, 11, 200, 18);
    phonetextfield.borderStyle =  UITextBorderStyleNone;
    phonetextfield.font = [UIFont systemFontOfSize:15];
    phonetextfield.placeholder = @"请输入11位真实手机号";
    [phonenumimg addSubview:phonetextfield];
    
    UIImageView* numbersimg= [[UIImageView alloc] initWithFrame:CGRectMake(PADDING, CGRectGetMaxY(phonenumimg.frame)+5, SCREEN_WIDTH-115-3*PADDING, 40)];
    [numbersimg setImage:[UIImage imageNamed:@"settingmessagelogin_function_edit_bg"]];
    numbersimg.userInteractionEnabled = YES;
    [self.view addSubview:numbersimg];
    
    UIImageView* yjicon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 18, 18)];
    yjicon.image = [UIImage imageNamed:@"settingmessagelogin_function_ico_message"];
    [numbersimg addSubview:yjicon];
    
    yzmtextfileld= [[UITextField alloc] init];
    yzmtextfileld.frame = CGRectMake(35, 11, 150, 18);
    yzmtextfileld.borderStyle =  UITextBorderStyleNone;
    [numbersimg addSubview:yzmtextfileld];
    yzmtextfileld.font = [UIFont systemFontOfSize:15];
    
    yzmtextfileld.placeholder = @"请输入收到的验证码";
    
    UIButton* getnumbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getnumbtn setBackgroundImage:[UIImage imageNamed:@"myorder_function_btn_normal"] forState:UIControlStateNormal];
    [getnumbtn setBackgroundImage:[UIImage imageNamed:@"myorder_function_btn_selected"] forState:UIControlStateNormal];
    [getnumbtn addTarget:self action:@selector(getnumbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    getnumbtn.frame = CGRectMake(SCREEN_WIDTH-PADDING-115, CGRectGetMaxY(phonenumimg.frame)+5, 115, 40);
    [getnumbtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    getnumbtn.titleLabel.font = [UIFont systemFontOfSize:14
                                 ];
    getnumbtn.tag = 999;
    [self.view addSubview:getnumbtn];
    
    UIButton* tijiaobtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tijiaobtn.frame = CGRectMake(PADDING, CGRectGetMaxY(getnumbtn.frame)+10, SCREEN_WIDTH-2*PADDING, 37);
    [self.view addSubview:tijiaobtn];
    [tijiaobtn setTitle:@"确定" forState:UIControlStateNormal];
    [tijiaobtn addTarget:self action:@selector(tijiaobtnclick) forControlEvents:UIControlEventTouchUpInside];
    
    [tijiaobtn setBackgroundImage:[UIImage imageNamed:@"activity_content_btn_selected"] forState:UIControlStateNormal];
}


#pragma -mark 方法待实现
-(void)tijiaobtnclick{
    if ([yzmtextfileld.text isEqualToString:numstr]) {
        [self.delegate changePhoneNum:phonetextfield.text];
        //[self returnFontView];
    }else{
        [self showMsg:@"验证码输入不正确"];
    }
}



-(void)getnumbtnclick:(UIButton*)sender{
    if (phonetextfield.text==nil||phonetextfield.text.length==0) {
        [self showMsg:@"请输入手机号码"];
        return;
    }
    
    NSMutableDictionary* canshudic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:phonetextfield.text,@"phone",nil];
    
    //    [WXDataSerice requestWithURL:CUSTOMER_GET_RANDOM params:canshudic completition:^(id result, NSInteger mark) {
    //        ZNLog(@"%@",result);
    //
    //        if (mark == 100) {
    //            if ([[result objectForKey:@"rescode"] isEqualToString:@"0000"]) {
    //                NSDictionary * dic = result;
    //                numstr = [dic objectForKey:@"random"];
    //            }else{
    //                ZNLog(@"%@",[result objectForKey:@"resdesc"]);
    //            }
    //        }
    //    } failed:^(id result, NSInteger mark) {
    //
    //        ZNLog(@"%@",result);
    //    } withtag:100];
    
    
    
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    [sender setTitle:@"获取验证码(60s)" forState:UIControlStateSelected];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timechange) userInfo:nil repeats:YES];
    
}
-(void)timechange{
    
    
    UIButton* label =(UIButton*)[self.view viewWithTag:999];
    [label setTitle:[NSString stringWithFormat:@"获取验证码(%2ds)",timecoutn--] forState:UIControlStateSelected];
    
    if (timecoutn == 0) {
        timecoutn = 59;
        [timer invalidate];
        label.userInteractionEnabled = YES;
        [label setTitle:@"获取验证码" forState:UIControlStateSelected];
    }
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
