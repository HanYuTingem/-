//
//  LSYImageDetails.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/22.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYImageDetails.h"
#import "MarketAPI.h"
#import "ZXYWarmingView.h"
#import "CJParameterModel.h"//属性规格 模型


@interface LSYImageDetails()<UIScrollViewDelegate, UIGestureRecognizerDelegate,UITableViewDelegate>{
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
/** 规格参数按钮 */
@property (weak, nonatomic) IBOutlet UIButton *changShangBtn;
/** 商品介绍按钮 */
@property (weak, nonatomic) IBOutlet UIButton *goodsBtn;
@property (weak, nonatomic) IBOutlet UIView *redView;

@end
@implementation LSYImageDetails

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"LSYImageDetails" owner:self options:nil][0];
        [self setFrame:frame];
        
        /** 添加属性规格页面 */
        [self makeParameterView];
        
        
        self.goodsBtn.selected = YES;
        
        self.webView.scrollView.delegate=self;
        // webview 左滑
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        swipeLeft.delegate = self;
        [self.webView addGestureRecognizer:swipeLeft];
        // webview 右滑
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        swipeRight.delegate = self;
//        [self.webView addGestureRecognizer:swipeRight];
        
        [self.parameterView addGestureRecognizer:swipeRight];
        
        
    }
    return self;
}


/**
 * 添加属性规格页面
 */
- (void)makeParameterView
{
    CJParameterTableView *parameterView = [[CJParameterTableView alloc] initWithFrame:CGRectMake(SCREENWIDTH, self.webView.frame.origin.y, SCREENWIDTH, CGRectGetHeight(self.webView.frame))];
    parameterView.tableView.delegate = self;
    [self addSubview:parameterView];
//    [parameterView bringSubviewToFront:self.webView];
    self.parameterView = parameterView;
}


#pragma webview 左滑
- (void)swipeLeft
{
    NSLog(@"swipeLeft");
    if (self.redView.frame.origin.x != SCREENWIDTH / 2) {
        [self changShangDidTap:nil];
    }
}

#pragma webview 右滑
- (void)swipeRight
{
    NSLog(@"swipeRight");
    if (self.redView.frame.origin.x != 0) {
        [self goodsDidTap:nil];
    }
}
/** 左滑动 和右侧按钮点击事件 */
- (IBAction)changShangDidTap:(id)sender
{
    self.goodsBtn.selected = NO;
    self.changShangBtn.selected = YES;
    if (_dictChangShang==nil) {
        [[ZXYWarmingView shareInstance]showMsg:@"暂时没有厂商介绍"];
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.redView setFrame:CGRectMake(SCREENWIDTH / 2, 40, SCREENWIDTH / 2, 2)];
        
        //改变参数规格页面的frame
        CGRect frame = self.parameterView.frame;
        frame.origin.x = 0;
        self.parameterView.frame = frame;
        
        CGRect frameWeb = self.webView.frame;
        frameWeb.origin.x = -SCREENWIDTH;
        self.webView.frame = frameWeb;
        
    }];
//    [self.webView loadHTMLString:[self.dictChangShang objectForKey:@"details"] baseURL:nil];
}
- (IBAction)goodsDidTap:(UIButton *)sender
{
    self.goodsBtn.selected = YES;
    self.changShangBtn.selected = NO;
    
    if (_dict==nil) {
        [[ZXYWarmingView shareInstance]showMsg:@"暂时没有商品介绍"];
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.redView setFrame:CGRectMake(0, 40, SCREENWIDTH / 2, 2)];
        
        //改变参数规格页面的frame
        CGRect frame = self.parameterView.frame;
        frame.origin.x = SCREENWIDTH;
        self.parameterView.frame = frame;
        
        CGRect frameWeb = self.webView.frame;
        frameWeb.origin.x = 0;
        self.webView.frame = frameWeb;
        
    }];
    
    [self.webView loadHTMLString: [self.dict objectForKey:@"details"] baseURL:nil];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if (scrollView.contentOffset.y<-100) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(backToTopView)]) {
            [self.delegate backToTopView];
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


-(void)setDict:(NSDictionary *)dict
{
    _dict=dict;
    [self.webView loadHTMLString: [_dict objectForKey:@"details"] baseURL:nil];
}

-(void)setDictChangShang:(NSDictionary *)dictChangShang
{
    _dictChangShang=dictChangShang;

    //parameterView数据刷新
    [self.parameterView setDataWithDataDict:dictChangShang];
}

- (void)setDictParameter:(NSDictionary *)dictParameter
{
    _dictParameter = dictParameter;
}

@end
