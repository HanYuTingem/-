//
//  CJAttributeNumAddView.h
//  MarketManage
//
//  Created by 赵春景 on 15-7-24.
//  Copyright (c) 2015年 Rice. All rights reserved.
//  加减号方格计数器

#import <UIKit/UIKit.h>
#import "LSYGoodsInfo.h"
@class CJAttributeModle;

@protocol CJAttributeNumAddViewDelegate <NSObject>
@optional
/** 商品数量改变 */
-(void)goodsNumChange:(int)count;
///** 点击对应的cellcontentView */
//- (void)didSecectGoodsContentView;
@end

@interface CJAttributeNumAddView : UIView


/** 商品Model */
@property (nonatomic,strong)LSYGoodsInfo * goods;
@property (nonatomic,weak)id <CJAttributeNumAddViewDelegate>delegate;


/** 从上级界面传入的模型 */
@property (nonatomic, strong) CJAttributeModle *modle;
/** 加减号中间的数字label */
//@property (nonatomic, strong) UILabel *numLabel;
/** 加减号中间的数字TextFiled (而不是label) */
@property (nonatomic, strong) UITextField *numLabel;

/** 加减号方格计数器中间的 数字label改变事件 文字block回调方法 */
@property (nonatomic, strong) void(^blockNumAddViewText)(NSString *);
/** 用来现实提示信息  超出购物车数量 */
@property (nonatomic, strong) void(^blockPrompt)(void);
/** 点击事件 用作键盘的收起 */
@property (nonatomic, copy) void(^blockViewClickAdd)(void);


/** 商品购买添加的数量 */
@property (nonatomic,assign) int count;
/** 是否秒杀 其他秒杀 0不秒杀 */
@property (copy, nonatomic) NSString * isSeckilling;
/** 是否有地址 1有0 没 有 */
@property (copy, nonatomic) NSString * isHaveAdd;
/** 用来接收上级页面传来的 已选择商品数量 */
@property (nonatomic, copy) NSString *getAttributeGoodsNums;


/** 初始化  加减号方格计数器 frame的高度随便写入 系统将自动调整 */
- (instancetype)initWithFrame:(CGRect)frame WithAttributeGoodsNums:(NSString *)attributeGoodsNums;



@end
