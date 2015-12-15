//
//  LSYEntityGoodsView.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYEntityGoodsView.h"
#import "MarketAPI.h"
#import "NSDate+LSY.h"

@implementation LSYEntityGoodsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"LSYEntityGoodsView" owner:self options:nil][0];
        [self setFrame:frame];
    }
    return self;
}

-(void)setGoods:(LSYGoodsInfo *)goods
{
    _goods=goods;
    _time=[_goods.end_time intValue];


//    [self startCountDown];
    self.goos_Name.text=goods.name;
    if (_goods.restriction!=0) {
        self.goods_CanBuyNum.text=[NSString stringWithFormat:@"限购%d件", goods.restriction];
    }
    
    
    if (_goods.isSeckilling) {
        self.clockIMG.hidden=NO;
        [self startCountDown];
        
        
        self.goods_Price.text=[NSString stringWithFormat:@"秒杀价:%@元",goods.ms_price];
        self.goods_Price.textColor=[UIColor colorWithRed:184.0/255 green:6.0/255 blue:6.0/255 alpha:1];
        
        
        CGSize size = [MarketAPI labelAutoCalculateRectWith:self.goods_Price.text FontSize:20 MaxSize:CGSizeMake(CGFLOAT_MAX, 26)];
        self.goods_PriceW.constant = size.width;
        
        self.oldPrice.text=[MarketAPI judgeCostTypeWithCash:[NSString stringWithFormat:@"%f",goods.cash] andIntegral:[NSString stringWithFormat:@"%.0f",goods.price] withfreight:@"0" withWrap:NO];
        self.oldPrice.text = [NSString stringWithFormat:@"原价:%@",self.oldPrice.text];
        
    }else{
        self.goods_Price.text=[MarketAPI judgeCostTypeWithCash:[NSString stringWithFormat:@"%f",goods.cash] andIntegral:[NSString stringWithFormat:@"%.0f",goods.price] withfreight:@"0" withWrap:NO];
        self.goods_Price.textColor=[UIColor colorWithRed:184.0/255 green:6.0/255 blue:6.0/255 alpha:1];
        self.goods_PriceW.constant = SCREENWIDTH - 20;
        self.goods_Num.text=[NSString stringWithFormat:@"销量%@件", goods.bum_convert];
    }
    
    self.goods_Kucun.text=[NSString stringWithFormat:@"库存%d件", goods.nums];

}
//点击分享
- (IBAction)tapShare:(id)sender
{
    if (self.delegate&& [self.delegate respondsToSelector:@selector(tapShare)]) {
        [self.delegate tapShare];
    }
}
#pragma mark - 倒计时
-(void)startCountDown
{
    if (self.time>0&&!self.timer) {
        self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFrieMethod) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

-(void)timeFrieMethod
{
    self.time=self.time-1;
        [self updateLabel];
    //到0销毁定时器
    if (self.time==0) {
        [self.timer invalidate];
        self.timer=nil;
        if (self.delegate&& [self.delegate respondsToSelector:@selector(entityNeedReload)]) {
            [self.delegate entityNeedReload];
        }
    }
}

-(void)updateLabel
{
    self.clockIMG.hidden=NO;
    
    int seconds = _time % 60;
    int minutes = (_time / 60) % 60;
    int hours = _time / 3600;

    NSString * hourStr;
    NSString * minutesStr;
    NSString * secondsStr;

    if (hours<10) {
        hourStr=[NSString stringWithFormat:@"0%d",hours];
    }else{
        hourStr=[NSString stringWithFormat:@"%d",hours];
    }
    if (minutes<10) {
        minutesStr=[NSString stringWithFormat:@"0%d",minutes];
    }else{
        minutesStr=[NSString stringWithFormat:@"%d",minutes];
    }
    if (seconds<10) {
        secondsStr=[NSString stringWithFormat:@"0%d",seconds];
    }else{
        secondsStr =[NSString stringWithFormat:@"%d",seconds];
    }
    self.goods_Num.text=[NSString stringWithFormat:@"     限时秒杀(还剩%@:%@:%@结束)",hourStr,minutesStr,secondsStr];
}

-(CGSize)widthOfString:(NSString *)string withFont:(int)font {
    
    CGRect textRect = [string boundingRectWithSize:CGSizeMake(3750, 9999)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                           context:nil];
    
    CGSize size = textRect.size;
    
    return size;
}
@end
