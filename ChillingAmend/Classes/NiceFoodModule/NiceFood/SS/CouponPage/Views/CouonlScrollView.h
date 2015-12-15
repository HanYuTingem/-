//
//  CouonlScrollView.h
//  MyNiceFood
//
//  Created by liujinhe on 15/7/28.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MerchantListView.h"
@interface CouonlScrollView : UIScrollView
@property (strong, nonatomic)  UIImageView *erweimaImageView;//二维码图片
@property (strong, nonatomic)  UILabel *shopNameLabel;//商家名
@property (strong, nonatomic)  UIButton *getMoneyButton;//分享
@property (strong, nonatomic)  UILabel *precautionsLabel;//使用须知
@property (strong, nonatomic)  UILabel *applicableShopName;//适用店名

@property (strong, nonatomic)  UILabel *shopAddressLabel;//地址
@property (strong, nonatomic)  UILabel *allShopLabel;//所有分店
@property (strong, nonatomic)  MerchantListView *merchantListView;//须知下面的
@property (strong, nonatomic)  UIButton *checkButton;//查看按钮
//@property (strong, nonatomic)  UIImageView *rightImageView;//向右箭头
@property (strong, nonatomic) UILabel   *useLabel;
@property (strong, nonatomic) UILabel   *bianLabel;
@property (strong, nonatomic) UIView    *baseKetView;
@property (strong, nonatomic) UILabel   *textLabel;
@property (strong, nonatomic) UILabel   *horzLabel;
@property (strong, nonatomic) UIWebView * detailWebview;
+ (instancetype)couponDetailViewWithFrame:(CGRect)frame;
- (instancetype)initWithCouponDetailViewFrame:(CGRect)frame;@end
