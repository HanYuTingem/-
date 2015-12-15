//
//  ZXYFillerSaveModel.h
//  MarketManage
//
//  Created by Rice on 15/1/27.
//  Copyright (c) 2015年 Rice. All rights reserved.
//
/**********************************
         商品列表筛选项保存
 **********************************/
#import <Foundation/Foundation.h>

@interface ZXYFillerSaveModel : NSObject

/** 0现金 1积分 2积分+现金 */
@property (copy, nonatomic) NSString       *currentType;
/** 0现金 1积分 2积分+现金 */
@property (copy, nonatomic) NSString       *lastType;
@property (strong, nonatomic) NSMutableArray *leftValueAry;
@property (strong, nonatomic) NSMutableArray *rightValueAry;

+(ZXYFillerSaveModel *)shareInstance;

/**
 重置商品列表筛选项
 */
-(void)resetSaveModel;

@end
