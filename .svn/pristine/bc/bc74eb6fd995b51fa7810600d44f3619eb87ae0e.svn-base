//
//  ZXYOrderDetailViewController.h
//  MarketManage
//
//  Created by Rice on 15/1/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "ZXYOrderNumCell.h"
#import "ZXYOrderTransportCell.h"
#import "ZXYOrderConnectCell.h"
#import "ZXYOrderGoodsCell.h"

#import "MarketAPI.h"
#import "ZXYOrderModell.h"
#import "ZXYOrderDetailModel.h"
#import "ZXYCommitOrderRequestModel.h"

#import "GCRequest.h"

#import "L_BaseMallViewController.h"


typedef NS_ENUM(NSInteger, OderDetailNumSection) {
    
    OderDetailNumSectionNone,
    OderDetailNumSectionOne,
    OderDetailNumSectionTwo,
    OderDetailNumSectionThree,
    OderDetailNumSectionFour,
    
};

@interface ZXYOrderDetailViewController : L_BaseMallViewController<UITableViewDataSource,UITableViewDelegate,GCRequestDelegate>

@property (strong, nonatomic) ZXYOrderModell             *orderModel;
@property (strong, nonatomic) ZXYOrderDetailModel        *orderDetailModel;
@property (strong, nonatomic) ZXYCommitOrderRequestModel *commitModel;
@property (strong, nonatomic) UIButton *rightTelBtn;
//退款电话
@property (copy, nonatomic) NSString *refundPhone;

@end
