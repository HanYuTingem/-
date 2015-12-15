//
//  CJNotSufficientFundsView.m
//  Wallet
//
//  Created by zhaochunjing on 15-10-28.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "CJNotSufficientFundsView.h"

@interface CJNotSufficientFundsView ()
{
    /** 记录支付方式的之前按钮 */
    UIButton *_oldBtn;
    
}

/** 支付宝选中图片 */
@property (weak, nonatomic) IBOutlet UIImageView *zhiFuImage;
/** 微信支付选中图片 */
@property (weak, nonatomic) IBOutlet UIImageView *weiXinImage;
/** 借记卡选中图片 */
@property (weak, nonatomic) IBOutlet UIImageView *jieJiImage;
/** 余额选中图片 */
@property (weak, nonatomic) IBOutlet UIImageView *balanceImage;

/** 弹出页的子页（支付方式页） */
@property (weak, nonatomic) IBOutlet UIView *jumpSubView;
/** 余额不足 */
@property (weak, nonatomic) IBOutlet UILabel *balanceDeficiencyLabel;
/** 余额name */
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
/** 余额的按钮 */
@property (weak, nonatomic) IBOutlet UIButton *balanceBtn;


/** 支付方式的点击状态事件 */
- (IBAction)zhiFuTypeClick:(UIButton *)sender;

@end

@implementation CJNotSufficientFundsView

static CJNotSufficientFundsView *sharedView = nil;

/** 单例对象 */
+ (CJNotSufficientFundsView *)sharedView {
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        sharedView = [[[NSBundle mainBundle] loadNibNamed:@"CJNotSufficientFundsView" owner:self options:nil] lastObject];
        CGRect frame = sharedView.jumpSubView.frame;
        frame.origin.y = ScreenHeight;
        sharedView.jumpSubView.frame = frame;
        sharedView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        CGRect frameSelf = sharedView.frame;
        frameSelf.size.width = ScreenWidth;
        frameSelf.size.height = ScreenHeight;
        sharedView.frame = frameSelf;
        sharedView.hidden = YES;
        sharedView.balanceBtn.enabled = NO;
        sharedView.balanceDeficiencyLabel.hidden = NO;
    });
    return sharedView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CJNotSufficientFundsView" owner:self options:nil] lastObject];
        CGRect frame1 = self.jumpSubView.frame;
        frame1.origin.y = frame.size.height;
        self.jumpSubView.frame = frame1;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        CGRect frameSelf = self.frame;
        frameSelf.size.width = ScreenWidth;
        frameSelf.size.height = frame.size.height;
        self.frame = frameSelf;
        self.hidden = YES;
        self.balanceBtn.enabled = NO;
        self.balanceDeficiencyLabel.hidden = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.frame = CGRectMake(0, 0, ScreenWidth, self.frame.size.height);
}

/** 展示没有余额的弹出界面 */
- (void)showNotSufficientFundsView
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.jumpSubView.frame;
        frame.origin.y = self.frame.size.height - 206;
        self.jumpSubView.frame = frame;
        self.hidden = NO;
    }];
}

/** 隐藏弹出界面 */
- (void)hiddenNotSufficientFundsView
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.jumpSubView.frame;
        frame.origin.y = self.frame.size.height ;
        self.jumpSubView.frame = frame;

    } completion:^(BOOL finished) {
        self.hidden = YES;
        if ([self.delegate respondsToSelector:@selector(notSufficientFundsViewHiddenEvent)]) {
            [self.delegate notSufficientFundsViewHiddenEvent];
        }
    }] ;
}

- (void)notSufficientFundsViewType:(BalanceViewType)balanceViewType
{
    switch (balanceViewType) {
        case BalanceViewTypeNoBalance:
            self.balanceBtn.enabled = NO;
            self.balanceDeficiencyLabel.hidden = NO;
            self.balanceImage.hidden = YES;
            self.balanceLabel.textColor = [UIColor colorWithRed:158.0 / 255.0 green:158.0 / 255.0 blue:158.0 / 255.0 alpha:1];
            break;
        case BalanceViewTypeHaveBalance:
            self.balanceBtn.enabled = YES;
            self.balanceDeficiencyLabel.hidden = YES;
            self.balanceLabel.textColor = [UIColor colorWithRed:34.0 / 255.0 green:34.0 / 255.0 blue:34.0 / 255.0 alpha:1.00f];
            break;
            
        default:
            break;
    }
}


- (IBAction)zhiFuTypeClick:(UIButton *)sender {
    //    if (_oldBtn == sender) return;
    
    self.zhiFuImage.hidden = YES;
    self.weiXinImage.hidden = YES;
    self.jieJiImage.hidden = YES;
    self.balanceImage.hidden = YES;
    switch (sender.tag) {
        case 0:
        {
            self.zhiFuImage.hidden = NO;
            sender.titleLabel.text = @"支付宝";
//            self.payLabel.text = @"支付宝";
        }
            break;
        case 1:
        {
            self.weiXinImage.hidden = NO;
            sender.titleLabel.text = @"微信支付";
            
//            self.payLabel.text = @"微信支付";
        }
            break;
        case 2:
        {
            self.jieJiImage.hidden = NO;
            sender.titleLabel.text = @"借记卡（U付）";
            
//            self.payLabel.text = @"借记卡（U付）";
        }
            break;
        case 3:
        {
            self.balanceImage.hidden = NO;
            sender.titleLabel.text = @"余额支付";
            
//            self.payLabel.text = @"余额支付";
        }
            break;
            
        default:
            break;
    }
    _oldBtn = sender;
    
    self.blookBtnClick(sender);
    
    //隐藏弹出页
    [self hiddenNotSufficientFundsView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hiddenNotSufficientFundsView];
}


@end
