//
//  ZXYWarmingView.h
//  MarketManage
//
//  Created by Rice on 15/1/19.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

/************************************
        短暂的提示窗 显示1秒后消失
 ************************************/

#import <UIKit/UIKit.h>
#import "MarketAPI.h"

@interface ZXYWarmingView : UIView
{
    UIView *msgView;
    UILabel *msgLabel;
}

+(ZXYWarmingView *)shareInstance;

/*显示提示信息 \n换行  需先执行shareInstance生成实例
 content : 显示内容;
 */
-(void)showMsg:(NSString *)content;


@end
