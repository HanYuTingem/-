//
//  RouteViewController.m
//  HCheap
//
//  Created by dairuiquan on 14-12-12.
//  Copyright (c) 2014年 qiaohongchao. All rights reserved.
//

#import "RouteViewController.h"
#import "RouteListView.h"


#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Version [[[UIDevice currentDevice] systemVersion] floatValue]
#define MidView_Hight_old [UIScreen mainScreen].bounds.size.height-100
#define MidView_Hight_new 130

@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
    int _degree;
    
}
@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end




@interface UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;

@end
@implementation UIImage(InternalMethod)
- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
    
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    CGSize rotatedSize;
    
    rotatedSize.width = width;
    rotatedSize.height = height;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    CGContextRotateCTM(bitmap, degrees * M_PI / 180);
    CGContextRotateCTM(bitmap, M_PI);
    CGContextScaleCTM(bitmap, -1.0, 1.0);
    CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end


@interface RouteViewController ()<BMKMapViewDelegate,BMKRouteSearchDelegate,RouteListViewDelegate>
{
    BMKMapView          *_mapView;
    BMKRouteSearch      *_routeSearch;
    NSMutableArray      *_dataArray;
    RouteListView       *_listView;
    
    
    BOOL                 _tapFlag;
    BOOL                 _panFlag;
    
    CGPoint              _startPoint;
    CGPoint              _stratOriginPoint;
}

@end

@implementation RouteViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    titleButton.hidden = NO;
    [titleButton setTitle:@"到这里去" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UILabel *titleLabel       = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    titleLabel.text           = self.navTitle;
    titleLabel.textAlignment  = NSTextAlignmentCenter;
    titleLabel.font           = [UIFont systemFontOfSize:15];
    self.navigationItem.titleView = titleLabel;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _routeSearch = [[BMKRouteSearch alloc] init];
    _dataArray   = [[NSMutableArray alloc] init];
    
    
    
    [self addReturnBtn];
    [self createMapView];
    
//    backView.hidden = NO;
//    titleButton.hidden = NO;
//    [titleButton setTitle:@"到这里去" forState:UIControlStateNormal];
//    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    // Do any additional setup after loading the view.
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
    [self.navigationController.view addSubview:view];
    
}
- (void)returnFontView{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _routeSearch.delegate = self;
    [self traficStyleSelected:self.traficStyle];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _routeSearch.delegate = nil;
}

#pragma mark - 创建地图

- (void)createMapView
{
    if (_mapView == nil)
    {
        _mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
        BMKCoordinateRegion region;
        region.center               = self.startLocation;
        region.span.latitudeDelta   = 0.05;
        region.span.longitudeDelta  = 0.05;
        [_mapView setRegion:region animated:NO];
        [mainView addSubview:_mapView];
    }
}

- (void)traficStyleSelected:(NSInteger)style{
    [_dataArray removeAllObjects];
    switch (style) {
        case 0://bus
        {
            [_dataArray removeAllObjects];
            BMKPlanNode* start = [[BMKPlanNode alloc]init] ;
           
            start.pt = self.startLocation;
            
            
            BMKPlanNode* end = [[BMKPlanNode alloc]init] ;
            end.pt = self.stopLocation;
            
            BMKTransitRoutePlanOption *transitRouteSearchOption = [[BMKTransitRoutePlanOption alloc]init];
            transitRouteSearchOption.city= @"北京市";
            transitRouteSearchOption.from = start;
            transitRouteSearchOption.to = end;
            BOOL flag = [_routeSearch transitSearch:transitRouteSearchOption];
            
            if(flag)
            {
                NSLog(@"bus检索发送成功");
            }
            else
            {
                NSLog(@"bus检索发送失败");
            }
        }
            break;
        case 1://car
        {
            [_dataArray removeAllObjects];
            BMKPlanNode* start = [[BMKPlanNode alloc]init] ;
            
            start.pt = self.startLocation;
            start.cityName = @"北京市";
            BMKPlanNode* end = [[BMKPlanNode alloc]init] ;
            end.pt = self.stopLocation;
            end.cityName = @"北京市";
            
            BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
            drivingRouteSearchOption.from = start;
            drivingRouteSearchOption.to = end;
            BOOL flag = [_routeSearch drivingSearch:drivingRouteSearchOption];
            if(flag)
            {
                NSLog(@"car检索发送成功");
            }
            else
            {
                NSLog(@"car检索发送失败");
            }
        }
            break;
        case 2://walk
        {
            [_dataArray removeAllObjects];
            
            BMKPlanNode* start = [[BMKPlanNode alloc]init] ;
            start.pt = self.startLocation;
            start.cityName = @"北京市";
            BMKPlanNode* end = [[BMKPlanNode alloc]init] ;
            end.pt = self.stopLocation;
            end.cityName = @"北京市";
            
            
            BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc]init];
            walkingRouteSearchOption.from = start;
            walkingRouteSearchOption.to = end;
            BOOL flag = [_routeSearch walkingSearch:walkingRouteSearchOption];
            if(flag)
            {
                NSLog(@"walk检索发送成功");
            }
            else
            {
                NSLog(@"walk检索发送失败");
            }
        }
            break;
        default:
            break;
    }
}

- (NSString*)getMyBundlePath1:(NSString *)filename
{
    
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}

- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
    BMKAnnotationView* view = nil;
    switch (routeAnnotation.type) {
        case 0:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"] ;
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 1:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"] ;
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 2:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"] ;
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 3:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 4:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"] ;
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
            
        }
            break;
        case 5:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"] ;
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
        }
            break;
        default:
            break;
    }
    
    return view;
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
    }
    return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay] ;
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}

- (void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:(BMKTransitRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    //NSLog(@"bus总共耗时===================%f分钟", result.taxiInfo.duration/60.0);
    
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    
    
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKTransitRouteLine* plan = (BMKTransitRouteLine*)[result.routes objectAtIndex:self.kindOfScheme];
     
        for (int j = 0; j < plan.steps.count; j++)
        {
            BMKTransitStep *transitStep = [plan.steps objectAtIndex:j];
            [_dataArray addObject:transitStep.instruction];
            
            NSLog(@"路段%@",transitStep.instruction);
            
        }
        if (_dataArray.count != 0)
        {
            [self createTableView];
        }
        
        // 计算路线方案中的路段数目
        int size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                ;
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
                ;
            }
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.instruction;
            item.type = 3;
            [_mapView addAnnotation:item];
            ;
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        //delete []temppoints;
    }
    
}
- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    
    
//    BMKTransitRouteLine *plan = (BMKTransitRouteLine *)result.routes[self.kindOfScheme];
//    for (int j = 0; j < plan.steps.count; j++) {
//        BMKTransitStep *transitStep = [plan.steps objectAtIndex:j];
//        //[array addObject:transitStep.instruction];
//            
//        // NSLog(@"路段%@",transitStep.instruction);
//            
//    }
//    [_dataArray addObject:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:self.kindOfScheme];
        
        
        for (int j = 0; j < plan.steps.count; j++)
        {
            BMKTransitStep *transitStep = [plan.steps objectAtIndex:j];
            [_dataArray addObject:transitStep.instruction];
            
            NSLog(@"路段%@",transitStep.instruction);
            
        }
        if (_dataArray.count != 0)
        {
            [self createTableView];
        }
        
        // 计算路线方案中的路段数目
        int size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                ;
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
                ;
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [_mapView addAnnotation:item];
                ;
            }
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        
        
    }
}

- (void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    
    
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];

    
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKWalkingRouteLine* plan = (BMKWalkingRouteLine*)[result.routes objectAtIndex:0];
        
        for (int j = 0; j < plan.steps.count; j++)
        {
            BMKTransitStep *transitStep = [plan.steps objectAtIndex:j];
            [_dataArray addObject:transitStep.instruction];
            
            NSLog(@"路段%@",transitStep.instruction);
            
            
        }
        
        if (_dataArray.count != 0)
        {
            [self createTableView];
        }
        
        int size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        
        
    }
    
}

#pragma mark - 创建列表界面
- (void)createTableView
{
    NSLog(@"%f",Screen_Height);
    if (_listView == nil)
    {
        NSLog(@"createTableView");
        _listView = [[RouteListView alloc] initWithFrame:CGRectMake(0, MidView_Hight_old, Screen_Width, MidView_Hight_old)];
        _listView.backgroundColor = [UIColor clearColor];
        _listView.delegate        = self;
        _listView.dataArray = _dataArray;
        [self.view addSubview:_listView];
    }

}

- (void)routeListTap
{

    if (!_tapFlag)
    {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = _listView.frame;
            frame.origin.y = MidView_Hight_new;
            _listView.frame = frame;
        }];
        
    }else
    {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = _listView.frame;
            frame.origin.y =  MidView_Hight_old;
            _listView.frame = frame;
        }];
    }
    _tapFlag = !_tapFlag;
}

- (void)routeListPan:(UIPanGestureRecognizer *)pan
{
    CGPoint centerPoint = _listView.center;
    
    CGPoint curPoint = [pan locationInView:self.view];
    
    if (pan.state == UIGestureRecognizerStateChanged)
    {
        if (curPoint.y < MidView_Hight_new)
        {
            return;
            [UIView animateWithDuration:0.1 animations:^{
                CGRect frame = _listView.frame;
                frame.origin.y =MidView_Hight_new;
                _listView.frame = frame;
            }];
        }
        CGFloat moveDistance = curPoint.y - _startPoint.y ;

    
        centerPoint.y += moveDistance;
        _startPoint  = curPoint;
        _listView.center = centerPoint;
        
    }else if (pan.state == UIGestureRecognizerStateBegan)
    {
        _startPoint = curPoint;
        _stratOriginPoint = curPoint;
        
    }else if (pan.state == UIGestureRecognizerStateEnded)
    {
        CGFloat moveDistance = curPoint.y - _stratOriginPoint.y ;
        if (moveDistance > 0)
        {
            if (moveDistance >= 30)
            {
                
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect frame = _listView.frame;
                    frame.origin.y =  MidView_Hight_old;
                    _listView.frame = frame;
                }];
                
            }else
            {  [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = _listView.frame;
                frame.origin.y = MidView_Hight_new;
                _listView.frame = frame;
            }];

            }
            
        }else
        {
            if (moveDistance >= 30)
            {
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect frame = _listView.frame;
                    frame.origin.y =  MidView_Hight_old;
                    _listView.frame = frame;
                }];
                

            }else
            {
                
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect frame = _listView.frame;
                    frame.origin.y = MidView_Hight_new;
                    _listView.frame = frame;
                }];

            }
        }
    }
}
@end
