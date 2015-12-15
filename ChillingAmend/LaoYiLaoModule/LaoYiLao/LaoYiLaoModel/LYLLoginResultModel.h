//
//  LYLLoginResultModel.h
//  LaoYiLao
//
//  Created by sunsu on 15/11/9.
//  Copyright © 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYLLoginResultModel : NSObject
@property (nonatomic, copy) NSString * age;
@property (nonatomic, copy) NSString * authCode;
@property (nonatomic, copy) NSString * authCodeCount;
@property (nonatomic, copy) NSString * authCodeTime ;
@property (nonatomic, copy) NSString * birthday;
@property (nonatomic, copy) NSString * birthplace;
@property (nonatomic, copy) NSString * busId ;
@property (nonatomic, copy) NSString * busName;
@property (nonatomic, copy) NSString * channel;
@property (nonatomic, copy) NSString * code ;
@property (nonatomic, copy) NSString * company;
@property (nonatomic, copy) NSString * constellation;
@property (nonatomic, copy) NSString * createDate ;
@property (nonatomic, copy) NSString * education ;
@property (nonatomic, copy) NSString * email;
@property (nonatomic, copy) NSString * height ;
@property (nonatomic, copy) NSString * hobby;
@property (nonatomic, copy) NSString * myID;//用户ID
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString * inviteCode ;
@property (nonatomic, copy) NSString * lastLeaveDate;
@property (nonatomic, copy) NSString * lastLoginDate;
@property (nonatomic, copy) NSString * lastLoginPos;
@property (nonatomic, copy) NSString * loginIp;
@property (nonatomic, copy) NSString * mac;
@property (nonatomic, copy) NSString * merchantId;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * parentId;
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * presentAddress;;
@property (nonatomic, copy) NSString * proId ;
@property (nonatomic, copy) NSString * proIden;
@property (nonatomic, copy) NSString * proName ;
@property (nonatomic, copy) NSString * profession;
@property (nonatomic, copy) NSString * pwd;
@property (nonatomic, copy) NSString * pwdType;
@property (nonatomic, copy) NSString * random ;
@property (nonatomic, copy) NSString * realName;
@property (nonatomic, copy) NSString * regIp;
@property (nonatomic, copy) NSString * relationshipStatus;
@property (nonatomic, copy) NSString * school;
@property (nonatomic, copy) NSString * sex ;
@property (nonatomic, copy) NSString * sexualOrientation;
@property (nonatomic, copy) NSString * shippingAddressId;
@property (nonatomic, copy) NSString * smoke;
@property (nonatomic, copy) NSString * src ;
@property (nonatomic, copy) NSString * status ;
@property (nonatomic, copy) NSString * thridPlatform;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * updateDate;
@property (nonatomic, copy) NSString * updateUserId ;
@property (nonatomic, copy) NSString * userName ;
@property (nonatomic, copy) NSString * weight ;


+ (LYLLoginResultModel *)getLYLLoginResultWithDic:(NSDictionary *)dic;
@end
