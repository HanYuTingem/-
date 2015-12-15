//
//  CJAllCategoriesThreeModel.h
//  MarketManage
//
//  Created by 赵春景 on 15-7-31.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJAllCategoriesThreeModel : NSObject


/** 全部分类 (三级) 分类id */
@property (nonatomic, copy) NSString * ID;
/** 全部分类 (三级) 分类名字 */
@property (nonatomic, copy) NSString *name;
/** 全部分类 (三级) 分类父类id */
@property (nonatomic, copy) NSString *parent_id;
/** 全部分类 (三级) 分类级别 */
@property (nonatomic, copy) NSString *level;
/** 全部分类 (三级) 分类种类 */
@property (nonatomic, copy) NSString *sort;
/** 三级界面图片 (三级) */
@property (nonatomic, copy) NSString *url;

/** 初始化 并将模型负值 (三级) */
- (instancetype)initWithDict:(NSDictionary *)dict;
/** 初始化 并将模型负值 (三级) */
+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
