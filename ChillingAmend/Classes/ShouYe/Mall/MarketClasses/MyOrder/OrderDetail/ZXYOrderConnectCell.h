//
//  ZXYOrderConnectCell.h
//  MarketManage
//
//  Created by Rice on 15/1/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXYOrderDetailModel.h"
#import "MyUILabel.h"

@interface ZXYOrderConnectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *connectManLabel;
@property (weak, nonatomic) IBOutlet UILabel *connectTelLabel;
/** 发票信息 */
@property (weak, nonatomic) IBOutlet MyUILabel *connectAddLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (strong, nonatomic) ZXYOrderDetailModel *detailModel;
-(void)setCellLayout;
-(void)setCellData;

@end
