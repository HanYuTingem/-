//
//  CJFeedbackViewController.h
//  MarketManage
//
//  Created by 赵春景 on 15-7-28.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "L_BaseMallViewController.h"

@interface CJFeedbackViewController : L_BaseMallViewController
/** 反馈内容的文本框 */
@property (weak, nonatomic) IBOutlet UITextView *feedbackTextView;
/** 联系方式的文本框 */
@property (weak, nonatomic) IBOutlet UITextField *iphoneTextfield;

@end
