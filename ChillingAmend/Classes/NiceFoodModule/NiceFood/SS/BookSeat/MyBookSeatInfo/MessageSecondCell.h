//
//  MessageSecondCell.h
//  QQList
//
//  Created by sunsu on 15/7/3.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MessageSecondCellDelegate <NSObject>
-(void)editPhoneNumClick;
@end

@interface MessageSecondCell : UITableViewCell

@property (nonatomic,weak) id<MessageSecondCellDelegate>delegate;

+(instancetype)cellWithTableView:(UITableView *)tableView;
-(void)reshCellWithPhone:(NSString*)phoneNumber;
@end
