//
//  CrazyBasisCell.m
//  MarketManage
//
//  Created by fielx on 15/4/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisCell.h"

/**
 *  基础Lable
 */
@implementation CrazyBasisCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CBGCELL;
        
        self.mBgView = [[CrazyBasisView alloc]init];
        [self addSubview:self.mBgView];
        
        
        self.mNameLabel = [[CrazyBasisLabel alloc]init];
        [self.mBgView addSubview:self.mNameLabel];
        self.mNameLabel.numberOfLines = 2;
        
        self.mTime = [[CrazyBasisLabel alloc]init];
        [self.mBgView addSubview:self.mTime];
        
//        (170, 40, 180, 60)
               
        
        self.mContentLabel = [[CrazyBasisLabel alloc]init];
        [self.mBgView addSubview:self.mContentLabel];
        
        self.mImageView = [[CrazyBasisImageView alloc]init];
        [self.mBgView addSubview:self.mImageView];
        
        self.mSelectButton = [CrazyBasisButton buttonWithType:UIButtonTypeCustom];
        [self.mBgView addSubview:self.mSelectButton];
        [self.mSelectButton addTarget:self action:@selector(tapSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        
//        self.mLineImageView = [[CrazyBasisImageView alloc]init];
//        [self.mBgView addSubview:self.mLineImageView];
//        self.mLineImageView.image = [UIImage imageNamed:@"zxy_line"];
    
        
      
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;

}


-(void)crazyBasisCellContent:(id)info
{

}


-(void)tapSelectButton:(CrazyBasisButton *)button
{
    button.selected = !button.selected;
}
//-(void)setIfEditOrShow:(BOOL)ifEditOrShow{
//    
//    if (ifEditOrShow) {
//        self.showView.hidden = YES;
//        self.editView.hidden = NO;
//        
//    }else
//    {
//        self.showView.hidden = NO;
//        self.editView.hidden = YES;
//    }
//}

@end
