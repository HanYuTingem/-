//
//  CrazyBasisTableNoDataView.h
//  MarketManage
//
//  Created by fielx on 15/4/21.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisView.h"


/**
 *  tableView 无数据视图
 */
@interface CrazyBasisTableNoDataView : CrazyBasisView


/**
 *  跳转按钮
 */
@property (retain,nonatomic) CrazyBasisButton *mButton;


/**
 *  提示图
 */
@property (retain,nonatomic) CrazyBasisImageView *mImageView;


/**
 *  提示标题
 */
@property (retain,nonatomic) CrazyBasisLabel *mTitleLabel;

/**
 *  提示内容
 */
@property (retain,nonatomic) CrazyBasisLabel *mContentLabel;

- (instancetype)initWithFrame:(CGRect)frame imageString:(NSString *)imageString;

-(void)tapButton:(CrazyBasisButton *)button;

@end
