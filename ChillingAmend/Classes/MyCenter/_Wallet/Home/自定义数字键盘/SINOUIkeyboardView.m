//
//  SINOUIkeyboardView.m
//  SINOUIKeyboard
//
//  Created by yll on 15/10/28.
//  Copyright © 2015年 yll. All rights reserved.
//

#import "SINOUIkeyboardView.h"
#import "AppDelegate.h"

@interface SINOUIkeyboardView ()
{
    NSString *textStr;
    UITextField *strTextField;
}
@end

@implementation SINOUIkeyboardView

+ (SINOUIkeyboardView *)sharedView{
    static dispatch_once_t once;
    static SINOUIkeyboardView *sharedView;
    dispatch_once(&once, ^ {
        sharedView = [[SINOUIkeyboardView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return sharedView;
}

+(UIView *)keyboardViewDelegate:(id<SINOUIkeyboardViewDelegate>)delegate text:(UITextField *)textField
{
    
    return [[SINOUIkeyboardView sharedView]keyboardViewDelegate:delegate text:textField];
}

- (UIView *)keyboardViewDelegate:(id<SINOUIkeyboardViewDelegate>)delegate text:(UITextField *)textField{
    strTextField = textField;
    self.frame = CGRectMake(0, kScreenHeight, kKeyBoardWidth, kKeyBoardHeight);
    if (self.keyboardbackgroundColor) {
        self.backgroundColor = self.keyboardbackgroundColor;
    }else{
        self.backgroundColor = kKeyboardbackgroundColor;
    }
    NSMutableArray *numArray;
    if (self.keyboardRandom) {
        numArray = [[SINOUIkeyboardView sharedView]GetRandomWithStartIndex:0 andEndIndex:10];
    }
    
    for (int x = 0; x < 12; x++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(kKeyBoardLeft + x%3*(kButtonWidth + kButtonLeft), kKeyBoardTop + x/3*(kButtonHeight + kButtonTop),kButtonWidth, kButtonHeight)];
        btn.layer.borderWidth = kButtonBorderWidth;
        btn.layer.borderColor = kButtonBorderColor;
        if (x < 9)
        {
            if (self.keyboardRandom) {
                [btn setTag:[numArray[x] integerValue]];
            }else{
                [btn setTag:(x + 1)];
            }
            
        }
        else if (x == 9)
        {
            [btn setTag:(x + 1)];
        }
        else if (x == 11)
        {
            btn.tag = x;
        }
        else if (x == 10)
        {
            if (self.keyboardRandom) {
                [btn setTag:[numArray[9] integerValue]];
            }else{
                btn.tag = 0;
            }            
        }
        else
        {
            // btn.tag = x;
        }
        if (self.keyboardbackgroundIsImage) {
            [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"imageName%d",(int)btn.tag]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"imageName%d",(int)btn.tag]] forState:UIControlStateHighlighted];
            if (btn.tag == 10) {
                if (self.keyboardLowerLeftButtonType == KeyboardLowerLeftButtonHidden) {
                    [btn setUserInteractionEnabled:NO];
                }
            }
        }else{
            [[SINOUIkeyboardView sharedView] numButtonBackground:btn];
            if (btn.tag == 10) {
                if (self.keyboardLowerLeftButtonType == KeyboardLowerLeftButtonComplete) {
                    if (self.lowerLeftButtonTextTitle) {
                        [btn setTitle:self.lowerLeftButtonTextTitle forState:UIControlStateNormal];
                    }else{
                        [btn setTitle:@"完成" forState:UIControlStateNormal];
                    }
                    
                }else if (self.keyboardLowerLeftButtonType == KeyboardLowerLeftButtonDecimalPoint){
                    [btn setTitle:@"." forState:UIControlStateNormal];

                }else{
                    [btn setUserInteractionEnabled:NO];
                }
                [[SINOUIkeyboardView sharedView] leftButtonBackground:btn];
                
            }else if (btn.tag == 11){
                if (self.lowerRightButtonTextTitle) {
                    [btn setTitle:self.lowerRightButtonTextTitle forState:UIControlStateNormal];
                }else{
//                    [btn setTitle:@"删除" forState:UIControlStateNormal];
                }
                [[SINOUIkeyboardView sharedView] rightButtonBackground:btn];
                
                [btn setImage:[UIImage imageNamed:@"形状-59"] forState:UIControlStateNormal];
            }else{
                [btn setTitle:[NSString stringWithFormat:@"%ld",(long)btn.tag] forState:UIControlStateNormal];
            }
        }
        
        
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:btn];
    }
    self.delegate = delegate;
    return self;
}
-(void)setLowerRightButtonNormalSetImageStr:(NSString *)lowerRightButtonNormalSetImageStr{
    _lowerRightButtonNormalSetImageStr = lowerRightButtonNormalSetImageStr;
}
- (void)numButtonBackground:(UIButton *)btn{
    /** 按钮的背景颜色 */
    [[SINOUIkeyboardView sharedView]buttonBackgroundColorFormCurrentButton:btn byColor:self.buttonNormalColor];
    /** 高亮状态下的背景图片 */
    [[SINOUIkeyboardView sharedView]buttonBackgroundImageFormCurrentButton:btn byImage:self.buttonHighlightedImage buttonState:UIControlStateHighlighted];
    /** 正常状态下的背景图片 */
    [[SINOUIkeyboardView sharedView]buttonBackgroundImageFormCurrentButton:btn byImage:self.buttonNormalImage buttonState:UIControlStateNormal];
    [[SINOUIkeyboardView sharedView]buttonTextTitleColorFromCurrentButton:btn byColor:self.buttonTextTitleColor buttonState:UIControlStateNormal];
    [[SINOUIkeyboardView sharedView]buttonTextTitleFontFromCurrentButton:btn byFont:self.buttonTextTitleFont buttonState:UIControlStateNormal];
}

- (void)leftButtonBackground:(UIButton *)btn{
    /** 按钮的背景颜色 */
    [[SINOUIkeyboardView sharedView]buttonBackgroundColorFormCurrentButton:btn byColor:self.lowerLeftButtonNormalColor];
    /** 高亮状态下的背景图片 */
    [[SINOUIkeyboardView sharedView]buttonBackgroundImageFormCurrentButton:btn byImage:self.lowerLeftButtonHighlightedImage buttonState:UIControlStateHighlighted];
    /** 正常状态下的背景图片 */
    [[SINOUIkeyboardView sharedView]buttonBackgroundImageFormCurrentButton:btn byImage:self.lowerLeftButtonNormalImage buttonState:UIControlStateNormal];
    [[SINOUIkeyboardView sharedView]buttonTextTitleColorFromCurrentButton:btn byColor:self.lowerLeftButtonTextTitleColor buttonState:UIControlStateNormal];
    [[SINOUIkeyboardView sharedView]buttonTextTitleFontFromCurrentButton:btn byFont:self.lowerLeftButtonTextTitleFont buttonState:UIControlStateNormal];
}

- (void)rightButtonBackground:(UIButton *)btn{
    /** 按钮的背景颜色 */
    [[SINOUIkeyboardView sharedView]buttonBackgroundColorFormCurrentButton:btn byColor:self.lowerRightButtonNormalColor];
    /** 高亮状态下的背景图片 */
    [[SINOUIkeyboardView sharedView]buttonBackgroundImageFormCurrentButton:btn byImage:self.lowerRightButtonHighlightedImage buttonState:UIControlStateHighlighted];
    /** 正常状态下的背景图片 */
    [[SINOUIkeyboardView sharedView]buttonBackgroundImageFormCurrentButton:btn byImage:self.lowerRightButtonNormalImage buttonState:UIControlStateNormal];
    [[SINOUIkeyboardView sharedView]buttonTextTitleColorFromCurrentButton:btn byColor:self.lowerRightButtonTextTitleColor buttonState:UIControlStateNormal];
    [[SINOUIkeyboardView sharedView]buttonTextTitleFontFromCurrentButton:btn byFont:self.lowerRightButtonTextTitleFont buttonState:UIControlStateNormal];
}

/** 按钮的背景颜色 */
- (void)buttonBackgroundColorFormCurrentButton:(UIButton *)button byColor:(UIColor *)color{
    if (color) {
        button.backgroundColor = color;
    }else{
        if (self.buttonNormalColor) {
            button.backgroundColor = self.buttonNormalColor;
        }else{
            button.backgroundColor = kButtonNormalColor;
        }
    }
}
/** 高亮或正常状态下的背景图片 */
- (void)buttonBackgroundImageFormCurrentButton:(UIButton *)button byImage:(UIImage *)image buttonState:(UIControlState)state{
    if (image) {
        [button setBackgroundImage:image forState:state];
    }else{
        
    }
}

/** 按钮的字体文本颜色 */
- (void)buttonTextTitleColorFromCurrentButton:(UIButton *)button byColor:(UIColor *)textColor buttonState:(UIControlState)state{
    if (textColor) {
        [button setTitleColor:textColor forState:state];
    }else{
        if (self.buttonTextTitleColor) {
            [button setTitleColor:self.buttonTextTitleColor forState:state];
        }else{
            [button setTitleColor:kButtonTextTitleColor forState:state];
        }
    }
}
/** 按钮的字体文本字体 */
- (void)buttonTextTitleFontFromCurrentButton:(UIButton *)button byFont:(UIFont *)textFont buttonState:(UIControlState)state{
    if (textFont) {
        button.titleLabel.font = textFont;
    }else{
        if (self.buttonTextTitleFont) {
            button.titleLabel.font = textFont;
        }else{
            button.titleLabel.font = kButtonTextTitleFont;
        }
    }
}
- (void)buttonClickAction:(id)sender{
    UIButton *button = sender;
    NSLog(@"--------%ld",(long)button.tag);
    if (button.tag == 10) {
        if (self.keyboardLowerLeftButtonType == KeyboardLowerLeftButtonComplete) {
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(keyboardHidden)]) {
                [self.delegate keyboardHidden];
                strTextField.text = textStr;
            }
        }else if (self.keyboardLowerLeftButtonType == KeyboardLowerLeftButtonDecimalPoint){
            [self keyboardClickNumberCurrentNum:@"." text:strTextField];
        }
    }else if (button.tag == 11) {
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(keyboardDeleteNumbertext:)]) {
            if (textStr.length > 0) {
                textStr = [textStr substringToIndex:[textStr length] - 1];
            }else{
                textStr = @"";
            }
            if ([self.delegate keyboardDeleteNumbertext:strTextField] == YES) {
                strTextField.text = textStr;
            }else{
                textStr = strTextField.text;
            }
        }
    }else{
        [self keyboardClickNumberCurrentNum:[NSString stringWithFormat:@"%ld",(long)button.tag] text:strTextField];
    }
}
/** 点击数字button的代理 */
- (void)keyboardClickNumberCurrentNum:(NSString *)buttonTag text:(UITextField *)textField{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(keyboardClickNumbertext:textStr:)]) {
//        if (textStr.length > 0) {
//            textStr = [NSString stringWithFormat:@"%@%@",textStr,buttonTag];
//        }else{
            textStr = [NSString stringWithFormat:@"%@",buttonTag];
//        }
        
        if ([self.delegate keyboardClickNumbertext:textField textStr:textStr] == YES) {
            strTextField.text = textStr;
        }else{
            textStr = strTextField.text;
        }
        
    }
}
/** 随机数产生
 *  @param startIndex 开始数字
 *  @param length    数字的长度
 */
-(NSMutableArray*) GetRandomWithStartIndex:(int) startIndex andEndIndex:(int) length
{
    int endIndex = startIndex+length;//结束数字
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:length];//返回的结果（随机数数组）
    NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:length];//填充随机数的数组
    for (int i = startIndex; i<endIndex; i++) {//填充随机数的所有可能值
        [arr1 addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i=startIndex; i<endIndex; i++) {
        int index = arc4random()%arr1.count;//这个随机数在当初初始化随机数数组中的随机位置
        int radom = [arr1[index] intValue];//随机位置对应的随机值
        NSNumber *num = [NSNumber numberWithInt:radom];
        [arr addObject:num];
        [arr1 removeObjectAtIndex:index];//添加之后就把基本的填充的数组的参数删除这个
    }
    return arr;
}

//+ (void)show
//{
//    [[SINOUIkeyboardView sharedView]showHeight];
//}
//- (void)showHeight{
//    [UIView animateWithDuration:0.3 animations:^{
//        self.transform = CGAffineTransformMakeTranslation(0, -200);
//    }];
//}
+ (void)hidden{
    [[SINOUIkeyboardView sharedView]hiddenHeight];
}
- (void)hiddenHeight{
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

+(void)clearAllData
{
    /** 键盘背景颜色 */
    [[SINOUIkeyboardView sharedView]setKeyboardbackgroundColor:kKeyboardbackgroundColor];
    /** 每个按钮背景颜色 */
    [[SINOUIkeyboardView sharedView]setButtonNormalColor:kButtonNormalColor];
    /** 每个按钮点击时的背景图片 */
    [[SINOUIkeyboardView sharedView]setButtonHighlightedImage:nil];
    /** 每个按钮正常时的背景图片 */
    [[SINOUIkeyboardView sharedView]setButtonNormalImage:nil];
    /** 每个按钮字体颜色 */
    [[SINOUIkeyboardView sharedView]setButtonTextTitleColor:kButtonTextTitleColor];
    /** 每个按钮字体大小 */
    [[SINOUIkeyboardView sharedView]setButtonTextTitleFont:kButtonTextTitleFont];
    
    /** 左下按钮设置 如果此按钮需要单独设置样式时用*/
    /** 左下按钮背景颜色*/
    [[SINOUIkeyboardView sharedView]setLowerLeftButtonNormalColor:kButtonNormalColor];
    /** 左下按钮点击时的背景图片 */
    [[SINOUIkeyboardView sharedView]setLowerLeftButtonHighlightedImage:nil];
    /** 左下按钮正常时的背景图片 */
    [[SINOUIkeyboardView sharedView] setLowerLeftButtonNormalImage:nil];
    /** 左下按钮字体颜色 */
    [[SINOUIkeyboardView sharedView] setLowerLeftButtonTextTitleColor:kButtonTextTitleColor];
    /** 左下按钮字体大小 */
    [[SINOUIkeyboardView sharedView] setLowerLeftButtonTextTitleFont:kButtonTextTitleFont];
    
    /** 右下按钮设置 如果此按钮需要单独设置样式时用*/
    /** 右下按钮背景颜色*/
    [[SINOUIkeyboardView sharedView] setLowerRightButtonNormalColor:kButtonNormalColor];
    /** 右下按钮点击时的背景图片 */
    [[SINOUIkeyboardView sharedView]setLowerRightButtonHighlightedImage:nil];
    /** 右下按钮正常时的背景图片 */
    [[SINOUIkeyboardView sharedView]setLowerRightButtonNormalImage:nil];
    /** 右下按钮字体颜色 */
    [[SINOUIkeyboardView sharedView] setLowerRightButtonTextTitleColor:kButtonTextTitleColor];
    /** 右下按钮字体大小 */
    [[SINOUIkeyboardView sharedView] setLowerRightButtonTextTitleFont:kButtonTextTitleFont];
    
    /** 判断左下按钮的状态 */
    [[SINOUIkeyboardView sharedView] setKeyboardLowerLeftButtonType:KeyboardLowerLeftButtonHidden];
    /** 是否需要随机键盘 默认是no：不随机 yes：要随机 */
    [[SINOUIkeyboardView sharedView] setKeyboardRandom:NO];
    /** 如果按钮全用图片 */
    [[SINOUIkeyboardView sharedView] setKeyboardbackgroundIsImage:NO];
    [[SINOUIkeyboardView sharedView] setImageName:@""];
    [[SINOUIkeyboardView sharedView] setLowerRightButtonTextTitle:@""];
    [[SINOUIkeyboardView sharedView] setLowerLeftButtonTextTitle:@""];
    [[SINOUIkeyboardView sharedView] setLowerRightButtonNormalSetImageStr:@""];
}
@end
