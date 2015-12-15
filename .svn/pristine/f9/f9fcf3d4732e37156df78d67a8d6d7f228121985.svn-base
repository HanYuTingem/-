//
//  ContactsView.m
//  HCheap
//
//  Created by JianDan on 14/12/17.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//

#import "ContactsView.h"
#import "MBProgressHUD.h"
@implementation ContactsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initData];
        
        [self createUI];
        
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
//                                                    name:@"UITextFieldTextDidChangeNotification"
//                                                  object:_nameTextfield];
    }
    return self;
}

- (void)initData
{
    _name = [NSString string];
}

- (void)createUI
{
    if (_nameTextfield == nil) {
        _nameTextfield = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 150, 33)];
        _nameTextfield.backgroundColor = [UIColor whiteColor];
        _nameTextfield.borderStyle = UITextBorderStyleNone;
        _nameTextfield.placeholder = @"您贵姓";
        _nameTextfield.textColor = [UIColor grayColor];
        _nameTextfield.font = [UIFont systemFontOfSize:15];
        _nameTextfield.textAlignment = NSTextAlignmentLeft;
        _nameTextfield.delegate = self;
        //是否纠错
        _nameTextfield.autocorrectionType = UITextAutocorrectionTypeNo;
        //再次编辑就清空
        _nameTextfield.clearsOnBeginEditing = YES;
        //设置键盘的样式
        _nameTextfield.keyboardType = UIKeyboardTypeNamePhonePad;
        //return键的样式
        _nameTextfield.returnKeyType = UIReturnKeyNext;
        //键盘外观
        _nameTextfield.keyboardAppearance = UIKeyboardAppearanceDefault;
        [self addSubview:_nameTextfield];
    }
    
    if (_womanLabel == nil) {
        _womanLabel = [[UILabel alloc] initWithFrame:CGRectMake(205, 12, 35, 30)];
        _womanLabel.text = @"女士";
        _womanLabel.textColor = [UIColor blackColor];
        _womanLabel.textAlignment = NSTextAlignmentCenter;
        _womanLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_womanLabel];
    }
    
    if (_manLabel == nil) {
        _manLabel = [[UILabel alloc] initWithFrame:CGRectMake(275, 12, 35, 30)];
        _manLabel.text = @"先生";
        _manLabel.textColor = [UIColor blackColor];
        _manLabel.textAlignment = NSTextAlignmentCenter;
        _manLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_manLabel];

    }
    
    if (_womanBtn == nil) {
        _womanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _womanBtn.frame = CGRectMake(177, 15, 23, 23);
        [_womanBtn setImage:[UIImage imageNamed:@"dingzuo_0003_itemoff.png"] forState:UIControlStateNormal];
        [_womanBtn setImage:[UIImage imageNamed:@"dingzuo_0004_itemon.png"] forState:UIControlStateHighlighted];
        _womanBtn.tag = 701;
        [_womanBtn addTarget:self action:@selector(selectedSex:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_womanBtn];
    }
    
    if (_manBtn == nil) {
        _manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _manBtn.frame = CGRectMake(247, 15, 23, 23);
        [_manBtn setImage:[UIImage imageNamed:@"dingzuo_0004_itemon.png"] forState:UIControlStateNormal];
        [_manBtn setImage:[UIImage imageNamed:@"dingzuo_0003_itemoff.png"] forState:UIControlStateHighlighted];
        _manBtn.tag = 702;
        [_manBtn addTarget:self action:@selector(selectedSex:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_manBtn];
    }
    
    if (_numberTellLabel == nil) {
        _numberTellLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 110, 30)];
        _numberTellLabel.textColor = [UIColor blackColor];
        _numberTellLabel.textAlignment = NSTextAlignmentCenter;
        _numberTellLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_numberTellLabel];
    }
    
    if (_tellnumberBtn == nil) {
        _tellnumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _tellnumberBtn.frame = CGRectMake(0, 65, SCREEN_WIDTH, 45);
        _tellnumberBtn.backgroundColor = [UIColor clearColor];
        [_tellnumberBtn addTarget:self action:@selector(numberTellAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_tellnumberBtn];
    }
    
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
        _lineView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
        [self addSubview:_lineView];
    }
}

// 选择性别
- (void)selectedSex:(UIButton *)sender
{
    switch (sender.tag) {
        case 701:
            [_manBtn setImage:[UIImage imageNamed:@"dingzuo_0003_itemoff.png"] forState:UIControlStateNormal];
            [_manBtn setImage:[UIImage imageNamed:@"dingzuo_0004_itemon.png"] forState:UIControlStateHighlighted];
            [_womanBtn setImage:[UIImage imageNamed:@"dingzuo_0004_itemon.png"] forState:UIControlStateNormal];
            [_womanBtn setImage:[UIImage imageNamed:@"dingzuo_0003_itemoff.png"] forState:UIControlStateHighlighted];
            _sex = @"0";
            break;
        case 702:
            [_manBtn setImage:[UIImage imageNamed:@"dingzuo_0004_itemon.png"] forState:UIControlStateNormal];
            [_manBtn setImage:[UIImage imageNamed:@"dingzuo_0003_itemoff.png"] forState:UIControlStateHighlighted];
            [_womanBtn setImage:[UIImage imageNamed:@"dingzuo_0003_itemoff.png"] forState:UIControlStateNormal];
            [_womanBtn setImage:[UIImage imageNamed:@"dingzuo_0003_itemoff.png"] forState:UIControlStateHighlighted];
            _sex = @"1";
            break;
            
        default:
            break;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _numberTellLabel.text = [NSString stringWithFormat:@"%@",_phone];
}

#pragma mark -TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    if ([self isContainsEmoji:textField.text]) {
        [self showMsg:@"输入内容不得包含非法字符、表情等"];
        return YES;
    }else{
        if (textField.text.length <= 4) {
            _name = textField.text;
            [textField resignFirstResponder];
            return YES;
        }else{
            [self showMsg:@"您输入的姓氏过长!"];
            return NO;
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _name = textField.text;
}

// 修改电话号码
- (void)numberTellAction
{
    if ([self.contactsViewDelegate respondsToSelector:@selector(modifyNumberTell)]) {
        [self.contactsViewDelegate modifyNumberTell];
    }else{
        ZNLog(@"代理未实现");
    }
}

- (void)setOldPhone:(NSString *)oldPhone andOldName:(NSString *)oldName andOldSex:(NSString *)oldSex
{
    _nameTextfield.text = [NSString stringWithFormat:@"%@",oldName];
    _numberTellLabel.text = [NSString stringWithFormat:@"%@",oldPhone];
    if ([oldSex isEqualToString:@"0"]) {
        [_manBtn setImage:[UIImage imageNamed:@"dingzuo_0004_itemon.png"] forState:UIControlStateNormal];
        [_manBtn setImage:[UIImage imageNamed:@"dingzuo_0003_itemoff.png"] forState:UIControlStateHighlighted];
        [_womanBtn setImage:[UIImage imageNamed:@"dingzuo_0003_itemoff.png"] forState:UIControlStateNormal];
        [_womanBtn setImage:[UIImage imageNamed:@"dingzuo_0003_itemoff.png"] forState:UIControlStateHighlighted];
    }else{
        [_manBtn setImage:[UIImage imageNamed:@"dingzuo_0003_itemoff.png"] forState:UIControlStateNormal];
        [_manBtn setImage:[UIImage imageNamed:@"dingzuo_0004_itemon.png"] forState:UIControlStateHighlighted];
        [_womanBtn setImage:[UIImage imageNamed:@"dingzuo_0004_itemon.png"] forState:UIControlStateNormal];
        [_womanBtn setImage:[UIImage imageNamed:@"dingzuo_0003_itemoff.png"] forState:UIControlStateHighlighted];
    }
    
    _phone = [NSString stringWithFormat:@"%@",oldPhone];
    _sex = [NSString stringWithFormat:@"%@",oldSex];
    _name = [NSString stringWithFormat:@"%@",oldName];
}

//提示框
-(void)showMsg:(NSString *)msg
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.superview];
    [self.superview addSubview:hud];
    
    // Set custom view mode
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.labelText = msg;
    [hud show:YES];
    [hud hide:YES afterDelay:1];
    hud = nil;
}

//  表情判断
- (BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
