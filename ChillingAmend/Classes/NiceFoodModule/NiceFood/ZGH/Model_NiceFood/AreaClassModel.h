//
//  AreaClassModel.h
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/6.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaClassModel : NSObject


@property (nonatomic, copy) NSMutableArray *data;  //商圈集合
@property (nonatomic, copy) NSMutableArray *hostShopareaList;  //热门商圈集合

@property (nonatomic, copy) NSString *city;         //城市名称
@property (nonatomic, copy) NSString *cityId;       //城市id
@property (nonatomic, copy) NSString *father;       //父级ID
@property (nonatomic, copy) NSString *rescode;      //返回编码
@property (nonatomic, copy) NSString *resdesc;      //返回提示

//@property (nonatomic, assign) int *hotFlag;


@end
