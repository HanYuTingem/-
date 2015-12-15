//
//  CrazySeckillGoodsView.m
//  MarketManage
//
//  Created by fielx on 15/4/22.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazySeckillGoodsView.h"

@implementation CrazySeckillGoodsView

-(void)setMInfoArray:(NSArray *)mInfoArray
{
    _mInfoArray = mInfoArray;
    
    
    NSAssert(self.mCurrentTime != nil, @"秒杀活动没设置服务器时间");
    
    
    for (int i = 0;i < mInfoArray.count;i ++) {
        NSDictionary *dict = mInfoArray[i];
        if ([dict[@"type"]intValue]==1) {
            if ([dict[@"list"][0][@"end_time"]intValue]>[self.mCurrentTime intValue]) {
                LSYXianShiMiaoShaView *seckillView=[[LSYXianShiMiaoShaView alloc]initWithFrame:CGRectMake(0, i*SECKILL_VIEW_HEIGHT, SCREENWIDTH, SECKILL_VIEW_HEIGHT)];
                seckillView.XianShiMiaoShaBlock = ^{
                    self.CrazySeckillUpdateBlock();
                };
                seckillView.host=self.mHost;
                seckillView.delegate = self;
                seckillView.img_Url=dict[@"list"][0][@"img"];
                seckillView.miaoShaID=dict[@"id"];
                seckillView.childMiaoShaID=dict[@"list"][0][@"id"];
                [self addSubview:seckillView];
                
                int status=[dict[@"list"][0][@"status"]intValue];
                NSString * server=self.mCurrentTime;
                NSString * startTime=dict[@"list"][0][@"start_time"];
                NSString * endTime=dict[@"list"][0][@"end_time"];
                seckillView.skill_time =endTime;
                switch (status) {
                    case 1:
                    {
                        seckillView.start_time=[startTime intValue]-[server intValue];
                    }
                        break;
                    case 2:
                    {
                        seckillView.start_time=[endTime intValue]-[server intValue];
                    }
                        break;
                    default:
                        break;
                }
            }
        }
    }
    
}

-(void)didTapSeckilling:(NSString *)miaoshaId andChild:(NSString *)childId
{
    self.CrazySeckillGoodsViewBlock(miaoshaId,childId);
}

-(void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(SCREENWIDTH, self.mInfoArray.count *SECKILL_VIEW_HEIGHT);
    [super setFrame:frame];
}

@end
