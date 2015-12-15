//
//  InvoiceViewController.h
//  MarketManage
//
//  Created by Rice on 15/1/17.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketAPI.h"
#import "ZXYInvoiceModel.h"

#import "L_BaseMallViewController.h"

@protocol InvoiceMessageDelegate <NSObject>

-(void)getInvoiceMsgModel:(ZXYInvoiceModel *)model;

@end

@interface InvoiceViewController : L_BaseMallViewController<UITextFieldDelegate>

@property (assign, nonatomic) id<InvoiceMessageDelegate> delegate;

@end
