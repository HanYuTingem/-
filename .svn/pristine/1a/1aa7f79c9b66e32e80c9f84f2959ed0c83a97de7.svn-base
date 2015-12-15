//
//  CJFillerView.h
//  MarketManage
//
//  Created by 赵春景 on 15-8-28.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXYFillerSaveModel.h"

@interface CJFillerView : UIView


@property (strong, nonatomic) ZXYFillerSaveModel *saveModel;

/** 记录之前点击的button */
@property (nonatomic, strong) UIButton *oldBtn;
/** 类型多的时候出现的下拉按钮 */
@property (nonatomic, strong) UIButton *fillerLableBtn;
/** 子标题Label(红字) */
@property (nonatomic, strong) UILabel *fillerSubLabel;


/** btn按钮的点击事件 将按钮的文字block回调 */
@property (nonatomic, strong) void(^blockBtnText)(UIButton *);
/** 下拉按钮的点击事件的回调 */
@property (nonatomic, copy) void(^blockFillerDownBtnClick)(UIButton *);


/**
 * titleName标题的名字  subTitleName子标题名字（没有传空）dataArray按钮数据数组
 */
- (instancetype)initWithFrame:(CGRect)frame titleName:(NSString *)titleName subTitleName:(NSString *)subTitleName dataArray:(NSArray *)dataArray numTag:(NSInteger)numTag oneSelsctBtnName:(NSString *)oneSelsctBtnName;

@end
