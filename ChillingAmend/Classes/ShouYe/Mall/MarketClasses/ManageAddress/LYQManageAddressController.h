//
//  LYQManageAddressController.h
//  Chiliring
//
//  Created by nsstring on 14-9-9.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketAPI.h"
#import "L_BaseMallViewController.h"

@protocol SelectAddDelegate <NSObject>

-(void)selectAddDic:(NSMutableDictionary *)dict;

@end

@interface LYQManageAddressController : L_BaseMallViewController

//YES为提交订单页面进来 NO为地址管理页面
@property (nonatomic,assign) BOOL status;
//已经选中的地址的id
@property (nonatomic,strong) NSString * addressID;

@property (assign, nonatomic) id <SelectAddDelegate> delegate;

@end
