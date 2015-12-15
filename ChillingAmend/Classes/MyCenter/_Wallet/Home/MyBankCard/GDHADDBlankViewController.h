//
//  GDHADDBlankViewController.h
//  Wallet
//
//  Created by GDH on 15/10/22.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "Wallet_BaseViewController.h"

@interface GDHADDBlankViewController : Wallet_BaseViewController
/** 所属银行输入框 */
@property (weak, nonatomic) IBOutlet UITextField *selectBankTextFiled;

/** 卡号 */
@property (weak, nonatomic) IBOutlet UITextField *blankNumberTextFlied;
/** 姓名 */
@property (weak, nonatomic) IBOutlet UITextField *blankNameFlied;
/** 正在认证提示框 */
@property (weak, nonatomic) IBOutlet UIView *VerificationLabel;
@property (weak, nonatomic) IBOutlet UILabel *titileLabel;
/** 下一步 */
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
- (IBAction)confirmBtnDown:(id)sender;
/** 选择的银行 */
@property (weak, nonatomic) IBOutlet UITableView *allBankTableView;

/** 蒙版遮罩  */
@property (weak, nonatomic) IBOutlet UIView *maskView;

@property (nonatomic,copy) NSString *theRightIden;
/** 文本输入框 */
@property (weak, nonatomic) IBOutlet UIView *inputView;
/** 所属银行 */
@property (weak, nonatomic) IBOutlet UILabel *BankOfChinalabel;
@property (weak, nonatomic) IBOutlet UIImageView *uplineImage;
@property (weak, nonatomic) IBOutlet UIImageView *twoLineImage;

@property (weak, nonatomic) IBOutlet UIImageView *threeLineImage;

@property (weak, nonatomic) IBOutlet UIImageView *fourLineIamge;
/** 所属银行标题 */
@property (weak, nonatomic) IBOutlet UILabel *bankOftitleLabel;
/** 卡号标题 */
@property (weak, nonatomic) IBOutlet UILabel *bankNumTitle;

@property (weak, nonatomic) IBOutlet UIImageView *bankImageVIww;
@property (weak, nonatomic) IBOutlet UILabel *theNameTitle;


/**  从银行卡列表传过来 */
@property (nonatomic,copy) NSString *theBank;
/** 卡号 */
@property (nonatomic,copy) NSString *bankNum;
/** 名称 */
@property (nonatomic,copy) NSString *bankName;
/** 银行卡id */
@property (nonatomic,copy) NSString *bankID;
/** 银行卡 图片 */
@property (nonatomic,copy) NSString *bankImg;

@end
