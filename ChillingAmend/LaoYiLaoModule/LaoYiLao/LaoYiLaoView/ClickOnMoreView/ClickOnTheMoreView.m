//
//  ClickOnTheMoreView.m
//  LaoYiLao
//
//  Created by wzh on 15/11/3.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "ClickOnTheMoreView.h"
#import "WebViewController.h"

@implementation ClickOnTheMoreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _moreBtn.backgroundColor = [UIColor blackColor];
        [_moreBtn setBackgroundImage:[UIImage imageNamed:@"lao_banner_bottom"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreBtn];
    }
    return self;
}

- (void)moreBtnClicked:(UIButton *)button{
    ZHLog(@"点击了查看更多");
    self.moreBtnBlock (button);
//    AppDelegate *app = ShareApp;
//    WebViewController *webView = [[WebViewController alloc]init];
//    [app.navi pushViewController:webView animated:YES];
}

@end
