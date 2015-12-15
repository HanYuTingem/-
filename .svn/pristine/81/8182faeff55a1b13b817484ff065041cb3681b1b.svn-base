//
//  CJShoppingButtonView.m
//  MarketManage
//
//  Created by 赵春景 on 15-7-21.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CJShoppingButtonView.h"
#import "MarketAPI.h"
#import "GCRequest.h"
#import "JSBadgeView.h"

#define C8 [UIColor colorWithRed:37/255.0 green:37/255.0 blue:37/255.0 alpha:1]

@interface CJShoppingButtonView ()

{
    /** 小红点提示数字 */
    JSBadgeView *_badgeView;
}

/** GCRequest */
@property (nonatomic,strong)GCRequest * lsyMainRequest;

@end

@implementation CJShoppingButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        /**
         * 添加购物车按钮
         */
        [self makeButtonWithFrame:frame];
        
        /**
         * 加载购物车的数量网络请求
         */
        [self getCardNumData];
        
    }
    return self;
}
#pragma 添加购物车按钮
- (void)makeButtonWithFrame:(CGRect)frame
{
    _ShoppingButton                    = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_ShoppingButton];
//    [self.barCenterView addSubview:_ShoppingButton];
//    [_ShoppingButton setFrame:CGRectMake(SCREENWIDTH-64, 13, 64, 64)];
    [_ShoppingButton setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//    CGFloat spRatio = frame.size.width / 64;
    _ShoppingButton.imageEdgeInsets    = UIEdgeInsetsMake(0, 25 , 20, 0);
//    _ShoppingButton.titleEdgeInsets    = UIEdgeInsetsMake(15, -3, 0, 0);
    _ShoppingButton.titleLabel.font    = [UIFont systemFontOfSize:12];
    [_ShoppingButton setImage:[UIImage imageNamed:@"lyq_goodsinfo_shoppingcart_image"] forState:UIControlStateNormal];
//    [_ShoppingButton setTitle:@"购物车" forState:UIControlStateNormal];
    [_ShoppingButton setTitleColor:C8 forState:UIControlStateNormal];
    _ShoppingButton.contentHorizontalAlignment = NSTextAlignmentCenter;
//    [_ShoppingButton addTarget:self action:@selector(rightBackCliked:) forControlEvents:UIControlEventTouchUpInside];
    
    //购物车的小红点
    _badgeView = [[JSBadgeView alloc] initWithParentView:_ShoppingButton alignment:JSBadgeViewAlignmentCenterRight];
    _badgeView.userInteractionEnabled = NO;
}

#pragma make - 获取购物车的数量的接口的网络请求
/** 获取购物车的数量的接口*/
-(void)getCardNumData
{
//    [self startActivity];
    self.lsyMainRequest = [MarketAPI requestHomeCardNumPost113WithController:self];
    
}

/** 请求加在成功 */
-(void)GCRequest:(GCRequest *)aRequest Finished:(NSString *)aString
{
    //    isFirstdownload = NO;
    //    [self stopActivity];
    NSDictionary * dic = [aString JSONValue];
    if (!dic){
        NSLog(@"接口错误");
        return;
    }
    {
        if([[dic objectForKey:@"goodscart_nums"] integerValue] > 0){
            if([[dic objectForKey:@"goodscart_nums"] integerValue]>99){
                _badgeView.badgeText =  @"99+";
            }else{
                _badgeView.badgeText =  IfNullToString([dic objectForKey:@"goodscart_nums"]);
            }
        }else{
            _badgeView.badgeText=@"";
        }
        
    }
}

@end
