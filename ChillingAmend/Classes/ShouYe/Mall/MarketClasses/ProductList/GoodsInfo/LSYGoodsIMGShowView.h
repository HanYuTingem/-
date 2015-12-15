//
//  LSYGoodsIMGShowView.h
//  MarketManage
//
//  Created by liangsiyuan on 15/1/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSYGoodsInfo.h"
@protocol LSYGoodsIMGShowViewDelegate <NSObject>
@optional
-(void)didScrollToINC;
-(void)didTapImg:(NSArray*)array andIndex:(int)index andHost:(NSString*)host;
@end

@interface LSYGoodsIMGShowView : UIView<UIScrollViewDelegate,UIPageViewControllerDelegate>

@property (nonatomic,strong)LSYGoodsInfo * goods;
@property (strong, nonatomic) IBOutlet UIScrollView *scorllView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property(weak,nonatomic)id <LSYGoodsIMGShowViewDelegate>delegate;


@end
