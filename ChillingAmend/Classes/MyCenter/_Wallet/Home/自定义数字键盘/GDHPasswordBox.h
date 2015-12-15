//
//  GDHPasswordBox.h
//  Wallet
//
//  Created by GDH on 15/10/22.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.


//  -------------- 密码框 --------------


#import <UIKit/UIKit.h>

@interface GDHPasswordBox : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextField *numTextfiledOne;
@property (weak, nonatomic) IBOutlet UITextField *numTextfiledTwo;
@property (weak, nonatomic) IBOutlet UITextField *numTextfiledThree;
@property (weak, nonatomic) IBOutlet UITextField *numTextfiledFour;
@property (weak, nonatomic) IBOutlet UITextField *numTextfiledFive;

@property (weak, nonatomic) IBOutlet UITextField *numTextfiledSix;
@property (weak, nonatomic) IBOutlet UIView *payView;
@property (weak, nonatomic) IBOutlet UIImageView *payImageView;


@property (nonatomic,copy) void (^passWordBlock)(NSString *);

-(instancetype)initWithFrame:(CGRect)frame;

/** 点击按钮 */

@property (weak, nonatomic) IBOutlet UIButton *passwordBoxButton;

/** 按钮事件 */
- (IBAction)passWordBoxDown:(id)sender;

@end
