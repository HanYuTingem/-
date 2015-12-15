//
//  BouncedView.m
//  LaoYiLao
//
//  Created by wzh on 15/10/31.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "BouncedView.h"


//back 的view
#define BackViewX 
#define BackViewY
#define BackViewW
#define BackViewH

@interface BouncedView ()

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation BouncedView

- (instancetype)init{
    if(self = [super init]){
        self.frame = CGRectMake(0, 0, kkViewWidth, kkViewHeight);
        self.backgroundColor = BackColor;
//        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
//        [self addGestureRecognizer:_tap];
    }
    return self;
}

- (void)addDumplingInforView{
    
    [self removeSelfWithSubviews];
    [self addAnaimationWithDuration:0.5];
//    [self addBeatingAnimationWithDuration:0.8];
    [self addSubview:[BounceDumplingInforView shareBounceDumplingInforView]];
    
}

//- (void)addSharedWithLogingView{
//
//    [self removeSelfWithSubviews];
//    _bounceWithLogingView = [[BounceShareLogingView alloc]init];
//    [_bounceWithLogingView sharedWithLoging];
//    [self addSubview:_bounceWithLogingView];
//
//}

- (void)addSharedWithCeilingView{
    
    [self removeSelfWithSubviews];
    _bounceSharedCeilingView = [[BounceSharedCeilingView alloc]init];
    _bounceSharedCeilingView.viewController = _viewController;
    [_bounceSharedCeilingView sharedWithCeiling];
    [self addSubview:_bounceSharedCeilingView];
}

/**
 *  移除本类的子视图
 */
- (void)removeSelfWithSubviews{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}
- (void)tap:(UITapGestureRecognizer *)tap{
//    [self removeFromSuperview];
}


- (void)setDumplingInforModel:(DumplingInforModel *)dumplingInforModel{
    _dumplingInforModel = dumplingInforModel;
    BounceDumplingInforView *inforView = [BounceDumplingInforView shareBounceDumplingInforView];
    [inforView refreshDataWithModel:_dumplingInforModel];
    inforView.viewController = _viewController;
    int number = [_dumplingInforModel.resultListModel.userHasNum intValue];//剩余次数
    
    if(LYLIsLoging){

        CGFloat totalMoney = [LYLTools todayTotalMoneyWithPath:DumplingInforLogingPath];
        
        if(number == 0){//没有次数
            if(totalMoney > 0){//有钱或劵
                
                [inforView.goToGetMoneyOrShareBtn setTitle:@"马上分享" forState:UIControlStateNormal];
                inforView.goToGetMoneyOrShareBtn.tag = ButtonTagWithGoToShareType;
                [inforView.continueToMakeBtn setTitle:@"查看我的钱包" forState:UIControlStateNormal];
                inforView.continueToMakeBtn.tag = ButtonTagWithCheckTheBalanceType;
            }else{//没钱没卷
                
                inforView.goToGetMoneyOrShareBtn.hidden = YES;
                [inforView.continueToMakeBtn setTitle:@"明天再捞" forState:UIControlStateNormal];
                inforView.continueToMakeBtn.tag = ButtonTagWithTomorrowAgainScoopType;
                [inforView.continueToMakeBtn setBackgroundImage:[UIImage imageNamed:@"7_button"] forState:UIControlStateNormal];
                inforView.continueToMakeBtn.center = CGPointMake(inforView.frame.size.width / 2, inforView.continueToMakeBtn.center.y);
                
            }
        }else if (number > 0){//有次数
            if(totalMoney > 0){//有钱或劵
                
                [inforView.goToGetMoneyOrShareBtn setTitle:@"马上分享" forState:UIControlStateNormal];
                inforView.goToGetMoneyOrShareBtn.tag = ButtonTagWithGoToShareType;
                [inforView.continueToMakeBtn setTitle:@"继续捞" forState:UIControlStateNormal];
                inforView.continueToMakeBtn.tag = ButtonTagWithContinueToMakeType;
                
            }else{//没钱没卷
                inforView.goToGetMoneyOrShareBtn.hidden = YES;
                [inforView.continueToMakeBtn setTitle:@"继续捞" forState:UIControlStateNormal];
                inforView.continueToMakeBtn.tag = ButtonTagWithContinueToMakeType;
                [inforView.continueToMakeBtn setBackgroundImage:[UIImage imageNamed:@"7_button"] forState:UIControlStateNormal];
                inforView.continueToMakeBtn.center = CGPointMake(inforView.frame.size.width / 2, inforView.continueToMakeBtn.center.y);
                
            }
        }

    }else{
        CGFloat totalMoney = [LYLTools todayTotalMoneyWithPath:DumplingInforNoLogingPath];
        
        if(number == 0){//没有次数
            if(totalMoney > 0){//有钱或劵
                inforView.continueToMakeBtn.hidden = YES;
                inforView.goToGetMoneyOrShareBtn.tag = ButtonTagWithGotoGetMoneyType;
                [inforView.goToGetMoneyOrShareBtn setTitle:@"去领取" forState:UIControlStateNormal];
                [inforView.goToGetMoneyOrShareBtn setBackgroundImage:[UIImage imageNamed:@"7_button"] forState:UIControlStateNormal];
                inforView.goToGetMoneyOrShareBtn.center = CGPointMake(inforView.frame.size.width / 2, inforView.continueToMakeBtn.center.y);
                
            }else{//没钱没卷
                inforView.continueToMakeBtn.hidden = YES;
                [inforView.goToGetMoneyOrShareBtn setTitle:@"登陆继续捞" forState:UIControlStateNormal];
                inforView.goToGetMoneyOrShareBtn.tag = ButtonTagWithGoToLoginType;
                [inforView.goToGetMoneyOrShareBtn setBackgroundImage:[UIImage imageNamed:@"7_button"] forState:UIControlStateNormal];
                inforView.goToGetMoneyOrShareBtn.center = CGPointMake(inforView.frame.size.width / 2, inforView.continueToMakeBtn.center.y);
            }
        }else if (number > 0){//有次数
            if(totalMoney > 0){//有钱或劵
                
                [inforView.goToGetMoneyOrShareBtn setTitle:@"去领取" forState:UIControlStateNormal];
                inforView.goToGetMoneyOrShareBtn.tag = ButtonTagWithGotoGetMoneyType;
                [inforView.continueToMakeBtn setTitle:@"继续捞" forState:UIControlStateNormal];
                inforView.continueToMakeBtn.tag = ButtonTagWithContinueToMakeType;
                
                
            }else{//没钱没卷
                inforView.continueToMakeBtn.hidden = YES;
                [inforView.goToGetMoneyOrShareBtn setTitle:@"继续捞" forState:UIControlStateNormal];
                inforView.goToGetMoneyOrShareBtn.tag = ButtonTagWithContinueToMakeType;
                [inforView.goToGetMoneyOrShareBtn setBackgroundImage:[UIImage imageNamed:@"7_button"] forState:UIControlStateNormal];
                inforView.goToGetMoneyOrShareBtn.center = CGPointMake(inforView.frame.size.width / 2, inforView.goToGetMoneyOrShareBtn.center.y);
            }
        }

    }
}

#pragma mark --调动动画
- (void)addBeatingAnimationWithDuration:(int)duration
{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [[BounceDumplingInforView shareBounceDumplingInforView].layer addAnimation:animation forKey:nil];
//    UIView *view = [BounceDumplingInforView shareBounceDumplingInforView];
//    //创建一个CABasicAnimation对象
//    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    view.layer.anchorPoint = CGPointMake(.5,.5);
//    // animation.fromValue = @2.0f;
//    animation.toValue = @0.5f;
//    
//    //动画时间
//    animation.duration=1;
//    animation.beginTime=CACurrentMediaTime()+1;
//    //是否反转变为原来的属性值
//    // animation.autoreverses=YES;
//    //把animation添加到图层的layer中，便可以播放动画了。forKey指定要应用此动画的属性
//    [view.layer addAnimation:animation forKey:@"scale"];
//    
//    
//    
//    CABasicAnimation *theAnimation;
//    // create the animation object, specifying the position property as the key path
//    // the key path is relative to the target animation object (in this case a CALayer)
//    theAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
//    
//    // set the fromValue and toValue to the appropriate points
//    theAnimation.fromValue=[NSValue valueWithCGPoint:CGPointMake(74.0,74.0)];
//    theAnimation.toValue=[NSValue valueWithCGPoint:CGPointMake(300.0,406.0)];
//    
//    // set the duration to 3.0 seconds
//    theAnimation.duration=3.0;
//    
//    // set a custom timing function
//    theAnimation.timingFunction=[CAMediaTimingFunction functionWithControlPoints:0.25f :0.1f :0.25f :1.0f];
//    [view.layer addAnimation:theAnimation forKey:@"move"];
    
}

#pragma mark-- 弹框动画
- (void)addAnaimationWithDuration:(int)duration{
    UIView *view = [BounceDumplingInforView shareBounceDumplingInforView];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    view.layer.anchorPoint = CGPointMake(.5,.5);
    animation.fromValue = @0.0f;
    animation.toValue = @1.0f;
    
    //动画时间
    animation.duration=duration;
    //是否反转变为原来的属性值
    // animation.autoreverses=YES;
    //把animation添加到图层的layer中，便可以播放动画了。forKey指定要应用此动画的属性
    [view.layer addAnimation:animation forKey:@"scale"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
