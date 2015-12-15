//
//  LSYImageDetailsViewController.m
//  MarketManage
//
//  Created by liangsiyuan on 15/1/22.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "LSYImageDetailsViewController.h"
#import "LSYImageDetails.h"
#import "UIBarButtonItem+IW.h"
@interface LSYImageDetailsViewController ()

@end

@implementation LSYImageDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mallTitleLabel.text = @"图文详情";
 
    LSYImageDetails * image=[[LSYImageDetails alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    image.dict=self.goodsInfoDic;
    image.dictChangShang=self.changShangInfoDic;
    [self.view addSubview:image];
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setChangShangInfoDic:(NSDictionary *)changShangInfoDic
{
    _changShangInfoDic = changShangInfoDic;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
