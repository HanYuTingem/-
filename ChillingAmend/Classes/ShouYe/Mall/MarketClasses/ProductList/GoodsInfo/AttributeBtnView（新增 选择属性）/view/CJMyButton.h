//
//  CJMyButton.h
//  MarketManage
//
//  Created by 赵春景 on 15-8-7.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJMyButton : UIButton

/** 判断是否存在 YSE不存在 NO存在 */
@property (nonatomic, assign) BOOL isDefault;
/** 用来记录拥有本按钮属性的模型 */
@property (nonatomic, strong) NSMutableArray *buttonArray;

/** 判断是否选中 YSE选中 NO没有选中 */
@property (nonatomic, assign) BOOL isSelect;

/** 用来记录拥有本按钮属性的 下级按钮 */
@property (nonatomic, strong) NSMutableArray *buttonArrayBtn;



/** 用来记录按钮选中后 存储相关属性的模型 */
@property (nonatomic, strong) NSMutableArray *buttonModelArray;

@end
