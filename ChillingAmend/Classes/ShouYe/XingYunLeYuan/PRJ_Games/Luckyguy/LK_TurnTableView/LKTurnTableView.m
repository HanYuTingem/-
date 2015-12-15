//
//  LKTurnTableView.m
//  TurnTable
//
//  Created by xn on 14-6-11.
//  Copyright (c) 2014年 xn. All rights reserved.
//

#import "LKTurnTableView.h"
#import "UIImageView+WebCache.h"
#import "LuckyGuyModel.h"
#import "UITapGestureRecognizer+KTapGesture.h" // 20140713 add
#import "BXAPI.h"
static LKTurnTableView *turnTableView = nil;

@implementation LKTurnTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark -初始化
- (void)initWithObjects
{
    _turnTablePointerAngle = 0.0;
    _tempTurnTablePointerAngle = 0.0;
    _speedSlowInt = 1;
    _speedUpFlt = 0.0;
    _animateTime = 0.01;
    _justEnterSlowState = YES; // 刚进入减速状态
    self.prizeNum = 6; // 奖品的数量
    self.slowDownOrSpeedUp = YES; // NO为减速
    // 20140723 add
    _whetherTurnTimeToFour = NO; // 初始化为NO
    // 改变奖品角度
    self.firstPrizeImageView.transform = CGAffineTransformMakeRotation(30 * (M_PI / 180.0f));
    self.secondPrizeImageView.transform = CGAffineTransformMakeRotation(90 * (M_PI / 180.0f));
    self.thirdPrizeImageView.transform = CGAffineTransformMakeRotation(150 * (M_PI / 180.0f));
    self.fouthPrizeImageView.transform = CGAffineTransformMakeRotation(210 * (M_PI / 180.0f));
    self.fifthPrizeImageView.transform = CGAffineTransformMakeRotation(270 * (M_PI / 180.0f));
    self.sixthPrizeImageView.transform = CGAffineTransformMakeRotation(330 * (M_PI / 180.0f));
    // 20140713 修改 数组
    _imageViewArray = [NSMutableArray arrayWithObjects:self.firstPrizeImageView, self.secondPrizeImageView, self.thirdPrizeImageView, self.fouthPrizeImageView, self.fifthPrizeImageView, self.sixthPrizeImageView, nil];
    // 添加手势  20140713修改
    for (int i = 0; i < [_imageViewArray count]; i ++) {
        UIImageView *imageView = [_imageViewArray objectAtIndex:i];
        [imageView setExclusiveTouch:YES];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPrizeImage:)];
        gesture.numberOfTapsRequired = 1;
        gesture.numberOfTouchesRequired = 1;
        gesture.tag = [NSString stringWithFormat:@"%d", i + 11];
        [imageView addGestureRecognizer:gesture];
        imageView.userInteractionEnabled = YES;
    }
    
}
#pragma mark 奖品手势（20140713修改）
- (void)showPrizeImage:(UIGestureRecognizer *)gesture
{
    UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer *)gesture;
    [self.turnTableViewDelegate prizeImageViewGesture:tapGesture.tag];
}

#pragma mark --- 展示转盘 ---
- (void)showTurnTableView
{
    // 连续动画:闪烁的灯
    NSArray *myImages = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"zhuanpan_content_img_default3.png"],
                         [UIImage imageNamed:@"zhuanpan_content_img_default4.png"], nil];
    _blinkImageView.animationImages = myImages; // animationImages属性返回一个存放动画图片的数组
    _blinkImageView.animationDuration = 1; // 浏览整个图片一次所用的时间
    _blinkImageView.animationRepeatCount = 0; // 0 = loops forever 动画重复次数
    [_blinkImageView startAnimating];
    
    [self initWithObjects];
    [self.turnBtn setExclusiveTouch:YES];
    self.turnBtn.userInteractionEnabled = YES;
    [self.turnTableBearingViewCon.view addSubview:self];
}

#pragma mark 开始转动
- (void)startTurining
{
    [self startButtonAction];
    //20140723 add 计时器，2.5秒之后把_whetherTurnTimeToFour=yes
    [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(turnTimeOfYes) userInfo:nil repeats:NO];
}

#pragma mark 点击中间button调用
- (void)startRequest
{
    // 点击中间button
    [self.turnTableViewDelegate startRequestDelegate];
}

#pragma mark --- startButtonAction 开始转动 ---
- (void)startButtonAction
{
    if (self.lotteryState) {
        NSLog(@"此时为不可再次点击状态，如果想要再次抽奖请设置self.lotteryState=NO");
        return;
    }
    // 设置为不可点击状态，防止在转的过程中再次点击
    if (self.turnBtn.userInteractionEnabled == YES) {
        self.turnBtn.userInteractionEnabled = NO;
    }
    // 每个位置偏移角度
    float changeAngle = 0;
    if (self.prizeWhich == 2 || self.prizeWhich == 4 || self.prizeWhich == 6) {
        changeAngle = 100;
    } else if (self.prizeWhich == 3 || self.prizeWhich == 5) {
        changeAngle = 280;
    } else if (self.prizeWhich == 1) {
        changeAngle = 270;
    }
    // M_PI / 180.0f 弧度制 这是1弧度
    CGAffineTransform endAngle = CGAffineTransformMakeRotation((_turnTablePointerAngle + changeAngle + self.prizeWhich * (360.0f / self.prizeNum)) * (M_PI / 180.0f));
    if (!self.slowDownOrSpeedUp && _whetherTurnTimeToFour) {
        // 减速定位 3.5圈减速，从2.5圈后开始定位
        if (_justEnterSlowState) {
            NSLog(@"start slow Angle = %lf", _turnTablePointerAngle);
            // 1.从零开始计算
            _tempTurnTablePointerAngle = 0;
        }
        _justEnterSlowState = NO;
        // 开始减速
        _animateTime += 0.0001 * _speedSlowInt;
        _speedSlowInt ++;
        if (_tempTurnTablePointerAngle/180 >= 3) {
            int quan = _turnTablePointerAngle / 360;
            float result = _turnTablePointerAngle - 360 * quan;
            // 一个奖品的弧度数
            float aPrizeAngle = 360 / self.prizeNum;
            float littleAngle = aPrizeAngle * (self.prizeWhich - 1) - 30;
            float bigAngle = aPrizeAngle * self.prizeWhich - 30;
            if (littleAngle == - 30) {
                int randomNum = arc4random() % 20 + 5;
                NSLog(@"randomNum = %d",randomNum);
                if ((330 + randomNum < result && result < 360) || (randomNum < result && result < 25)) {
                    [UIView animateWithDuration:_animateTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                        self.turnTablePointerImageView.transform = endAngle;
                    } completion:^(BOOL finished) {
                        // 抽奖成功
                        [self.turnTableViewDelegate turnTableResultDelegate];
                        self.turnBtn.userInteractionEnabled = YES;
                    }];
                    self.lotteryState = YES;
                    return;
                }
            } else {
                int randomNum = arc4random() % 50 + 5;
                if (littleAngle + randomNum < result && result < bigAngle - 5) {
                    [UIView animateWithDuration:_animateTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                        self.turnTablePointerImageView.transform = endAngle;
                    } completion:^(BOOL finished) {
                        // 抽奖成功
                        [self.turnTableViewDelegate turnTableResultDelegate];
                        self.turnBtn.userInteractionEnabled = YES;
                    }];
                    self.lotteryState = YES;
                    return;
                }
            }
        } else if (_animateTime > 0.6) {
            NSLog(@"end slow Angle = %lf",_turnTablePointerAngle);
            _animateTime = 0.01;
            _speedUpFlt = 0.0;
            _speedSlowInt = 1;
            _turnTablePointerAngle -= _speedUpFlt + 0.05;
            self.slowDownOrSpeedUp = YES;
            _whetherTurnTimeToFour = NO; // 20140723 add
            return;
        }
    }
    [UIView animateWithDuration:_animateTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.turnTablePointerImageView.transform = endAngle;
    } completion:^(BOOL finished) {
        _turnTablePointerAngle += _speedUpFlt;
        _tempTurnTablePointerAngle += _speedUpFlt;
        if (self.slowDownOrSpeedUp || !_whetherTurnTimeToFour) { // 20140723 amend
            if (_speedUpFlt != 20) {
                _speedUpFlt += 1.0;
            }
        } else if (_whetherTurnTimeToFour) { // 20140723 amend
            // 开始减速
            if (_speedUpFlt > 0.1) {
                _speedUpFlt -= 0.2;
            }
        }
        [self startButtonAction];
    }];
    // 简单办法：直接0-6.28
}

#pragma mark -添加奖品图片
- (void)getImageByUrl:(NSMutableArray *)imageUrlArray
{
    NSMutableArray *imageViewArray = [NSMutableArray arrayWithObjects:self.firstPrizeImageView,self.secondPrizeImageView,self.thirdPrizeImageView,self.fouthPrizeImageView,self.fifthPrizeImageView,self.sixthPrizeImageView, nil];
    for (int i = 0; i < [imageUrlArray count]; i ++) {
        LuckyGuyModel *model = [imageUrlArray objectAtIndex:i];
        NSURL * imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", img_url, model.img]];
        dispatch_queue_t loadImageQueue =
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_async(loadImageQueue, ^{
            //            NSData * data = [NSData dataWithContentsOfURL:imageURL];
            //            UIImage * atuImage = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageView *imageView = [imageViewArray objectAtIndex:i];
                //                imageView.image = atuImage;
                [imageView setImageWithURL: imageURL placeholderImage:[UIImage imageNamed:@"zhuanpan_content_liwu.png"]];
                //去除多个button同事点击的效果
                [imageView setExclusiveTouch:YES];
            });
        });
    }
}

#pragma mark - 归零，指针、计数等清零
- (void)settingStateReturnToZero
{
    [self initWithObjects];
    //    self.turnTablePointerImageView.transform = CGAffineTransformMakeRotation(0);
}

#pragma mark -单例
+ (LKTurnTableView *)sharedTurnTableView
{
    if (!turnTableView) {
        turnTableView = [[[UINib nibWithNibName:@"LKTurnTableView" bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
        turnTableView.frame = CGRectMake(0, 20, 320, 300);
    }
    return turnTableView;
}

#pragma mark - 转动足够秒后执行的方法 20140723
- (void)turnTimeOfYes
{
    _whetherTurnTimeToFour = YES; // 可以减速的条件之一
}

- (IBAction)turnButtonAction:(id)sender {
    [self startRequest];
}
@end
