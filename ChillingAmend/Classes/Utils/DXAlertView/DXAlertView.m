//
//  ILSMLAlertView.m
//  MoreLikers
//
//  Created by xiekw on 13-9-9.
//  Copyright (c) 2013年 谢凯伟. All rights reserved.
//

#import "DXAlertView.h"
#import <QuartzCore/QuartzCore.h>
#import "RTLabel.h"
#import "JPCommonMacros.h"
#import "UIImageView+WebCache.h"
#import "BXAPI.h"
#define kAlertWidth 225.0f
#define kAlertHeight 133.0f
#define kAlertGiftHeight 221.0f

@interface DXAlertView ()
{
    BOOL _leftLeave;
    BOOL _isGift;
}

@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) RTLabel *alertContentLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *backImageView;
@property (nonatomic, strong) UIImageView * image11;

@property (nonatomic,strong) UIButton *xButton;

@end

@implementation DXAlertView

+ (CGFloat)alertWidth
{
    return kAlertWidth;
}

+ (CGFloat)alertHeight
{
    return kAlertHeight;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#define kTitleYOffset 30.0f
#define kTitleHeight 15.0f
#define kContentOffset 30.0f
#define kBetweenLabelOffset 20.0f
#define kSingleButtonWidth 72.0f
#define kCoupleButtonWidth 72.0f
#define kButtonHeight 28.0f
#define kButtonBottomOffset 18.0f

- (id)initWithnoTitle:(NSString *)title
          contentText:(NSString *)content
      leftButtonTitle:(NSString *)leftTitle
     rightButtonTitle:(NSString *)rigthTitle
{
    if (self = [super init]) {
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor whiteColor];
        _image11 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"activity_pop_bg1.png"]];
        _image11.frame = CGRectMake(0, 0, kAlertWidth, 133);
        [self addSubview:_image11];
        
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kTitleYOffset, kAlertWidth, kTitleHeight)];
        self.alertTitleLabel.font = [UIFont systemFontOfSize:17.0f];
        self.alertTitleLabel.backgroundColor = [UIColor clearColor];
        self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.alertTitleLabel];
        
        CGFloat contentLabelWidth = kAlertWidth - 30;
        CGFloat alertContentLabelY = CGRectGetMaxY(self.alertTitleLabel.frame);
        float alertContentFont;
        if ([title isEqual:@""] || title == nil) {
            alertContentLabelY = alertContentLabelY - 10;
            alertContentFont = 17.0f;
        } else {
            alertContentLabelY = alertContentLabelY + 10;
            alertContentFont = 15.0f;
        }
        
        self.alertContentLabel = [[RTLabel alloc] initWithFrame:CGRectMake((kAlertWidth - contentLabelWidth) * 0.5,  alertContentLabelY, contentLabelWidth, 60)];
        self.alertContentLabel.textAlignment = RTTextAlignmentCenter;
        self.alertContentLabel.backgroundColor = [UIColor clearColor];
        self.alertContentLabel.font = [UIFont systemFontOfSize:alertContentFont];
        [self addSubview:self.alertContentLabel];
        
        CGRect leftBtnFrame;
        CGRect rightBtnFrame;

        if (!leftTitle) {
            rightBtnFrame = CGRectMake((kAlertWidth - kSingleButtonWidth) * 0.5, kAlertHeight - kButtonBottomOffset - kButtonHeight, kSingleButtonWidth, kButtonHeight);
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"c1share_content_btn_default.png"] forState:UIControlStateNormal];
            [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"c1share_content_btn_default.png"] forState:UIControlStateHighlighted];
            self.rightBtn.frame = rightBtnFrame;
        } else {
            leftBtnFrame = CGRectMake(23, kAlertHeight - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            rightBtnFrame = CGRectMake(CGRectGetMaxX(leftBtnFrame) + 35, kAlertHeight - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"c1share_content_btn_default.png"] forState:UIControlStateNormal];
            [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"c1share_content_btn_default.png"] forState:UIControlStateHighlighted];
            [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"d1share_content_btn_bottom_gray_default.png"] forState:UIControlStateNormal];
            [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"d1share_content_btn_bottom_gray_selected.png"] forState:UIControlStateHighlighted];
            self.leftBtn.frame = leftBtnFrame;
            self.rightBtn.frame = rightBtnFrame;
            
        }
        
        [self.rightBtn setTitle:rigthTitle forState:UIControlStateNormal];
        [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        self.leftBtn.titleLabel.font = self.rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.leftBtn setTitleColor:kkCColor forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor colorWithRed:184/255.0 green:6/255.0 blue:6/255.0 alpha:1.0] forState:UIControlStateNormal];
        
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

/**
 *  获得积分alertview
 *
 *  @param title      标题
 *  @param content    获得多少积分
 *  @param leftTitle  左按键标题
 *  @param rigthTitle 右按键标题
 *
 *  @return 返回自定义alertview
 */
- (id)initWithTitle:(NSString *)title
          contentText:(NSString *)content
      leftButtonTitle:(NSString *)leftTitle
     rightButtonTitle:(NSString *)rigthTitle
{
    if (self = [super init]) {
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor whiteColor];
        _image11 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"activity_pop_bg1.png"]];
        _image11.frame = CGRectMake(0, 0, kAlertWidth, 133);
        [self addSubview:_image11];
        
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kTitleYOffset, kAlertWidth, kTitleHeight)];
        self.alertTitleLabel.font = [UIFont systemFontOfSize:17.0f];
        self.alertTitleLabel.backgroundColor = [UIColor clearColor];
        self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.alertTitleLabel];
        
        CGFloat contentLabelWidth = kAlertWidth - 30;
        CGFloat alertContentLabelY = CGRectGetMaxY(self.alertTitleLabel.frame);
        UIView *alertContentView = [[UIView alloc] initWithFrame:CGRectMake((kAlertWidth - contentLabelWidth) * 0.5,  alertContentLabelY - 10, contentLabelWidth, 60)];
        
        UILabel *getlabel = [[UILabel alloc] initWithFrame:CGRectMake(contentLabelWidth / 7, 0, 40, 60)];
        getlabel.textAlignment = NSTextAlignmentCenter;
        getlabel.backgroundColor = [UIColor clearColor];
        getlabel.font = [UIFont systemFontOfSize:15.0f];
        getlabel.text = @"获得";
        // 积分
        UIImageView *coinImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(getlabel.frame), 24, 14, 12)];
        coinImg.image = [UIImage imageNamed:@"activity_icon_default_middle.png"];
        // 获得的积分
        UILabel *coinLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(coinImg.frame), 0, 40, 60)];
        coinLabel.textAlignment = NSTextAlignmentCenter;
        coinLabel.textColor = [UIColor colorWithRed:184/255.0 green:6/255.0 blue:6/255.0 alpha:1.0];
        coinLabel.backgroundColor = [UIColor clearColor];
        coinLabel.font = [UIFont systemFontOfSize:17.0f];
        coinLabel.text = content;
        // 宽度自适应
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:coinLabel.font, NSFontAttributeName, nil];
        CGSize size = CGSizeMake(coinLabel.frame.size.width, MAXFLOAT);
        CGSize actualsize = [coinLabel.text boundingRectWithSize:size options:NSStringDrawingUsesFontLeading  attributes:tdic context:nil].size;
        coinLabel.frame = CGRectMake(coinLabel.frame.origin.x + 5, 0, actualsize.width, 60);
        
        UILabel *coinslabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(coinLabel.frame), 0, 60, 60)];
        coinslabel.textAlignment = NSTextAlignmentCenter;
        coinslabel.backgroundColor = [UIColor clearColor];
        coinslabel.font = [UIFont systemFontOfSize:15.0f];
        coinslabel.text = @"积分";
        
        [alertContentView addSubview:getlabel];
        [alertContentView addSubview:coinLabel];
        [alertContentView addSubview:coinImg];
        [alertContentView addSubview:coinslabel];
        [self addSubview:alertContentView];
        CGRect leftBtnFrame;
        CGRect rightBtnFrame;
        
        if (!leftTitle) {
            rightBtnFrame = CGRectMake((kAlertWidth - kSingleButtonWidth) * 0.5, kAlertHeight - kButtonBottomOffset - kButtonHeight, kSingleButtonWidth, kButtonHeight);
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"c1share_content_btn_default.png"] forState:UIControlStateNormal];
            [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"c2share_content_btn_selected.png"] forState:UIControlStateHighlighted];
            self.rightBtn.frame = rightBtnFrame;
        } else {
            leftBtnFrame = CGRectMake(23, kAlertHeight - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            rightBtnFrame = CGRectMake(CGRectGetMaxX(leftBtnFrame) + 35, kAlertHeight - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"c1share_content_btn_default.png"] forState:UIControlStateNormal];
            [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"c2share_content_btn_selected.png"] forState:UIControlStateHighlighted];
            [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"d1share_content_btn_gray_default.png"] forState:UIControlStateNormal];
            [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"d2share_content_btn_gray_selected.png"] forState:UIControlStateHighlighted];
            self.leftBtn.frame = leftBtnFrame;
            self.rightBtn.frame = rightBtnFrame;
            
        }
        
        [self.rightBtn setTitle:rigthTitle forState:UIControlStateNormal];
        [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        self.leftBtn.titleLabel.font = self.rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.leftBtn setTitleColor:kkCColor forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor colorWithRed:184/255.0 green:6/255.0 blue:6/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.leftBtn.layer.masksToBounds = self.rightBtn.layer.masksToBounds = YES;
        self.leftBtn.layer.cornerRadius = self.rightBtn.layer.cornerRadius = 3.0;
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        
        self.alertTitleLabel.text = title;
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}

/**
 *  获得礼物alertview
 *
 *  @param title      标题
 *  @param content    获得礼物名称
 *  @param leftTitle  左按键标题
 *  @param rigthTitle 右按键标题
 *  @param
 *
 *  @return 返回自定义alertview
 */
- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
          giftImage:(UIImage *)giftImage
         orImageUrl:(NSString *)imageUrl
{
    if (self = [super init]) {
        _isGift = YES;
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor whiteColor];
        _image11 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"activity_pop_bg2.png"]];
        _image11.frame = CGRectMake(0, 0, kAlertWidth, kAlertGiftHeight);
        [self addSubview:_image11];
        
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kTitleYOffset, kAlertWidth, kTitleHeight)];
        self.alertTitleLabel.font = [UIFont systemFontOfSize:17.0f];
        self.alertTitleLabel.backgroundColor = [UIColor clearColor];
        self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.alertTitleLabel];
        
        CGFloat contentLabelWidth = kAlertWidth - 30;
        CGFloat alertContentLabelY = CGRectGetMaxY(self.alertTitleLabel.frame);
        UIView *alertContentView = [[UIView alloc] initWithFrame:CGRectMake((kAlertWidth - contentLabelWidth) * 0.5,  alertContentLabelY - 5, contentLabelWidth, 40)];
        
        UILabel *getlabel = [[UILabel alloc] initWithFrame:CGRectMake(contentLabelWidth / 14, 0, 40, 40)];
        getlabel.textAlignment = NSTextAlignmentCenter;
        getlabel.backgroundColor = [UIColor clearColor];
        getlabel.font = [UIFont systemFontOfSize:15.0f];
        getlabel.text = @"获得";
        
        UILabel *giftlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(getlabel.frame), 0, contentLabelWidth - CGRectGetMaxX(getlabel.frame), 40)];
        giftlabel.textAlignment = NSTextAlignmentLeft;
        giftlabel.backgroundColor = [UIColor clearColor];
        giftlabel.font = [UIFont systemFontOfSize:17.0f];
        giftlabel.textColor = [UIColor colorWithRed:184/255.0 green:6/255.0 blue:6/255.0 alpha:1.0];
        giftlabel.text = content;
        
        [alertContentView addSubview:getlabel];
        [alertContentView addSubview:giftlabel];
        [self addSubview:alertContentView];
        
        // 礼物
        UIImageView *coinImg = [[UIImageView alloc] initWithFrame:CGRectMake((kAlertWidth - 79)/2, CGRectGetMaxY(alertContentView.frame), 79, 79)];
        if (imageUrl.length > 0) {
            [coinImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",img_url,imageUrl]]];
        } else {
            coinImg.image = giftImage;
        }
        [self addSubview:coinImg];
        
        CGRect leftBtnFrame;
        CGRect rightBtnFrame;
        
        if (!leftTitle) {
            rightBtnFrame = CGRectMake((kAlertWidth - kSingleButtonWidth) * 0.5, kAlertGiftHeight - kButtonBottomOffset - kButtonHeight, kSingleButtonWidth, kButtonHeight);
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"c1share_content_btn_default.png"] forState:UIControlStateNormal];
            [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"c2share_content_btn_selected.png"] forState:UIControlStateHighlighted];
            self.rightBtn.frame = rightBtnFrame;
        } else {
            leftBtnFrame = CGRectMake(23, kAlertGiftHeight - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            rightBtnFrame = CGRectMake(CGRectGetMaxX(leftBtnFrame) + 35, kAlertGiftHeight - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"c1share_content_btn_default.png"] forState:UIControlStateNormal];
            [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"c2share_content_btn_selected.png"] forState:UIControlStateHighlighted];
            [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"d1share_content_btn_gray_default.png"] forState:UIControlStateNormal];
            [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"d2share_content_btn_gray_selected.png"] forState:UIControlStateHighlighted];
            self.leftBtn.frame = leftBtnFrame;
            self.rightBtn.frame = rightBtnFrame;
            
        }
        
        [self.rightBtn setTitle:rigthTitle forState:UIControlStateNormal];
        [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        self.leftBtn.titleLabel.font = self.rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.leftBtn setTitleColor:kkCColor forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor colorWithRed:184/255.0 green:6/255.0 blue:6/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.leftBtn.layer.masksToBounds = self.rightBtn.layer.masksToBounds = YES;
        self.leftBtn.layer.cornerRadius = self.rightBtn.layer.cornerRadius = 3.0;
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        
        self.alertTitleLabel.text = title;
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}


- (id)initShangChengAlertWithTitle:(NSString *)title
                       contentText:(NSString *)content
                   leftButtonTitle:(NSString *)leftTitle
                  rightButtonTitle:(NSString *)rigthTitle
{
    if (self = [super init]) {
        
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor whiteColor];
        
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kTitleYOffset, kAlertWidth, kTitleHeight)];
        self.alertTitleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.alertTitleLabel];
        
        CGFloat contentLabelWidth = kAlertWidth - 16;
        self.alertContentLabel = [[RTLabel alloc] initWithFrame:CGRectMake((kAlertWidth - contentLabelWidth) * 0.5, kTitleYOffset, contentLabelWidth, 60)];
        self.alertContentLabel.textAlignment = kCTTextAlignmentCenter;
        self.alertContentLabel.backgroundColor = [UIColor clearColor];
        self.alertContentLabel.font = [UIFont systemFontOfSize:17.0f];
        [self addSubview:self.alertContentLabel];
        
        CGRect leftBtnFrame;
        CGRect rightBtnFrame;
#define kkSingleButtonWidth 213.0f
#define kkCoupleButtonWidth 80.0f
#define kkButtonHeight 40.0f
#define kkButtonBottomOffset 10.0f
        if (!leftTitle) {
            rightBtnFrame = CGRectMake((kAlertWidth - kkSingleButtonWidth) * 0.5, kAlertHeight - kkButtonBottomOffset - kkButtonHeight, kkSingleButtonWidth, kkButtonHeight);
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"L_popdetermineImage.png"] forState:UIControlStateNormal];
            self.rightBtn.frame = rightBtnFrame;
            
            
        }else {
            
            leftBtnFrame = CGRectMake((kAlertWidth-120)/3, kAlertHeight - kkButtonBottomOffset - kkButtonHeight, 60, 35);
            
            rightBtnFrame = CGRectMake(2*(kAlertWidth-120)/3+60, kAlertHeight - kkButtonBottomOffset - kkButtonHeight, 60, 35);
            
            self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [self.rightBtn setBackgroundColor:[UIColor lightGrayColor]];
            [self.leftBtn setBackgroundColor:[UIColor colorWithRed:46/255. green:168/255. blue:225/255. alpha:1]];
            self.leftBtn.frame = leftBtnFrame;
            self.rightBtn.frame = rightBtnFrame;
        }
        
        [self.rightBtn setTitle:rigthTitle forState:UIControlStateNormal];
        [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        self.leftBtn.titleLabel.font = self.rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.leftBtn setTitleColor:[UIColor colorWithRed:48/255. green:48/255. blue:48/255. alpha:1] forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor colorWithRed:48/255. green:48/255. blue:48/255. alpha:1] forState:UIControlStateNormal];
        
        [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.leftBtn.layer.masksToBounds = self.rightBtn.layer.masksToBounds = YES;
        self.leftBtn.layer.cornerRadius = self.rightBtn.layer.cornerRadius = 3.0;
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        
        self.alertTitleLabel.text = title;
        self.alertContentLabel.text = content;
        
        _xButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_xButton setImage:[UIImage imageNamed:@"L_closeBtnImage.png"] forState:UIControlStateNormal];
        [_xButton setImage:[UIImage imageNamed:@"L_closeBtnImage.png"] forState:UIControlStateHighlighted];
        _xButton.frame = CGRectMake(kAlertWidth - 27, 5, 20, 20);
        [self addSubview:_xButton];
        [_xButton addTarget:self action:@selector(dismissAlert) forControlEvents:UIControlEventTouchUpInside];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        
        
    }
    return self;
}


- (void)closeBtn
{
    _xButton.hidden = YES;
}

- (void)leftBtnClicked:(id)sender
{
    _leftLeave = YES;
    if (self.leftBlock) {
        self.leftBlock();
    }
    [self dismissAlert];

}

- (void)rightBtnClicked:(id)sender
{
    _leftLeave = NO;
    if (self.rightBlock) {
        self.rightBlock();
    }
    [self dismissAlert];

}

- (void)show
{
    //UIViewController *topVC = [self appRootViewController];
    float hight;
    if (_isGift) {
        hight = kAlertGiftHeight;
    } else hight = kAlertHeight;
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

//- (UIViewController *)appRootViewController
//{
//    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
//    UIViewController *topVC = appRootVC;
//    while (topVC.presentedViewController) {
//        topVC = topVC.presentedViewController;
//    }
//    return topVC;
//}
- (UIWindow *)appRootViewController
{
   return [[UIApplication sharedApplication].delegate window];
//    UIViewController *topVC = appRootVC;
//    while (topVC.presentedViewController) {
//        topVC = topVC.presentedViewController;
//    }
//    return topVC;
}

- (void)removeSuperview
{
   [self.backImageView removeFromSuperview];
   self.backImageView = nil;
    [self removeFromSuperview];
   // UIWindow *topVC = [self appRootViewController];
//   CGRect afterFrame = CGRectMake(([UIScreen mainScreen].bounds.size.width - kAlertWidth) * 0.5, ([UIScreen mainScreen].bounds.size.height), kAlertWidth, kAlertHeight);
    
//    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        self.frame = afterFrame;
//        if (_leftLeave) {
//            self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);
//        } else {
//            self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
//        }
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
    
   //  self.frame = afterFrame;
     //if (!_leftLeave) {
       //  [self removeFromSuperview];
    // }


}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    //UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [[[UIApplication sharedApplication].delegate window] addSubview:self.backImageView];
   self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    float hight;
    if (_isGift) {
        hight = kAlertGiftHeight;
    } else hight = kAlertHeight;
   CGRect afterFrame = CGRectMake((([UIScreen mainScreen].bounds.size.width) - kAlertWidth) * 0.5, ([UIScreen mainScreen].bounds.size.height - hight) * 0.5, kAlertWidth, hight);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
    } completion:^(BOOL finished) {
    }];
    //self.frame = afterFrame;

    [super willMoveToSuperview:newSuperview];


}

@end

@implementation UIImage (colorful)

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
