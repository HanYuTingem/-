//
//  GDHPasswordBox.m
//  Wallet
//
//  Created by GDH on 15/10/22.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "GDHPasswordBox.h"
#import "SINOUIkeyboardView.h"
#import "UITextField+JianPan.h"

@interface GDHPasswordBox   ()<UITextFieldDelegate,SINOUIkeyboardViewDelegate>
{
    CGRect _frame;
}

@end

@implementation GDHPasswordBox
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"GDHPasswordBox" owner:self options:nil]lastObject];
        [self setFrame:frame];
        
        self.numTextfiledOne.delegate =self;
        self.numTextfiledTwo.delegate =self;
        self.numTextfiledThree.delegate =self;
        self.numTextfiledFour.delegate =self;
        self.numTextfiledFive.delegate =self;
        self.numTextfiledSix.delegate =self;
        
        self.numTextfiledOne.jianPanDelegate = self;
        self.numTextfiledTwo.jianPanDelegate = self;
        self.numTextfiledThree.jianPanDelegate = self;
        self.numTextfiledFour.jianPanDelegate = self;
        self.numTextfiledFive.jianPanDelegate = self;
        self.numTextfiledSix.jianPanDelegate = self;
        
        
        self.numTextfiledTwo.enabled = NO;
        self.numTextfiledThree.enabled = NO;
        self.numTextfiledFour.enabled = NO;
        self.numTextfiledFive.enabled = NO;
        self.numTextfiledSix.enabled = NO;
        _frame = frame;
        
    }
    return self;
}

-(BOOL)keyboardClickNumbertext:(UITextField *)textField textStr:(NSString *)textStr{
    textField.text = textStr;
    if (textField == self.numTextfiledOne) {
        
        self.numTextfiledOne.enabled = NO;
        self.numTextfiledTwo.enabled = YES;
        [self.numTextfiledTwo becomeFirstResponder];
        
    }else if (textField == self.numTextfiledTwo){
        self.numTextfiledTwo.enabled = NO;
        self.numTextfiledThree.enabled = YES;
        [self.numTextfiledThree becomeFirstResponder];
    }else if (textField == self.numTextfiledThree){
        self.numTextfiledThree.enabled = NO;
        self.numTextfiledFour.enabled = YES;
        [self.numTextfiledFour becomeFirstResponder];
    }else if (textField == self.numTextfiledFour){
        self.numTextfiledFour.enabled = NO;
        self.numTextfiledFive.enabled = YES;
        [self.numTextfiledFive becomeFirstResponder];
    }else if (textField == self.numTextfiledFive){
        self.numTextfiledFive.enabled = NO;
        self.numTextfiledSix.enabled = YES;
        [self.numTextfiledSix becomeFirstResponder];
        
        
    }else if (textField == self.numTextfiledSix){
        
        NSString *theNumString = [NSString stringWithFormat:@"%@%@%@%@%@%@",self.numTextfiledOne.text,self.numTextfiledTwo.text ,self.numTextfiledThree.text,self.numTextfiledFour.text,self.numTextfiledFive.text,self.numTextfiledSix.text];
        self.passWordBlock(theNumString);
        return NO;
        //            返回代理
    }
    return YES;
    
}
-(BOOL)keyboardDeleteNumbertext:(UITextField *)textField{
    @try {
        if (textField == self.numTextfiledSix) {
            if (self.numTextfiledSix.text.length != 0) {
                textField.text = @"";
            }
            else{
                
                self.numTextfiledSix.enabled = NO;
                self.numTextfiledFive.enabled = YES;
                [self.numTextfiledFive becomeFirstResponder];
                self.numTextfiledFive.text = @"";
                
                textField.text = @"";
            }
            //        [self.numTextfiledTwo becomeFirstResponder];
        }else if (textField == self.numTextfiledFive){
            if (self.numTextfiledFive.text.length == 0) {
                
                self.numTextfiledFive.enabled = NO;
                self.numTextfiledFour.enabled = YES;
                [self.numTextfiledFour becomeFirstResponder];
                
                self.numTextfiledFour.text = @"";
            }
            //            else{
            //                textField.text = @"";
            //            }
            //
            //        [self.numTextfiledThree becomeFirstResponder];
        }else if (textField == self.numTextfiledFour){
            if (self.numTextfiledFour.text.length == 0) {
                self.numTextfiledFour.enabled = NO;
                self.numTextfiledThree.enabled = YES;
                [self.numTextfiledThree becomeFirstResponder];
                self.numTextfiledThree.text = @"";
            }else{
                textField.text = @"";
            }
            
            //        [self.numTextfiledFour becomeFirstResponder];
        }else if (textField == self.numTextfiledThree){
            if (self.numTextfiledThree.text.length == 0) {
                self.numTextfiledThree.enabled = NO;
                self.numTextfiledTwo.enabled = YES;
                [self.numTextfiledTwo becomeFirstResponder];
                self.numTextfiledTwo.text = @"";
            }else{
                textField.text = @"";
            }
            
            //        [self.numTextfiledFive becomeFirstResponder];
        }else if (textField == self.numTextfiledTwo){
            if (self.numTextfiledTwo.text.length == 0) {
                self.numTextfiledTwo.enabled = NO;
                self.numTextfiledOne.enabled = YES;
                [self.numTextfiledOne becomeFirstResponder];
                self.numTextfiledOne.text = @"";
            }else{
                textField.text = @"";
            }
            
            //        [self.numTextfiledSix becomeFirstResponder];
        }else{
            textField.text = @"";
        }
    }
    @catch (NSException *exception) {
        NSLog(@"lskdjgajrega:%@",exception);
    }
    @finally {
        return NO;
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)awakeFromNib{
    
}
- (void)drawRect:(CGRect)rect
{
    self.frame = _frame;
    
}


- (IBAction)passWordBoxDown:(id)sender {

    if (self.numTextfiledOne.enabled){
        [self.numTextfiledOne becomeFirstResponder];
    }    else if (self.numTextfiledTwo.enabled){
        [self.numTextfiledTwo becomeFirstResponder];
    }else if (self.numTextfiledThree.enabled){
        [self.numTextfiledThree becomeFirstResponder];
    }else if (self.numTextfiledFour.enabled){
        [self.numTextfiledFour becomeFirstResponder];
    }else if (self.numTextfiledFive.enabled){
        [self.numTextfiledFive becomeFirstResponder];
    }else if (self.numTextfiledSix.enabled){
        [self.numTextfiledSix becomeFirstResponder];
    }
}
@end
