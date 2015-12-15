//
//  JYViewController.m
//  dreamWorks
//
//  Created by dreamRen on 13-6-27.
//  Copyright (c) 2013年 dreamRen. All rights reserved.
//

#import "JYViewController.h"
#import "FXLabel.h"
#import "JPCommonMacros.h"

@interface JYViewController ()

@end

@implementation JYViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton=YES;
    
    UIButton *tButton=[UIButton buttonWithType:UIButtonTypeCustom];
    tButton.frame=CGRectMake(0, 0, 45, 30);
    [tButton setTitle:@"返回" forState:UIControlStateNormal];
    [tButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [tButton setBackgroundImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
    [tButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *tItem=[[UIBarButtonItem alloc] initWithCustomView:tButton];
    self.navigationItem.leftBarButtonItem = tItem;
    
    topTitleLabel=[[FXLabel alloc] initWithFrame:CGRectMake(0, 0, 190, 40)];
    topTitleLabel.backgroundColor=[UIColor clearColor];
    topTitleLabel.font=[UIFont boldSystemFontOfSize:22];
    topTitleLabel.textAlignment=NSTextAlignmentCenter;
    topTitleLabel.gradientStartColor = [UIColor whiteColor];
    topTitleLabel.gradientEndColor = [UIColor colorWithWhite:0.32 alpha:1.0];
    self.navigationItem.titleView=topTitleLabel;
    
    
    mainView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, kkViewHeight-44)];
    mainView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:mainView];
    [self.view sendSubviewToBack:mainView];
    
    UIImageView *tImageView=[[UIImageView alloc] initWithFrame:mainView.bounds];
    tImageView.image=[UIImage imageNamed:@"all_back.png"];
    [mainView addSubview:tImageView];
    [self.view sendSubviewToBack:tImageView];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showActivity
{
    tActView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    tActView.frame = CGRectMake((self.view.frame.size.width-20)/2, (self.view.frame.size.height-20)/2, 20, 20);
    [tActView startAnimating];
    [self.view addSubview:tActView];
}
-(void)hideActivity
{
    [tActView stopAnimating];
    [tActView removeFromSuperview];
    tActView = nil;
}


@end
