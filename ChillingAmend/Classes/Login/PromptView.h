//
//  PromptView.h
//  LANSING
//
//  Created by nsstring on 15/5/29.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import <UIKit/UIKit.h>
// 获取RGB颜色
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@protocol PromptViewDelegate <NSObject>
@optional;

-(void)chooseSkip:(int) skipInt;
-(void)chooseToUnderstand:(int) understandInt;

@end

@interface PromptView : UIView

@property (assign, nonatomic)int InTheFormOfInt;
-(void)setInTheFormOfInt:(int)InTheFormOfInt;

/*登录注册*/
@property (strong, nonatomic) IBOutlet UILabel *logInToRegisterLabel;

/*标题形式*/
@property (strong, nonatomic) IBOutlet UIView *backgroundView;

@property (strong, nonatomic) IBOutlet UIView *skipView;

@property (strong, nonatomic) IBOutlet UIView *toUnderstandView;

/*无标题形式*/
@property (strong, nonatomic) IBOutlet UIView *background1View;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIView *skip1View;
@property (strong, nonatomic) IBOutlet UILabel *skip1Label;

@property (strong, nonatomic) IBOutlet UIView *toUnderstand1View;
@property (strong, nonatomic) IBOutlet UILabel *toUnderstand1Label;

//用户已注册
@property (strong, nonatomic) IBOutlet UIView *registeredView;
@property (strong, nonatomic) IBOutlet UILabel *registeredLabel;
@property (strong, nonatomic) IBOutlet UIView *skip2View;
@property (strong, nonatomic) IBOutlet UIView *toUnderstand2View;

@property (weak, nonatomic) id<PromptViewDelegate>delegate;

-(void)draw;

+ (id) Instance;

@end
