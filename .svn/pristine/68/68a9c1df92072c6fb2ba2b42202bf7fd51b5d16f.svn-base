//
//  LSYContentView.h
//  MarketManage
//
//  Created by liangsiyuan on 15/1/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSYConetntViewDelegate <NSObject>
@optional
-(void)gotoGoodsInfo:(NSDictionary*)dic status:(BOOL)status;
-(void)tablewViewNeedReloadDate:(int)num;
@end

@interface LSYContentView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 活动ID */
@property(nonatomic,copy)NSString * activityID;
/** 活动信息 */
@property(nonatomic,strong)NSDictionary * dict;
/** 商品数组 */
@property(nonatomic,strong)NSMutableArray * goodsArray;
/** 开始时间 */
@property(nonatomic,assign)long long int start_time;
/** 分页 */
@property(nonatomic,assign)int pageIndex;
/** 标识 */
@property(nonatomic,assign)int oldPageTag;
/** 标识 */
@property(nonatomic,assign)int PageTag;
@property (nonatomic,weak)id <LSYConetntViewDelegate>delegate;
@end
