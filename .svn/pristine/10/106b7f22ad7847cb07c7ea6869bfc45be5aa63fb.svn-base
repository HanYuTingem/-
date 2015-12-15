//  游戏提示框
//  GameAlertView.m
//  ChillingAmend
//
//  Created by 许文波 on 15/1/6.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import "GameAlertView.h"
#import <QuartzCore/QuartzCore.h>
#import "RTLabel.h"
#import "JPCommonMacros.h"
#import "UIImageView+WebCache.h"
#import "BXAPI.h"
#define kAlertWidth 239.0f
#define kAlertHeight 187.0f

@interface GameAlertView ()

@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) RTLabel *alertContentLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *backImageView;
@property (nonatomic, strong) UIImageView * image11; // 背景图片

@property (nonatomic,strong) UIButton *xButton;

@end

@implementation GameAlertView

+ (CGFloat)alertWidth
{
    return kAlertWidth;
}

+ (CGFloat)alertHeight
{
    return kAlertHeight;
}

#define kTitleYOffset 70.0f
#define kTitleHeight 15.0f
#define kSingleButtonWidth 125.0f
#define kCoupleButtonWidth 105.0f
#define kButtonHeight 35.0f
#define kButtonBottomOffset 18.0f
#define kTitleFontSize 13.0f
#define kContentFontSize 19.0f

- (id)initWithTitle:(NSString *)title
          contentText:(NSString *)content
      leftButtonTitle:(NSString *)leftTitle
     rightButtonTitle:(NSString *)rigthTitle
{
    if (self = [super init]) {
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor clearColor];
        
        
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kTitleYOffset, kAlertWidth, kTitleHeight)];
        self.alertTitleLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
        self.alertTitleLabel.backgroundColor = [UIColor clearColor];
        self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.alertTitleLabel.textColor = [UIColor colorWithRed:80/255.0 green:42/255.0 blue:0/255.0 alpha:1.0];
        
        CGFloat contentLabelWidth = kAlertWidth - 20;
        CGFloat alertContentLabelY = CGRectGetMaxY(self.alertTitleLabel.frame);
        float alertContentFont;
        UIImage *tempImage;
        if ([title isEqual:@""] || title == nil) { // 没中奖
            alertContentLabelY = alertContentLabelY - 10;
            alertContentFont = kTitleFontSize;
            tempImage = [UIImage imageNamed:@"zhuanpan_middle_content_img_defaultl1.png"];
        } else {
            alertContentLabelY = alertContentLabelY + 10;
            alertContentFont = kContentFontSize;
            tempImage = [UIImage imageNamed:@"zhuanpan_middle_content_img_defaultl2.png"];
        }
        _image11 = [[UIImageView alloc] initWithImage:tempImage];
        _image11.frame = CGRectMake(0, 0, kAlertWidth, kAlertHeight);
        [self addSubview:_image11];
        
        self.alertContentLabel = [[RTLabel alloc] initWithFrame:CGRectMake((kAlertWidth - contentLabelWidth) * 0.5,  alertContentLabelY, contentLabelWidth, 60)];
        self.alertContentLabel.textAlignment = RTTextAlignmentCenter;
        self.alertContentLabel.textColor = [UIColor colorWithRed:80/255.0 green:42/255.0 blue:0/255.0 alpha:1.0];
        self.alertContentLabel.backgroundColor = [UIColor clearColor];
        self.alertContentLabel.font = [UIFont systemFontOfSize:alertContentFont];
        
        [self addSubview:self.alertTitleLabel];
        [self addSubview:self.alertContentLabel];
        
        CGRect leftBtnFrame;
        CGRect rightBtnFrame;
        
        if (!leftTitle) {
            rightBtnFrame = CGRectMake((kAlertWidth - kSingleButtonWidth) * 0.5, kAlertHeight - kButtonBottomOffset - kButtonHeight, kSingleButtonWidth, kButtonHeight);
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"public_content_btn_queding_moren.png"] forState:UIControlStateNormal];
            [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"public_content_btn_queding_dianji.png"] forState:UIControlStateHighlighted];
            self.rightBtn.frame = rightBtnFrame;
        } else {
            leftBtnFrame = CGRectMake((kAlertWidth - kCoupleButtonWidth * 2) / 2 , kAlertHeight - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            rightBtnFrame = CGRectMake(CGRectGetMaxX(leftBtnFrame), kAlertHeight - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"public_middle_content_btn_normal_ok_sure1.png"] forState:UIControlStateNormal];
            [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"public_middle_content_btn_selectedl_ok_sure.png"] forState:UIControlStateHighlighted];
            [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"zhuanpan_content_btn_normal_share.png"] forState:UIControlStateNormal];
            [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"zhuanpan_content_btn_selected_share.png"] forState:UIControlStateHighlighted];
            self.leftBtn.frame = leftBtnFrame;
            self.rightBtn.frame = rightBtnFrame;
            
        }
        
        [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.leftBtn.layer.masksToBounds = self.rightBtn.layer.masksToBounds = YES;
        self.leftBtn.layer.cornerRadius = self.rightBtn.layer.cornerRadius = 3.0;
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        
        self.alertTitleLabel.text = title;
        self.alertContentLabel.text = content;
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}

- (void)leftBtnClicked:(id)sender
{
    if (self.leftBlock) {
        self.leftBlock();
    }
    [self dismissAlert];
}

- (void)rightBtnClicked:(id)sender
{
    if (self.rightBlock) {
        self.rightBlock();
    }
    [self dismissAlert];
}

- (void)show
{
    float hight = kAlertHeight;
    self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - kAlertWidth) * 0.5, - hight - 30, kAlertWidth, hight);
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
}

- (void)dismissAlert
{
    if (self.dismissBlock) {
        self.dismissBlock();
    }
    [self removeSuperview];
    
}

- (void)removeSuperview
{
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    [self removeFromSuperview];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [[[UIApplication sharedApplication].delegate window] addSubview:self.backImageView];
    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    float hight = kAlertHeight;
    CGRect afterFrame = CGRectMake((([UIScreen mainScreen].bounds.size.width) - kAlertWidth) * 0.5, ([UIScreen mainScreen].bounds.size.height - hight) * 0.5, kAlertWidth, hight);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
    
}


- ( id )initGameErrorMessageWithContent:(NSString *)content
{
    if (self == [super init]) {
//        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//        bgView.backgroundColor = [UIColor blackColor];
//        bgView.userInteractionEnabled = YES;
//        bgView.alpha = 0.5;
//        [self addSubview:bgView];
    
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 247, 123)];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:@"public_middle_content_pop_normal.png"];
        [self addSubview:imageView];
        
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(247 / 2 - 135 / 2, imageView.frame.size.height - 33 - 15, 135, 35)];
        sureBtn.userInteractionEnabled = YES;
        [sureBtn setImage:[UIImage imageNamed:@"public_content_btn_queding_dianji.png"] forState:UIControlStateNormal];
        [sureBtn setImage:[UIImage imageNamed:@"public_content_btn_queding_moren.png"] forState:UIControlStateHighlighted];
        [sureBtn addTarget:self action:@selector(sureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:sureBtn];
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 204, 21)];
        messageLabel.text = content;
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont systemFontOfSize:14.0];
        messageLabel.textColor = [UIColor colorWithRed:50.0/255 green:0.0 blue:0.0 alpha:1.0];
        CGSize textSize = [content sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(204, 103)];
        if (textSize.width > 204) {
            messageLabel.frame = CGRectMake(0, 0, 204, textSize.height);
            messageLabel.textAlignment = NSTextAlignmentLeft;
        }
        messageLabel.frame = CGRectMake((FRAMNE_W(imageView) - FRAMNE_W(messageLabel)) / 2,  (FRAMNE_H(imageView) - textSize.height - FRAMNE_H(sureBtn)) / 2, 204, textSize.height);
        [imageView addSubview:messageLabel];
        
      }
    return self;
}

- (void)sureButtonClicked:(UIButton *)sureButton
{
    if (self.gameErrorDismissBlock) {
        self.gameErrorDismissBlock();
    }
    [self removeSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation UIImage (ccolorful)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  image;
    ;
}

@end
