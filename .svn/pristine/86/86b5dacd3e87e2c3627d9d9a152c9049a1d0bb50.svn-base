//
//  SINOActionListTableViewCell.m
//  LANSING
//
//  Created by yll on 15/7/20.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "SINOActionListTableViewCell.h"

@implementation SINOActionListTableViewCell{
    
    __weak IBOutlet UILabel *lineLabel;
}

- (void)awakeFromNib {
    // Initialization code
#pragma mark 单个倒圆角
    CAShapeLayer *styleLayer = [CAShapeLayer layer];
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.actionListImageView.bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)cornerRadii:CGSizeMake(5.0, 5.0)];
    styleLayer.path = shadowPath.CGPath;
    self.actionListImageView.layer.mask = styleLayer;

//    lineLabel.layer.shadowColor = KGrayLineTwoThreeFourColor.CGColor;
//    lineLabel.layer.shadowOffset = CGSizeMake(0, 3);
//    lineLabel.layer.shadowRadius = 2;
//    lineLabel.layer.shadowOpacity = 1;
    [self initActionEndView];
}

//活动结束提醒View
- (void) initActionEndView{
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, self.frame.size.width -20, self.frame.size.height-10)];
    self.bgView.backgroundColor = [[UIColor colorWithRed:149/255.0f green:149/255.0f blue:149/255.0f alpha:1] colorWithAlphaComponent:0.6];
    CAShapeLayer *styleLayer = [CAShapeLayer layer];
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)cornerRadii:CGSizeMake(5.0, 5.0)];
    styleLayer.path = shadowPath.CGPath;
    self.bgView.layer.mask = styleLayer;
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(self.bgView.frame.size.width-36, 0, 36, 36)];
    imageV.image = [UIImage imageNamed:@"圆角矩形 412 拷贝 3.png"];
    [self.bgView addSubview:imageV];
    [self addSubview:self.bgView];
    self.bgView.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
