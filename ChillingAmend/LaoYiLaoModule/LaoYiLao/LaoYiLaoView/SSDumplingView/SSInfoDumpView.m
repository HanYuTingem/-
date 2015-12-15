//
//  SSInfoDumpView.m
//  LaoYiLao
//
//  Created by sunsu on 15/11/30.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import "SSInfoDumpView.h"



#define labelViewHeight  (KPercenY * (410.0/2))
#define functionBtnHeight (KPercenY * (160.0/2))

@interface SSInfoDumpView()
{
    //捞到饺子信息view
    UIView * _labelView;
    
    UIImageView * _jiaoziImgView;//饺子图片
    UILabel  * _moneyOfJiaoziLabel;//捞到多少个饺子label
    

    //按钮的view
    UIView * _buttonsView;
    
    FunctionBtn * _blessBtn;
    FunctionBtn * _collectionBtn;
    FunctionBtn * _hekaBtn;
    
    UIButton  * _xuanyaoBtn;

    NSString * _modelStr1;

    

}
@end

@implementation SSInfoDumpView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        _modelStr1 = @"";
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)initUI{

       //图片和捞到的饺子个数
    _labelView = [[UIView alloc]init];
    [self addSubview:_labelView];
    
    _jiaoziImgView = [[UIImageView alloc]init];
    [_labelView addSubview:_jiaoziImgView];
    _moneyOfJiaoziLabel = [[UILabel alloc]init];
    [_labelView addSubview:_moneyOfJiaoziLabel];
    
    
    //buttons view
    _buttonsView = [[UIView alloc]init];
    
    [self addSubview:_buttonsView];
    
    _blessBtn = [[FunctionBtn alloc]init];
    [_buttonsView addSubview:_blessBtn];
    
    _collectionBtn = [[FunctionBtn alloc]init];
    [_buttonsView addSubview:_collectionBtn];
    
    _hekaBtn = [[FunctionBtn alloc]init];
    [_buttonsView addSubview:_hekaBtn];
    
    _xuanyaoBtn = [[UIButton alloc]init];
    [_buttonsView addSubview:_xuanyaoBtn];
    
    [self labelView];
    [self buttonsView];
}


- (void) labelView{
    CGFloat Start_Y = 90.0/2;
    CGFloat imgW = 193.0/2;
    CGFloat imgH = 176.0/2;
    
    CGRect jiaoziFrame = CGRectMake((kkViewWidth-imgW)/2,Start_Y, imgW, imgH);
    _jiaoziImgView.frame = jiaoziFrame;
    
    CGRect moneyFrame = CGRectMake(0, CGRectGetMaxY(_jiaoziImgView.frame)+29/2, kkViewWidth, 30);
    _moneyOfJiaoziLabel.frame = moneyFrame;
    
    CGRect labelFrame = CGRectMake(0, 0, kkViewWidth,labelViewHeight);
    _labelView.frame = labelFrame;
    
    _labelView.backgroundColor = [UIColor colorWithPatternImage:[LYLTools scaleImage:[UIImage imageNamed:@"lao_bg"] ToSize:CGSizeMake(kkViewWidth,labelViewHeight )]];
//    _labelView.backgroundColor  = [UIColor whiteColor];
    _jiaoziImgView.image = [UIImage imageNamed:@"0_jiaozi"];
}

- (void) buttonsView{
    CGFloat btnView_Y = CGRectGetMaxY(_labelView.frame)+ 12;
    _buttonsView.frame = CGRectMake(0, btnView_Y, kkViewWidth,100);//self.frame.size.height-50-labelViewHeight
//    _buttonsView.backgroundColor = [UIColor clearColor];
    _buttonsView.userInteractionEnabled = YES;
    int btnCount = 3;
    CGFloat btn_W = 35;
    CGFloat btn_X = (kkViewWidth - btnCount*35)/(btnCount+1);
    CGFloat btn_Y = 0;
    
    _blessBtn.frame = CGRectMake(btn_X, btn_Y, btn_W, functionBtnHeight);
    
    _collectionBtn.frame = CGRectMake(btn_X+CGRectGetMaxX(_blessBtn.frame), btn_Y, btn_W, functionBtnHeight);
    _hekaBtn.frame = CGRectMake(btn_X+CGRectGetMaxX(_collectionBtn.frame), btn_Y, btn_W, functionBtnHeight);
    
    
    
    CGFloat xuanyaoY = CGRectGetMaxY(_blessBtn.frame)+74/2;
    _xuanyaoBtn .frame = CGRectMake((kkViewWidth-300/2)/2, xuanyaoY, 300/2, 64/2);
    [_xuanyaoBtn setBackgroundImage:[UIImage imageNamed:@"button_xuanyao"] forState:UIControlStateNormal];
    [_xuanyaoBtn setTitle:@"炫耀一下" forState:UIControlStateNormal];
    [_xuanyaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _xuanyaoBtn.titleLabel.font = UIFont24;
    _xuanyaoBtn.userInteractionEnabled = YES;
    
    [_blessBtn addTarget:self action:@selector(xianjin) forControlEvents:UIControlEventTouchUpInside];
    [_collectionBtn addTarget:self action:@selector(youhuiquan) forControlEvents:UIControlEventTouchUpInside];
    [_hekaBtn addTarget:self action:@selector(heka) forControlEvents:UIControlEventTouchUpInside];
    [_xuanyaoBtn addTarget:self action:@selector(xuanyaoyixia) forControlEvents:UIControlEventTouchUpInside];
    

}

//设置字体颜色大小
- (void)settingLabelAttributedWithLabel:(UILabel *)label String:(NSString *)textStr modelStr:(NSString *)modelStr str2:(NSString *)str2 str3:(NSString *)str3 font1:(UIFont *)font1 font2:(UIFont *)font2 font3:(UIFont *)font3 color1:(UIColor *)color1 color2:(UIColor *)color2 color3:(UIColor *)color3{
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:textStr];
    NSRange range = [textStr rangeOfString:modelStr];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.paragraphSpacing = 0;
    
    style.alignment = NSTextAlignmentCenter;
    NSDictionary * adic = @{NSFontAttributeName :font1,NSForegroundColorAttributeName:color1,NSParagraphStyleAttributeName:style};
    [AttributedStr addAttributes:adic range:range];
    
    NSRange range2 = [textStr rangeOfString:str2];
    NSDictionary * bdic = @{NSFontAttributeName :font2,NSForegroundColorAttributeName:color2,NSParagraphStyleAttributeName:style};
    [AttributedStr addAttributes:bdic range:range2];
    
    NSRange range3 = [textStr rangeOfString:str3];
    NSDictionary * cdic = @{NSFontAttributeName :font3,NSForegroundColorAttributeName:color3,NSParagraphStyleAttributeName:style};
    [AttributedStr addAttributes:cdic range:range3];
    [label setAttributedText: AttributedStr];
}


-(void)setMyDumModel:(SSMyDumplingModel *)myDumModel{
    _myDumModel = myDumModel;
    CGRect moneyFrame = CGRectMake(0, CGRectGetMaxY(_jiaoziImgView.frame)+29/2, kkViewWidth, 30);
    _moneyOfJiaoziLabel.frame = moneyFrame;
    
    _modelStr1 = _myDumModel.resultListModel.count;
    NSString  *textStr1 = [NSString stringWithFormat:@"捞到 %@ 个饺子",_modelStr1];
    _moneyOfJiaoziLabel.text = textStr1;
    
    _moneyOfJiaoziLabel.textAlignment = NSTextAlignmentCenter;
    UIColor * color = [UIColor blackColor];
    [self settingLabelAttributedWithLabel:_moneyOfJiaoziLabel String:textStr1 modelStr:_modelStr1 str2:@"捞到" str3:@"个饺子" font1:UIFont50 font2:UIFont24 font3:UIFont24 color1:color color2:color color3:color];
    
    NSString * price = [NSString stringWithFormat:@"%.2f元",[_myDumModel.resultListModel.price floatValue]];
    NSString * coupon = [NSString stringWithFormat:@"%@张",_myDumModel.resultListModel.couponNumber];
    NSString * card = [NSString stringWithFormat:@"%@张",_myDumModel.resultListModel.cardNumber];
    
    [_blessBtn FunctionBtnWithCount:price Img:@"iconfont-xianjinzhanghu01" title:@"现金"];
    [_collectionBtn FunctionBtnWithCount:coupon Img:@"iconfont-youhuiquan" title:@"优惠券"];
    [_hekaBtn FunctionBtnWithCount:card Img:@"iconfont-faheqia" title:@"贺卡"];
    
    }


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat btnView_Y = CGRectGetMaxY(_labelView.frame)+ 12;
    _buttonsView.frame = CGRectMake(0, btnView_Y, kkViewWidth,self.frame.size.height-labelViewHeight);//self.frame.size.height-50-labelViewHeight
    _buttonsView.backgroundColor = RGBACOLOR(242, 242, 242, 1);
}

#pragma mark buttonDelegate


- (void) heka{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ClickHeka)]) {
        [self.delegate ClickHeka];
    }
}
- (void) xianjin{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ClickXianjin)]) {
        [self.delegate ClickXianjin];
    }
}

- (void) youhuiquan{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ClickYouhuiquan)]) {
        [self.delegate ClickYouhuiquan];
    }
}

- (void)xuanyaoyixia{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ClickXuanyaoyixia:)]) {
        [self.delegate ClickXuanyaoyixia:_xuanyaoBtn];
    }
}

@end
