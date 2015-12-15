//
//  PRJ_BusinessList.m
//
//  Created by 瑞 孙 on 15/9/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PRJ_BusinessList.h"


NSString *const kPRJ_BusinessListStar = @"star";
NSString *const kPRJ_BusinessListProvideServiceTakeout = @"provideServiceTakeout";
NSString *const kPRJ_BusinessListAddress = @"address";
NSString *const kPRJ_BusinessListCouponStart = @"couponStart";
NSString *const kPRJ_BusinessListImageUrl = @"imageUrl";
NSString *const kPRJ_BusinessListProvideServiceOrder = @"provideServiceOrder";
NSString *const kPRJ_BusinessListName = @"name";
NSString *const kPRJ_BusinessListAvgprice = @"avgprice";
NSString *const kPRJ_BusinessListDistrictName = @"districtName";
NSString *const kPRJ_BusinessListIndustry = @"industry";
NSString *const kPRJ_BusinessListIndustryName = @"industryName";

@interface PRJ_BusinessList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PRJ_BusinessList

@synthesize star = _star;
@synthesize provideServiceTakeout = _provideServiceTakeout;
@synthesize address = _address;
@synthesize couponStart = _couponStart;
@synthesize imageUrl = _imageUrl;
@synthesize provideServiceOrder = _provideServiceOrder;
@synthesize name = _name;
@synthesize avgprice = _avgprice;
@synthesize districtName = _districtName;
@synthesize industry = _industry;
@synthesize industryName = _industryName;

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
        self.star = [self objectOrNilForKey:kPRJ_BusinessListStar fromDictionary:dict];
        self.provideServiceTakeout = [[self objectOrNilForKey:kPRJ_BusinessListProvideServiceTakeout fromDictionary:dict] doubleValue];
        self.address = [self objectOrNilForKey:kPRJ_BusinessListAddress fromDictionary:dict];
        self.couponStart = [[self objectOrNilForKey:kPRJ_BusinessListCouponStart fromDictionary:dict] doubleValue];
        self.imageUrl = [self objectOrNilForKey:kPRJ_BusinessListImageUrl fromDictionary:dict];
        self.provideServiceOrder = [[self objectOrNilForKey:kPRJ_BusinessListProvideServiceOrder fromDictionary:dict] doubleValue];
        self.name = [self objectOrNilForKey:kPRJ_BusinessListName fromDictionary:dict];
        self.avgprice = [[self objectOrNilForKey:kPRJ_BusinessListAvgprice fromDictionary:dict] doubleValue];
        self.districtName = [self objectOrNilForKey:kPRJ_BusinessListDistrictName fromDictionary:dict];
        self.industry = [self objectOrNilForKey:kPRJ_BusinessListIndustry fromDictionary:dict];
        self.industryName = [self objectOrNilForKey:kPRJ_BusinessListIndustryName fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.star forKey:kPRJ_BusinessListStar];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provideServiceTakeout] forKey:kPRJ_BusinessListProvideServiceTakeout];
    [mutableDict setValue:self.address forKey:kPRJ_BusinessListAddress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.couponStart] forKey:kPRJ_BusinessListCouponStart];
    [mutableDict setValue:self.imageUrl forKey:kPRJ_BusinessListImageUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provideServiceOrder] forKey:kPRJ_BusinessListProvideServiceOrder];
    [mutableDict setValue:self.name forKey:kPRJ_BusinessListName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.avgprice] forKey:kPRJ_BusinessListAvgprice];
    [mutableDict setValue:self.districtName forKey:kPRJ_BusinessListDistrictName];
    [mutableDict setValue:self.industry forKey:kPRJ_BusinessListIndustry];
    [mutableDict setValue:self.industryName forKey:kPRJ_BusinessListIndustryName];

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

    self.star = [aDecoder decodeObjectForKey:kPRJ_BusinessListStar];
    self.provideServiceTakeout = [aDecoder decodeDoubleForKey:kPRJ_BusinessListProvideServiceTakeout];
    self.address = [aDecoder decodeObjectForKey:kPRJ_BusinessListAddress];
    self.couponStart = [aDecoder decodeDoubleForKey:kPRJ_BusinessListCouponStart];
    self.imageUrl = [aDecoder decodeObjectForKey:kPRJ_BusinessListImageUrl];
    self.provideServiceOrder = [aDecoder decodeDoubleForKey:kPRJ_BusinessListProvideServiceOrder];
    self.name = [aDecoder decodeObjectForKey:kPRJ_BusinessListName];
    self.avgprice = [aDecoder decodeDoubleForKey:kPRJ_BusinessListAvgprice];
    self.districtName = [aDecoder decodeObjectForKey:kPRJ_BusinessListDistrictName];
    self.industry = [aDecoder decodeObjectForKey:kPRJ_BusinessListIndustry];
    self.industryName = [aDecoder decodeObjectForKey:kPRJ_BusinessListIndustryName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_star forKey:kPRJ_BusinessListStar];
    [aCoder encodeDouble:_provideServiceTakeout forKey:kPRJ_BusinessListProvideServiceTakeout];
    [aCoder encodeObject:_address forKey:kPRJ_BusinessListAddress];
    [aCoder encodeDouble:_couponStart forKey:kPRJ_BusinessListCouponStart];
    [aCoder encodeObject:_imageUrl forKey:kPRJ_BusinessListImageUrl];
    [aCoder encodeDouble:_provideServiceOrder forKey:kPRJ_BusinessListProvideServiceOrder];
    [aCoder encodeObject:_name forKey:kPRJ_BusinessListName];
    [aCoder encodeDouble:_avgprice forKey:kPRJ_BusinessListAvgprice];
    [aCoder encodeObject:_districtName forKey:kPRJ_BusinessListDistrictName];
    [aCoder encodeObject:_industry forKey:kPRJ_BusinessListIndustry];
    [aCoder encodeObject:_industryName forKey:kPRJ_BusinessListIndustryName];
}

- (id)copyWithZone:(NSZone *)zone
{
    PRJ_BusinessList *copy = [[PRJ_BusinessList alloc] init];
    
    if (copy) {

        copy.star = [self.star copyWithZone:zone];
        copy.provideServiceTakeout = self.provideServiceTakeout;
        copy.address = [self.address copyWithZone:zone];
        copy.couponStart = self.couponStart;
        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.provideServiceOrder = self.provideServiceOrder;
        copy.name = [self.name copyWithZone:zone];
        copy.avgprice = self.avgprice;
        copy.districtName = [self.districtName copyWithZone:zone];
        copy.industry = [self.industry copyWithZone:zone];
        copy.industryName = [self.industryName copyWithZone:zone];
    }
    
    return copy;
}


@end
