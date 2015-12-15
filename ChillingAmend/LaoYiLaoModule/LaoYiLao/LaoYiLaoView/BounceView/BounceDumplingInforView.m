//
//  BounceDumplingInforView.m
//  LaoYiLao
//
//  Created by wzh on 15/11/11.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "BounceDumplingInforView.h"
#import "LYLQuickLoginViewController.h"
#import "mineWalletViewController.h"
#import "ShareInfoManage.h"


//当前视图的Frame
#define BounceDumplingInforViewX 21 * KPercenX
#define BounceDumplingInforViewY 98 * KPercenY
#define BounceDumplingInforViewW kkViewWidth - 2 * BounceDumplingInforViewX
#define BounceDumplingInforViewH 275 * KPercenY

//iconBtnFrame
#define IconBtnX 7 * KPercenX
#define IconBtnY 30 * KPercenY
#define IconBtnW 50 * KPercenX
#define IconBtnH IconBtnW

//titleBtnFrame
#define TitleLabX CGRectGetMaxX(bounceDumplingInforView.iconBtn.frame) + 10 * KPercenY
#define TitleLabY 47 * KPercenY
#define TitleLabW 200 * KPercenX
#define TitleLabH 15 * KPercenY

//MoneyLabFrame
#define MoneyLabX 10 //无所谓
#define MoneyLabY 100 * KPercenY
#define MoneyLabW 105
#define MoneyLabH 30

//contentLabFrame
#define ContentLabX 10 //无所谓
#define ConTentLabY CGRectGetMaxY(bounceDumplingInforView.moneyLab.frame) + 30 * KPercenY
#define ContentLabW 200
#define ContentLabH 13

//remainingNumberLabFrme
#define RemainingNumberLabX 10
#define RemainingNumberLabY bounceDumplingInforView.frame.size.height - RemainingNumberLabH - 20
#define RemainingNumberLabW 200
#define RemainingNumberLabH 15

#define ShutDowbBtnX bounceDumplingInforView.frame.size.width - ShutDowbBtnW - ShutDowbBtnY
#define ShutDowbBtnY 5
#define ShutDowbBtnW 45 / 2 * KPercenY
#define ShutDowbBtnH 45 / 2 * KPercenY



//去领钱，去分享 ，继续捞btn宽高
#define BtnW 90 * KPercenX
#define BtnH 30 * KPercenY
#define BtnY BounceDumplingInforViewH -  85 * KPercenY
//去领钱，去分享x
#define GoToGetMoneyOrShareBtnX 30 * KPercenX
//继续捞的x 有次数
#define ContinueToMakeBtnX  BounceDumplingInforViewW - CGRectGetMaxX(bounceDumplingInforView.goToGetMoneyOrShareBtn.frame)

//无次数
#define ContinueToMakeNullNumberBtnW BtnW * 2



static BounceDumplingInforView *bounceDumplingInforView;
@implementation BounceDumplingInforView


+ (BounceDumplingInforView *)shareBounceDumplingInforView{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        bounceDumplingInforView = [[BounceDumplingInforView alloc]init];
        bounceDumplingInforView.layer.masksToBounds = YES;
        bounceDumplingInforView.layer.cornerRadius = 5;
        bounceDumplingInforView.frame = CGRectMake(BounceDumplingInforViewX, BounceDumplingInforViewY, BounceDumplingInforViewW, BounceDumplingInforViewH);
        //头像固定
        bounceDumplingInforView.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bounceDumplingInforView.iconBtn.backgroundColor = [UIColor brownColor];
        bounceDumplingInforView.iconBtn.layer.cornerRadius = IconBtnW / 2;
        bounceDumplingInforView.iconBtn.layer.masksToBounds = YES;
        [bounceDumplingInforView.iconBtn setFrame:CGRectMake(IconBtnX, IconBtnY, IconBtnW, IconBtnH)];
        [bounceDumplingInforView addSubview:bounceDumplingInforView.iconBtn];
        //标题固定
        bounceDumplingInforView.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(TitleLabX, TitleLabY, TitleLabW, TitleLabH)];
        bounceDumplingInforView.titleLab.text = @"恭喜你捞到了一个饺子";
        bounceDumplingInforView.titleLab.textAlignment = NSTextAlignmentLeft;
        //_titleLab.backgroundColor = [UIColor brownColor];
        bounceDumplingInforView.titleLab.font = UIFont26;
        //bounceDumplingInforView.titleLab.center = CGPointMake(bounceDumplingInforView.frame.size.width / 2, bounceDumplingInforView.titleLab.center.y);
        [bounceDumplingInforView addSubview:bounceDumplingInforView.titleLab];
        //金钱lab
        bounceDumplingInforView.moneyLab = [[UILabel alloc]init];
        bounceDumplingInforView.moneyLab.text = @"0.01元";
        bounceDumplingInforView.moneyLab.adjustsFontSizeToFitWidth = YES;
        bounceDumplingInforView.moneyLab.textAlignment = NSTextAlignmentCenter;
        //    _moneyLab.backgroundColor = [UIColor brownColor];
        [bounceDumplingInforView addSubview:bounceDumplingInforView.moneyLab];
        
        
        bounceDumplingInforView.contentLab = [[UILabel alloc]init ];
        bounceDumplingInforView.contentLab.text = [NSString stringWithFormat:@"今日共捞到%@,棒棒哒~",bounceDumplingInforView.contentLab.text];
        bounceDumplingInforView.contentLab.textAlignment = NSTextAlignmentCenter;
        bounceDumplingInforView.contentLab.font = UIFont22;
        //    _contentLab.backgroundColor = [UIColor brownColor];
        [bounceDumplingInforView addSubview:bounceDumplingInforView.contentLab];
        
        
        
        bounceDumplingInforView.goToGetMoneyOrShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bounceDumplingInforView.goToGetMoneyOrShareBtn.titleLabel.font = UIFontBild30;
        [bounceDumplingInforView.goToGetMoneyOrShareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bounceDumplingInforView.goToGetMoneyOrShareBtn addTarget:bounceDumplingInforView action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bounceDumplingInforView addSubview:bounceDumplingInforView.goToGetMoneyOrShareBtn];
        
        
        bounceDumplingInforView.continueToMakeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bounceDumplingInforView.continueToMakeBtn.titleLabel.font = UIFontBild30;
        [bounceDumplingInforView.continueToMakeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bounceDumplingInforView.continueToMakeBtn addTarget:bounceDumplingInforView action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bounceDumplingInforView addSubview:bounceDumplingInforView.continueToMakeBtn];

        
        
        bounceDumplingInforView.remainingNumberLab = [[UILabel alloc]initWithFrame:CGRectMake(RemainingNumberLabX, RemainingNumberLabY, RemainingNumberLabW, RemainingNumberLabH)];
        bounceDumplingInforView.remainingNumberLab.center = CGPointMake(bounceDumplingInforView.frame.size.width / 2, bounceDumplingInforView.remainingNumberLab.center.y);
        bounceDumplingInforView.remainingNumberLab.font = UIFont24;
        bounceDumplingInforView.remainingNumberLab.textColor = [UIColor redColor];
        bounceDumplingInforView.remainingNumberLab.text = [NSString stringWithFormat:@"还有%d次机会",1];
        bounceDumplingInforView.remainingNumberLab.textAlignment = NSTextAlignmentCenter;
        [bounceDumplingInforView addSubview:bounceDumplingInforView.remainingNumberLab];
        
        UIButton *shutDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [shutDownBtn setFrame:CGRectMake(ShutDowbBtnX, ShutDowbBtnY, ShutDowbBtnW, ShutDowbBtnH)];
        [shutDownBtn setBackgroundImage:[UIImage imageNamed:@"9_shut_down"] forState:UIControlStateNormal];
        [shutDownBtn addTarget:bounceDumplingInforView action:@selector(shutDownBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bounceDumplingInforView addSubview:shutDownBtn];
        
        
    });
    return bounceDumplingInforView;
}

#pragma mark -- 去关闭点击
- (void)shutDownBtnClicked:(UIButton *)button{
    
    [LYLTools removeBounceViewWithVC:_viewController];
    NSLog(@"关闭");
    
}

- (void)refreshDataWithModel:(DumplingInforModel *)model{
    

    [self setDefaultState];//设置初始的位置及状态
    bounceDumplingInforView.remainingNumberLab.text = [NSString stringWithFormat:@"还有%@次机会",model.resultListModel.userHasNum];


    if(IsStrWithNUll(model.resultListModel.starIcon)){
        [bounceDumplingInforView.iconBtn  setImage:[UIImage imageNamed:@"9_default_avatar"] forState:UIControlStateNormal];
    }else{
        [bounceDumplingInforView.iconBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.resultListModel.starIcon] forState:UIControlStateNormal];
    }
    bounceDumplingInforView.titleLab.text = [NSString stringWithFormat:@"%@给你包了一个饺子",model.resultListModel.starName];
    
    
    
    if([model.resultListModel.dumplingModel.dumplingType isEqualToString:DumplingTypeMoney]){//如果是钱
        
        bounceDumplingInforView.moneyLab.text = [NSString stringWithFormat:@"%@元",model.resultListModel.dumplingModel.prizeAmount];
        bounceDumplingInforView.moneyLab.frame = CGRectMake(bounceDumplingInforView.moneyLab.frame.origin.x, bounceDumplingInforView.moneyLab.frame.origin.y, [LYLTools boundingRectWithStrW:bounceDumplingInforView.moneyLab.text labStrH:bounceDumplingInforView.moneyLab.frame.size.height andFont:bounceDumplingInforView.moneyLab.font], bounceDumplingInforView.moneyLab.frame.size.height);
        bounceDumplingInforView.moneyLab.center = CGPointMake(bounceDumplingInforView.frame.size.width / 2, bounceDumplingInforView.moneyLab.center.y);

    }else if ([model.resultListModel.dumplingModel.dumplingType isEqualToString:DumplingTypeBlessing]){//祝福
        
        _moneyLab.text = [NSString stringWithFormat:@"%@",model.resultListModel.dumplingModel.prizeInfo] ;
        _moneyLab.font = UIFontBild30;
        //固定的宽
        CGFloat moneyLabFixedW = bounceDumplingInforView.frame.size.width - 2 * 10;
        //根据内容计算的宽
        CGFloat moneylabW = [LYLTools boundingRectWithStrW:_moneyLab.text labStrH:MoneyLabH andFont:UIFontBild30];
        //根据内容计算的高
        CGFloat moneylabH = [LYLTools boundingRectWithStrH:_moneyLab.text labStrW:moneyLabFixedW andFont:UIFontBild30];
        if(moneylabW > moneyLabFixedW){
            _moneyLab.numberOfLines = 0;
            if(moneylabH > MoneyLabH * 2){
                _moneyLab.frame = CGRectMake(MoneyLabX, MoneyLabY, moneyLabFixedW, MoneyLabH * 2);
            }else{
                _moneyLab.frame = CGRectMake(MoneyLabX, MoneyLabY, moneyLabFixedW,moneylabH);
            }
        }else{
            _moneyLab.frame = CGRectMake(MoneyLabX, MoneyLabY, [LYLTools labWithStringW:_moneyLab.text andLabelHeight:MoneyLabH andFontSize:UIFontBild30], MoneyLabH);
        }
        _moneyLab.center = CGPointMake(self.frame.size.width / 2, _moneyLab.center.y);
    }else if ([model.resultListModel.dumplingModel.dumplingType isEqualToString:DumplingTypeCoupon]){//3优惠卷
        
    }
    
    
    
    CGFloat totalMoney = 0.00;
    int number = [model.resultListModel.userHasNum intValue];//剩余次数
    if(LYLIsLoging){//已登录
        totalMoney = [LYLTools todayTotalMoneyWithPath:DumplingInforLogingPath];
        if(number == 0){
            if(totalMoney > 0){//有钱
                
                /**
                 *  分享是否增加次数，0 增加 1不增加
                 */
                if([model.resultListModel.isMarkShare isEqualToString:@"0"]){
                    bounceDumplingInforView.remainingNumberLab.text = [NSString stringWithFormat:@"马上分享，再得1次机会"];
                }else if ([model.resultListModel.isMarkShare isEqualToString:@"1"]){
                    bounceDumplingInforView.remainingNumberLab.text = [NSString stringWithFormat:@"机会用完啦"];
                }
                
            }else{//没钱
                bounceDumplingInforView.remainingNumberLab.text = [NSString stringWithFormat:@"机会用完啦"];
            }
        }
    }else{
        totalMoney = [LYLTools todayTotalMoneyWithPath:DumplingInforNoLogingPath];
        if(number == 0){
            if(totalMoney > 0){
                bounceDumplingInforView.remainingNumberLab.text = [NSString stringWithFormat:@"马上领钱，再得1次机会"];
            }else{
                bounceDumplingInforView.remainingNumberLab.text = [NSString stringWithFormat:@"登录后，再得2次机会"];
            }
        }
    }
    
    if(totalMoney > 0){
        bounceDumplingInforView.contentLab.text = [NSString stringWithFormat:@"今日共捞到%.2f元,棒棒哒~",totalMoney];
        bounceDumplingInforView.contentLab.hidden = NO;
    }else{
        bounceDumplingInforView.contentLab.hidden = YES;
        bounceDumplingInforView.moneyLab.center = CGPointMake(bounceDumplingInforView.moneyLab.center.x, bounceDumplingInforView.frame.size.height / 2);
    }
    
}


- (void)addAnimationWithDuration:(int)duration{
    [UIView animateWithDuration:duration animations:^{
//        bounceDumplingInforView.frame = CGRectMake(bounceDumplingInforView.center., bounceDumplingInforView.center.y, 0, 0);
    }];
}

- (void)buttonClicked:(UIButton *)button{
    [LYLTools removeBounceViewWithVC:_viewController];
    switch (button.tag) {
        case ButtonTagWithGotoGetMoneyType:
        case ButtonTagWithGoToLoginType:
        {
            LYLQuickLoginViewController *quickLogingVc = [[LYLQuickLoginViewController alloc]init];
            quickLogingVc.backBlock = ^void(){
                
            };
            [_viewController.navigationController pushViewController:quickLogingVc animated:YES];

        }
            break;

        case ButtonTagWithGoToShareType:
        {
            MySetObjectForKey(ShareTypeWithBounce, ShareTypeKey);
            [ShareInfoManage shareWithType:@"1" andAllMoney:@"" andViewController:_viewController];
//            [ShareInfoManage shareJiaoziInfoWithButton:button andController:_viewController];

        }
            break;
        case ButtonTagWithTomorrowAgainScoopType:
        case ButtonTagWithContinueToMakeType:
        
        {
                
            
        }
            break;
        case ButtonTagWithCheckTheBalanceType:
        {
            mineWalletViewController *wallerViewController = [[mineWalletViewController alloc]init];
//            wallerViewController.backBlock = ^void(){
//                [_viewController.switchView rollingBackViewWithIndex:0];
//            };
            [_viewController.navigationController pushViewController:wallerViewController animated:YES];
            
        }
            break;
        default:
            break;
    }
    
}


- (void)setDefaultState{
    bounceDumplingInforView.backgroundColor = [UIColor whiteColor];
    bounceDumplingInforView.moneyLab.frame = CGRectMake(MoneyLabX, MoneyLabY, MoneyLabW, MoneyLabH);
    bounceDumplingInforView.moneyLab.font = UIFontBild60;
    bounceDumplingInforView.moneyLab.hidden = NO;
    bounceDumplingInforView.moneyLab.textAlignment = NSTextAlignmentCenter;
    
//    bounceDumplingInforView.moneyLab.backgroundColor = [UIColor brownColor];
    bounceDumplingInforView.moneyLab.center = CGPointMake(bounceDumplingInforView.frame.size.width / 2, bounceDumplingInforView.moneyLab.center.y);
    
    bounceDumplingInforView.contentLab.frame = CGRectMake(ContentLabX, ConTentLabY, ContentLabW, ContentLabH);
    bounceDumplingInforView.contentLab.center = CGPointMake(bounceDumplingInforView.frame.size.width / 2, bounceDumplingInforView.contentLab.center.y);
    
    [bounceDumplingInforView.goToGetMoneyOrShareBtn setFrame:CGRectMake(GoToGetMoneyOrShareBtnX, BtnY, BtnW, BtnH)];
    bounceDumplingInforView.goToGetMoneyOrShareBtn.hidden = NO;
    [bounceDumplingInforView.goToGetMoneyOrShareBtn setTitle:@"确定" forState:UIControlStateNormal];
    [bounceDumplingInforView.goToGetMoneyOrShareBtn setBackgroundImage:[UIImage imageNamed:@"9_button_a"] forState:UIControlStateNormal];
    
    [bounceDumplingInforView.continueToMakeBtn setFrame:CGRectMake(ContinueToMakeBtnX, BtnY, BtnW, BtnH)];
    [bounceDumplingInforView.continueToMakeBtn setTitle:@"取消" forState:UIControlStateNormal];
    bounceDumplingInforView.continueToMakeBtn.hidden = NO;
    [bounceDumplingInforView.continueToMakeBtn setBackgroundImage:[UIImage imageNamed:@"9_button_b"] forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
