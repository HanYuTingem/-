//
//  MapViewController.h
//  MapForbaidu
//
//  Created by liujinhe on 15/7/17.
//  Copyright (c) 2015年 liujinhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BaseController.h"

typedef enum style{
    traficStyleBus,
    traficStyleCar,
    traficStyleWalk
}traficStyle;

@interface MapViewController : BaseController
@property (nonatomic,strong)NSString *lat;
@property (nonatomic,strong)NSString *lng;
@property (nonatomic,assign) CLLocationCoordinate2D coor;
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *address;
@end
