//
//  ZXYWarmingView.m
//  MarketManage
//
//  Created by Rice on 15/1/19.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYWarmingView.h"

@implementation ZXYWarmingView
+(ZXYWarmingView *)shareInstance
{
    static ZXYWarmingView *warmingView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        warmingView = [[ZXYWarmingView alloc] init];
        [warmingView addWarmingView];
        [warmingView setFrame:CGRectMake(0, 64, SCREENWIDTH, [UIScreen mainScreen].bounds.size.height)];
    });
    return warmingView;
}

-(void)addWarmingView
{
    msgView = [[UIView alloc] initWithFrame:CGRectMake(160 *SP_WIDTH, 0, 0, 0)];
    [msgView setCenter:CGPointMake(160*SP_WIDTH, (SCREENHEIGHT-64)/2)];
    msgView.backgroundColor = [UIColor blackColor];
    
    msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    msgLabel.textColor = [UIColor whiteColor];
    msgLabel.font = [UIFont systemFontOfSize:17];
    msgLabel.numberOfLines = 0;
    msgLabel.backgroundColor = [UIColor clearColor];

    [msgView addSubview:msgLabel];
    [self addSubview:msgView];
    
    self.backgroundColor = [UIColor clearColor];
    self.alpha = 0;
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    NSLog(@"%@",[[UIApplication sharedApplication] keyWindow].subviews);
}

-(void)showMsg:(NSString *)content;
{
    NSArray *msgAry =[content componentsSeparatedByString:@"\n"];
    CGFloat msgWidthest = 0.0;
    if (msgAry.count >= 2) {
        for (int i = 0; i < msgAry.count; i++) {
            CGFloat width_1 = [MarketAPI labelAutoCalculateRectWith:msgAry[i] FontSize:17 MaxSize:CGSizeMake(320, 20)].width;
            msgWidthest = MAX(width_1, msgWidthest);
        }
    }else{
        msgWidthest = [MarketAPI labelAutoCalculateRectWith:content FontSize:17 MaxSize:CGSizeMake(320, 20)].width;
    }
    
    msgLabel.text = content;
    msgView.layer.cornerRadius = 3 + msgAry.count /2;
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    [msgLabel setAttributedText:attributedString];
    [msgLabel sizeToFit];
    
    if (msgAry.count == 1) {
        [msgView setFrame:CGRectMake((320*SP_WIDTH - msgWidthest)/2., (SCREENHEIGHT - 20 * msgAry.count - 64)/2, msgWidthest + 20, 30) ];
        [msgLabel setFrame:CGRectMake(10, 0, msgWidthest, 30)];
    }else{
        [msgView setFrame:CGRectMake((320*SP_WIDTH - msgWidthest)/2., (SCREENHEIGHT - 20 * msgAry.count - 64)/2, msgWidthest + 20, 25 * msgAry.count) ];
        [msgLabel setFrame:CGRectMake(10, 0, msgWidthest, 25 * msgAry.count)];
    }
    
    [msgView setCenter:CGPointMake(160*SP_WIDTH, (SCREENHEIGHT-64)/2)];
    [msgLabel setCenter:CGPointMake(FRAMNE_W(msgView)/2., FRAMNE_H(msgView)/2.)];

    [UIView animateWithDuration:.3 animations:^{
    self.alpha = 0.7;
        }];
    [self performSelector:@selector(hideWarmingView) withObject:self afterDelay:1];
    
}



-(void)hideWarmingView
{
    
    [UIView animateWithDuration:.2 animations:^{
        self.alpha = 0;
    }];
    
}

@end
