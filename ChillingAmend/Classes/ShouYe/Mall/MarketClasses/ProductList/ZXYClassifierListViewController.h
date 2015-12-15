//
//  ZXYClassifierListViewController.h
//  Chiliring
//
//  Created by Rice on 14-9-9.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "ZXYFillerSliderCalculate.h"

#import "AnimationView.h"                    //大图列表
#import "ZXYCategoryView.h"                  //分类下拉菜单
#import "ZXYFillerView.h"                    //筛选
#import "ZXYSearchHistroyView.h"

#import "ZXYCatogeryModel.h"                 //分类信息
#import "ZXYClassfierListModel.h"            //列表信息

#import "MarketAPI.h"
#import "LSYGoodsInfoViewController.h"

#import "L_BaseMallViewController.h"

@interface ZXYClassifierListViewController : L_BaseMallViewController<categorySlected,AnimationSelectedRowDelegate,FinishFillerDelegate,UISearchBarDelegate,SelectHistroyDelegate>
/** 分类id */
@property (copy, nonatomic) NSString *cat_id;
/** 分类名称 */
@property (copy, nonatomic) NSString *cat_name;
/** 记录分类选择行 */
@property (assign, nonatomic) NSInteger leftRow;
/** 首页搜索 */
@property (copy, nonatomic) NSString *searchName;
/** 是否来自app的录播图 */
@property (nonatomic) BOOL  fromAppBanner;

@end
