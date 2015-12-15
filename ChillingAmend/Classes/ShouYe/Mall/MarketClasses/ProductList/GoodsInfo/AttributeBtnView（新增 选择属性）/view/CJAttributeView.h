//
//  CJAttributeView.h
//  MarketManage
//
//  Created by 赵春景 on 15-7-24.
//  Copyright (c) 2015年 Rice. All rights reserved.
//  添加 颜色  尺寸 等 模块的按钮

#import <UIKit/UIKit.h>
#import "LSYGoodsInfo.h"
#import "CJMyButton.h"//自定义的button按钮


@interface CJAttributeView : UIView

/** 从CJAttributeSelectController 里传过来的商品信息 只要attr_spec数组 */
@property (nonatomic, strong) LSYGoodsInfo *goods;

/** 从CJAttributeSelectController 里传过来的商品信息 只要attr_spec数组 */
@property (nonatomic, strong) NSMutableArray *goodsArray;

/** 记录之前点击的button */
@property (nonatomic, strong) CJMyButton *oldBtn;

/** btn按钮的点击事件 将按钮的文字block回调 */
@property (nonatomic, strong) void(^blockBtnText)(CJMyButton *);
/** view被点击后的事件回调 用于键盘的收起 */
@property (nonatomic, copy) void(^blockViewClick)(void);

/** 用来存储创建按钮的数组 */
@property (nonatomic, strong) NSMutableArray *btnArrayM;
/** 用来接收上级页面传过来的 已选择商品模型 */
@property (nonatomic, strong) CJAttributeModle *getAttributeModel;


/**
 * goods LSYGoodsInfo请求的数据   titleName标题名称key的值  group第几组数据
 */
- (instancetype)initWithFrame:(CGRect)frame andLSYGoodsInfo:(LSYGoodsInfo *)goods titleName:(NSString *)titleName group:(int)group CJAttributeModel:(CJAttributeModle *)attributeModel;

/**
 * 当按钮选中后调用这个方法 判断按钮是否是置非状态
 */
- (void)attributeViewWithCJAttributeViewBtnArray:(NSMutableArray *)btnArray;


@end
