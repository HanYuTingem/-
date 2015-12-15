//
//  UITextField+JianPan.h
//  SINOUIKeyboard
//
//  Created by yll on 15/10/30.
//  Copyright © 2015年 yll. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SINOUIkeyboardView.h"

@interface UITextField (JianPan)<SINOUIkeyboardViewDelegate>
@property (nonatomic, weak)id<SINOUIkeyboardViewDelegate>jianPanDelegate;

//-(void)setJianPanDelegate:(id<SINOUIkeyboardViewDelegate>)jianPanDelegate text:(UITextField *)textField;
/** 每次都初始化一个 */
-(void)setJianPanDelegate:(id<SINOUIkeyboardViewDelegate>)jianPanDelegate;
/** 始终只有一个，相当于单例 */
-(void)setJianPanDelegateManagerInstance:(id<SINOUIkeyboardViewDelegate>)jianPanDelegate;
@end
