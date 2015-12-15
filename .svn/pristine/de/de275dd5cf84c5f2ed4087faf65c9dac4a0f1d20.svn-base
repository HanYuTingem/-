//
//  DHHeadSecondsKill.h
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketAPI.h"
#import "ActitvityListModel.h"
#import "ActivityModel.h"




@interface DHHeadSecondsKill : UICollectionReusableView

@property (nonatomic,strong) UILabel *headTitle;//限时秒杀标题

@property(nonatomic,strong) UIImageView *ClockImageview;// 时钟图片

@property (nonatomic,strong) UILabel * hourLabel;//小时

@property(nonatomic,strong) UILabel * minuteLabel;//分钟

@property (nonatomic,strong) UILabel * secondsLabel;//秒

@property(nonatomic,strong) UIButton *moreButton;// 更多按钮

@property(nonatomic,strong) UIImageView *upLineIamgeView;
@property(nonatomic,strong) UIImageView *downLineImageView;

/** 当前时间 */
@property (nonatomic,copy) NSString *mCurrentTime;


/** 时间 倒计时 如果 大于一天显示 年月日 */
@property(nonatomic,strong)UILabel  *timeView;

/** 时间倒计时  显示时分秒  */
@property(nonatomic,strong)UIView *HMSView;

@property(nonatomic,strong)NSTimer *timer;

/** 箭头 */
@property(nonatomic,strong)UIImageView *ArrowImageView;

@property (nonatomic)     BOOL single;
-(void)refresj:(NSString *)titleName;
-(void)RefreshActivityUI:(ActivityModel *)model;
@end
