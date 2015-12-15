//
//  ZXYCatogeryModel.m
//  Chiliring
//
//  Created by Rice on 14-9-9.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import "ZXYCatogeryModel.h"

@implementation ZXYCatogeryModel

+(ZXYCatogeryModel *)shareInstance
{
    static ZXYCatogeryModel *catogeryModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        catogeryModel = [[ZXYCatogeryModel alloc] init];
        catogeryModel.dataAry = [[NSMutableArray alloc] init];
    });
    return catogeryModel;
}

-(void)setDataAry:(NSMutableArray *)dataAry
{
    if (dataAry != _dataAry) {
        _dataAry = dataAry;
    }
}


@end
