//
//  CrazyBasisModel.h
//  MarketManage
//
//  Created by fielx on 15/4/20.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrazyBasisModel : NSObject


/**
 *  头像地址
 */
@property (retain,nonatomic) NSString *mImageUrl;

/**
 *  ID
 */
@property (retain,nonatomic) NSString *mId;


/**
 *  名称
 */
@property (retain,nonatomic) NSString *mName;

/**
 *  价格
 */
@property (retain,nonatomic) NSString *mPrice;

/**
 *  积分
 */
@property (retain,nonatomic) NSString *mIntegral;

/**
 *   内容
 */
@property (retain,nonatomic) NSString *mContent;

/**
 *  初始化
 */
- (instancetype)initWithDic:(NSDictionary *)dic;

/**
 *  去NULL
 */
+(NSMutableDictionary *)crazyModelDeleteNull:(NSDictionary *)dic;
@end
