//
//  LSYRealGoodsTableViewCell.h
//  MarketManage
//
//  Created by liangsiyuan on 15/1/19.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXYCommitOrderRequestModel.h"
@protocol LSYRealGoodsTableViewCellDelegate <NSObject>
@optional
-(void)getFaPiaoInfo;
@end

@interface LSYRealGoodsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *faPiaoInfo;
@property (weak, nonatomic) IBOutlet UILabel *freight;
@property (nonatomic,weak)id <LSYRealGoodsTableViewCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@property (strong,  nonatomic) ZXYCommitOrderRequestModel *commitModel;

@end
