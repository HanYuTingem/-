//
//  MapViewController.m
//  MapForbaidu
//
//  Created by liujinhe on 15/7/17.
//  Copyright (c) 2015年 liujinhe. All rights reserved.
//

#import "MapViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "TraficStyleListViewController.h"
#define Version [[[UIDevice currentDevice] systemVersion] floatValue]
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define Screen_Width [UIScreen mainScreen].bounds.size.width




@interface MapViewController ()<BMKMapViewDelegate,CLLocationManagerDelegate,BMKLocationServiceDelegate>
{
    BMKMapView* _mapView;
    CLLocationCoordinate2D  _myLocation;
    BMKLocationService* _locService;
    NSInteger               _index;
}
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [returnButton setHidden:YES];

    titleButton.hidden = NO;
    [titleButton setTitle:@"商家地理位置" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self createMapView];
    
    [self createThreeTraficStyle];
    if ([CLLocationManager locationServicesEnabled])
    {
        NSLog(@"可以定位");
        
    }else
    {
        [self showMsg:@"定位没有开启请开启定位"];
        
        NSLog(@"不可以定位");
    }
    _locService = [[BMKLocationService alloc] init];
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    BMKCoordinateRegion region;
    region.center               = self.coor;
    region.span.latitudeDelta   = 0.001;
    region.span.longitudeDelta  = 0.001;
    [_mapView setRegion:region animated:YES];
    
    
}
-(void)createNav{
    UIButton*  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnBtn setFrame:CGRectMake(5, 5, 30, 30)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"msxq_0013_title_back"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnFontView) forControlEvents:UIControlEventTouchUpInside];
 //   UIBarButtonItem *returnItem = [[UIBarButtonItem alloc] initWithCustomView:returnBtn];
  UIView *tiView = [[UIView alloc] init];
    if (Version<7) {
       tiView.frame = CGRectMake(50, 0, 70, 44);
    }
    else
    {
      tiView.frame = CGRectMake(20, 20, 70, 44);
    }
    [tiView addSubview:returnBtn];
    [self.view addSubview:tiView];
    
 // self.navigationController.navigationBar.backgroundColor = [UIColor colorWithWhite:0 alpha:1.0];

}
- (void)returnFontView{
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)createMapView
{
  _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, -20, Screen_Width, Screen_Height-30)];
  _mapView.delegate = self;
  [mainView addSubview:_mapView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _index                  = 0;
    NSArray *array = [NSArray arrayWithArray:_mapView.annotations];
    if (array.count != 0)
    {
        [_mapView removeAnnotations:array];
    }
    [self createNav];
    [self addAnn:self.coor];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.navigationController.navigationBarHidden = YES;

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//   self.navigationController.navigationBarHidden = NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//加大头针
- (void)addAnn:(CLLocationCoordinate2D)coordinate
{
    
    BMKPointAnnotation *ann = [[BMKPointAnnotation alloc] init];
    ann.title               = self.shopName;
    ann.coordinate = coordinate;
    [_mapView addAnnotation:ann];
}

//定位授权的代理方法
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    NSLog(@"%d",status);
    
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSString *mapId = @"my map id";
    BMKAnnotationView *annView = [mapView dequeueReusableAnnotationViewWithIdentifier:mapId];
    if (annView == nil)
    {
        annView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:mapId];
        ((BMKPinAnnotationView *)annView).animatesDrop = YES;
        ((BMKPinAnnotationView*)annView).pinColor = BMKPinAnnotationColorPurple;
    }
    annView.image       = [UIImage imageNamed:@"map_0000_dk"];

    //定制泡泡
    UIImageView *paopao = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    paopao.tag          = 2001+_index;
    paopao.image        = [UIImage imageNamed:@"map_0002_qipao"];
    

    UILabel *nameLabel     = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 180, 30)];
    nameLabel.font         = [UIFont systemFontOfSize:15];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.adjustsFontSizeToFitWidth = YES;
    nameLabel.text         = _address;
    

    [paopao addSubview:nameLabel];

    
    annView.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:paopao];
    annView.paopaoView.tag = 2001+_index;
    annView.selected = YES;

    return annView;
}


//地图大头针点击的代理方法
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    view.image = [UIImage imageNamed:@"map_0000_dk"];
}


//- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
//{
//    NSLog(@"datouzhen");
//    NSString *mapId = @"my map id";
//    BMKAnnotationView *annView = [mapView dequeueReusableAnnotationViewWithIdentifier:mapId];
////    if (annView == nil)
////    {
//        annView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:mapId];
//        ((BMKPinAnnotationView *)annView).animatesDrop = YES;
//        ((BMKPinAnnotationView*)annView).pinColor = BMKPinAnnotationColorPurple;
// //   }
//    annView.image       = [UIImage imageNamed:@"map_locate_red@2x"];
//    
//    
//    return annView;
//}
/*************************定位**************************/
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}
/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"地图定位");
    if (_index == 0)
    {
        _myLocation = userLocation.location.coordinate;
    }
    _index++;
    if (_index != 0) {
        [_locService stopUserLocationService];
        _mapView.showsUserLocation = NO;
    }
}
/**
*在地图View停止定位后，会调用此函数
*@param mapView 地图View
*/
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"======================");
    NSLog(@"location error");
    NSLog(@"======================");
}
/*************************定位**************************/
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

#pragma mark - 创建三种交通方式

- (void)createThreeTraficStyle
{
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height-50, Screen_Width, 50)];
    buttomView.backgroundColor = [UIColor whiteColor];
    
    NSArray *imageArray = @[@"map_action_icon_bus@2x",@"map_action_icon_car@2x",@"map_action_icon_walk@2x"];
    NSArray *titleArr   = @[@"公交",@"驾车",@"步行"];
    
    for (int i = 0; i < 3; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame     = CGRectMake(i*(Screen_Width-90)/2+30, 5, 30, 30);
        button.tag       = 1101+i;
        button.showsTouchWhenHighlighted = YES;
        [button setBackgroundImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        
        [button addTarget:self
                   action:@selector(tranficBtnClick:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [buttomView addSubview:button];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*(Screen_Width-90)/2+30, 35, 30, 15)];
        label.text     = titleArr[i];
        label.font     = [UIFont systemFontOfSize:14];
        [buttomView addSubview:label];
        
    }
    
    [self.view  addSubview:buttomView];
}
- (void)tranficBtnClick:(UIButton *)button
{
    if (_myLocation.latitude == 0)
    {
        NSLog(@"没有获取到位置");
        [self showMsg:@"没有获取到位置"];
        
    }
    TraficStyleListViewController *traficList = [[TraficStyleListViewController alloc] init];
    traficList.myLocation = _myLocation;
    traficList.shopLocation = self.coor;
    traficList.shopName = self.shopName;
    if (button.tag == 1101)                          //公交
    {
        
        traficList.style        = traficStyleBus;
        
        
    }else if (button.tag == 1102)                    //驾车
    {
        traficList.style        = traficStyleCar;
        
    }else if (button.tag == 1103)                    //步行
    {
        
        traficList.style        = traficStyleWalk;
    }
   
    [self.navigationController pushViewController:traficList animated:YES];
}

@end
