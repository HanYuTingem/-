//
//  ZXYOrderTransportCell.h
//  MarketManage
//
//  Created by Rice on 15/1/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyUILabel.h"
#import "ZXYOrderDetailModel.h"
@interface ZXYOrderTransportCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UILabel *trpTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *expNameHeadLabel;
@property (weak, nonatomic) IBOutlet UILabel *expNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *expNumHeadLabel;
@property (weak, nonatomic) IBOutlet UILabel *expNumLabel;
@property (weak, nonatomic) IBOutlet MyUILabel *expBillMsgLabel;



@property (strong, nonatomic) ZXYOrderDetailModel *detailModel;
-(void)setCellLayout;
-(void)setCellData;
@property (weak, nonatomic) IBOutlet UIImageView *line_2;
@property (weak, nonatomic) IBOutlet UIImageView *line_1;
@property (weak, nonatomic) IBOutlet UIImageView *line_bottom;

@end
