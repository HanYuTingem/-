//
//  QuickLoginView.h
//  LaoYiLao
//
//  Created by sunsu on 15/11/7.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuickLoginViewDelegate <NSObject>

- (void) tijiaobtnclick;
- (void) getnumbtnclick:(UIButton *)sender;
- (void) serverAgreementClicked;

@end

@interface QuickLoginView : UIView
@property (nonatomic, strong) UITextField* phonetextfield;//  输入电话
@property (nonatomic, strong) UITextField* yzmtextfileld;//  验证码 ;
@property (nonatomic, weak) id<QuickLoginViewDelegate>delegate;
@end
