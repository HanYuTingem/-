//
//  PRJ_BusinessList.h
//
//  Created by 瑞 孙 on 15/9/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PRJ_BusinessList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *star;
@property (nonatomic, assign) double provideServiceTakeout;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) double couponStart;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) double provideServiceOrder;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double avgprice;
@property (nonatomic, strong) NSString *districtName;
@property (nonatomic, strong) NSString *industry;
@property (nonatomic, strong) NSString *industryName;




+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
