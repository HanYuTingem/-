//
//  BarView.h
//  LaoYiLao
//
//  Created by sunsu on 15/10/29.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BarViewDelegate <NSObject>
-(void)backBtnClicked;
-(void)helpBtnClicked;
-(void)shareBtnClicked:(UIButton *)btn;
@end


@interface BarView : UIView
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIButton * rightButton;
@property (nonatomic, strong) UIButton * shareButton;
//@property (nonatomic, assign) BOOL isLogin;//是否是登录
@property(nonatomic,weak)id<BarViewDelegate>delegate;
@end
