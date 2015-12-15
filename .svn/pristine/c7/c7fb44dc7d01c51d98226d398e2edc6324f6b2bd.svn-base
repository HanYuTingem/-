//
//  StoreCommentListCell.h
//  MyNiceFood
//
//  Created by sunsu on 15/7/16.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreCommentListCell.h"

#import "CommentModel.h"

@class StoreCommentListCell;

@protocol StoreCommentListCellDelegate <NSObject>
- (void)select:(StoreCommentListCell *)cell withButton:(UIButton *)button withArray:(NSArray *)array;
-(void)clickPerson:(NSInteger )number;
@end

@interface StoreCommentListCell : UITableViewCell

@property (nonatomic,strong) CommentModel   * commentModel;
@property (nonatomic,assign) id<StoreCommentListCellDelegate> delegate;
@property (nonatomic,strong) NSArray *imageArray;  //图片数组

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
