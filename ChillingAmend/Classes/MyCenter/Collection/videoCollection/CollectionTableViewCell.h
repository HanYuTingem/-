//  收藏视频cell
//  CollectionTableViewCell.h
//  ChillingAmend
//
//  Created by 许文波 on 14/12/20.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionMessageModel.h"

@interface CollectionTableViewCell : UITableViewCell
{
@private
    UIImageView*	m_checkImageView; // 需要删除的视频选中的imageView
    BOOL			m_checked; // 是否选中
}

- (void) setChecked:(BOOL)checked;
@property (weak, nonatomic) IBOutlet UIImageView *topLineView; // 上线条
@property (weak, nonatomic) IBOutlet UIImageView *bottomLineView; // 下线条
@property (weak, nonatomic) IBOutlet UIImageView *collectionImageView; // 视频图片
@property (weak, nonatomic) IBOutlet UILabel *collectionNameLabel; // 视频名称
@property (weak, nonatomic) IBOutlet UILabel *collectionSubLabel; // 视频时间

- (void)parseWithPrizeModel:(CollectionMessageModel*)model;
@end
