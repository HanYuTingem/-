//
//  ZXYClassfierListModel.m
//  Chiliring
//
//  Created by Rice on 14-9-15.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "ZXYClassfierListModel.h"

@implementation ZXYClassfierListModel

+(ZXYClassfierListModel *)shareInstance
{
    static ZXYClassfierListModel *classfierListModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        classfierListModel = [[ZXYClassfierListModel alloc] init];
        classfierListModel.leftDataAry = [[NSMutableArray alloc] init];
        classfierListModel.rightDataAry = [[NSMutableArray alloc] init];
    });
    return classfierListModel;
}

-(void)setLeftDataAry:(NSMutableArray *)leftDataAry
{
    if (_leftDataAry != leftDataAry) {
        _leftDataAry = leftDataAry;
    }
}

-(void)setRightDataAry:(NSMutableArray *)rightDataAry
{
    if (_rightDataAry != rightDataAry) {
        _rightDataAry = rightDataAry;
    }
}

@end
