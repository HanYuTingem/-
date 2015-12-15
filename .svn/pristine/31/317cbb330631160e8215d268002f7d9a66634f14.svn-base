//
//  LSYXianShiMiaoShaView.m
//  PRJ_Mall_Demo
//
//  Created by liangsiyuan on 15/1/10.
//  Copyright (c) 2015年 Liangsiyuan. All rights reserved.
//

#import "LSYXianShiMiaoShaView.h"
#import "NSDate+LSY.h"
#import "MarketAPI.h"
#define PADDING 10
#define TITLEHEIGHT 45
@interface LSYXianShiMiaoShaView()
@property(nonatomic,strong)NSTimer * timer;

@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;


@end

@implementation LSYXianShiMiaoShaView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"LSYXianShiMiaoShaView" owner:self options:nil][0];
        [self setFrame:frame];
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapSeckilling)];
        [self addGestureRecognizer:tap];

    }
    return self;
}

-(void)didTapSeckilling
{

    if (self.delegate&&[self.delegate respondsToSelector:@selector(didTapSeckilling:andChild:)]) {
        [self.delegate didTapSeckilling:self.miaoShaID andChild:self.childMiaoShaID];
    }
}


#pragma mark - 倒计时
-(void)startCountDown
{
    if (self.start_time>0&&!self.timer) {
        self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFrieMethod) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

-(void)timeFrieMethod
{

    self.start_time--;
    [self updateLabel];
    //到0销毁定时器
    if (self.start_time==0) {
        [self.timer invalidate];
        self.timer=nil;
        self.XianShiMiaoShaBlock ();
        
    }
}

-(void)updateLabel
{
    int seconds = _start_time % 60;
    int minutes = (_start_time / 60) % 60;
    int hours = _start_time / 3600;
    if (hours<10) {
        self.hoursLabel.text=[NSString stringWithFormat:@"0%d",hours];
    }else{
        self.hoursLabel.text=[NSString stringWithFormat:@"%d",hours];
    }
    if (minutes<10) {
        self.minutesLabel.text=[NSString stringWithFormat:@"0%d",minutes];
    }else{
        self.minutesLabel.text=[NSString stringWithFormat:@"%d",minutes];
    }
    if (seconds<10) {
        self.secondsLabel.text=[NSString stringWithFormat:@"0%d",seconds];
    }else{
        self.secondsLabel.text=[NSString stringWithFormat:@"%d",seconds];
    }
}

-(void)setImg_Url:(NSString *)img_Url
{
    [self.leftImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.host,img_Url]] placeholderImage:[UIImage imageNamed:@"defaultimg_4.png"]];
    
}

-(void)setStart_time:(int)start_time
{
    _start_time=start_time;
    if(_start_time > 3600*24){
        
        _timeView.hidden = NO;
        self.timerLabel.text = [MarketAPI getTimestamp:_skill_time];
    }else{
        _timeView.hidden = YES;
        [self startCountDown];
    }
}

@end
