//
//  CrazyBasisCell.h
//  MarketManage
//
//  Created by fielx on 15/4/15.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "CrazyBasisLabel.h"
#import "CrazyBasisImageView.h"
#import "CrazyBasisView.h"
#import "CrazyBasisButton.h"
#import "CrazyBasisFile.h"
#import "CrazyBasisFrameTool.h"

/**
 *  基础cell
 */
@interface CrazyBasisCell : UITableViewCell


/**
 *  名称
 */
@property (retain,nonatomic) CrazyBasisLabel *mNameLabel;


/**
 *  内容
 */
@property (retain,nonatomic) CrazyBasisLabel *mContentLabel;


/**
 *  价格
 */
@property (retain,nonatomic) CrazyBasisLabel *mPrice;


/**
 *  时间
 */
@property (retain,nonatomic) CrazyBasisLabel *mTime;


/**
 *  图片
 */
@property (retain,nonatomic) CrazyBasisImageView *mImageView;


/**
 *  背景视图
 */
@property (retain,nonatomic) CrazyBasisView *mBgView;


/**
 *  选择按钮
 */
@property (retain,nonatomic) CrazyBasisButton *mSelectButton;


/**
 *  分割线
 */
@property (retain,nonatomic) CrazyBasisImageView *mLineImageView;

//#pragma mark  后来添加
///** 未编辑显示的view */
//
//@property (nonatomic,strong) UIView *showView;
//
///** 显示颜色的label */
//@property(nonatomic,strong) UILabel *colorLabel;
//
///** 现价 */
//@property (nonatomic,strong)UILabel *nowLabel;
//
///** 原来的价钱 */
//@property(nonatomic,strong) UILabel *agoLabel;
//
///** 编辑的View */
//
//@property (nonatomic,strong) UIView *editView;
//

@property (assign,nonatomic) BOOL ifEditOrShow;

-(void)crazyBasisCellContent:(id)info;


-(void)tapSelectButton:(CrazyBasisButton *)button;
@end
