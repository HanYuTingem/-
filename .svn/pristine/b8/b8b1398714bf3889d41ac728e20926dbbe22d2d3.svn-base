//
//  MyApplyModel.m
//  LANSING
//
//  Created by yll on 15/7/21.
//  Copyright (c) 2015年 DengLu. All rights reserved.
//

#import "MyApplyModel.h"
#import "CommomListModel.h"

@implementation MyApplyModel
+(id)initWithMyApplyModelInforApplyListWithJSONDic:(NSDictionary *)dicInfor
{
    MyApplyModel *myApplyData = [[MyApplyModel alloc]init];
    if (dicInfor == nil ||
        dicInfor.count < 1) {
        return myApplyData;
    }
    [myApplyData setPageCount:[dicInfor objectForKey:@"pageCount"]];
    [myApplyData setActive_url:[dicInfor objectForKey:@"active_url"]];
    [myApplyData setImg_urlToApply:[dicInfor objectForKey:@"img_url"]];
    NSArray *array = [dicInfor objectForKey:@"list"];
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSDictionary *dic in array) {
        CommomListModel *model = [CommomListModel initWithMyApplyModelInforJSONDic:dic];
        [tempArray addObject:model];
    }
    [myApplyData setMyApplyArray:tempArray];
    return myApplyData;
}

@end
