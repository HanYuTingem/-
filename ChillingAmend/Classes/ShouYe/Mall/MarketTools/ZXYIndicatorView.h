//
//  ZXYIndicatorView.h
//  MarketManage
//
//  Created by Rice on 15/1/19.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

/************************************
          请求等待Indicator
 ************************************/

#import <UIKit/UIKit.h>

@interface ZXYIndicatorView : UIView

+(ZXYIndicatorView *)shareInstance;

/*显示请求等待  需先执行shareInstance生成实例
 */
-(void)showIndicator;
/*隐藏请求等待  需已执行shareInstance生成实例
 */
-(void)hideIndicator;

@end
