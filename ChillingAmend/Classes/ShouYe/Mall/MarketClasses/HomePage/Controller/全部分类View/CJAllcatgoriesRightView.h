//
//  CJAllcatgoriesRightView.h
//  MarketManage
//
//  Created by 赵春景 on 15-7-21.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJAllcatgoriesRightView : UIView

/** 全局的collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;
/** 将左侧的选择按钮的属性传入的请求头 图片用的 */
@property (nonatomic, copy) NSString *hostUrl;
/** 外界穿入的数组 二级数组 */
@property (nonatomic, strong) NSArray *dataArray;

/**
 * 初始化一个CollectionView
 */
- (instancetype)initWithFrame:(CGRect)frame controller:(UIViewController *)controller;

/**
 * 刷新CollectionView的数据
 */
- (void)upWithData;

@end
