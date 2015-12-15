//
//  TextHistoryCell.h
//  Saoyisao
//
//  Created by 宋鑫鑫 on 14-8-28.
//  Copyright (c) 2014年 pipixia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextHistoryCell : UITableViewCell
/*
 *contentLabel  扫描到的文字内容
 *dateLabel  扫描到文字内容的日期
 */
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@end
