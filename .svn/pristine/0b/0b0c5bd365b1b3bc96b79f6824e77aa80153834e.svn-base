//
//  CustomActionSheet.h
//  HCheap
//
//  Created by dairuiquan on 14-12-8.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//

/*
 我的外面清除过期和取消的订单窗口
 */
#import <UIKit/UIKit.h>
@class CustomActionSheet;

@protocol CustomActionSheetDelegate <NSObject>

- (void)customActionSheetButtonIndex:(NSInteger)index;

@end

@interface CustomActionSheet : UIView

@property (nonatomic, weak) id<CustomActionSheetDelegate>delegate;
@property (nonatomic, strong)UIButton *clearBtn;
@end
