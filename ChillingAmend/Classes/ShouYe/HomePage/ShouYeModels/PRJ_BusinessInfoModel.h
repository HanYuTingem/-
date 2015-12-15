//
//  PRJ_BusinessInfoModel.h
//
//  Created by 瑞 孙 on 15/9/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PRJ_BusinessInfoModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *businessList;
@property (nonatomic, strong) NSString *rescode;
@property (nonatomic, strong) NSString *resdesc;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
