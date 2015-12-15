//
//  LSYImageDetails.h
//  MarketManage
//
//  Created by liangsiyuan on 15/1/22.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJParameterTableView.h"//属性规格 新改变页面

@protocol LSYImageDetailsDelegate <NSObject>
@optional
-(void)backToTopView;

@end

@interface LSYImageDetails : UIView
@property (nonatomic,weak)id <LSYImageDetailsDelegate>delegate;
/** 商品介绍数据 */
@property (nonatomic,strong)NSDictionary * dict;
/** 厂商数据  2015.8 新添加 商品规格  */
@property (nonatomic,strong)NSDictionary * dictChangShang;

//没用它
/** 2015.8 新添加 商品规格 */
@property (nonatomic, strong) NSDictionary *dictParameter;

/** 全局的参数规格页面 */
@property (nonatomic, strong) CJParameterTableView *parameterView;

@end
