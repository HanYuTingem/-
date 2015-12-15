//
//  AddressViewController.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/28.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "AddressViewController.h"

#define CellHieght 50
#define AddressArray [[NSUserDefaults standardUserDefaults] arrayForKey:@"addressArray"]


@interface AddressViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *addressTextField;    //送餐地址输入框

@property (nonatomic, strong) UIButton *putIn;      //确定按钮

@property (nonatomic, strong) BMKLocationService *locService;   //定位
@property (nonatomic, assign) CLLocationCoordinate2D location;  //送餐地址的经纬度

@property (nonatomic, strong) BMKGeoCodeSearch *search;         //地理编码服务

@property (nonatomic, strong) NSString *locationAddress;        //送餐地址

@property (nonatomic, strong) UITapGestureRecognizer *tapMain; //背景点击事件

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _locationAddress = [[NSString alloc] init];
    
    _search = [[BMKGeoCodeSearch alloc] init];
    _search.delegate = self;
    
    titleButton.hidden = NO;
    [titleButton setTitle:@"送餐地址" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    _putIn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-40, (NavigationH - 20 -30)/2+20, 40, 30)];
    [_putIn setTitle:@"确定" forState:UIControlStateNormal];
    [_putIn setTitleColor:RGBACOLOR(230, 60, 82, 1) forState:UIControlStateNormal];
    [backView addSubview:_putIn];
    
    [_putIn addTarget:self action:@selector(clickPutIn) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationH)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [mainView addSubview:_tableView];
    
    _tableView.tableFooterView = [[UIView alloc] init];
   
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]){
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]){
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    _tapMain = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMainView)];
    

    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CellHieght)];
    [headerView setBackgroundColor:RGBACOLOR(210, 210, 210, 1)];
    
    
    _addressTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, CellHieght / 4, SCREEN_WIDTH - 100 , CellHieght / 2)];
    [_addressTextField setBorderStyle:UITextBorderStyleNone];
    _addressTextField.placeholder = @"请输入您的送餐地址~";
    _addressTextField.returnKeyType =UIReturnKeyDone;
    _addressTextField.delegate = self;
    [headerView addSubview:_addressTextField];
    
    UIButton *location = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, CellHieght /5, 60, CellHieght*3 / 5)];
    [location.layer setCornerRadius:3];
    [location setTitle:@"定位" forState:UIControlStateNormal];
    [location setBackgroundColor:RGBACOLOR(230, 60, 82, 1)];
    [headerView addSubview:location];
    [location addTarget:self action:@selector(clickLocation) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_tableView setTableHeaderView:headerView];
}

//确定按钮
- (void)clickPutIn{
    NSLog(@"点击确定");
    
    if (_addressTextField.text.length > 0) {
        if(_location.latitude == 0 || _location.longitude == 0) {
            [self showMsg:@"外卖小哥找不到您的地址~"];
        } else {
            
            NSMutableArray *temp = [NSMutableArray arrayWithArray:AddressArray];
            
            for (int i = 0; i < temp.count; i++) {
                NSString *str = AddressArray[i];
                if ([str isEqualToString:_locationAddress]) {
                    [temp removeObjectAtIndex:i];
                }
            }
            [temp insertObject:_locationAddress atIndex:0];
            
            if (temp.count > 5) {
                [temp removeObjectAtIndex:5];
            }
            [[NSUserDefaults standardUserDefaults] setObject:temp forKey:@"addressArray"];
            [_tableView reloadData];
            
            BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake([_lat floatValue],[_lng floatValue]));
            BMKMapPoint point2 = BMKMapPointForCoordinate(_location);
            CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
            
            if (distance > [_serverScope floatValue]) {
                [self showMsg:@"sorry，这个位置有点远，可能送不到~"];
            } else {
                NSDictionary *dic = @{@"address":_addressTextField.text};
                [[NSNotificationCenter defaultCenter] postNotificationName:@"address" object:nil userInfo:dic];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } else {
        [self showMsg:@"请输您的送餐地址~"];
    }
    
    
}

- (void)clickLocation{
    NSLog(@"定位按钮");
    [self getUserLocation];
    [self close];
    [self chrysanthemumOpen];
}


//地址cell的删除按钮
- (void)deleteAddress:(UIButton *)btn{
     NSMutableArray *temp = [NSMutableArray arrayWithArray:AddressArray];
    [temp removeObjectAtIndex:btn.tag - 400 - 1];
    [[NSUserDefaults standardUserDefaults] setObject:temp forKey:@"addressArray"];
    [_tableView reloadData];
}


#pragma mark -- 百度地图代理
- (void)getUserLocation{
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    _location = userLocation.location.coordinate;
    
    //    逆地理编码
    BMKReverseGeoCodeOption *loc = [[BMKReverseGeoCodeOption alloc] init];
    loc.reverseGeoPoint = userLocation.location.coordinate;
    [_search reverseGeoCode:loc];
    [_locService stopUserLocationService];
    
}

//地理编码
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    NSLog(@"地理编码");

    _location = result.location;
    [self open];
    [self chrysanthemumClosed];
}

//逆地理编码
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    NSLog(@"逆地理编码");
    _locationAddress = result.address;
    [_addressTextField setText:[NSString stringWithFormat:@"%@", _locationAddress]];
    [self open];
    [self chrysanthemumClosed];

}



#pragma mark -- tableView代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.userInteractionEnabled = YES;
    if (indexPath.row == 0) {
        [cell.textLabel setText:@"常用送餐地址"];
    } else {

        [cell.textLabel setText:AddressArray[indexPath.row -1]];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, CellHieght /5, 60, CellHieght*3 / 5)];
        [btn setTag:400 + indexPath.row];
        [btn.layer setCornerRadius:3];
        [btn setTitle:@"删除" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor]];
        [cell.contentView addSubview:btn];
        
        [btn addTarget:self action:@selector(deleteAddress:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 0) {
        [_addressTextField setText:AddressArray[indexPath.row - 1]];

        _locationAddress = _addressTextField.text;
        [self close];
        [self chrysanthemumOpen];
    }
    [self getAddressLocation];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return AddressArray.count + 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]){
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark --UITextFieldDelegate实现方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    _locationAddress = _addressTextField.text;
    
    [_addressTextField resignFirstResponder];
    [mainView removeGestureRecognizer:_tapMain];

    [self getAddressLocation];
    
    NSLog(@"完成编辑");
    
    return YES;
}

- (void)getAddressLocation{
    //    地理编码
    BMKGeoCodeSearchOption *loc = [[BMKGeoCodeSearchOption alloc] init];
    loc.city = CityName;
    loc.address = _addressTextField.text;
    [_search geoCode:loc];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [mainView addGestureRecognizer:_tapMain];
 
    return YES;
}


- (void)clickMainView{
    
    [self textFieldShouldReturn:_addressTextField];

}


- (void)dealloc{
    _locService.delegate = nil;
    _search.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
