//
//  NoGetMoneyView.h
//  LaoYiLao
//
//  Created by wzh on 15/11/10.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GetMoneyViewDelegate <NSObject>

- (void)getMoney;

@end

@interface NoGetMoneyView : UIView

+ (NoGetMoneyView *)shareGetMoneyView;

- (void)refreshShareGetMoneyView;

@property (nonatomic, weak) __weak id<GetMoneyViewDelegate>delegate;
@end
