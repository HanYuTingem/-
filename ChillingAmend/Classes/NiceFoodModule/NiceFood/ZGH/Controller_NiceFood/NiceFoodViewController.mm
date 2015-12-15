//
//  NiceFoodViewController.m
//  PRJ_NiceFoodModule
//
//  Created by 张恭豪 on 15/6/15.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "NiceFoodViewController.h"
#import "BackButton.h"


@interface NiceFoodViewController ()

@end

@implementation NiceFoodViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [returnButton setImage:[UIImage imageNamed:@"msxq_0013_title_back"] forState:UIControlStateHighlighted];
    [returnButton setImage:[UIImage imageNamed:@"msxq_0013_title_back"] forState:UIControlStateNormal];
    
   
    self.seg.selectedSegmentIndex = 0;

    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.showData.count == 0) {
        [self chrysanthemumOpen];
       
    }
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadAnnotation" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"near" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"location" object:nil];

    [super viewWillDisappear:animated];
    
}

- (void)reloadList{

    BOOL reg = [self.cloudSearch nearbySearchWithSearchInfo:self.searchInfo];
    [self chrysanthemumWithBOOL:reg];
}

- (void)addAnimationView{
    
    self.animationView = [[UIView alloc] initWithFrame:CGRectMake(0, NavigationH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationH)];
    self.animationView.backgroundColor = [UIColor whiteColor];
    
}


- (void)dealloc{
    if (self.mapView) {
        self.mapView = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadAnnotation" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"near" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"location" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
