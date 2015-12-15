//
//  YaoYiYaoViewController.m
//  LeWan
//
//  Created by 程国帅 on 14-11-29.
//  Copyright (c) 2014年 李祖浩. All rights reserved.
//

#import "YaoYiYaoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "BXAPI.h"
#import "NSString+SBJSON.h"
#import "SBJSON.h"
#import <AudioToolbox/AudioToolbox.h>
#import "LoginViewController.h"
#import "PRJ_YaoYiYaoDetailsModel.h"


//#define KKUserYL musicBool//音乐
//#define KKUserYX soundBool//音效
//#define KKUserZD shockBool//震动

@interface YaoYiYaoViewController ()
{
//    AVAudioPlayer *_audioPlayer;
//    NSString *path;
//    SystemSoundID soundID;
    BOOL isRequest;//判断网络
    BOOL isWave;//

    PRJ_YaoYiYaoDetailsModel *model;    //100接口数据
    
    BOOL isAward; // 判断是否有奖励
}

@property (weak, nonatomic) IBOutlet UIImageView *BackGroundImageView;  //背景图片

@property (weak, nonatomic) IBOutlet UILabel *consumeLabel;
@property (weak, nonatomic) IBOutlet UITextView *rulesTextView;//游戏规则
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIView *helpView;//帮助
@property (weak, nonatomic) IBOutlet UIView *AleltZView;//中奖
@property (weak, nonatomic) IBOutlet UIView *AleltMZView;//没中奖
@property (weak, nonatomic) IBOutlet UIImageView *prizeImageView;//中奖奖品图片
@property (weak, nonatomic) IBOutlet UILabel *prizeNameLabel;//中奖奖品名称
@property (weak, nonatomic) IBOutlet UIImageView *shakeAnimationImageView;//手机
@property (weak, nonatomic) IBOutlet UIView *ExchangeView;//是否兑换

@property (weak, nonatomic) IBOutlet UIView *moreView; //右边按钮弹出框

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;

@end

@implementation YaoYiYaoViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isAward = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (UIButton *btn in self.allButtons) {
        [btn setExclusiveTouch:YES];
    }
    self.bar.hidden = YES;
    [self drawYaoYiYaoViewController];
    
    NSString *resolution = @"";
    if (iPhone5) {
        resolution = @"568*320";
    } else {
        resolution = @"480*320";
    }
    
    if (![GCUtil connectedToNetwork]) {
        [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
    } else {
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI yaoYiYaoBackGroundImageWithResolution:resolution]];
        mainRequest.tag = 1000;
        isRequest = YES;
    
    [self requestData];
    }
    
//    path=[[NSBundle mainBundle]pathForResource:@"积分游戏进入音效" ofType:@"mp3"];
//    _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
//    [_audioPlayer play];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [_audioPlayer stop];
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)requestData
{
    isRequest = YES;
    [self request_100];
    
}
- (void)CGRectshakeAnimationImageView
{
    CGRect frameA = _shakeAnimationImageView.frame;
    CABasicAnimation *shakeanimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shakeanimation.fromValue = [NSNumber numberWithFloat:M_PI/11];
    shakeanimation.toValue = [NSNumber numberWithFloat:-M_PI/11];
    shakeanimation.duration = 0.5;
    shakeanimation.autoreverses = YES;//是否重复
    shakeanimation.repeatCount = 5;
    //设置旋转点
    _shakeAnimationImageView.layer.anchorPoint = CGPointMake(0.5,2.0f);
    //重新设置frame
    _shakeAnimationImageView.frame=frameA;
    [_shakeAnimationImageView.layer addAnimation:shakeanimation forKey:@"shakeAnimation"];
}
- (void)drawYaoYiYaoViewController
{
    self.helpView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    self.AleltZView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    self.AleltMZView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    self.ExchangeView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
}

- (IBAction)UbuttonSender:(UIButton *)sender
{
    [self cancleIndicateShareView];
    self.moreView.hidden = YES;
    switch (sender.tag) {
        case 1://返回上一层
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        case 2://帮助
        {
            self.moreView.hidden = NO;
            isWave = NO;

        }
            break;
        case 3://分享
        {
            [self shareContentRequest];
        }
            break;
            
        case 4://帮助返回
        {
            self.helpView.hidden = YES;
            isWave = YES;

        }
            break;
        case 5://帮助
        {
            self.rulesTextView.text = @"关注辽宁广播电视台精彩节目\n积极参与有奖互动！\n赶快来赢取您的超级大奖吧！";
             self.helpView.hidden = NO;
        }
            break;
    }
}


- (void)request_100 //请求首页
{
    mainRequest.tag = 100;
    [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI yaoYiYaoDetailsWithUserID:kkUserId]];
    [self showMsg:nil];
}

- (void)request_101//摇奖
{
    if (![GCUtil connectedToNetwork]) {
        [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
    } else {
        mainRequest.tag = 101;
        if (model.reCordID) {
            [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI yaoYiYaoOpenAwardsWithUserID:kkUserId andActivityId:model.reCordID]];
        }else {
            [GCUtil showGameErrorMessageWithContent:@"暂时还没有活动"];
        }
        [self CGRectshakeAnimationImageView];
    }
}

#pragma mark 请求分享内容
- (void) shareContentRequest
{
    if (![GCUtil connectedToNetwork]) {
        [self shareDefalutMessage];
    } else {
        [mainRequest requestHttpWithPost:CHONG_url withDict:[BXAPI shareContentType:@"3"]];
        mainRequest.tag = 103;
        [self showMsg:nil];
    }
}

#pragma mark 分享内容请求返回的数据处理
- (void) setShareContentData:(NSDictionary*)dict
{
    if ([[dict objectForKey:@"code"] intValue] == 1) { // 有分享内容
        self.shareContent = [NSString stringWithFormat:@"%@%@", dict[@"share_content"], dict[@"share_url"]];
        [self callOutShareViewWithUseController:self andSharedUrl:dict[@"share_url"]];
    } else {
        [self shareDefalutMessage];
    }
}

// 分享默认内容
- (void) shareDefalutMessage
{
    [self callOutShareViewWithUseController:self andSharedUrl:@"http://ht.sinosns.cn/"];
    self.shareContent = [NSString stringWithFormat:@"小伙伴们,我在使用黑土app中摇一摇呢~ 快来黑土跟我一起摇出大奖吧 (来自于黑土App) http://ht.sinosns.cn/"];
}


#pragma mark motionBegan motionEnded
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (isWave) {
//        AudioServicesPlaySystemSound (soundID);
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        [self request_101];
    }
}

//得到时间转换后的数值
-( double )getTimeStampWithTimeString:(NSString *)timeStr
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLocale *local =[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateformatter setLocale: local];
    NSDate *date = [dateformatter dateFromString:timeStr];
    double time = [date timeIntervalSince1970];
    time = time + 8 * 60 * 60;
    NSLog(@"-----------%f",time);
    
    return time;
}



- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake )
    {
        
    }
    
}
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}

#pragma mark  网络请求
-(void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    [self hide];
    isRequest= NO;
    NSLog(@"=====%@",aString);
    NSMutableDictionary *dict = [aString JSONValue];
    if (aString.length == 0) {
        if (aRequest.tag == 103) {
            [self shareDefalutMessage];
        } else {
            [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
        }
        return;
    }
    
    if (dict) {
        if (aRequest.tag == 1000) {
            if ([dict[@"code"] integerValue] == 0) {
                [self.BackGroundImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",img_url,dict[@"img"]]] placeholderImage:[UIImage imageNamed:@"lexiaoyao_content_bg_Begin_selected.png"]];
            }
        }
        
        if (aRequest.tag == 100 ) {
            isWave = YES;
            if ([[dict objectForKey:@"code"] intValue] == 0) {
                model = [PRJ_YaoYiYaoDetailsModel getYaoYiYaoDetailModelWithDic:dict];
            } else {
                isWave = NO;
                GameAlertView *alert =  [GCUtil showGameErrorMessageWithContent:dict[@"message"]];
                alert.gameErrorDismissBlock = ^(){
                    isWave = YES;
                };
            }
        }
        
        if (aRequest.tag == 101) {
            isWave = YES;
            if ([[dict objectForKey:@"code"] intValue] == 0) {
                isWave = NO;
                isAward = YES;
                
                GameAlertView *alert =  [GCUtil showGameAlertTitle:@"太给力了！亲~" andContent:[NSString stringWithFormat:@"获得%@%@",dict[@"money"],dict[@"prize_name"]] cancel:nil andOK:@"确定"];
                //            path=[[NSBundle mainBundle]pathForResource:@"获取积分声音" ofType:@"wav"];
                alert.rightBlock = ^(){
                    isWave = YES;
                };
            } else if ([[dict objectForKey:@"code"] intValue] == 10) {
                isWave = NO;
                GameAlertView *alert = [GCUtil showGameAlertTitle:@"太给力了！亲~" andContent:[NSString stringWithFormat:@"获得%@",dict[@"prize_name"]] cancel:nil andOK:@"确定"];
                //            path=[[NSBundle mainBundle]pathForResource:@"获得物品" ofType:@"wav"];
                alert.rightBlock = ^(){
                    isWave = YES;
                };
            } else if ([[dict objectForKey:@"code"] intValue] == 2) {
                
                isAward = NO;
                isWave = NO;
                GameAlertView *alert =  [GCUtil showGameErrorMessageWithContent:[NSString stringWithFormat:@"您的摇奖次数已用尽，下次活动时间 %@",model.next]];
                //            path=[[NSBundle mainBundle]pathForResource:@"提示音" ofType:@"wav"];
                alert.gameErrorDismissBlock = ^(){
                    isWave = YES;
                };
            } else {
                isAward = NO;
                isWave = NO;
                GameAlertView *alert =  [GCUtil showGameErrorMessageWithContent:dict[@"message"]];
                alert.gameErrorDismissBlock = ^(){
                    isWave = YES;
                };
            }
            //        if (path.length > 0) {
            //            _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
            //            [_audioPlayer play];
            //        }
        }
        
        if (aRequest.tag == 103) { // 分享内容
            [self setShareContentData:dict];
        }
    } else {
        if (aRequest.tag == 103) {
            [self shareDefalutMessage];
        } else {
           [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
        }
        return;
    }
}


-(void)GCRequest:(GCRequest *)aRequest Error:(NSString *)aError
{
    if (aRequest.tag == 103) {
        [self shareDefalutMessage];
    } else {
        [GCUtil showGameErrorMessageWithContent:@"网络连接失败"];
    }
}

//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    
//    self.AleltMZView.hidden = YES;
//    isWave = YES;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _moreView.hidden = YES;
    [self cancleIndicateShareView];
}
- (IBAction)hideAllSubViews:(UITapGestureRecognizer *)sender {
    _moreView.hidden = YES;
    [self cancleIndicateShareView];
    self.helpView.hidden = YES;
}
@end
