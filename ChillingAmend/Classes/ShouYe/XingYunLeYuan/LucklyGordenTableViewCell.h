//
//  LucklyGordenTableViewCell.h
//  ChillingAmend
//
//  Created by svendson on 14-12-19.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LucklyGordenTableViewCell : UITableViewCell

//图片
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *gameNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;

@end
