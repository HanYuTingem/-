//
//  TableHeaderView.h
//  QQList
//
//  Created by sunsu on 15/6/23.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZNSegmentedControl.h"
#import "MerchantModel.h"
#import "GetMerOrVideoModel.h"

@protocol TableHeaderViewDelegate <NSObject>
-(void)turnToMap;
-(void)clickByIndex:(NSInteger)index;
@end


@interface TableHeaderView : UIView

@property (nonatomic, strong) UIImageView         * foodImg;
@property (nonatomic, strong) UILabel             * locationLabel;
@property (nonatomic, strong) UIView              * sectionView;//三个按钮
@property (nonatomic, strong) NSMutableArray      * segTitles;
@property (nonatomic, strong) NSString            * title;
@property (nonatomic, strong) UIButton            * mapButton;
@property (nonatomic, strong) DZNSegmentedControl * control;

@property (nonatomic, strong) MerchantModel       * merchantModel;//商户详情界面模型
@property (nonatomic, strong) GetMerOrVideoModel  * getMerOrVideoModel;//是否有视频和商品模型

//typedef void(^locationlabelClick)(NSInteger index);
//@property(nonatomic,copy)locationlabelClick locationlabelClickBlock;

@property(nonatomic,weak)id<TableHeaderViewDelegate>deleagte;

-(instancetype)init;
+ (instancetype)headerViewWithFrame:(CGRect)frame andModel:(GetMerOrVideoModel*)model;
- (instancetype)initWithHeaderViewFrame:(CGRect)frame andModel:(GetMerOrVideoModel*)model;

@end

