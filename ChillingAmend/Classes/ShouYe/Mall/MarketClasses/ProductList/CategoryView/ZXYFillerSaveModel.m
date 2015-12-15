//
//  ZXYFillerSaveModel.m
//  MarketManage
//
//  Created by Rice on 15/1/27.
//  Copyright (c) 2015年 Rice. All rights reserved.
//

#import "ZXYFillerSaveModel.h"

@implementation ZXYFillerSaveModel

+(ZXYFillerSaveModel *)shareInstance
{
    static ZXYFillerSaveModel *fillerSaveModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fillerSaveModel = [[ZXYFillerSaveModel alloc] init];
        fillerSaveModel.currentType = @"-1";
        fillerSaveModel.lastType = @"-1";
        fillerSaveModel.leftValueAry = [[NSMutableArray alloc] initWithObjects:@"0",@"0",nil];
        fillerSaveModel.rightValueAry = [[NSMutableArray alloc] initWithObjects:@"1",@"1",nil];
    });
    return fillerSaveModel;
}
/** 重新设置模型数据 */
-(void)resetSaveModel;
{
    self.currentType = @"-1";
    self.lastType = @"-1";
    self.leftValueAry[0] = @"0";
    self.leftValueAry[1] = @"0";
    self.rightValueAry[0] = @"1";
    self.rightValueAry[1] = @"1";
}

@end
