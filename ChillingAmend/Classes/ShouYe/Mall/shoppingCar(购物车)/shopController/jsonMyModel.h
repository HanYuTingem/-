//
//  jsonMyModel.h
//  tableView
//
//  Created by 许文波 on 15/7/10.
//  Copyright (c) 2015年 Sinoglobal. All rights reserved.
//

#import "JSONModel.h"

#import "ListModel.h"

@protocol  ListModel;

@interface jsonMyModel : JSONModel

@property(nonatomic,copy)NSString *shop_name;

@property(nonatomic,strong)NSArray <ListModel>*list;


@end
