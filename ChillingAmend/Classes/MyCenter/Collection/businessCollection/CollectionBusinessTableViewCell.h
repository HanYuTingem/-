//
//  CollectionBusinessTableViewCell.h
//  ChillingAmend
//
//  Created by 孙瑞 on 15/9/21.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYC_BusinessModel.h"

@interface CollectionBusinessTableViewCell : UITableViewCell
{
@private
    UIImageView*	m_checkImageView; // 需要删除的商户选中的imageView
    BOOL			m_checked; // 是否选中
}

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *merchantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *merchantAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgpriceLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *starImgArray;
@property (weak, nonatomic) IBOutlet UIImageView *topLineView; // 上线条
@property (weak, nonatomic) IBOutlet UIImageView *bottomLineView; // 下线条
@property (weak, nonatomic) IBOutlet UIView *starView;

- (void)setChecked:(BOOL)checked;
- (void)businessWithCollectionBusinessModel:(BYC_BusinessModel *)model;

@end
