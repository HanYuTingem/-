//
//  LSYXianShiMiaoShaView.h
//  PRJ_Mall_Demo
//
//  Created by liangsiyuan on 15/1/10.
//  Copyright (c) 2015年 Liangsiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "LSYStrikeLineLabel.h"
@protocol LSYXianShiMiaoShaViewDelegate <NSObject>
@optional
-(void)didTapSeckilling:(NSString * )miaoshaId andChild:(NSString*)childId;
-(void)xianshiMiaoShaNeedsReload;
@end

@interface LSYXianShiMiaoShaView : UIView

@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *minutesLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondsLabel;
@property (nonatomic,weak)id <LSYXianShiMiaoShaViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;

//限时秒杀回条
@property (nonatomic,copy) void (^XianShiMiaoShaBlock)();
//活动ID
@property (nonatomic,copy)NSString * miaoShaID;
//子活动ID
@property (nonatomic,copy)NSString * childMiaoShaID;
//倒计时时
@property (nonatomic,assign)int start_time;
//秒杀时间
@property (nonatomic,copy) NSString * skill_time;
//图片
@property (nonatomic,copy)NSString * img_Url;
//图片
@property (nonatomic,copy)NSString * host;

@end
