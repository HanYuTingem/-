//
//  CrazySeckillGoodsView.h
//  MarketManage
//
//  Created by fielx on 15/4/22.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisView.h"

#import "LSYXianShiMiaoShaView.h"



#define SECKILL_VIEW_HEIGHT 157

/**
 *  显示秒杀列表
 */
@interface CrazySeckillGoodsView : CrazyBasisView<LSYXianShiMiaoShaViewDelegate>

/**
 *  信息数组
 */
@property (retain,nonatomic) NSArray *mInfoArray;


/**
 *  图片前地址
 */
@property (retain,nonatomic) NSString *mHost;

/**
 *  服务器当前时间
 */
@property (retain,nonatomic) NSString *mCurrentTime;

//点击对应的活动跳转
@property (nonatomic,copy) void (^CrazySeckillGoodsViewBlock)(NSString  * miaoshaId,NSString * subId);
//限时秒杀更新数据
@property (nonatomic,copy) void (^CrazySeckillUpdateBlock)();

@end
