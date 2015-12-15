//
//  TraficStyleListViewController.h
//  MapForbaidu
//
//  Created by liujinhe on 15/7/20.
//  Copyright (c) 2015年 liujinhe. All rights reserved.
//

/**
 * 要去的地方
 */

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import "BaseController.h"
@interface TraficStyleListViewController : BaseController
@property (nonatomic,assign) CLLocationCoordinate2D myLocation;
@property (nonatomic,assign) CLLocationCoordinate2D shopLocation;

//  交通工具
@property (nonatomic,assign) traficStyle style;
//  选中状态图片
@property (weak, nonatomic) IBOutlet UIImageView *btnStatusBg;

//  商户位置
@property (weak, nonatomic) IBOutlet UIView *shopView;
//  自己位置
@property (weak, nonatomic) IBOutlet UIView *myView;

//  商户名Label
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
//目的
@property (weak, nonatomic) IBOutlet UIImageView *owdImageView;
//  公交按钮
@property (weak, nonatomic) IBOutlet UIButton *busBtn;
//我的
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
//我的位置
@property (weak, nonatomic) IBOutlet UILabel *myLable;
//  驾车
@property (weak, nonatomic) IBOutlet UIButton *carBtn;
//  步行
@property (weak, nonatomic) IBOutlet UIButton *walkBtn;
//  商户名
@property (copy, nonatomic) NSString *shopName;

//  调换位置按钮
- (IBAction)translateBtn:(id)sender;
//  貌似无用
//@property (nonatomic, strong) NSArray *array;
@end
