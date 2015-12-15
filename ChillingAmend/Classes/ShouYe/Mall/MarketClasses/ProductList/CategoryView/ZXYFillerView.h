//
//  ZXYFillerView.h
//  LiaoNing
//
//  Created by Rice on 14/11/25.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXYFillerCell.h"
#import "ZXYFillerSaveModel.h"
#import "CJFillerView.h"

@protocol FinishFillerDelegate <NSObject>

-(void)fillerResultWithType:(NSInteger)fillerType andLeftValue:(CGFloat)leftValue andRightValue:(CGFloat)rightValue;

@end

@interface ZXYFillerView : UIView<UITableViewDataSource,UITableViewDelegate,UpdateValueDelegate>

@property (strong, nonatomic) ZXYFillerSaveModel *saveModel;
@property (assign, nonatomic) id <FinishFillerDelegate> delegate;
/** 上个展开 */
@property (assign, nonatomic) NSInteger lastExTag;
/** 当前展开 */
@property (assign, nonatomic) NSInteger currExTag;
@property (strong, nonatomic) UITableView *fillerTableview;

@property (assign, nonatomic) CGFloat sliderLeftValue;
@property (assign, nonatomic) CGFloat sliderRightValue;

/** 接收分类模型的数组 */
@property (nonatomic, strong) NSMutableArray *fillerCategoryArray;
/** 试图View（按钮） */
@property (nonatomic, strong) CJFillerView *fillerView;

/** 分类按钮的点击事件的回调方法 把点击的tag值传回 */
@property (nonatomic, copy) void (^blockFillerCategoryBtn)(NSInteger);

/** 用来记录选中的第一行按钮是现金，还是积分 等 */
@property (nonatomic,copy) NSString *oneSelectBtn;

//BOOL _once;
//NSString *cashorIntegral;

@property (nonatomic) BOOL once;

@property (nonatomic,copy) NSString *cashorIntegral;


-(void)setListFrame:(CGRect)frame fillerCategoryArray:(NSMutableArray *)fillerCategoryArray  subTitleName:(NSString *)subTitleName;
+(ZXYFillerView *)shareInstance;

@end


