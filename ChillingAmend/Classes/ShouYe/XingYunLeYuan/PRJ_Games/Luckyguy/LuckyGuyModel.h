//
//  LuckyGuyModel.h
//  ChillingAmend
//
//  Created by 许文波 on 15/1/21.
//  Copyright (c) 2015年 SinoGlobal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LuckyGuyModel : NSObject
@property (nonatomic, strong) NSString *img; // 小图
@property (nonatomic, strong) NSString *big_img; // 大图
@property (nonatomic, strong) NSString *descript; // 描述
@property (nonatomic, strong) NSString *level; // 等级
@property (nonatomic, strong) NSString *weizhi; // 位置
@property (nonatomic, strong) NSString *content; // 内容

+ (LuckyGuyModel *)getLuckyGuyModelModelWithDic:(NSDictionary *)dic;

@end
