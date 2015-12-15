//
//  DumplingsAndSpoonView.h
//  animation
//
//  Created by wzh on 15/10/30.
//  Copyright (c) 2015年 王兆华. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DumplingsAndSpoonViewDelegate <NSObject>

- (void)spoonBtnClicked:(UIButton *)spoonBtnClicked;
- (void)dumpilngsBtnClicked:(UIButton *)dumpilngsBtnClicked;
@end

@interface DumplingsAndSpoonView : UIView

@property (nonatomic, weak) __weak id<DumplingsAndSpoonViewDelegate>delegate;
@property (nonatomic, strong) UIButton *spoonBtn;//勺btn
@property (nonatomic, strong) UIButton *spoonTopBtn;//勺btn

@property (nonatomic, strong) UIButton *dumplingsBtn;//饺子btn

@end
