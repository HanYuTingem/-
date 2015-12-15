//
//  CrazyBasisAlertView.h
//  MarketManage
//
//  Created by fielx on 15/4/27.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBgBlackView.h"

typedef void (^ConfirmBlock)(CrazyBasisButton *confirmButton);
typedef void (^CancelBlock)(CrazyBasisButton *cancelBlock);

@interface CrazyBasisAlertView : CrazyBgBlackView


+(CrazyBasisAlertView *)CrazyBasisAlertViewShowTitle:(NSString *)title content:(NSString *)content  buttonTextArray:(NSArray *)textArray  leftSelectBlock:(ConfirmBlock)confirmBlock  rigthSelectBlock:(CancelBlock)cancelBlock;

@end
