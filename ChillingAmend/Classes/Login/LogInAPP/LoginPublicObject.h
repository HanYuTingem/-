//
//  LoginPublicObject.h
//  LANSING
//
//  Created by nsstring on 15/6/4.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginPublicObject : NSObject



@property(strong, nonatomic)NSDictionary *logInDic;


@property(strong, nonatomic)NSDictionary *logInPHPDic;

@property(copy, nonatomic)NSDictionary *stringLat;    //纬度
@property(copy, nonatomic)NSDictionary *stringIng;    //经度
@property(copy, nonatomic)NSDictionary *stringToken;  //Token

+ (id) Instance;

@end
