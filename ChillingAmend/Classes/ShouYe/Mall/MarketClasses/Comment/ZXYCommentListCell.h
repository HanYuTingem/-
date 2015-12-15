//
//  ZXYCommentListCell.h
//  Chiliring
//
//  Created by Rice on 14-9-11.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyUILabel.h"
@interface ZXYCommentListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet MyUILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageLine;

@end
