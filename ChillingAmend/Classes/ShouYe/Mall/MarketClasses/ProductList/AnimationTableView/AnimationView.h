//
//  AnimationView.h
//  animationView
//
//  Created by Rice on 14/12/3.
//  Copyright (c) 2014年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListCell.h"
#import "ZXYClassfierListModel.h"
#import "MJRefresh.h"
#import "MarketAPI.h"

@protocol AnimationSelectedRowDelegate <NSObject>
-(void)animationSelectedBtnWithLeft:(BOOL)isleft WithIndexRow:(NSInteger)row;
// xuwenbo add
- (void)scrollViewEndScroll:(BOOL)isScrollEnd;

@end

@interface AnimationView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    ZXYClassfierListModel *listModel;
}
/** AnimationView 的 UITableView */
@property (nonatomic, strong) UITableView *listTableView;
/** AnimationView 的代理方法 */
@property (nonatomic, assign) id<AnimationSelectedRowDelegate>animationDelegate;

@property (copy, nonatomic) NSString *imageHostUrl;

@end


