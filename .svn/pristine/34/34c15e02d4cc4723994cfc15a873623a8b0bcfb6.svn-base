//
//  CouponDetailScrollView.m
//  QQList
//
//  Created by sunsu on 15/6/29.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "CouponDetailScrollView.h"

@implementation CouponDetailScrollView
+ (instancetype)couponDetailViewWithFrame:(CGRect)frame{
    return [[[self class]alloc]initWithFrame:frame];
}
- (instancetype)initWithCouponDetailViewFrame:(CGRect)frame {
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
    [self.getMoneyButton setTitle:@"立即领取" forState:UIControlStateNormal];
    self.getMoneyButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:self.getMoneyButton];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(RECTFIX_WIDTH(10), CGRectGetMaxY(getBtnFrame)+10, 300, 20)];
    label.text = @"使用须知";
    label.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:label];
    
    
    
    CGFloat precautionsX = padding;
    CGFloat precautionsY = CGRectGetMaxY(label.frame)+10;
    CGFloat precautionsW = SCREEN_WIDTH - 2*padding;
    CGFloat precautionsH = 40;
    CGRect precautionsFrame = CGRectMake(precautionsX, precautionsY, precautionsW, precautionsH);

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
- (void)layoutSubviews{

    
}
-(CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *dict = @{NSFontAttributeName : font};
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}


@end
