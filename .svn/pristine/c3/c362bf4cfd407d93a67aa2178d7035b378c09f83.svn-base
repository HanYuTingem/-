//
//  CrazyBasisViewController.m
//  MarketManage
//
//  Created by fielx on 15/4/14.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "CrazyBasisViewController.h"

#define LOAD_FAILULE @"网络不给力..."

@implementation CrazyBasisViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CrazyPushTool Share];
    
    self.view.backgroundColor = [UIColor whiteColor];
        
    warmingView = [ZXYWarmingView shareInstance];
    loadView = [ZXYIndicatorView shareInstance];

    
    // 自定义导航栏的bar
    _barView = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    _barView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_barView];
    
    //左边的按钮
    _leftButton = [CrazyBasisButton buttonWithType:UIButtonTypeCustom];

    [_leftButton setFrame:CGRectMake(10, 20, 44, 44)];
    [_barView addSubview:_leftButton];
    [_leftButton crazyButtonSizeExpand:2];
    [_leftButton addTarget:self action:@selector(leftBackCliked:) forControlEvents:UIControlEventTouchUpInside];
    
    //左边的图片
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(15,31 , 10,20)];

    imageV.image = [UIImage imageNamed:@"title_btn_back"];
    [self.view addSubview:imageV];
    
    
    //右边的按钮
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];

    _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_rightButton setFrame:CGRectMake(SCREENWIDTH-59, 20, 44, 44)];
    _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_barView addSubview:_rightButton];
  //  _rightButton.backgroundColor= [UIColor blackColor];
    [_rightButton addTarget:self action:@selector(rightBackCliked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //标题
    _mallTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(54, 20,SCREENWIDTH-54*2, 44)];
    _mallTitleLabel.textAlignment = NSTextAlignmentCenter;
    [_barView addSubview:_mallTitleLabel];
    
    self.mRequsetArray = [NSMutableArray arrayWithCapacity:10];
    self.mInfoArray = [NSMutableArray arrayWithCapacity:10];
}



-(void)showMsg:(NSString *)content
{
    [warmingView showMsg:content];
}




//左边按钮
- (void)leftBackCliked:(UIButton*)sender
{
    for (ASIHTTPRequest *requset in self.mRequsetArray) {
        [requset clearDelegatesAndCancel];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


//页面即将显示的的时候
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadFailure) name:@"JIANCHAWANGLUO" object:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"JIANCHAWANGLUO" object:nil];
}


-(void)loadFailure
{
    [self showMsg:LOAD_FAILULE];
}

//右边按钮
- (void)rightBackCliked:(UIButton*)sender
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startActivity
{
    [loadView showIndicator];
}

-(void)stopActivity
{
    [loadView hideIndicator];
}

@end
