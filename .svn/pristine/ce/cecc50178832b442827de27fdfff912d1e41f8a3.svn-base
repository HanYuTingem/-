//
//  ZXYCategoryView.h
//  Chiliring
//
//  Created by Rice on 14-9-9.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXYCatogeryModel.h"
#import "MarketAPI.h"

@protocol categorySlected <NSObject>
/** 分类页的点击代理方法 */
-(void)didSelectedCategoryWithIndexRow:(NSInteger)row;
@end

@interface ZXYCategoryView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    /** 分类页的数据源 */
    ZXYCatogeryModel *catogeryModel;
}
/** 分类页的代理 */
@property (nonatomic) id <categorySlected> costomDelegate;
/** 分类页的tableView */
@property (nonatomic) UITableView *categoryListTableview;

/** 自定义分类页列表大小 */
-(void)setListFrame:(CGRect)frame;
+(ZXYCategoryView *)shareInstance;
@end


