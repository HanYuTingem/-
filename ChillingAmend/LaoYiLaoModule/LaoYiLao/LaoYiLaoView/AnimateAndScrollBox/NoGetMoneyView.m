//
//  NoGetMoneyView.m
//  LaoYiLao
//
//  Created by wzh on 15/11/10.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "NoGetMoneyView.h"
#import "DumplingInforModel.h"
#import "LYLQuickLoginViewController.h"
//未领取钱的Frame
#define NoGetMoneyViewX 0//无所谓居中
#define NoGetMoneyViewY 8 * KPercenY
#define NoGetMoneyViewW kkViewWidth - 20
#define NoGetMoneyViewH 20
static NoGetMoneyView *noGetMoneyView;
static UIButton *getMoneyBtn;
@implementation NoGetMoneyView

+ (NoGetMoneyView *)shareGetMoneyView{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        noGetMoneyView = [[NoGetMoneyView alloc]init];
//        noGetMoneyView.backgroundColor = [UIColor whiteColor];
        noGetMoneyView.frame = CGRectMake(NoGetMoneyViewX, NoGetMoneyViewY, NoGetMoneyViewW, NoGetMoneyViewH);
        noGetMoneyView.center = CGPointMake(kkViewWidth / 2, noGetMoneyView.center.y);
        
        getMoneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        getMoneyBtn.backgroundColor = [UIColor blueColor];
        getMoneyBtn.titleLabel.font = UIFont28;
        getMoneyBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        getMoneyBtn.frame = CGRectMake(0, 0, noGetMoneyView.frame.size.width, noGetMoneyView.frame.size.height);
        [getMoneyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [getMoneyBtn addTarget:noGetMoneyView action:@selector(getMoneybtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        //        _noGetMoneyView.noGetMoneyStr = @"";
        [noGetMoneyView addSubview:getMoneyBtn];

    });
    return noGetMoneyView;
}

- (void)refreshShareGetMoneyView{
    NSMutableArray *dumplingInforArray = [NSMutableArray arrayWithContentsOfFile:DumplingInforNoLogingPath];
    CGFloat totalMoney = 0.00;
    for (NSDictionary *subDic in dumplingInforArray) {
        DumplingInforModel *model = [DumplingInforModel dumplingInforModelWithDic:subDic];
        if([model.resultListModel.dumplingModel.dumplingType isEqualToString:DumplingTypeMoney]){
            totalMoney = totalMoney +  [model.resultListModel.dumplingModel.prizeAmount floatValue];
        }
    }
    
    
    if(totalMoney > 0){
        if(LYLIsLoging){
            [getMoneyBtn setTitle:[NSString stringWithFormat:@"今日共捞到%.2f元,换个手机号领取.",totalMoney] forState:UIControlStateNormal];
        }else{
            [getMoneyBtn setTitle:[NSString stringWithFormat:@"今日共捞到%.2f元,点击领取。",totalMoney] forState:UIControlStateNormal];
        }
        noGetMoneyView.hidden = NO;
    }else{
        noGetMoneyView.hidden = YES;
    }
}


- (void)getMoneybtnClicked:(UIButton *)button{
    
    if([self.delegate respondsToSelector:@selector(getMoney)]){
        [self.delegate performSelector:@selector(getMoney)];
    }//外
//    if([MyObjectForKey(LogingState) isEqualToString:LoginStateYES]){
//    }else{
//        LYLQuickLoginViewController *quickVc = [[LYLQuickLoginViewController alloc]init];
//        AppDelegate *app = ShareApp;
//        quickVc.backBlock = ^void(){
//            
//        };
//        [app.navi pushViewController:quickVc animated:YES];
//        ZHLog(@"去领钱");
//    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
