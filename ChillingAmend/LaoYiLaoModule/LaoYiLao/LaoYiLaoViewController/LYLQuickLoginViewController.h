//
//  LYLQuickLoginViewController.h
//  LaoYiLao
//
//  Created by sunsu on 15/11/7.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickLoginView.h"
@interface LYLQuickLoginViewController : UIViewController<QuickLoginViewDelegate>
//必须实现
@property (nonatomic, copy) void(^backBlock)();

/**
 *  1 首页我的饺子 （默认领取不弹领取成功） 2.首页我得钱包
 */
@property (nonatomic, strong) NSString *type;
@end
