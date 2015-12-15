//
//  GDHInputPassWordView.m
//  Wallet
//
//  Created by GDH on 15/10/26.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "GDHInputPassWordView.h"


#import "GDHPasswordBox.h"

@interface GDHInputPassWordView ()
{
    GDHPasswordBox *passWord;
    UILabel *_shouldPayMoneyLabel;
}

@end

@implementation GDHInputPassWordView

-(instancetype)initWithFrame:(CGRect)frame andPayMoney:(NSString *)payMoney{
    if (self = [super initWithFrame:frame]) {
        
        
        UILabel *shouldPayMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.frame.size.width, 20)];
        shouldPayMoneyLabel.textAlignment = NSTextAlignmentCenter;
        shouldPayMoneyLabel.textColor = [UIColor colorWithRed:0.22f green:0.22f blue:0.22f alpha:1.00f];
        shouldPayMoneyLabel.font = [UIFont boldSystemFontOfSize:18];
        [self addSubview:shouldPayMoneyLabel];
        shouldPayMoneyLabel.text  = payMoney;
        _shouldPayMoneyLabel = shouldPayMoneyLabel;
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CGRectMake(self.frame.size.width - 30, 5, 25, 25);
        [closeButton addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
        [closeButton setImage:[UIImage imageNamed:@"content_ico_delete"] forState:UIControlStateNormal];
        [self addSubview:closeButton];
        /**  密码框  */
        passWord = [[GDHPasswordBox alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(shouldPayMoneyLabel.frame), self.frame.size.width - 30, 94)];
        passWord.backgroundColor = [UIColor yellowColor];
        passWord.backgroundColor =[UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f];
        passWord.titleLabel.text = @"请输入支付密码";
        
        __weak GDHInputPassWordView *tempView = self;
        passWord.passWordBlock = ^(NSString *thePassWord){
        
            // 回调。
            
            tempView.payPassWordBlock(thePassWord);

        
        };
        [self addSubview:passWord];
        
        
        UIButton *findButton = [UIButton buttonWithType:UIButtonTypeCustom];
        findButton.frame = CGRectMake(self.frame.size.width - 65, CGRectGetMaxY(passWord.frame)+10, 57, 15);
        [self addSubview:findButton];

//        [findButton setImage:[UIImage imageNamed:@"content_btn_link_01"] forState:UIControlStateNormal];
        [findButton setBackgroundImage:[UIImage imageNamed:@"content_btn_link_01"] forState:UIControlStateNormal];
        [findButton addTarget:self action:@selector(findButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
/** 关闭按钮 */
-(void)closeButton:(UIButton *)closeButton{
    self.closeBlock(closeButton);
}
/**  找回密码 */
-(void)findButton:(UIButton *)findButton{
    self.findBlock(findButton);
}
/** 清空密码 */
- (void)clearTextPassWordWithOneTextFiledEnabled:(BOOL)oneTextFiledEnabled
{
    passWord.numTextfiledOne.text = @"";
    passWord.numTextfiledTwo.text = @"";
    passWord.numTextfiledThree.text = @"";
    passWord.numTextfiledFour.text = @"";
    passWord.numTextfiledFive.text = @"";
    passWord.numTextfiledSix.text = @"";
    
    passWord.numTextfiledOne.enabled = oneTextFiledEnabled;
    passWord.numTextfiledTwo.enabled = NO;
    passWord.numTextfiledThree.enabled = NO;
    passWord.numTextfiledFour.enabled = NO;
    passWord.numTextfiledFive.enabled = NO;
    passWord.numTextfiledSix.enabled = NO;
//    if (oneTextFiledEnabled) {
//        [passWord.numTextfiledOne becomeFirstResponder];
//    } else {
//        [passWord.numTextfiledOne resignFirstResponder];
//    }
}

- (void)setPayMoney:(NSString *)payMoney
{
    _shouldPayMoneyLabel.text = payMoney;
}
/** 调出键盘 */
- (void)theKeyboardShow{
    [passWord.numTextfiledOne becomeFirstResponder];
}

/** 推出键盘 */
- (void)theKeyboardResign
{
    [passWord.numTextfiledOne resignFirstResponder];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
