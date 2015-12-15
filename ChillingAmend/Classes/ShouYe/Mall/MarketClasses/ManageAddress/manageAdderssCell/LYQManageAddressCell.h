//
//  LYQManageAddressCell.h
//  Chiliring
//
//  Created by nsstring on 14-9-9.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyUILabel.h"

@interface LYQManageAddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet MyUILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *morenLabel;

@end
