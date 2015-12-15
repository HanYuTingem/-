//
//  SINOMyCollectTableViewCell.m
//  LANSING
//
//  Created by yll on 15/7/20.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "SINOMyCollectTableViewCell.h"

@implementation SINOMyCollectTableViewCell
{
    __weak IBOutlet UILabel *bottomLable;
}


- (void)awakeFromNib {
//    self.signUpForactiveState = 3;
    
    // Initialization code
//    topBlankLable.layer.borderWidth = 1;
//    topBlankLable.layer.borderColor = KGrayLineTwoTwoOneColor.CGColor;
    
    [self initActionEndView];
    
}
//活动结束提醒View
- (void) initActionEndView{
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    UILabel *endLable = [[UILabel alloc]initWithFrame:CGRectMake(self.bgView.frame.size.width-60, self.bgView.frame.size.height/2-25, 50, 50)];
    endLable.layer.masksToBounds = YES;
    endLable.text = @"已结束";
    endLable.font = [UIFont systemFontOfSize:14];
    endLable.textAlignment = NSTextAlignmentCenter;
    endLable.textColor = [UIColor whiteColor];
    endLable.backgroundColor = [UIColor colorWithRed:125/255.0f green:125/255.0f blue:125/255.0f alpha:1];
    endLable.layer.cornerRadius = endLable.frame.size.width/2;
    [self.bgView addSubview:endLable];
    self.bgView.backgroundColor = [[UIColor colorWithRed:149/255.0f green:149/255.0f blue:149/255.0f alpha:1] colorWithAlphaComponent:0.5];
    [self addSubview:self.bgView];
    self.bgView.hidden = YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
