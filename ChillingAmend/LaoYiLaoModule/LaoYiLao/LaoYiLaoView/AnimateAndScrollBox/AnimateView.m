//
//  AnimateView.m
//  animation
//
//  Created by wzh on 15/10/29.
//  Copyright (c) 2015年 王兆华. All rights reserved.
//

#import "AnimateView.h"
#import "MCSteamView.h"
#define DownAnimationDuration 3  //向下移动的动画时间
#define RotationAnimationDuration 0.2  //旋转的动画时间
#define UpAnimationDuration 0.5  //向上移动的动画时间
#define LeftSwinging 45//左摆动弧度
#define RightSwinging -5 //右摆动弧度
#define LeftOrRightSwinging 10 // 左右摆动弧度
#define LeftRotatingAngle - M_PI_4 *2 /6 //左旋转的角度
#define SpoonDownOrUpHeight 110 * KPercenY //勺下移或上移的高度

//标题frame、
#define TitleImageViewX 0 //无所谓居中
#define TitleImageViewY 30 * KPercenY
#define TitleImageViewW 242 * KPercenX
#define TitleImageViewH 58 * KPercenY

//饺子和勺view的起始坐标
#define DumplingsAndSpoonBtnX 125 * KPercenX
#define DumplingsAndSpoonBtnY  CGRectGetMaxY(titleImageView.frame) + 10 * KPercenY
#define DumplingsAndSpoonBtnW 160 * KPercenX
#define DumplingsAndSpoonBtnH 110 * KPercenY

//雾的坐标
#define SteamiImageViewX 0
#define SteamiImageViewY DumplingsAndSpoonBtnH + DumplingsAndSpoonBtnY - 30 * KPercenY
#define SteamiImageViewW 128 * KPercenY
#define SteamiImageViewH 128 * KPercenY


//锅后边的坐标
#define PanBackImageViewX 0
#define PanBackImageViewY DumplingsAndSpoonBtnH + DumplingsAndSpoonBtnY + 60 * KPercenY
#define PanBackImageViewW kkViewWidth
#define PanBackImageViewH 18 * KPercenY

//锅的图片起始坐标
#define PanImageViewX 0
#define PanImageViewY CGRectGetMaxY(_panBackImageView.frame)
#define PanImageViewW kkViewWidth
#define PanImageViewH 122 * KPercenY

//锅的btn起始坐标
#define PanBtnX 75 *KPercenX
#define PanBtnY DumplingsAndSpoonBtnH + DumplingsAndSpoonBtnY + 90 * KPercenY
#define PanBtnW kkViewWidth - 2 * PanBtnX
#define PanBtnH 80 * KPercenY


#define DumplingsHeight //

//继续加油lab的frame
#define ContinueRefuelingLabX 0//无所谓居中
#define ContinueRefuelingLabY CGRectGetMaxY(_panImageView.frame) + 15 * KPercenY
#define ContinueRefuelingLabW 80 * KPercenX
#define ContinueRefuelingLabH 15

//描述lab的frame
#define DescribeLabX 0//无所谓居中
#define DescribeLabY CGRectGetMaxY(continueRefuelingLab.frame) + 5 * KPercenY
#define DescribeLabW 300
#define DescribeLabH 15

#define Time 1
#define Arc4randomNumMax 100
#define Arc4randomNumMin 50
#define Arc4randomAdd 0

@implementation AnimateView
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor colorWithPatternImage:[LYLTools scaleImage:[UIImage imageNamed:@"lao_bg"] ToSize:CGSizeMake(kkViewWidth, frame.size.height)]];
        
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setFrame:frame];
        _startBtn.backgroundColor = [UIColor clearColor];
        [self addSubview:_startBtn];
//        self.backgroundColor = [UIColor whiteColor];
        [self addAnimateView];
        _number = 100000000;
        _numTimer = [NSTimer scheduledTimerWithTimeInterval:Time target:self selector:@selector(timerNumber) userInfo:nil repeats:YES];        
        [_numTimer setFireDate:[NSDate distantFuture]];//关闭定时器

    }
    return self;
}


- (void)addAnimateView{
    
    UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(TitleImageViewX, TitleImageViewY, TitleImageViewW, TitleImageViewH)];
    titleImageView.image = [UIImage imageNamed:@"banner"];
    titleImageView.center = CGPointMake(self.frame.size.width / 2, titleImageView.center.y);
    [self addSubview:titleImageView];
    
    
    _panBackImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lao_water_top"]];
    [_panBackImageView setFrame:CGRectMake(PanBackImageViewX, PanBackImageViewY, PanBackImageViewW, PanBackImageViewH)];
    _panBackImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_panBackImageView];
    
 

//    _steamiImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SteamiImageViewX, SteamiImageViewY, SteamiImageViewW, SteamiImageViewH)];
//    _steamiImageView.center = CGPointMake(self.frame.size.width / 2, _steamiImageView.center.y);
////    _steamiImageView.backgroundColor = [UIColor blueColor];
//    _steamiImageView.image = [UIImage imageNamed:@"lao_steami"];
//    _steamiImageView.userInteractionEnabled = YES;
//    [self addSubview:_steamiImageView];
    
    _dumplingsAndSpoonView = [[DumplingsAndSpoonView alloc]initWithFrame:CGRectMake(DumplingsAndSpoonBtnX, DumplingsAndSpoonBtnY, DumplingsAndSpoonBtnW, DumplingsAndSpoonBtnH)];
    _dumplingsAndSpoonView.delegate = self;
    _dumplingsAndSpoonView.dumplingsBtn.hidden = YES;
//    _dumplingsAndSpoonView.backgroundColor = [UIColor blueColor];
    [self addSubview:_dumplingsAndSpoonView];

    
    MCSteamView * steamView = [[MCSteamView alloc] initWithFrame:CGRectMake(SteamiImageViewX, SteamiImageViewY, SteamiImageViewW, SteamiImageViewH)];
    steamView.userInteractionEnabled = NO;
    steamView.center = CGPointMake(self.frame.size.width / 2, steamView.center.y);
//    steamView.backgroundColor = [UIColor blackColor];
    [self addSubview:steamView];
    
    _panImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lao_water_bottom"]];
//    if(IS_IPHONE6_PLUS){
//        [_panImageView setFrame:CGRectMake(PanImageViewX, PanImageViewY * 12 * KPercenY, PanImageViewW, PanImageViewH)];
//    }else{
        [_panImageView setFrame:CGRectMake(PanImageViewX, PanImageViewY, PanImageViewW, PanImageViewH)];
//    }
    _panImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_panImageView];
    
    _panBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_panBtn addTarget:self action:@selector(panBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_panBtn setImage:[UIImage imageNamed:@"lao_logo"] forState:UIControlStateNormal];
    [_panBtn setImage:[UIImage imageNamed:@"lao_logo"] forState:UIControlStateHighlighted];
//    _panBtn.backgroundColor = [UIColor colorWithRed:0.53f green:0.53f blue:0.53f alpha:0.5f];
    [_panBtn setFrame:CGRectMake(PanBtnX, PanBtnY, PanBtnW, PanBtnH)];
    [self addSubview:_panBtn];
    
    
    UILabel *continueRefuelingLab = [[UILabel alloc]initWithFrame:CGRectMake(ContinueRefuelingLabX, ContinueRefuelingLabY, ContinueRefuelingLabW, ContinueRefuelingLabH)];
    continueRefuelingLab.textAlignment = NSTextAlignmentCenter;
    continueRefuelingLab.font = UIFont32;
    continueRefuelingLab.center = CGPointMake(self.frame.size.width / 2, continueRefuelingLab.center.y);
    continueRefuelingLab.text = @"继续加油";
    continueRefuelingLab.textColor =  [UIColor whiteColor];
    [self addSubview:continueRefuelingLab];
    
    _describeLab = [[UILabel alloc]initWithFrame:CGRectMake(DescribeLabX, DescribeLabY, DescribeLabW, DescribeLabH)];
    _describeLab.textAlignment = NSTextAlignmentCenter;
    _describeLab.font = UIFont32;
    _describeLab.textColor = [UIColor whiteColor];
    _describeLab.text = [NSString stringWithFormat:@"还剩%@个饺子",@"100,000,000"];
    _describeLab.center = CGPointMake(self.frame.size.width / 2, _describeLab.center.y);
    [self addSubview:_describeLab];

}

-(void)setNumber:(int)number{
    _number = number;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *numberStr = [formatter stringFromNumber:[NSNumber numberWithInt:number]];
    NSString *headerStr = @"还剩";
    NSString *fooderStr = @"个饺子";
    NSString *describeStr = [NSString stringWithFormat:@"%@%@%@",headerStr,numberStr,fooderStr];
    NSMutableAttributedString *mutAttributeStr = [[NSMutableAttributedString alloc]initWithString:describeStr];
    [mutAttributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(headerStr.length,numberStr.length)];
    _describeLab.attributedText = mutAttributeStr;    
}
- (void)timerNumber{
//    ZHLog(@"饺子数在减少随机数%d",(arc4random() % Arc4randomNumMax + Arc4randomNumMin));
    self.number  =  _number - (arc4random() % Arc4randomNumMax + Arc4randomNumMin) + Arc4randomAdd;
}
/**
 *  开启定时器
 */
- (void)startTimer{
    [_numTimer setFireDate:[NSDate distantPast]];//关闭定时器
}

/**
 *  关闭定时器
 */
- (void)stopTimer{
    [_numTimer setFireDate:[NSDate distantFuture]];//关闭定时器
}
//- (void)startBtnClicked:(UIButton *)button{
//    
//    
// }

#pragma mark -- DumplingsAndSpoonView delegate
#pragma mark -- 勺的点击事件
- (void)spoonBtnClicked:(UIButton *)spoonBtnClicked{
    ZHLog(@"点击了勺");
    if([self.delegate respondsToSelector:@selector(laoYiLaoAnimateBegin)]){
        [self.delegate performSelector:@selector(laoYiLaoAnimateBegin)];
    }//外面响应代理
}
#pragma mark -- 饺子的点击事件
- (void)dumpilngsBtnClicked:(UIButton *)dumpilngsBtnClicked{
    ZHLog(@"点击了饺子");
}

#pragma mark -- 动画开始的点击事件
- (void)animationDidStart:(CAAnimation *)anim{
    //    _dumplingsAndSpoonView.userInteractionEnabled = NO;
}

#pragma mark -- 动画停止的点击事件
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if(anim.duration == DownAnimationDuration){//向下移动的那段动画
        
        [UIView animateWithDuration:RotationAnimationDuration animations:^{
            
            _dumplingsAndSpoonView.transform =   CGAffineTransformMakeRotation(0);//旋转原位
            _dumplingsAndSpoonView.dumplingsBtn.hidden = NO;//捞出饺子

        }completion:^(BOOL finished) {

            UIBezierPath *upPath = [UIBezierPath bezierPath];
            [upPath moveToPoint:CGPointMake(_dumplingsAndSpoonView.center.x, _dumplingsAndSpoonView.center.y + SpoonDownOrUpHeight)];
            [upPath addLineToPoint:CGPointMake(_dumplingsAndSpoonView.center.x, _dumplingsAndSpoonView.center.y )];
            //
            CAKeyframeAnimation *upKeyframe = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            upKeyframe.path = upPath.CGPath;
            upKeyframe.duration = UpAnimationDuration;
            upKeyframe.delegate = self;
            upKeyframe.fillMode = kCAFillModeForwards;//从头至尾
            upKeyframe.removedOnCompletion = NO;//移走完成的
            [_dumplingsAndSpoonView.layer addAnimation:upKeyframe forKey:@"animationKey"];
            
        }];
    }else if(anim.duration == UpAnimationDuration){//向上移动的那段动画
        _dumplingsAndSpoonView.userInteractionEnabled = YES;
        if([self.delegate respondsToSelector:@selector(laoYiLaoAnimateFinished)]){
            _dumplingsAndSpoonView.dumplingsBtn.hidden = YES;
            [self.delegate performSelector:@selector(laoYiLaoAnimateFinished)];
        }//外面响应代理
        
    }
}
#pragma mark -- 锅的点击事件
- (void)panBtnClicked:(UIButton *)button{
    ZHLog(@"点击了锅");
}


//#pragma mark -- 外部控制的开始

- (void)start{
    _dumplingsAndSpoonView.dumplingsBtn.hidden = YES;//隐藏饺子
    _dumplingsAndSpoonView.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:RotationAnimationDuration animations:^{
        _dumplingsAndSpoonView.transform =   CGAffineTransformMakeRotation(LeftRotatingAngle);
        
    } completion:^(BOOL finished) {
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(_dumplingsAndSpoonView.center.x, _dumplingsAndSpoonView.center.y)];
        [path addLineToPoint:CGPointMake(_dumplingsAndSpoonView.center.x, _dumplingsAndSpoonView.center.y + SpoonDownOrUpHeight)];
        [path addLineToPoint:CGPointMake(_dumplingsAndSpoonView.center.x - LeftSwinging, _dumplingsAndSpoonView.center.y + SpoonDownOrUpHeight)];
        [path addLineToPoint:CGPointMake(_dumplingsAndSpoonView.center.x + RightSwinging, _dumplingsAndSpoonView.center.y + SpoonDownOrUpHeight)];
        [path addLineToPoint:CGPointMake(_dumplingsAndSpoonView.center.x - LeftSwinging, _dumplingsAndSpoonView.center.y + SpoonDownOrUpHeight)];
        [path addLineToPoint:CGPointMake(_dumplingsAndSpoonView.center.x + RightSwinging, _dumplingsAndSpoonView.center.y + SpoonDownOrUpHeight)];
        [path addLineToPoint:CGPointMake(_dumplingsAndSpoonView.center.x - LeftSwinging, _dumplingsAndSpoonView.center.y + SpoonDownOrUpHeight)];
        [path addLineToPoint:CGPointMake(_dumplingsAndSpoonView.center.x + RightSwinging, _dumplingsAndSpoonView.center.y + SpoonDownOrUpHeight)];
        [path addLineToPoint:CGPointMake(_dumplingsAndSpoonView.center.x, _dumplingsAndSpoonView.center.y + SpoonDownOrUpHeight)];
        CAKeyframeAnimation *keyframe = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        keyframe.path = path.CGPath;
        keyframe.duration = DownAnimationDuration;
        keyframe.delegate = self;
        keyframe.fillMode = kCAFillModeForwards;//从头至尾
        keyframe.removedOnCompletion = NO;//移走完成的
        //        keyframe.repeatCount = 0;//重复次数
        [_dumplingsAndSpoonView.layer addAnimation:keyframe forKey:@"animationKey"];
        
    }];
}


//#pragma mark -- 外部控制的停止
//- (BOOL)stop{
//    return NO;
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
