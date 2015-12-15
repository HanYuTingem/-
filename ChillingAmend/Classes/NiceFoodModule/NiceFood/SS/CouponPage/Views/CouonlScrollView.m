//
//  CouonlScrollView.m
//  MyNiceFood
//
//  Created by liujinhe on 15/7/28.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "CouonlScrollView.h"

@implementation CouonlScrollView
+ (instancetype)couponDetailViewWithFrame:(CGRect)frame{
    return [[[self class]alloc]initWithFrame:frame];
}
- (instancetype)initWithCouponDetailViewFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    CGFloat padding = RECTFIX_WIDTH(10);
    //   CGFloat couponW = 180;
    CGFloat couponH = 150;
    CGFloat couponX = padding;
    CGFloat couponY = 5;
    CGRect couponImgViewFrame = CGRectMake(couponX,couponY, SCREEN_WIDTH-2*couponX, couponH);
    UIImageView * couponImgView = [[UIImageView alloc]initWithFrame:couponImgViewFrame];
    couponImgView.image = [UIImage imageNamed:@"很便宜优惠卷2副本.png"];
    [self addSubview:couponImgView];
    //很便宜优惠卷2副本.png
    //    CGFloat erweimaW = 100;
    //    CGFloat erweimaH = 100;
    //    CGFloat erweimaX = padding+couponW +(SCREEN_WIDTH-couponW-padding-erweimaW)/2;
    //    CGFloat erweimaY = (couponH - erweimaH)/2;
    //    CGRect erweimaFrame = CGRectMake(erweimaX, erweimaY, erweimaW, erweimaH);
    //    self.erweimaImageView = [[UIImageView alloc]initWithFrame:erweimaFrame];
    //    self.erweimaImageView.image = [UIImage imageNamed:@"erweima.jpg"];
    //   [self addSubview:self.erweimaImageView];
    
    CGFloat getBtnW = SCREEN_WIDTH-2*padding;
    CGFloat getBtnH = 40;
    CGFloat getBtnY = CGRectGetMaxY(couponImgViewFrame)+10;
    CGRect getBtnFrame = CGRectMake((SCREEN_WIDTH-getBtnW)/2, getBtnY, getBtnW, getBtnH);
    self.getMoneyButton = [[UIButton alloc]initWithFrame:getBtnFrame];
    [self.getMoneyButton setBackgroundImage:[UIImage imageNamed:@"settingmessagelogin_message_btn_main_bg_normal.png"] forState:UIControlStateNormal];
    [self.getMoneyButton setTitle:@"分享给我的小伙伴" forState:UIControlStateNormal];
    self.getMoneyButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:self.getMoneyButton];
    //订单信息
    CGRect getpreFrame = CGRectMake(20,getBtnY+getBtnH+5, SCREEN_WIDTH -40, 110);
    UIImageView *preImage = [[UIImageView alloc] initWithFrame:getpreFrame];
    
    preImage.layer.cornerRadius = 8;
    preImage.layer.masksToBounds = YES;
    preImage.layer.borderWidth = 1;
    preImage.layer.borderColor = [[UIColor lightGrayColor] CGColor];
   _useLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH -80, 30)];
    _useLabel.font = [UIFont systemFontOfSize:14.0f];
    [preImage addSubview:_useLabel];
    _bianLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, SCREEN_WIDTH -80, 30)];
    _bianLabel.font = [UIFont systemFontOfSize:14.0f];
    [preImage addSubview:_bianLabel];
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, SCREEN_WIDTH -80, 30)];
    _textLabel.font = [UIFont systemFontOfSize:14.0f];
    [preImage addSubview:_textLabel];
    [self addSubview:preImage];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(RECTFIX_WIDTH(10), CGRectGetMaxY(getpreFrame)+10, 300, 20)];
    label.text = @"使用须知";
    label.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:label];
    
    
    
    CGFloat precautionsX = padding;
    CGFloat precautionsY = CGRectGetMaxY(label.frame)+10;
    CGFloat precautionsW = SCREEN_WIDTH - 2*padding;
    CGFloat precautionsH = 40;
    CGRect precautionsFrame = CGRectMake(precautionsX, precautionsY, precautionsW, precautionsH);
//    self.precautionsLabel = [[UILabel alloc]initWithFrame:precautionsFrame];
//    self.precautionsLabel.textColor = [UIColor lightGrayColor];
//    self.precautionsLabel.font = [UIFont systemFontOfSize:12.0f];
//    self.precautionsLabel.numberOfLines = 0;
//    [self addSubview:self.precautionsLabel];
    
    self.detailWebview = [[UIWebView alloc]initWithFrame:precautionsFrame];
    self.detailWebview.backgroundColor = [UIColor clearColor];
    self.detailWebview.scrollView.bounces = NO;
    [self addSubview:self.detailWebview];
    
    _baseKetView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(precautionsFrame)+10, SCREEN_WIDTH, 200)];
    //    UIImageView * divisionImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(precautionsFrame)+10, SCREEN_WIDTH, 20)];
    
    UIImageView * divisionImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 20)];
    divisionImgView.image = [UIImage imageNamed:@"banyuanxian.png"];
    [_baseKetView addSubview:divisionImgView];
    
    CGRect suitLabelFrame = CGRectMake(padding, CGRectGetMaxY(divisionImgView.frame)+10, 300, 20);
    
    UILabel *suitLabel = [[UILabel alloc]initWithFrame:suitLabelFrame];
    suitLabel.text= @"适用商户";
    suitLabel.font = [UIFont systemFontOfSize:14.0f];
    [_baseKetView addSubview:suitLabel];
    
    CGRect merchantListViewFrame = CGRectMake(0, CGRectGetMaxY(suitLabelFrame)+10, SCREEN_WIDTH, 60);
    self.merchantListView = [[MerchantListView alloc]initWithMerchantListViewWithFrame:merchantListViewFrame];
    [_baseKetView addSubview:self.merchantListView];
    
    _horzLabel = [[UILabel alloc]initWithFrame:CGRectMake(padding, CGRectGetMaxY(merchantListViewFrame)+10, SCREEN_WIDTH-2*padding, 1)];
    _horzLabel.backgroundColor = [UIColor lightGrayColor];
    [_baseKetView addSubview:_horzLabel];
    
    CGRect checkBtnFrame = CGRectMake(padding, CGRectGetMaxY(_horzLabel.frame)+10, SCREEN_WIDTH-2*padding, 20);
    self.checkButton = [[UIButton alloc]initWithFrame:checkBtnFrame];
    UIImage *image =[UIImage imageNamed:@"zxy_arrow_right.png"];
    [self.checkButton setImage:image forState:UIControlStateNormal];
    [self.checkButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.checkButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    CGSize titleSize = [self sizeWithString:self.checkButton.titleLabel.text font:self.checkButton.titleLabel.font maxSize:CGSizeMake(SCREEN_WIDTH-2*padding-30, 20)];
    
    self.checkButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, SCREEN_WIDTH-titleSize.width-160);
    self.checkButton.imageEdgeInsets = UIEdgeInsetsMake(0, self.checkButton.frame.size.width - 10 - image.size.width, 0, (10 - titleSize.width));
    
    //    CGFloat titleRightInset = self.checkButton.frame.size.width - 10 - titleSize.width;
    //    if (titleRightInset<10-image.size.width) {
    //        titleRightInset=10-image.size.width;
    //    }
    //    self.checkButton.titleEdgeInsets = UIEdgeInsetsMake(0, (160- image.size.width), 0, titleRightInset);
    
    [_baseKetView addSubview:self.checkButton];
    [self addSubview:_baseKetView];
    
}

-(CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *dict = @{NSFontAttributeName : font};
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}


@end
