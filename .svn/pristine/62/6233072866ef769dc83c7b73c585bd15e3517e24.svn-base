//
//  ActionListModel.m
//  LANSING
//
//  Created by yll on 15/7/21.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "ActionListModel.h"
#import "CommomListModel.h"

@implementation ActionListModel
+(id)initWithMyActionListModelInforActionListWithJSONDic:(NSDictionary *)dicInfor
{
    ActionListModel *myActionListData = [[ActionListModel alloc]init];
    if (dicInfor == nil ||
        dicInfor.count < 1) {
        return myActionListData;
    }
    [myActionListData setPageCount:[dicInfor objectForKey:@"pageCount"]];
    [myActionListData setActive_url:[dicInfor objectForKey:@"active_url"]];
    [myActionListData setImg_urlToList:[dicInfor objectForKey:@"img_url"]];
    NSArray *array = [dicInfor objectForKey:@"list"];
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSDictionary *dic in array) {
        CommomListModel *model = [CommomListModel initWithALlActionListModelInforJSONDic:dic];
        [tempArray addObject:model];
    }
    [myActionListData setListArray:tempArray];
    return myActionListData;
}
@end
