//
//  CollectionModel.h
//  MyNiceFood
//
//  Created by sunsu on 15/8/3.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionModel : NSObject

@property (nonatomic,assign) BOOL select;

@property(nonatomic,copy)NSString   * ownerId;
@property(nonatomic,copy)NSString   * star;
@property(nonatomic,copy)NSString   * count;
@property(nonatomic,copy)NSString   * rescode;
@property(nonatomic,copy)NSString   * address;
@property(nonatomic,copy)NSString   * consumption;
@property(nonatomic,copy)NSString   * industry;
@property(nonatomic,copy)NSString   * industryName;
@property(nonatomic,copy)NSString   * level;
@property(nonatomic,copy)NSString   * ownerName;
@property(nonatomic,copy)NSString   * shopImageUrl;
@property(nonatomic,copy)NSArray    * collentionList;
@property(nonatomic,copy)NSString   * lat;
@property(nonatomic,copy)NSString   * lon;
@end
