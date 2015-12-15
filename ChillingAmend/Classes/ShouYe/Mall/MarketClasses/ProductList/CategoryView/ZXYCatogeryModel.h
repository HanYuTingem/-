//
//  ZXYCatogeryModel.h
//  Chiliring
//
//  Created by Rice on 14-9-9.
//  Copyright (c) 2014年 Sinoglobal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXYCatogeryModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataAry;
+(ZXYCatogeryModel *)shareInstance;
@end
