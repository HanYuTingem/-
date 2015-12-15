//
//  UITextField+JianPan.m
//  SINOUIKeyboard
//
//  Created by yll on 15/10/30.
//  Copyright © 2015年 yll. All rights reserved.
//

#import "UITextField+JianPan.h"
#import "SINOUIkeyboardView.h"

@implementation UITextField (JianPan)

//-(void)setJianPanDelegate:(id<SINOUIkeyboardViewDelegate>)jianPanDelegate text:(UITextField *)textField{
//    [self setInputView:[SINOUIkeyboardView keyboardViewDelegate:jianPanDelegate text:textField]];
//}

-(void)setJianPanDelegate:(id<SINOUIkeyboardViewDelegate>)jianPanDelegate{
    
        [self setInputView:[[[SINOUIkeyboardView alloc] init] keyboardViewDelegate:jianPanDelegate text:self]];
}

-(void)setJianPanDelegateManagerInstance:(id<SINOUIkeyboardViewDelegate>)jianPanDelegate{
    [self setInputView:[[SINOUIkeyboardView sharedView] keyboardViewDelegate:jianPanDelegate text:self]];
}
@end
