//
//  CrazyShoppingCartFootView.m
//  MarketManage
//
//  Created by fielx on 15/4/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyShoppingCartFootView.h"

#define BUTTON_SIZE CGSizeMake(18, 18)

#define OPERATION_BUTTON_SIZE CGSizeMake(84, 44)

@implementation CrazyShoppingCartFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self cornerRadius:0 lineColor:C9 borderWidth:1];
        
        self.mSelectButton = [CrazyBasisButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.mSelectButton];
        [self.mSelectButton addTarget:self action:@selector(tapSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        self.mSelectButton.frame = (CGRect){DISTANCEX, 0, BUTTON_SIZE};
        [CrazyBasisFrameTool CrazyBasisFrameToolSubCenter:CrazyBasisFrameToolRelativePositionVerticalCenter superView:self suberView:self.mSelectButton];
         [self.mSelectButton crazyButtonSetNormalImage:@"crazy_mall_pay-for_norma" selectImage:@"crazy_mall_pay-for_selected"];
        
        
        
       CrazyBasisLabel *totalLabel = [CrazyBasisLabel labelAddInController:self andTitle:@"全选" andFrame:CGRectMake(CGRectGetMaxX(self.mSelectButton.frame)+INTERVAL, 0, 40, 20) andTextAlignment:NSTextAlignmentLeft andTextColor:C8 andRow:1 andFont:15 andBackGroundColor:nil andCorner:NO];
        [CrazyBasisFrameTool CrazyBasisFrameToolCenter:CrazyBasisFrameToolRelativePositionVerticalCenter mainView:self.mSelectButton moveView:totalLabel];
//       OPERATION_BUTTON_SIZE.height
        
        self.mClearButton = [CrazyBasisButton buttonAddInView:self andButtonTitleText:@"去结算(0)" andTextColor:[UIColor whiteColor] andBackGroundColor:C1 andCorner:YES andFrame:CGRectMake(SCREENWIDTH - OPERATION_BUTTON_SIZE.width - DISTANCEX, (frame.size.height -OPERATION_BUTTON_SIZE.height)/2, OPERATION_BUTTON_SIZE.width, OPERATION_BUTTON_SIZE.height) andNormalImage:nil andTextFont:15 andCorneNumberr:4 andTarget:self andSelector:@selector(tapClearButton:)];
     //   [self.mOperationButton setTitle:@"删除" forState:UIControlStateSelected];


        self.mDeleteLabel = [CrazyBasisButton buttonAddInView:nil andButtonTitleText:@"删除" andTextColor:[UIColor whiteColor] andBackGroundColor:C1 andCorner:YES andFrame:CGRectMake(SCREENWIDTH - OPERATION_BUTTON_SIZE.width - DISTANCEX, (frame.size.height -OPERATION_BUTTON_SIZE.height)/2, OPERATION_BUTTON_SIZE.width, OPERATION_BUTTON_SIZE.height) andNormalImage:nil andTextFont:15 andCorneNumberr:4 andTarget:self andSelector:@selector(tapDeleteButton:)];
        //   [self.mOperationButton setTitle:@"删除" forState:UIControlStateSelected];
        
        
        self.mShowPriceLabel = [CrazyBasisLabel labelAddInController:self andTitle:@"合计:￥0" andFrame:CGRectMake(0, 10 , CGRectGetMinX(self.mClearButton.frame) - 12, 20) andTextAlignment:NSTextAlignmentRight andTextColor:C1 andRow:1 andFont:13 andBackGroundColor:nil andCorner:NO];
        
        
        self.mPromptLabel = [CrazyBasisLabel labelAddInController:self andTitle:@"不含运费" andFrame:CGRectMake(0, frame.size.height - 30 , CGRectGetMinX(self.mClearButton.frame) - 12, 20) andTextAlignment:NSTextAlignmentRight andTextColor:nil andRow:1 andFont:13 andBackGroundColor:nil andCorner:NO];
        
        [self.mSelectButton crazyButtonSizeExpand:3];
    }
    return self;
}
//全选按钮
-(void)tapSelectButton:(CrazyBasisButton *)button
{
    button.selected = !button.selected;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"CrazyShoppingCartFootViewTotalSelect" object:nil userInfo:@{@"select":[NSNumber numberWithBool:button.selected]}];
    
}


-(void)setMState:(CrazyShoppingCartFootViewState)mState
{
    _mState = mState;
    if (mState == CrazyShoppingCartFootViewStateSelect) {
        [self addSubview:self.mClearButton];
        [self addSubview:self.mPromptLabel];
        [self addSubview:self.mShowPriceLabel];
        [self.mDeleteLabel removeFromSuperview];

    }
    else
    {
        [self.mClearButton removeFromSuperview];
        [self.mShowPriceLabel removeFromSuperview];
        [self.mPromptLabel removeFromSuperview];
        [self addSubview:self.mDeleteLabel];
    }
}



-(void)tapDeleteButton:(CrazyBasisButton *)button
{
    if ([self.delegate respondsToSelector:@selector(crazyShoppingCartFootView:didSelectDeleteButton:)]) {
        [self.delegate crazyShoppingCartFootView:self didSelectDeleteButton:button];
    }
}

-(void)tapClearButton:(CrazyBasisButton *)button
{
    if ([self.delegate respondsToSelector:@selector(crazyShoppingCartFootView:didSelectClearButton:)]) {
        [self.delegate crazyShoppingCartFootView:self didSelectClearButton:button];
    }
}

-(void)setMNumger:(int)mNumger
{
    _mNumger = mNumger;
    [self.mClearButton setTitle:[NSString stringWithFormat:@"去结算(%d)",self.mNumger] forState:UIControlStateNormal];
}


@end
