//
//  QuickLoginView.m
//  LaoYiLao
//
//  Created by sunsu on 15/11/7.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "QuickLoginView.h"

#define PADDING 10

@interface QuickLoginView ()
{
    UITextField  * _QuserNameTF;
    UITextField  * _QpassWordTF;
    UIButton     * _QverifyCodeBtn;
    UIButton     * _QloginBtn;
    UIButton     * _QserviceAgreementBtn;
}

@end


@implementation QuickLoginView


- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        self.backgroundColor = RGBACOLOR(242, 242, 242, 1);
    }
    return self;
}

-(void)initUI{
    CGFloat Start_Y = 0;
    UIImageView* phonenumimg= [[UIImageView alloc] initWithFrame:CGRectMake(PADDING, Start_Y+20, kkViewWidth-2*PADDING, 40)];
    [phonenumimg setImage:[LYLTools resizedImageWithName:@"content_img_editor"]];
    phonenumimg.userInteractionEnabled = YES;
    [self addSubview:phonenumimg];
    
    UIImageView* phone = [[UIImageView alloc] initWithFrame:CGRectMake(PADDING, (phonenumimg.frame.size.height-18)/2, 14, 18)];
    
    phone.image = [UIImage imageNamed:@"content_btn_phone"];
    [phonenumimg addSubview:phone];
    
    _phonetextfield = [[UITextField alloc] init];
    _phonetextfield.frame = CGRectMake(35, 11, phonenumimg.frame.size.width-phone.frame.size.width-10-8, 18);
    _phonetextfield.font = [UIFont systemFontOfSize:15];
    _phonetextfield.keyboardType = UIKeyboardTypeNumberPad;
    _phonetextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phonetextfield.placeholder = @"请输入手机号";
    [phonenumimg addSubview:_phonetextfield];
    
    UIImageView* numbersimg= [[UIImageView alloc] initWithFrame:CGRectMake(PADDING, CGRectGetMaxY(phonenumimg.frame)+20, kkViewWidth-115-3*PADDING, 40)];
    [numbersimg setImage:[LYLTools resizedImageWithName:@"content_img_editor"]];
    numbersimg.userInteractionEnabled = YES;
    [self addSubview:numbersimg];
    
    UIImageView* yjicon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 14, 18)];
    yjicon.image = [UIImage imageNamed:@"content_btn_password-1"];
    [numbersimg addSubview:yjicon];
    
    _yzmtextfileld= [[UITextField alloc] init];
    _yzmtextfileld.frame = CGRectMake(35, 11, 150, 18);
    _yzmtextfileld.keyboardType = UIKeyboardTypeNumberPad;
    [numbersimg addSubview:_yzmtextfileld];
    
    _yzmtextfileld.font = [UIFont systemFontOfSize:15];
    
    _yzmtextfileld.placeholder = @"请输入验证码";
    
    UIButton* getnumbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getnumbtn addTarget:self action:@selector(getnumbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
    getnumbtn.frame = CGRectMake(kkViewWidth-PADDING-115, CGRectGetMaxY(phonenumimg.frame)+20, 115, 40);
    [getnumbtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getnumbtn setBackgroundColor:[UIColor colorWithPatternImage:[LYLTools scaleImage:[UIImage imageNamed:@"lao_bg"] ToSize:CGSizeMake(getnumbtn.frame.size.width, getnumbtn.frame.size.height)]]];
//    [getnumbtn setBackgroundImage:[LYLTools scaleImage:[UIImage imageNamed:@"lao_bg"] ToSize:CGSizeMake(getnumbtn.frame.size.width, getnumbtn.frame.size.height)] forState:UIControlStateHighlighted];

    getnumbtn.titleLabel.font = [UIFont systemFontOfSize:14
                                 ];
    getnumbtn.tag = 999;
//    getnumbtn.backgroundColor = RGBACOLOR(37, 169, 161, 1);
    getnumbtn.layer.masksToBounds = YES;
    getnumbtn.layer.cornerRadius = 5;
    [self addSubview:getnumbtn];
    
    UIButton* tijiaobtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tijiaobtn.frame = CGRectMake(PADDING, CGRectGetMaxY(getnumbtn.frame)+40, kkViewWidth-2*PADDING, 37);
    [self addSubview:tijiaobtn];
    
    [tijiaobtn setTitle:@"登录" forState:UIControlStateNormal];
    [tijiaobtn addTarget:self action:@selector(tijiaobtnclicked) forControlEvents:UIControlEventTouchUpInside];
    [tijiaobtn setBackgroundImage:[LYLTools scaleImage:[UIImage imageNamed:@"lao_bg"] ToSize:CGSizeMake(tijiaobtn.frame.size.width, tijiaobtn.frame.size.height)] forState:UIControlStateNormal];
    [tijiaobtn setBackgroundImage:[LYLTools scaleImage:[UIImage imageNamed:@"lao_bg"] ToSize:CGSizeMake(tijiaobtn.frame.size.width, tijiaobtn.frame.size.height)] forState:UIControlStateHighlighted];


//    tijiaobtn.backgroundColor = RGBACOLOR(37, 169, 161, 1);
    tijiaobtn.layer.masksToBounds = YES;
    tijiaobtn.layer.cornerRadius = 5;
    
    
    
    CGRect severFrame = CGRectMake((kkViewWidth-130-70)/2, CGRectGetMaxY(tijiaobtn.frame)+5,130,30);
    UILabel * alabel = [[UILabel alloc]initWithFrame:severFrame];
    alabel.text = @"点击登录,即表示同意";
    alabel.font = UIFont22;
    alabel.textColor = [UIColor blackColor];
    alabel.textAlignment = NSTextAlignmentRight;
//    [alabel sizeToFit];
    [self addSubview:alabel];
    
    CGRect agreeFrame = CGRectMake(CGRectGetMaxX(alabel.frame), CGRectGetMaxY(tijiaobtn.frame)+5,70,30);
    UIButton * QserverAgreementBtn = [[UIButton alloc]initWithFrame:agreeFrame];
    [self addSubview:QserverAgreementBtn];
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:@"《服务协议》"];
    NSRange strRange = {0,[str length]};
    NSDictionary * adic = @{NSFontAttributeName :UIFont22,NSForegroundColorAttributeName:[UIColor blueColor],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    [str addAttributes:adic range:strRange];
    [QserverAgreementBtn setAttributedTitle:str forState:UIControlStateNormal];
    [QserverAgreementBtn addTarget:self action:@selector(agreeMentClicked) forControlEvents:UIControlEventTouchUpInside];

}

-(void)getnumbtnclicked:(UIButton*)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(getnumbtnclick:)]) {
        [self.delegate getnumbtnclick:sender];
    }
}

-(void)tijiaobtnclicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tijiaobtnclick)]) {
        [self.delegate tijiaobtnclick];
    }
}

-(void)agreeMentClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(serverAgreementClicked)]) {
        [self.delegate serverAgreementClicked];
    }
}

@end
