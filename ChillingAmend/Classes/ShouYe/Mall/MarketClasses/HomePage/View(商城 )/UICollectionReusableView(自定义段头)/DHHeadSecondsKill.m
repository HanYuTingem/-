//
//  DHHeadSecondsKill.m
//  MarketManage
//
//  Created by 许文波 on 15/7/16.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "DHHeadSecondsKill.h"



@interface DHHeadSecondsKill ()
{
    NSString *_skill_time;
    int start_time;
    
    
    int singleTime;
}

@end

@implementation DHHeadSecondsKill
-(instancetype)initWithFrame:(CGRect)fram{
    
    self = [super initWithFrame:fram];
    if (self) {

        UIView *categroyLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.5)];
        categroyLineView.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];;
        [self addSubview:categroyLineView];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, SCREENWIDTH, 9.5)];
        view.backgroundColor = CrazyColor(240, 242, 245);
        [self addSubview:view];
        
        
//        self.headTitle = [[DHHomePageTool alloc] set_Labelframe:CGRectMake(Left, up, HomeTitleWidth*SP_WIDTH, homeTitleHeight*SP_HEIGHT) Label_text:@"" Label_Font:homeTitleFont];
//
        self.headTitle = [[UILabel alloc] initWithFrame:CGRectMake(Left, up, 65, homeTitleHeight)];
        self.headTitle.font = [UIFont systemFontOfSize:homeTitleFont];
        self.headTitle.textColor = [UIColor colorWithRed:0.72f green:0.02f blue:0.02f alpha:1.00f];

        [self addSubview:self.headTitle];
        
        self.ClockImageview = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headTitle.frame),up+2, 14, 16)];
        self.ClockImageview.image = [UIImage imageNamed:@"mall_home_icon_clock_default.png"];
        [self addSubview:self.ClockImageview];
        

        
        
        /** 线条 */
        self.upLineIamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, SCREENWIDTH, 0.5)];
        self.upLineIamgeView.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [self addSubview:self.upLineIamgeView];
        
        
        self.timeView = [[UILabel alloc] initWithFrame:CGRectMake(100, up, 200, 20)];
        self.timeView.font = [UIFont systemFontOfSize:13];
        self.timeView.textColor = [UIColor colorWithRed:0.71f green:0.71f blue:0.71f alpha:1.00f];
        [self addSubview:self.timeView];
        
        
        
        self.HMSView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.ClockImageview.frame)+10, 18, 180, 30)];
        self.HMSView.hidden = YES;
        [self addSubview:self.HMSView];
        
        
        self.hourLabel = [[DHHomePageTool alloc] set_Labelframe:CGRectMake(0, 0, 25*SP_WIDTH, 20*SP_HEIGHT) Label_text:self.hourLabel.text Label_Font:homeTitleFont];
        self.hourLabel.backgroundColor = [UIColor colorWithRed:0.54f green:0.54f blue:0.54f alpha:1.00f];
        self.hourLabel.textColor = [UIColor whiteColor];
        self.hourLabel.layer.cornerRadius = 2;
        self.hourLabel.layer.masksToBounds = YES;
        [self.HMSView addSubview:self.hourLabel];
        
        
        
        UILabel *PointOne = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.hourLabel.frame)+1, 0, 4, 20)];
        PointOne.text = @":";
        PointOne.textColor = [UIColor colorWithRed:0.54f green:0.54f blue:0.54f alpha:1.00f];
        [self.HMSView addSubview:PointOne];
        
        
        self.minuteLabel = [[DHHomePageTool alloc] set_Labelframe:CGRectMake(35, 0, 25*SP_WIDTH, 20*SP_HEIGHT) Label_text:self.minuteLabel.text Label_Font:homeTitleFont];
        self.minuteLabel.backgroundColor = [UIColor colorWithRed:0.54f green:0.54f blue:0.54f alpha:1.00f];
        self.minuteLabel.layer.masksToBounds = YES;
        self.minuteLabel.textColor = [UIColor whiteColor];
        self.minuteLabel.layer.cornerRadius = 2;
        [self.HMSView addSubview:self.minuteLabel];
        
        UILabel *PointTwo = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.minuteLabel.frame)+1, 0, 4, 20)];
        PointTwo.text = @":";
        PointTwo.textColor = [UIColor colorWithRed:0.54f green:0.54f blue:0.54f alpha:1.00f];
        [self.HMSView addSubview:PointTwo];
        
        self.secondsLabel = [[DHHomePageTool alloc] set_Labelframe:CGRectMake(70, 0, 25*SP_WIDTH, 20*SP_HEIGHT) Label_text:self.secondsLabel.text Label_Font:homeTitleFont];
        self.secondsLabel.layer.cornerRadius = 2;
        self.secondsLabel.backgroundColor = [UIColor colorWithRed:0.54f green:0.54f blue:0.54f alpha:1.00f];
        self.secondsLabel.layer.masksToBounds = YES;
        self.secondsLabel.textColor = [UIColor whiteColor];
        [self.HMSView addSubview:self.secondsLabel];
        
        
        self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.moreButton.frame =   CGRectMake(SCREENWIDTH - 44, up-9, 40, 37);
        self.moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.moreButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        [self.moreButton setTitle:@"更多" forState:UIControlStateNormal];
//        self.moreButton.backgroundColor = [UIColor redColor];
        [self.moreButton addTarget:self action:@selector(moreButtonDown) forControlEvents:UIControlEventTouchUpInside];
        self.moreButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        self.moreButton.imageEdgeInsets =UIEdgeInsetsMake(1, 30, 0, 0);
        [self.moreButton setTitleColor:homeTitleTextColor forState:UIControlStateNormal];
        [self addSubview:self.moreButton];
        
        
        
        /** 线条 */
        self.downLineImageView = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 44.5, SCREENWIDTH, 0.5)];
        self.downLineImageView.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        [self addSubview:self.downLineImageView];
        
    }
    return self;
}

-(void)moreButtonDown{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"moreButtonDown" object:nil];
}
-(void)RefreshActivityUI:(ActivityModel*)model{

    
    
    self.headTitle.text = @"限时秒杀";
    ActitvityListModel *activityListModel = model.list[0];
    
    //1443594600    1440640675
    if ([model.type isEqualToString:@"1"]) {
        if ([activityListModel.end_time intValue] > [activityListModel.start_time intValue]) {
            
//            NSString * startTime=   @"1440040675";
//            NSString *server_time = @"1440040675";
//            NSString *endTime =     @"1440040685";
            
            NSString * startTime= activityListModel.start_time;
            NSString * endTime = activityListModel.end_time;

            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *server_time = [user objectForKey:@"server_time"];
            

            NSLog(@"%lu",_single);
            NSLog(@"%@",activityListModel.status);
            _skill_time = activityListModel.end_time;
            
            if ([endTime integerValue]> [server_time integerValue]) {
                switch ([activityListModel.status intValue]) {
                    case 1:
                    {
                        if (_single) {
                            start_time = singleTime;
                            [self setStart_time:start_time];

                        }else
                        {
                            //                            start_time =[startTime intValue]-[server_time intValue];

                            start_time =[startTime intValue]-[server_time intValue];
                            [self setStart_time:start_time];
                        }
                    }
                        break;
                    case 2:
                    {
                        if (_single) {
                            NSLog(@" _single:  %lu",_single);
                            start_time = singleTime;
                            [self setStart_time:start_time];
                        }else{
                            start_time =[endTime intValue]-[server_time intValue];
                            [self setStart_time:start_time];
                           
                        }
                    }
                        break;
                        
                    default:
                        break;
                }
            }
        }
    }
}

-(void)setStart_time:(int)startTime
{
    NSLog(@"%d",startTime);
    
    if(startTime > 3600*24){
        
        _timeView.hidden = NO;
        self.HMSView.hidden = YES;
        self.timeView.text = [MarketAPI getTimestamp:_skill_time];
        NSLog(@"%@=     [MarketAPI getTimestamp:_skill_time]" ,[MarketAPI getTimestamp:_skill_time]);
        
    }else{
         _single = YES;
        self.HMSView.hidden = NO;
        _timeView.hidden = YES;
        [self startCountDown];
    }
}


#pragma mark - 倒计时
-(void)startCountDown
{
    if (start_time>0&&!self.timer) {
        self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFrieMethod) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}
-(void)timeFrieMethod
{
 
    start_time--;
    singleTime = start_time;
    [self updateLabel];
    //到0销毁定时器
    if (start_time==0) {
        [self.timer invalidate];
        self.timer=nil;
//        self.XianShiMiaoShaBlock ();
    }
    
  
}
-(void)updateLabel
{
    int seconds = start_time % 60;
    int minutes = (start_time / 60) % 60;
    int hours = start_time / 3600;
    if (hours<10) {
        self.hourLabel.text=[NSString stringWithFormat:@"0%d",hours];
    }else{
        self.hourLabel.text=[NSString stringWithFormat:@"%d",hours];
    }
    if (minutes<10) {
        self.minuteLabel.text=[NSString stringWithFormat:@"0%d",minutes];
    }else{
        self.minuteLabel.text=[NSString stringWithFormat:@"%d",minutes];
    }
    if (seconds<10) {
        self.secondsLabel.text=[NSString stringWithFormat:@"0%d",seconds];
    }else{
        self.secondsLabel.text=[NSString stringWithFormat:@"%d",seconds];
    }
    
    
    if (seconds == 0 && minutes ==0 && hours == 0) {
        _single = NO;
        
//        _timeView.hidden = NO;
//        self.HMSView.hidden = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"FreshTime" object:nil];

        });
    }
    
    
}

@end
