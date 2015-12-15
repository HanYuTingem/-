//
//  MyCllectModel.m
//  LANSING
//
//  Created by yll on 15/7/21.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "MyCllectModel.h"
#import "CommomListModel.h"

@implementation MyCllectModel
+(id)initWithMyCllectModelInforCllectListWithJSONDic:(NSDictionary *)dicInfor
{
    MyCllectModel *myCllectData = [[MyCllectModel alloc]init];
    if (dicInfor == nil ||
        dicInfor.count < 1) {
        return myCllectData;
    }
    [myCllectData setPageCount:[dicInfor objectForKey:@"pageCount"]];
    [myCllectData setActive_url:[dicInfor objectForKey:@"active_url"]];
    [myCllectData setImg_urlToCllect:[dicInfor objectForKey:@"img_url"]];
    NSArray *array = [dicInfor objectForKey:@"list"];
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSDictionary *dic in array) {
        CommomListModel *model = [CommomListModel initWithMyCollectModelInforJSONDic:dic];
        [tempArray addObject:model];
    }
    [myCllectData setMyCllectArray:tempArray];
    return myCllectData;
}
@end
