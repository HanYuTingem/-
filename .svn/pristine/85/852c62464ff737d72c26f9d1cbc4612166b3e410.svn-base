//
//  PRJ_BusinessInfoModel.m
//
//  Created by 瑞 孙 on 15/9/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PRJ_BusinessInfoModel.h"
#import "PRJ_BusinessList.h"


NSString *const kPRJ_BusinessInfoModelBusinessList = @"businessList";
NSString *const kPRJ_BusinessInfoModelRescode = @"rescode";
NSString *const kPRJ_BusinessInfoModelResdesc = @"resdesc";


@interface PRJ_BusinessInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PRJ_BusinessInfoModel

@synthesize businessList = _businessList;
@synthesize rescode = _rescode;
@synthesize resdesc = _resdesc;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedPRJ_BusinessList = [dict objectForKey:kPRJ_BusinessInfoModelBusinessList];
    NSMutableArray *parsedPRJ_BusinessList = [NSMutableArray array];
    if ([receivedPRJ_BusinessList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPRJ_BusinessList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPRJ_BusinessList addObject:[PRJ_BusinessList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPRJ_BusinessList isKindOfClass:[NSDictionary class]]) {
       [parsedPRJ_BusinessList addObject:[PRJ_BusinessList modelObjectWithDictionary:(NSDictionary *)receivedPRJ_BusinessList]];
    }

    self.businessList = [NSArray arrayWithArray:parsedPRJ_BusinessList];
            self.rescode = [self objectOrNilForKey:kPRJ_BusinessInfoModelRescode fromDictionary:dict];
            self.resdesc = [self objectOrNilForKey:kPRJ_BusinessInfoModelResdesc fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForBusinessList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.businessList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBusinessList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBusinessList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBusinessList] forKey:kPRJ_BusinessInfoModelBusinessList];
    [mutableDict setValue:self.rescode forKey:kPRJ_BusinessInfoModelRescode];
    [mutableDict setValue:self.resdesc forKey:kPRJ_BusinessInfoModelResdesc];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.businessList = [aDecoder decodeObjectForKey:kPRJ_BusinessInfoModelBusinessList];
    self.rescode = [aDecoder decodeObjectForKey:kPRJ_BusinessInfoModelRescode];
    self.resdesc = [aDecoder decodeObjectForKey:kPRJ_BusinessInfoModelResdesc];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_businessList forKey:kPRJ_BusinessInfoModelBusinessList];
    [aCoder encodeObject:_rescode forKey:kPRJ_BusinessInfoModelRescode];
    [aCoder encodeObject:_resdesc forKey:kPRJ_BusinessInfoModelResdesc];
}

- (id)copyWithZone:(NSZone *)zone
{
    PRJ_BusinessInfoModel *copy = [[PRJ_BusinessInfoModel alloc] init];
    
    if (copy) {

        copy.businessList = [self.businessList copyWithZone:zone];
        copy.rescode = [self.rescode copyWithZone:zone];
        copy.resdesc = [self.resdesc copyWithZone:zone];
    }
    
    return copy;
}


@end
