//
//  NiceFoodSecondRootViewController.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/6/18.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "NiceFoodSecondRootViewController.h"
#import "ShopAndCheapSegmentedControl.h"
#import "ShopListModel.h"
#import "ListTableViewController.h"


@interface NiceFoodSecondRootViewController () <BMKMapViewDelegate, BMKLocationServiceDelegate>

@end

@implementation NiceFoodSecondRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cloudSearch.delegate = self;
    

//    _cheapParameterDic = [self addCheapConditionWithDic:self.parameterDic];
    
    
//    初始化地图
    [self addSceondView];
    [self addMap];
    

//    添加分段选择器
    [self addSegmentedControl];

//    添加导航栏右边地图按钮
    [self addRightBarButtonItem];
    
    _seg.selectedSegmentIndex = 1;
    
    
    
    
}

//清除大头针
- (void)releaseAnnotation{
    NSArray *array = [[NSArray alloc] initWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    _index = 0;
}

//刷新大头针
- (void)reloadAnnotation{
    
    if (_mapBtn.selected == YES) {
        [self releaseAnnotation];
        
        //加大头针
        for (int i = 0; i < self.showData.count ;i++)
        {
            ShopListModel *model = self.showData[i];
            CLLocationCoordinate2D coor;
            coor.latitude = [model.location[0] floatValue];
            coor.longitude = [model.location[1] floatValue];
            if(i == 0)
            {
                //将第一个点的坐标移到屏幕中央
                _mapView.centerCoordinate = coor;
                _mapView.zoomLevel = 13;
            }
            [self addMapAnnotation:coor];
        }
        [self.tableView reloadData];
    }

}

//添加大头针
- (void)addMapAnnotation:(CLLocationCoordinate2D)coordinate{
    if (coordinate.latitude == 0 || coordinate.longitude == 0) {
        
    } else {
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        annotation.coordinate = coordinate;
        [_mapView addAnnotation:annotation];
    }
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
    annView.image       = [UIImage imageNamed:@"map_0003_dwd"];
    
    ShopListModel *model = self.showData[_index];
    
    //定制泡泡
    UIImageView *paopao = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 60)];
    paopao.tag          = 2001+_index;
    paopao.image        = [UIImage imageNamed:@"map_0002_qipao"];
    
    //头像图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [imageView setImageWithURL:[NSURL URLWithString:model.shopImageUrl] placeholderImage:[UIImage imageNamed:@"morenshop"]];
    
    //店名
    UILabel *nameLabel     = [[UILabel alloc] initWithFrame:CGRectMake(45, 10, 80, 30)];
    nameLabel.font         = [UIFont systemFontOfSize:15];
    //nameLabel.adjustsFontSizeToFitWidth = YES;
    nameLabel.text         = model.name;
    
    //箭头
    UIImageView *arrow     = [[UIImageView alloc] initWithFrame:CGRectMake(115, 10, 30, 30)];
    arrow.image            = [UIImage imageNamed:@"jt"];
    
    [paopao addSubview:imageView];
    [paopao addSubview:nameLabel];
    [paopao addSubview:arrow];
    
    //给泡泡加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchPaoPao:)];
    annView.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:paopao];
    annView.paopaoView.tag = 2001+_index;
    [annView.paopaoView addGestureRecognizer:tap];
    _index++;
    return annView;
}


//地图大头针点击的代理方法
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    view.image = [UIImage imageNamed:@"map_0000_dk"];
}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    view.image = [UIImage imageNamed:@"map_0003_dwd"];
}

#pragma mark -- 大头针点击事件
- (void)touchPaoPao:(UITapGestureRecognizer *)tap
{
    UIImageView *view = (UIImageView *)tap.view;
    
    ShopListModel *model = self.showData[view.tag - 2001];
    
    ListTableViewController * list = [[ListTableViewController alloc]init];
    
    //商户id
    list.ownerId = [NSString stringWithFormat:@"%ld", model.autoid];
    
    [self.navigationController pushViewController:list  animated:YES];
    
//    MerchantDetailViewController *mer = [[MerchantDetailViewController alloc] init];
//    mer.ownerId = model.autoid;
//    
//    [self.navigationController pushViewController:mer animated:YES];
    
}


//选择器标记
- (void)reloadList{
    //当默认为进入优惠页面时
//    [self cheapNearRequestWithParameters:_cheapParameterDic];
    
    
    self.searchInfo = [self addCheapConditionWithObj:self.searchInfo];
    NSLog(@"%@", self.searchInfo.filter);
    BOOL reg = [self.cloudSearch nearbySearchWithSearchInfo:self.searchInfo];
    [self chrysanthemumWithBOOL:reg];
    
}

#pragma mark -- 添加地图View
// 初始化第二View
- (void)addSceondView{
    _sceondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.animationView.frame.size.width, self.animationView.frame.size.height)];

}

//添加地图
- (void)addMap{

    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, TopMenuH, SCREEN_WIDTH, _sceondView.frame.size.height - TopMenuH)];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showMapScaleBar = YES;
    
    [_sceondView addSubview:_mapView];
    
    _locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;
    
    
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
}




#pragma mark -- 导航栏右边地图按钮
- (void)addRightBarButtonItem{
    
    _mapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mapBtn.frame= CGRectMake(SCREEN_WIDTH-15-40, (NavigationH - 20 -30)/2+20, 40, 30);
    [_mapBtn setImage:[UIImage imageNamed:@"meishi_title_btn_map"] forState:UIControlStateNormal];

    [_mapBtn  addTarget:self
                action:@selector(mapBtnClick:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:_mapBtn];
    
}

#pragma mark -- 地图按钮点击事件
- (void)mapBtnClick:(UIButton *)btn{
    
    if (self.screen.tempBtn.selected == YES) {
        [self.screen buttonClick:self.screen.tempBtn];
    }
    
    if (btn.selected == NO) {
    
        btn.selected = YES;
        [self.sceondView addSubview:self.screen];

//        View的动画过程
        [UIView transitionFromView:self.firstView toView:_sceondView duration:1.0f options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
            [self.view sendSubviewToBack:self.firstView];
        }];
        
//        按钮的动画过程
        [UIButton transitionWithView:btn duration:1.0f options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            
            [btn setImage:[UIImage imageNamed:@"fenlei@2x"] forState:UIControlStateNormal];
            
        } completion:^(BOOL finished) {
            [self reloadAnnotation];
        }];
        
    } else {
        
        btn.selected = NO;
        
        [self.firstView addSubview:self.screen];
        
//        View的动画过程
        [UIView transitionFromView:_sceondView toView:self.firstView duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            [self.view sendSubviewToBack:_sceondView];
        }];
        
//        按钮的动画过程
        [UIButton transitionWithView:btn duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
            [btn setImage:[UIImage imageNamed:@"meishi_title_btn_map"] forState:UIControlStateNormal];
            
        } completion:^(BOOL finished) {
            
        }];
        
        NSArray *array = [NSArray arrayWithArray:_mapView.annotations];
        [_mapView removeAnnotations:array];
        _index = 0;
    }
}


#pragma mark -- 分段选择器
- (void)addSegmentedControl{
    
    titleButton.hidden = YES;
    
    //    自定义SegmentedControl
    _seg = [ShopAndCheapSegmentedControl setSegmentedWithArray: @[@"商户",@"优惠"]];
    
    [backView addSubview:_seg];

    [_seg    addTarget:self
               action:@selector(segmentValueChange:)
     forControlEvents:UIControlEventValueChanged];
}


//    分段选择器点击事件
- (void)segmentValueChange:(ShopAndCheapSegmentedControl *)seg{
    [self chrysanthemumOpen];
    [self close];
    [self.showData removeAllObjects];
    self.pageIndex = 0;
    
    if (seg.selectedSegmentIndex == 0) {
        if (self.areaIndex == 0) {
            self.searchInfo = [self removeCheapConditionWithObj:self.searchInfo];
            BOOL reg = [self.cloudSearch nearbySearchWithSearchInfo:self.searchInfo];
            [self chrysanthemumWithBOOL:reg];
        } else {
            self.locationInfo = [self removeCheapConditionWithObj:self.locationInfo];
            BOOL reg = [self.cloudSearch localSearchWithSearchInfo:self.locationInfo];
            [self chrysanthemumWithBOOL:reg];
        }
    } else if (seg.selectedSegmentIndex == 1) {
        if (self.areaIndex == 0) {
            self.searchInfo = [self addCheapConditionWithObj:self.searchInfo];
            BOOL reg = [self.cloudSearch nearbySearchWithSearchInfo:self.searchInfo];
            [self chrysanthemumWithBOOL:reg];
        } else {
            self.locationInfo = [self addCheapConditionWithObj:self.locationInfo];
            BOOL reg = [self.cloudSearch localSearchWithSearchInfo:self.locationInfo];
            [self chrysanthemumWithBOOL:reg];
        }
    }
    
    
//    if (seg.selectedSegmentIndex == 0) {//当分段选择器选择商户
//        [self.showData removeAllObjects];
//        if (self.areaIndex == 0) {      //附近检索
////            [self nearHttpRequestWithParameters:self.parameterDic];
//            BOOL reg = [self.cloudSearch nearbySearchWithSearchInfo:self.searchInfo];
//            [self chrysanthemumWithBOOL:reg];
//        } else {                        //本地检索
//            BOOL reg = [self.cloudSearch localSearchWithSearchInfo:self.locationInfo];
//            [self chrysanthemumWithBOOL:reg];
////            [self locationHttpRequestWithParameters:self.parameterDic];
//        }
//        
//    } else if(seg.selectedSegmentIndex == 1) {//当分段选择器选择优惠
//        [self.showData removeAllObjects];
////        拼接优惠筛选条件
//        NSDictionary *dic = [[NSDictionary alloc] init];
////        dic = [self addCheapConditionWithDic:self.parameterDic];
//        
//        if (self.areaIndex == 0) {      //附近检索
//            [self cheapNearRequestWithParameters:dic];
//        } else {                        //本地检索
//            [self cheapLocationRequestWithParameters:dic];
//        }
//    }
}

#pragma mark -- 当选择筛选器为优惠时  向请求条件里添加优惠标记的条件
- (id)addCheapConditionWithObj:(id)obj{
    if ([obj isKindOfClass:[BMKCloudNearbySearchInfo class]]) {
        BMKCloudNearbySearchInfo *info = obj;
        info.pageIndex = 0;
        info.filter = [NSString stringWithFormat:@"%@%@", info.filter, @"|provideServiceDiscount:0"];
        return info;
    } else if ([obj isKindOfClass:[BMKCloudLocalSearchInfo class]]){
        BMKCloudLocalSearchInfo *info = obj;
        info.pageIndex = 0;
        info.filter = [NSString stringWithFormat:@"%@%@", info.filter, @"|provideServiceDiscount:0"];
        return info;
    } else {
        return nil;
    }
}

#pragma mark -- 当选择筛选器为商户时  向请求条件里移除优惠标记的条件
- (id)removeCheapConditionWithObj:(id)obj{
    if ([obj isKindOfClass:[BMKCloudNearbySearchInfo class]]) {
        BMKCloudNearbySearchInfo *info = obj;
        
        info.pageIndex = 0;
        NSMutableString *str = [[NSMutableString alloc] initWithString:info.filter];
        NSRange range = [str rangeOfString:@"|provideServiceDiscount:0"];
        if (range.length > 0) {
            [str deleteCharactersInRange:range];
            info.filter = [NSString stringWithString:str];
        }
        return info;
    } else if ([obj isKindOfClass:[BMKCloudLocalSearchInfo class]]){
        BMKCloudLocalSearchInfo *info = obj;
        
        info.pageIndex = 0;
        NSMutableString *str = [[NSMutableString alloc] initWithString:info.filter];
        NSRange range = [str rangeOfString:@"|provideServiceDiscount:0"];
        if (range.length > 0) {
            [str deleteCharactersInRange:range];
            info.filter = [NSString stringWithString:str];
        }
        return info;
    } else {
        return nil;
    }
}

#pragma mark -- 重写通过点击筛选条件获得请求体的方法
- (void)getNearNotification:(NSNotification *)notification{
    
    [self chrysanthemumOpen];
    [self close];
    self.pageIndex = 0;
    
    self.searchInfo = notification.userInfo[@"near"];
    [self.showData removeAllObjects];
    
//    [self.shopData removeAllObjects];
//    [self.cheapData removeAllObjects];
//    self.parameterDic = notification.userInfo;                              //商户页面请求体
//    _cheapParameterDic = [self addCheapConditionWithDic:self.parameterDic]; //优惠页面请求体
    
    self.areaIndex = self.screen.areaIndex;                                 //区域筛选标记
    
    if (_seg.selectedSegmentIndex == 1) {
        self.searchInfo = [self addCheapConditionWithObj:self.searchInfo];
    }
    
    BOOL reg = [self.cloudSearch nearbySearchWithSearchInfo:self.searchInfo];
    [self chrysanthemumWithBOOL:reg];
    

    
}

- (void)getLocationNotification:(NSNotification *)notification{
    
    [self chrysanthemumOpen];
    [self close];
    self.pageIndex = 0;

    self.locationInfo = notification.userInfo[@"location"];
    [self.showData removeAllObjects];
    
//    [self.shopData removeAllObjects];
//    [self.cheapData removeAllObjects];
//    self.parameterDic = notification.userInfo;                              //商户页面请求体
//    _cheapParameterDic = [self addCheapConditionWithDic:self.parameterDic]; //优惠页面请求体
    self.areaIndex = self.screen.areaIndex;                                 //区域筛选标记
    
    if (_seg.selectedSegmentIndex == 1) {
        self.locationInfo = [self addCheapConditionWithObj:self.locationInfo];
    }
    
    BOOL reg = [self.cloudSearch localSearchWithSearchInfo:self.locationInfo];
    [self chrysanthemumWithBOOL:reg];
    
    
}

#pragma mark 重写下拉刷新方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{

    if (self.areaIndex == 0) {
        
//        if (_seg.selectedSegmentIndex == 1) {
//            self.searchInfo = [self addCheapConditionWithObj:self.searchInfo];
//        }
        
        if (refreshView.tag == 901) {
            self.pageIndex ++;
            self.searchInfo.pageIndex = self.pageIndex;
        } else {
            self.pageIndex = 0;
            self.searchInfo.pageIndex = self.pageIndex;
//            [self.showData removeAllObjects];
        }
        
        NSLog(@"page = %ld", (long)self.searchInfo.pageIndex);
        NSLog(@"fider = %@", self.searchInfo.filter);
        BOOL reg = [self.cloudSearch nearbySearchWithSearchInfo:self.searchInfo];
        [self chrysanthemumWithBOOL:reg];
        
    } else {
        
//        if (_seg.selectedSegmentIndex == 1) {
//            self.locationInfo = [self addCheapConditionWithObj:self.locationInfo];
//        }
        
        if (refreshView.tag == 901) {
            self.pageIndex ++;
            self.locationInfo.pageIndex = self.pageIndex;
        } else {
            self.pageIndex = 0;
            self.locationInfo.pageIndex = self.pageIndex;
//            [self.showData removeAllObjects];
        }
        
        NSLog(@"page = %ld", (long)self.locationInfo.pageIndex);
        NSLog(@"fider = %@", self.locationInfo.filter);
        BOOL reg = [self.cloudSearch localSearchWithSearchInfo:self.locationInfo];
        [self chrysanthemumWithBOOL:reg];
    }
    [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:1.5];
}

//- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView{
//    [refreshView endRefreshing];
//}

-(void)viewWillAppear:(BOOL)animated {
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadAnnotation) name:@"reloadAnnotation" object:nil];
    
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadAnnotation" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"near" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"location" object:nil];
    
    [super viewWillDisappear:animated];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    if (_mapView) {
        _mapView = nil;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadAnnotation" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"near" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"location" object:nil];
}

@end
