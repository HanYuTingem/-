//
//  payPassWordViewController.h
//  Wallet
//
//  Created by GDH on 15/10/21.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "Wallet_BaseViewController.h"

@interface payPassWordViewController : Wallet_BaseViewController
/** 确定按钮 */
@property (weak, nonatomic) IBOutlet UIButton *confirmButtonDown;
/** 确定按钮事件 */
- (IBAction)confirmButtonAction:(id)sender;


@property (nonatomic,copy) NSString *changePassWord;

/** 未设置密码，提现，设置了密码后返回提现界面  */
@property (nonatomic,copy) NSString *fromVcToSetPassWord;

@end
