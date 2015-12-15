//
//  GDHOriginalChangeController.h
//  Wallet
//
//  Created by GDH on 15/10/23.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "Wallet_BaseViewController.h"

@interface GDHOriginalChangeController : Wallet_BaseViewController

- (IBAction)confirmbuttonDown:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
/** 通过字符串来判断是不是从修改密码push 过来 字符串的长度不为0就是从修改密码页面过来 */
@property (nonatomic,copy) NSString *changeTheTitle;

@end
