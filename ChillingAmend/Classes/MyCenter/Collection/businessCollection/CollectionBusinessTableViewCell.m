//
//  CollectionBusinessTableViewCell.m
//  ChillingAmend
//
//  Created by 孙瑞 on 15/9/21.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import "CollectionBusinessTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation CollectionBusinessTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setChecked:(BOOL)checked {
    if (checked) {
        m_checkImageView.image = [UIImage imageNamed:@"mycollect_list_spanner_icon_selected.png"];
    } else {
        m_checkImageView.image = [UIImage imageNamed:@"mycollect_list_spanner_btn_normal.png"];
    }
    m_checked = checked;
}

- (void)businessWithCollectionBusinessModel:(BYC_BusinessModel *)model {
    
    _headImgView.layer.borderWidth = 1;
    _headImgView.layer.borderColor = [UIColor colorWithRed:226.0/255 green:226.0/255 blue:226.0/255 alpha:1.0].CGColor;
    _headImgView.layer.masksToBounds = YES;
    [_headImgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", NiceFood_ImageUrl, model.business_img]] placeholderImage:[UIImage imageNamed:@"defaultimg_content_img"]];
    _merchantNameLabel.text = model.business_name;
    NSString *addressString;
    if (model.business_address == nil || [model.business_address isEqualToString:@"0"]) {
        addressString = [NSString stringWithFormat:@"%@",model.business_industryName];
    }
    else {
        
        addressString = [NSString stringWithFormat:@"%@  %@",model.business_address,model.business_industryName];
    }
    
    _merchantAddressLabel.text = addressString;
    NSLog(@"%@",model.business_consumption);
    _avgpriceLabel.text = [NSString stringWithFormat:@"人均￥%@",model.business_consumption];
    
    //控制评分的显示
    for (int i = 0; i < 5; i++) {
        [self.starImgArray[i] setHidden:YES];
    }
    for (int i = 0; i < 5; i++) {
        if ([model.business_star isEqualToString:[NSString stringWithFormat:@"%d",i]]) {
            break;
        }
        else {
            [self.starImgArray[i] setHidden:NO];
        }
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


@end
