//  收藏视频cell
//  CollectionTableViewCell.m
//  ChillingAmend
//
//  Created by 许文波 on 14/12/20.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "CollectionTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "BXAPI.h"
#import "TimeStringTransform.h"
#import "GCUtil.h"

@implementation CollectionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 解析视频数据
- (void)parseWithPrizeModel:(CollectionMessageModel*)model
{
    _collectionImageView.layer.borderWidth = 1;
    _collectionImageView.layer.borderColor = [UIColor colorWithRed:226.0/255 green:226.0/255 blue:226.0/255 alpha:1.0].CGColor;
    _collectionImageView.layer.masksToBounds = YES;
    [_collectionImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", img_url, model.video_img]] placeholderImage:[UIImage imageNamed:@"defaultimg_content_img"]];
    _collectionSubLabel.text = [[[TimeStringTransform getTimeString:model.create_time] componentsSeparatedByString:@" "] objectAtIndex:0];
    _collectionNameLabel.text = model.video_name;
    _collectionNameLabel.frame = [GCUtil changeLabelFrame:_collectionNameLabel andSize:CGSizeMake(211, 40) andFontSize:[UIFont systemFontOfSize:14.0f]];
}

// 设置选中的图片位置
- (void) setCheckImageViewCenter:(CGPoint)pt alpha:(CGFloat)alpha animated:(BOOL)animated
{
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        
        m_checkImageView.center = pt;
        m_checkImageView.alpha = alpha;
        
        [UIView commitAnimations];
    } else {
        m_checkImageView.center = pt;
        m_checkImageView.alpha = alpha;
    }
}

// 设置是否编辑
- (void) setEditing:(BOOL)editting animated:(BOOL)animated
{
    if (self.editing == editting) {
        return;
    }
    
    [super setEditing:editting animated:animated];
    
    if (editting) {
        self.topLineView.frame = CGRectMake(-60, 0, CGRectGetWidth(self.bounds) + 60, 1);
        self.bottomLineView.frame = CGRectMake(-60, CGRectGetHeight(self.bounds) - 1, CGRectGetWidth(self.bounds) + 60, 1);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        if (m_checkImageView == nil) {
            m_checkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mycollect_list_spanner_btn_normal.png"]];
            m_checkImageView.frame = CGRectMake(25, CGRectGetHeight(self.bounds) * 0.5 - 9, 18, 18);
            [self addSubview:m_checkImageView];
        }
        
        [self setChecked:m_checked];
        m_checkImageView.center = CGPointMake(-CGRectGetWidth(m_checkImageView.frame) * 0.5,
                                              CGRectGetHeight(self.bounds) * 0.5);
        m_checkImageView.alpha = 0.0;
        [self setCheckImageViewCenter:CGPointMake(25, CGRectGetHeight(self.bounds) * 0.5)
                                alpha:1.0 animated:animated];
    } else {
        m_checked = NO;
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        if (m_checkImageView) {
            [self setCheckImageViewCenter:CGPointMake(-CGRectGetWidth(m_checkImageView.frame) * 0.5,
                                                      CGRectGetHeight(self.bounds) * 0.5)
                                    alpha:0.0
                                 animated:animated];
        }
    }
}

// 改变选中图片
- (void) setChecked:(BOOL)checked
{
    if (checked) {
        m_checkImageView.image = [UIImage imageNamed:@"mycollect_list_spanner_icon_selected.png"];
    } else {
        m_checkImageView.image = [UIImage imageNamed:@"mycollect_list_spanner_btn_normal.png"];
    }
    m_checked = checked;
}

@end
