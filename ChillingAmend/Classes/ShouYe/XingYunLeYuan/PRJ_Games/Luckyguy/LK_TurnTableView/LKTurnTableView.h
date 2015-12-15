//
//  LKTurnTableView.h
//  TurnTable
//
//  Created by xn on 14-6-11.
//  Copyright (c) 2014年 xn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LKTurnTableViewDelegate;

@interface LKTurnTableView : UIView
{
    float _turnTablePointerAngle; // 指针转动角度
    float _tempTurnTablePointerAngle;
    int _speedSlowInt; // 以此为倍数增长
    float _speedUpFlt;//加速浮点数
    NSTimeInterval _animateTime; // 执行动画的时间间隔
    BOOL _justEnterSlowState; // YES刚进入，NO已经进入
    
    //20140723 add
    BOOL _whetherTurnTimeToFour; // 是否转动了至少四秒，才能开始减速 yes可以，no不可以

    NSMutableArray *_imageViewArray; // 存储六个展示奖品的UIImageView 20140713 add
}

@property (strong, nonatomic) UIViewController *turnTableBearingViewCon; // 转盘承载controller
@property (strong, nonatomic) id<LKTurnTableViewDelegate> turnTableViewDelegate; // 用于通知转盘结束
@property (nonatomic) int prizeNum; // 奖品数量
@property (nonatomic) int prizeWhich; // 哪个奖品
@property (nonatomic) BOOL lotteryState; // 抽奖状态 YES已经抽完，NO还没抽。如果允许多次抽奖的话可在外部进行设置为no
@property (nonatomic) BOOL slowDownOrSpeedUp; // 判断是否应该减速了
@property (strong, nonatomic) IBOutlet UIView *turnTablePointerImageView; // 转盘指针图片
@property (strong, nonatomic) IBOutlet UIImageView *firstPrizeImageView; // 奖品1
@property (strong, nonatomic) IBOutlet UIImageView *secondPrizeImageView; // 奖品2
@property (strong, nonatomic) IBOutlet UIImageView *thirdPrizeImageView; // 奖品3
@property (strong, nonatomic) IBOutlet UIImageView *fouthPrizeImageView; // 奖品4
@property (strong, nonatomic) IBOutlet UIImageView *fifthPrizeImageView; // 奖品5
@property (strong, nonatomic) IBOutlet UIImageView *sixthPrizeImageView; // 奖品6
@property (weak, nonatomic) IBOutlet UIImageView *blinkImageView; // 一闪一闪动画背景
@property (weak, nonatomic) IBOutlet UIButton *turnBtn; // 开始按钮

- (IBAction)turnButtonAction:(id)sender;
//展示转盘
- (void)showTurnTableView;
//添加图片
- (void)getImageByUrl:(NSMutableArray *)imageUrlArray;
//开始转动
- (void)startTurining;
//归零，指针、计数等清零
- (void)settingStateReturnToZero;
+ (LKTurnTableView *)sharedTurnTableView;

@end

//转盘行为完成后调用的代理
@protocol LKTurnTableViewDelegate <NSObject>

- (void)startRequestDelegate;
- (void)turnTableResultDelegate;
//20140713 add 手势
- (void)prizeImageViewGesture:(NSString *)tag;

@end
