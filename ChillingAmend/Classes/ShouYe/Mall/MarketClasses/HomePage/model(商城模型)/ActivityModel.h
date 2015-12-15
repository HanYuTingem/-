//
//  ActivityModel.h
//  MarketManage
//
//  Created by 许文波 on 15/8/25.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "JSONModel.h"
#import "ActitvityListModel.h"

@protocol  ActitvityListModel;

@interface ActivityModel : JSONModel

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *name;


@property(nonatomic,strong)NSArray<ActitvityListModel> *list;

@end
