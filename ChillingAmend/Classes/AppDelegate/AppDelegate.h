//
//  AppDelegate.h
//  ChillingAmend
//
//  Created by svendson on 14-12-17.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAHomeTabBarController.h"
#import "GCRequest.h"
@class ZXYCommitOrderRequestModel;

@interface AppDelegate : UIResponder <UIApplicationDelegate, GCRequestDelegate,BMKGeneralDelegate,BMKLocationServiceDelegate>
{
    GCRequest *advertisingRequest;
    ZXYCommitOrderRequestModel *commitModel;
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) GAHomeTabBarController *homeTabBarController;
@property (nonatomic, strong) BMKLocationService *locService;//定位

+ (AppDelegate *)sharedAppDelegate;

@end

