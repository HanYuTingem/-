//
//  ClickOnTheMoreView.h
//  LaoYiLao
//
//  Created by wzh on 15/11/3.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClickOnTheMoreView : UIView

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, copy) void(^moreBtnBlock)(UIButton *button);

@end
