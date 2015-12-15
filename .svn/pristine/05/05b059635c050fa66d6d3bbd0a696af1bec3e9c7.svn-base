//
//  MerchantListView.m
//  QQList
//
//  Created by sunsu on 15/6/29.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "MerchantListView.h"

@implementation MerchantListView

+(instancetype)merchantListViewWithFrame:(CGRect)frame{
    return [[[self class]alloc]initWithMerchantListViewWithFrame:frame];
}

-(instancetype)initWithMerchantListViewWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    CGFloat padding = RECTFIX_WIDTH(10);

    CGFloat phoneBtnW = 50;
    CGFloat phoneBtnH = 50;
    CGFloat phoneBtnX = SCREEN_WIDTH - 2*padding - phoneBtnW;
    CGFloat phoneBtnY = 5;
    CGRect phoneBtnFrame = CGRectMake(phoneBtnX, phoneBtnY,phoneBtnW, phoneBtnH);
    self.merchantPhoneBtn =  [[UIButton alloc]initWithFrame:phoneBtnFrame];
    [self.merchantPhoneBtn setImage:[UIImage imageNamed:@"mycoupon_function_btn_phone_norma.png"] forState:UIControlStateNormal];
    [self addSubview:self.merchantPhoneBtn];
    
    CGFloat verLabelX = phoneBtnX - padding - 1;
    UILabel  *verLabel = [[UILabel alloc]initWithFrame:CGRectMake(verLabelX, 5, 1, 50)];
    verLabel.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:verLabel];
    
    
    CGFloat nameBtnW = SCREEN_WIDTH - padding - verLabelX;
    CGRect nameBtnFrame = CGRectMake(padding, 5, nameBtnW, 60);
    self.merchantNameBtn = [[UIButton alloc]initWithFrame:nameBtnFrame];
    self.merchantNameBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    self.merchantNameBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 40, SCREEN_WIDTH-self.merchantNameBtn.titleLabel.frame.size.width-verLabelX-140);
    self.merchantNameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.merchantNameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.merchantNameBtn];
    
    CGRect addressLabelFrame = CGRectMake(padding, 30, 220, 20);
    self.merchantAddressLabel = [[UILabel alloc]initWithFrame:addressLabelFrame];
    self.merchantAddressLabel.font = [UIFont systemFontOfSize:12.0f];
    self.merchantAddressLabel.numberOfLines = 0;
    self.merchantAddressLabel.textAlignment = NSTextAlignmentLeft;
    [self.merchantNameBtn addSubview:self.merchantAddressLabel];
}

@end
