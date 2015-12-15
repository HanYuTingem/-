//
//  CrazyBasisViewController.h
//  MarketManage
//
//  Created by fielx on 15/4/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASIHTTPRequest.h"

#import "ZXYWarmingView.h"

#import "CrazyBasisRequset.h"

#import "CrazyBasisFile.h"

#import "CrazyPushTool.h"

#import "ZXYIndicatorView.h"

#import "CrazyBasisAlertView.h"

#define LOAD_FAILURE @"加载失败"

/**
 *  基础控制区父类
 */
@interface CrazyBasisViewController : UIViewController
{
    /**
     *  提示框
     */
    ZXYWarmingView *warmingView;
    
    /**
     *
     */
    ZXYIndicatorView *loadView;
}
/**
 *  请求数组
 */
@property (strong,nonatomic) NSMutableArray *mRequsetArray;

/**
 *  数据Array
 */
@property (retain,nonatomic) NSMutableArray *mInfoArray;


@property (nonatomic, strong) UIView    *barView; // 导航栏
@property (nonatomic, strong) CrazyBasisButton  *leftButton; // 左键
@property (nonatomic, strong) UIButton  *rightButton; // 右键
@property (nonatomic, strong) UILabel  * mallTitleLabel;


//左边按钮
- (void)leftBackCliked:(UIButton*)sender;

//右边按钮
- (void)rightBackCliked:(UIButton*)sender;

/**
 *  提示内容
 */
-(void)showMsg:(NSString *)content;



/**
 *  加载提示框
 */
-(void)startActivity;
/**
 *  完成加载移除提示框
 */
-(void)stopActivity;








@end
