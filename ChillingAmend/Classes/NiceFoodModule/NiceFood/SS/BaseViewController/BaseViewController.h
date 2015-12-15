//
//  BaseViewController.h
//  QQList
//
//  Created by sunsu on 15/6/29.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : CCViewController{
    BOOL _jietu;
}


@property(nonatomic,strong)UIButton             * backBtn;
@property(nonatomic,strong)UIButton             * rightNavItem;

- (void)showMsg:(NSString *)msg;
- (void)showStartHud;
- (void)stopHud:(NSString *)str;
- (void)showStartHud1;
- (void)close;
- (void)open;

-(void)showStartHudWithString:(NSString*)str;
- (void)baseShareText:(NSString *)text withUrl:(NSString *)idStr withContent:(NSString *)content withImageName:(NSString *)imagePath ImgStr:(NSString *)AimgStr domainName:(NSString *)AdomainName withqqTitle:(NSString *)qqTitle withqqZTitle:(NSString *)qqZTitle withweCTitle:(NSString *)weCTitle withweChtTitle:(NSString *)weChtTitle withsinaTitle:(NSString *)sinaTitle;
@end
