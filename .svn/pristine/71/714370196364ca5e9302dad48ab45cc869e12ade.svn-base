//
//  TraficStyleListViewController.m
//  MapForbaidu
//
//  Created by liujinhe on 15/7/20.
//  Copyright (c) 2015年 liujinhe. All rights reserved.
//

#import "TraficStyleListViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "RouteModel.h"
#import "MyTraficCellCell.h"
#import "RouteViewController.h"

#define LONGITUDE [[NSUserDefaults standardUserDefaults] floatForKey:@"longitude"]
#define LATITUDE  [[NSUserDefaults standardUserDefaults] floatForKey:@"latitude"]
#define Version [[[UIDevice currentDevice] systemVersion] floatValue]
#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define Screen_Width [UIScreen mainScreen].bounds.size.width

@interface TraficStyleListViewController ()<UITableViewDataSource,UITableViewDelegate,BMKRouteSearchDelegate>
{
    UITableView        * _tableView;
    NSMutableArray     * _dataArray;
    NSMutableArray     * _streetArray;
    BMKRouteSearch     * _routesearch;
    NSInteger            _streetIndex;
    BOOL                 _busIsSelected;
    BOOL                 _carIsSelected;
    BOOL                 _walkIsSelected;
    BOOL                 _turnSelected;
}


@end

@implementation TraficStyleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //适配ios7
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
//    {
//        //        self.edgesForExtendedLayout=UIRectEdgeNone;
//        self.navigationController.navigationBar.translucent = NO;
//    }
    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    self.shopView.backgroundColor = [UIColor clearColor];
    self.myView.backgroundColor   = [UIColor clearColor];
    [self.view sendSubviewToBack:self.btnStatusBg];
    _dataArray   = [[NSMutableArray alloc] init];
    _streetArray = [[NSMutableArray alloc] init];
    _streetIndex = 0;
    _routesearch = [[BMKRouteSearch alloc]init];
    _routesearch.delegate = self;
//    CLLocationCoordinate2D coor ;
//    coor.latitude= LATITUDE;
//    coor.longitude = LONGITUDE;
//    self.myLocation = coor;
    _turnSelected = YES;
    [self addReturnBtn];
    [self setTranficStyle];
    
    [self getTranficBtnSelectedStatus];
    
    self.shopNameLabel.text = self.shopName;
    
//    [self.navigationController setNavigationBarHidden:YES];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_routesearch.delegate == nil)
    {
        _routesearch.delegate = self;
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _routesearch.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    if (_routesearch != nil) {
        _routesearch = nil;
    }
   
}
- (void)addReturnBtn{
#pragma mark-导航栏添加返回按钮
    UIButton*  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnBtn setFrame:CGRectMake(5, 5, 30, 30)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"msxq_0013_title_back"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnFontView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *returnItem = [[UIBarButtonItem alloc] initWithCustomView:returnBtn];
    self.navigationItem.leftBarButtonItem = returnItem;
    UIView *view = [[UIView alloc]init];
    if (Version<7) {
        view.frame = CGRectMake(50, 0, 70, 44);
    }
    else
    {
        view.frame = CGRectMake(50, 20, 70, 44);
    }
    
    view.backgroundColor =[UIColor clearColor];
    [backView addSubview:view];

}
-(void)returnFontView{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setTranficStyle{
    [self.busBtn addTarget:self
                    action:@selector(transficBtn:)
          forControlEvents:UIControlEventTouchUpInside];
    
    [self.carBtn addTarget:self
                    action:@selector(transficBtn:)
          forControlEvents:UIControlEventTouchUpInside];
    
    [self.walkBtn addTarget:self
                     action:@selector(transficBtn:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self.busBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.carBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.walkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}
- (void)transficBtn:(UIButton *)button
{
    
    [self removeTableView];
    _streetIndex = 0;
    [_streetArray removeAllObjects];
    if (button == self.busBtn)
    {
        self.btnStatusBg.image = [UIImage imageNamed:@"map_0002_bgleft"];
        _busIsSelected = YES;
        _carIsSelected = NO;
        _walkIsSelected = NO;
        self.style              = traficStyleBus;
        
        [_dataArray removeAllObjects];
        BMKPlanNode* start = [[BMKPlanNode alloc]init] ;
        start.pt = self.myLocation;
        BMKPlanNode* end = [[BMKPlanNode alloc]init] ;
        end.pt = self.shopLocation;
        
        BMKTransitRoutePlanOption *transitRouteSearchOption = [[BMKTransitRoutePlanOption alloc]init];
        transitRouteSearchOption.city= @"北京市";
        transitRouteSearchOption.from = start;
        transitRouteSearchOption.to = end;
        
        [self showStartHud1];
        BOOL flag = [_routesearch transitSearch:transitRouteSearchOption];
        
        if(flag)
        {
            NSLog(@"bus检索发送成功");
        }
        else
        {
            NSLog(@"bus检索发送失败");
            [self stopHud:@"公交检索失败"];
        }
        
        
    }else if (button == self.carBtn)
    {
        self.btnStatusBg.image = [UIImage imageNamed:@"map_0000_bgcenter"];
        _carIsSelected = YES;
        _busIsSelected = NO;
        _walkIsSelected = NO;
        self.style              = traficStyleCar;
        [_dataArray removeAllObjects];
        BMKPlanNode* start = [[BMKPlanNode alloc]init] ;
        start.pt = self.myLocation;
        start.cityName = @"北京市";
        BMKPlanNode* end = [[BMKPlanNode alloc]init] ;
        end.pt = self.shopLocation;
        end.cityName = @"北京市";
        BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
        drivingRouteSearchOption.from = start;
        drivingRouteSearchOption.to = end;
        
        [self showStartHud1];
        BOOL flag = [_routesearch drivingSearch:drivingRouteSearchOption];
        if(flag)
        {
            NSLog(@"car检索发送成功");
        }
        else
        {
            NSLog(@"car检索发送失败");
            [self stopHud:@"驾车检索失败"];
        }
    }else
    {
        self.btnStatusBg.image = [UIImage imageNamed:@"map_0002_bgright"];
        _walkIsSelected = YES;
        _busIsSelected = NO;
        _carIsSelected = NO;
        self.style              = traficStyleWalk;
        
        [_dataArray removeAllObjects];
        BMKPlanNode* start = [[BMKPlanNode alloc]init] ;
        start.pt = self.myLocation;
        start.cityName = @"北京市";
        BMKPlanNode* end = [[BMKPlanNode alloc]init] ;
        end.pt = self.shopLocation;
        end.cityName = @"北京市";
        BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc]init];
        walkingRouteSearchOption.from = start;
        walkingRouteSearchOption.to = end;
        
        BOOL flag = [_routesearch walkingSearch:walkingRouteSearchOption];
       [self showStartHud1];
        if(flag)
        {
            NSLog(@"walk检索发送成功");
        }
        else
        {
            NSLog(@"walk检索发送失败");
            [self stopHud:@"步行检索失败"];
        }
    }

    [self setBtnTitleColor];
    
}
- (void)setBtnTitleColor
{
    if (_busIsSelected)
    {
        [self.busBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.carBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.walkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if (_carIsSelected)
    {
        [self.carBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.walkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.busBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    if (_walkIsSelected)
    {
        [self.walkBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.carBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.busBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
- (NSString*)getMyBundlePath1:(NSString *)filename
{
    
    NSBundle * libBundle = MYBUNDLE;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}
- (NSInteger )myObtainWalkMeterTool:(NSString *)string;
{
    NSArray *array = [string componentsSeparatedByString:@"步行"];
    if (array.count == 2)
    {
        NSString *str1 = array[1];
        
        NSArray *arr   = [str1 componentsSeparatedByString:@"米"];
        NSString *strNum = arr[0];
        for (int i = 0; i < strNum.length; i++)
        {
            char ch = (char)[strNum characterAtIndex:i];
            if (!(ch >= '0' && ch <= '9'))
            {
                NSLog(@"-1");
                return -1;
            }
        }
        return [strNum integerValue];
    }else
    {
        return -1;
    }
    
}

- (void)removeTableView
{
    if (_tableView != nil)
    {
        [_tableView removeFromSuperview];
        _tableView.delegate = nil;
        _tableView.dataSource = nil;
        _tableView = nil;
    }
}
- (void)getTranficBtnSelectedStatus{
    if (self.style == traficStyleBus)
    {
        //self.busBtn.selected = YES;
        _busIsSelected = YES;
        self.btnStatusBg.image = [UIImage imageNamed:@"map_0002_bgleft"];
        [self transficBtn:self.busBtn];
        
    }else if (self.style == traficStyleCar)
    {
        //self.carBtn.selected = YES;
        _carIsSelected = YES;
        self.btnStatusBg.image = [UIImage imageNamed:@"map_0000_bgcenter"];
        [self transficBtn:self.carBtn];
        
    }else
    {
        //self.walkBtn.selected = YES;
        _walkIsSelected = YES;
        self.btnStatusBg.image = [UIImage imageNamed:@"map_0002_bgright"];
        [self transficBtn:self.walkBtn];
    }
    
    
}

#pragma mark - 商家位置和我的位置的转换按钮的响应事件
- (IBAction)translateBtn:(id)sender{
    UIButton *button = (UIButton *)sender;
    if (!button.selected)
    {
        [UIView animateWithDuration:0.5 animations:^{
            button.transform = CGAffineTransformMakeRotation(M_PI);
            
            
        }];
    }else
    {
        [UIView animateWithDuration:0.5 animations:^{
            button.transform = CGAffineTransformMakeRotation(0);
        }];
    }
    button.selected = !button.selected;
    CLLocationCoordinate2D coor = self.shopLocation;
    self.shopLocation = self.myLocation;
    self.myLocation = coor;
//    CGRect frame = self.shopView.frame;
//    NSLog(@"%@",NSStringFromCGRect (frame));
//    self.shopView.frame = self.myView.frame;
//    NSLog(@"%@",NSStringFromCGRect(self.shopView.frame));
//    self.myView.frame = frame;
//    NSLog(@"%@",NSStringFromCGRect(self.myView.frame));
    
//    [UIView animateWithDuration: 0.5 animations:^{
//       
//       CGRect frame = self.shopView.frame;
//        self.shopView.frame = self.myView.frame;
//        self.myView.frame = frame;
//    }];
    if (_turnSelected ==YES) {
        _myLable.text = _shopName;
        _shopNameLabel.text = @"我的位置";
        _myImageView.image = [UIImage imageNamed:@"map_0003_ty.png"];
        _owdImageView.image = [UIImage imageNamed:@"map_0005_bqa.png"];
        _turnSelected = NO;
    }else{
        _myLable.text =  @"我的位置";
        _shopNameLabel.text =_shopName;
        _myImageView.image = [UIImage imageNamed:@"map_0005_bqa.png"];
        _owdImageView.image = [UIImage imageNamed:@"map_0003_ty.png"];
        _turnSelected = YES;
    }
    
    if (_busIsSelected)
    {
        [self transficBtn:self.busBtn];
    }
    else if (_carIsSelected)
    {
        [self transficBtn:self.carBtn];
    }else if (_walkIsSelected)
    {
        [self transficBtn:self.walkBtn];
    }

}

- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    
    
    NSLog(@"几种方案%lu",(unsigned long)result.routes.count);
    
    for (int i = 0; i < result.routes.count; i++) {
        RouteModel *model = [[RouteModel alloc] init];
        BMKTransitRouteLine *plan = (BMKTransitRouteLine *)result.routes[i];
        NSInteger allMinute = plan.duration.hours * 60+plan.duration.minutes;
        model.minute    = [NSString stringWithFormat:@"%ld分钟",(long)allMinute];
        model.distance  = [NSString stringWithFormat:@"%d",plan.distance];
        NSMutableString *mutableString = [[NSMutableString alloc] init];
        
        for (int j = 0; j < plan.steps.count; j++) {
            BMKTransitStep *transitStep = [plan.steps objectAtIndex:j];
            NSLog(@"路段%@++++++++++",transitStep.instruction);
            [self carAndWalkObtainRoadTool:transitStep.instruction];
            
            
        }
        NSLog(@"%lu",(unsigned long)_streetArray.count);
        NSInteger num ;
        if (_streetArray.count >= 3)
        {
            num = 3;
        }else
        {
            num = _streetArray.count;
        }
        
        if (num == 0)
        {
 //           return;
        }
        
        for (int n = 0; n < num; n++)
        {
            NSString *str = _streetArray[n];
            NSLog(@"str:%@",str);
            NSRange range = [str rangeOfString:@">"];
            if (range.location != NSNotFound)
            {
                [ mutableString appendFormat:@"%@ ",[str substringFromIndex:1] ];
            }
        }
        model.title = mutableString;
        [_dataArray addObject:model];
        
    }
    if (_dataArray.count == 0)
    {
        NSLog(@"无驾车方案");
        [self stopHud:@"无驾车方案"];
    }else
    {
        [self stopHud:nil];
    }
    [self createTableView];
    
}


- (void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSLog(@"几种方案%lu",(unsigned long)result.routes.count);
    [self stopHud:nil];
    if (result.routes.count == 0)
    {
       [self showMsg:@"无步行方案"];
        return;
    }
    
    
    for (int i = 0; i < result.routes.count; i++) {
        BMKTransitRouteLine *plan = (BMKTransitRouteLine *)result.routes[i];
        RouteModel *model = [[RouteModel alloc] init];
        
        NSInteger allMinute = plan.duration.hours * 60+plan.duration.minutes;
        model.minute    = [NSString stringWithFormat:@"%ld分钟",(long)allMinute];
        model.distance  = [NSString stringWithFormat:@"%d",plan.distance];
        NSMutableString *mutableString = [[NSMutableString alloc] init];
        for (int j = 0; j < plan.steps.count; j++)
        {
            BMKTransitStep *transitStep = [plan.steps objectAtIndex:j];
            
            [self carAndWalkObtainRoadTool:transitStep.instruction];
            
        }
        NSInteger num;
        if (_streetArray.count >= 3)
        {
            num = 3;
        }else
        {
            num = _streetArray.count;
        }
        
        for (int n = 0; n < num; n++)
        {
            NSString *str = _streetArray[n];
            NSLog(@"str:%@",str);
            NSRange range = [str rangeOfString:@">"];
            if (range.location != NSNotFound)
            {
                [ mutableString appendFormat:@"%@ ",[str substringFromIndex:1] ];
            }
        }
        NSLog(@"%@",mutableString);
        model.title = mutableString;
        [_dataArray addObject:model];
    }
    [self createTableView];
}


- (NSString *)carAndWalkObtainRoadTool:(NSString *)str
{
    NSArray *array1 = [str componentsSeparatedByString:@","];
    
    NSLog(@"%lu",(unsigned long)array1.count);
    
    for (NSString *str1 in array1)
    {
        NSLog(@"str1:%@",str1);
        NSRange range1 = [str1 rangeOfString:@">"];
        NSRange range2 = [str1 rangeOfString:@"</b>"];
        
        NSLog(@"range1.location:%lu",(unsigned long)range1.location);
        NSLog(@"rnage2.location:%lu",(unsigned long)range2.location);
        
        if ((range1.location != NSNotFound) && (range2.location != NSNotFound))
        {
            NSString *str2 = [str1 substringWithRange:NSMakeRange(range1.location,range2.location-range1.location)];
            
            
            NSRange range3 = [str2 rangeOfString:@"路"];
            NSRange range4 = [str2 rangeOfString:@"街"];
            
            if ((range3.location != NSNotFound) || (range4.location != NSNotFound))
            {
                if (![_streetArray containsObject:str2])
                {
                    [_streetArray addObject:str2];
                }
                
                return str2;
            }
            
        }else
        {
            return @"NO";
        }
        
        
        
    }
    return @"NO";
}


- (void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:(BMKTransitRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
     [self stopHud:nil];
    NSLog(@"几种方案%lu",(unsigned long)result.routes.count);
    if (result.routes.count == 0)
    {
            [self showMsg:@"无公交方案"];
        NSLog(@"wu");
        return;
    }
    
//    我自己添加的
    for (int i = 0; i < result.routes.count; i++) {
        BMKTransitRouteLine *plan = (BMKTransitRouteLine *)result.routes[i];
        RouteModel *model = [[RouteModel alloc] init];
        NSInteger allMinute = plan.duration.hours * 60+plan.duration.minutes;
        model.minute        = [NSString stringWithFormat:@"%ld分钟",(long)allMinute];
        NSMutableString *mutableString = [[NSMutableString alloc] init];
        
        NSInteger walkDistance = 0;
        for (int j = 0; j < plan.steps.count; j++) {
            BMKTransitStep *transitStep = [plan.steps objectAtIndex:j];
            if (transitStep.stepType != BMK_WAKLING)
            {
                [mutableString appendFormat:@"%@  ",transitStep.vehicleInfo.title];
            }
            NSLog(@"%@",transitStep.instruction);
            NSInteger myNum = [self myObtainWalkMeterTool:transitStep.instruction];
            if (myNum != -1)
            {
                walkDistance += myNum;
            }
            model.title = mutableString;
        }
        model.distance = [NSString stringWithFormat:@"步行%ld米",(long)walkDistance];
        [_dataArray addObject:model];
    }
    
   [self createTableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (void)createTableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 242, Screen_Width, 60*_dataArray.count) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [mainView addSubview:_tableView];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = nil;
    cellID = @"MyTraficCellCell";
    MyTraficCellCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
       cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTraficCellCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    RouteModel *model = _dataArray[indexPath.row];
    cell.roadNameLabel.text = model.title;
    cell.minuteLabel.text   = model.minute;
    
    
    if (_busIsSelected)
    {
        cell.minuteImage.image = [UIImage imageNamed:@"map_icon_time@2x"];
        cell.meterImage.image  = [UIImage imageNamed:@"map_icon_walk@2x"];
        cell.distanceLabel.text = model.distance;
    }
    
    if(_carIsSelected)
    {
        cell.minuteImage.image = [UIImage imageNamed:@"map_action_icon_car@2x"];
        cell.meterImage.image  = [UIImage imageNamed:@"map_icon_km@3x"];
        
        float dis = [model.distance floatValue];
        if (dis < 1000)
        {
            cell.distanceLabel.text = [NSString stringWithFormat:@"%d米",(int)dis];
        }
        
        if (dis >= 1000)
        {
            cell.distanceLabel.text = [NSString stringWithFormat:@"%.1f公里",dis/1000.0];
        }
    }
    
    if (_walkIsSelected)
    {
        cell.minuteImage.image = [UIImage imageNamed:@"map_icon_walk@2x"];
        cell.meterImage.image  = [UIImage imageNamed:@"map_icon_walk@2x"];
        float dis = [model.distance floatValue];
        if (dis < 1000)
        {
            cell.distanceLabel.text = [NSString stringWithFormat:@"%d米",(int)dis];
        }
        
        if (dis >= 1000)
        {
            cell.distanceLabel.text = [NSString stringWithFormat:@"%.1f公里",dis/1000.0];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RouteViewController *route = [[RouteViewController alloc] init];
    
    route.startLocation        = self.myLocation;
    route.stopLocation         = self.shopLocation;
    route.traficStyle          = self.style;
    route.kindOfScheme         = indexPath.row;
    route.navTitle             = [_dataArray[indexPath.row] title];
    
    [self.navigationController pushViewController:route animated:YES];
}

@end
